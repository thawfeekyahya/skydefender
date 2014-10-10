/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 3:35 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.worlds {
import com.thawfeek.skydefender.EmbededAssets;
import com.thawfeek.skydefender.GameConfig;
import com.thawfeek.skydefender.GameConstants;
import com.thawfeek.skydefender.event.EventConstants;
import com.thawfeek.skydefender.event.IEventDelegate;
import com.thawfeek.skydefender.flights.AbsFlight;
import com.thawfeek.skydefender.flights.low.BellP39;
import com.thawfeek.skydefender.flights.low.RedBarron;
import com.thawfeek.skydefender.hud.GameHud;
import com.thawfeek.skydefender.player.Player;
import com.thawfeek.skydefender.shop.IShopMenu;
import com.thawfeek.skydefender.shop.ItemData;
import com.thawfeek.skydefender.shop.ShopItemID;
import com.thawfeek.skydefender.shop.ShopMenu;
import com.thawfeek.skydefender.ui.uielements.IUserInterfaceItem;
import com.thawfeek.skydefender.ui.uielements.UICreator;
import com.thawfeek.skydefender.ui.uielements.UIMsgBox;
import com.thawfeek.skydefender.utils.EntityPool;

import flash.geom.Point;

import flash.geom.Rectangle;
import flash.utils.Dictionary;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Input;

public class GamePlay extends World implements IEventDelegate{

    private var backgroundImage:Backdrop;
    private var gameMusic:Sfx;
    private var player:Player   ;
    private var gameHud:GameHud;

    private static const STATE_GAME_PLAY:int = 0;
    private static const STATE_GAME_PAUSED:int = 1;
    private static const STATE_GAME_SHOP:int = 2;
    private static const STATE_NEW_LEVEL:int = 3;

    private var currentState:int = -1;
    private var prevState:int;
    private var currStateFunction:Function;

    private const BG_STACK_ORDER:int = 100;
    private const HUD_STACK_ORDER:int = 95;
    private const GAME_PLAY_HEIGHT:int = 350;
    private const GAME_PLAY_WIDTH:int  = 640;

    private var enemyFightList:Vector.<AbsFlight>;
    private var tempEnemyFlight:AbsFlight;
    private var enemyFlightArray:Array;
    private var enemyFlightWaveDelay:int = 30;
    private var enemyFlightPool:EntityPool;
    private var enemyTimeCount:Number=0;
    private var level:int;
    private var numEnemyFlights:int;
    private var enemyFlightCount:int;
    private var gamePlayArea:Rectangle;
    private var gameStarted:Boolean;
    private var playerScore:int;
    private var shopShowCase:IShopMenu;

    private var uiMsgBox:IUserInterfaceItem;
    private var uiScoreBoard:IUserInterfaceItem;

    private var scoreBoardElementDict:Dictionary;


    private var levelData:Array = [
            undefined,
            {
                enemyFlights:[RedBarron]
            },
            {
                enemyFlights:[BellP39]
            },
            {
                enemyFlights:[BellP39,RedBarron]
            }
    ];

    public function GamePlay() {
    }

    //TODO: Init function should be made sync with begin()
    private function init():void {
        player = Player.getInstance();
        gameHud = new GameHud(0,20);
        gameHud.layer = HUD_STACK_ORDER;
        gamePlayArea = new Rectangle();
        scoreBoardElementDict = new Dictionary(true);
        uiMsgBox = UICreator.createMsgBoxUI("Click to Start",new Point(FP.halfWidth-40,FP.halfHeight));
        backgroundImage = new Backdrop(EmbededAssets.GAME_BG_IMAGE);
        gameMusic = GameConfig.getInstance().addSound(EmbededAssets.GAME_MUSIC);
        uiScoreBoard = UICreator.createScoreElement(GameConstants.PLAYER_SCORE,"0",new Point(400,40));
        scoreBoardElementDict[GameConstants.PLAYER_SCORE] = uiScoreBoard;
        uiScoreBoard.show();

        //TODO: Shop Test function
        tempShopTest();
    }

    private function tempShopTest():void {
        shopShowCase = new ShopMenu(this,100, 200);
        var itemData:Array = [new ItemData("120m Bullet", EmbededAssets.SHOP_FW_BTN, "Heavy", 80, ShopItemID.BULLET_HEAVY),
                              new ItemData("90m Bullet", EmbededAssets.SHOP_FW_BTN, "Medium", 40, ShopItemID.BULLET_MEDIUM),
                              new ItemData("40m Bullet", EmbededAssets.SHOP_FW_BTN, "Normal", 20, ShopItemID.BULLET_SMALL),
                              new ItemData("Rapid Fire", EmbededAssets.SHOP_FW_BTN, "Pump Action", 140, ShopItemID.TURRET_RAPID_FIRE),
                              new ItemData("Silver Killer", EmbededAssets.SHOP_FW_BTN, "Hydraulic", 180, ShopItemID.TURRET_SILVER_KILLER),
                              new ItemData("Thunder Bolt", EmbededAssets.SHOP_FW_BTN, "Turbo Turret", 220, ShopItemID.TURRET_THUNDER_BOLT)
                             ];
        for (var i:int = 0 ,len:int = itemData.length; i < len; i++) {
            shopShowCase.addShopItem(itemData[i]);
        }
        //shopShowCase.showShopShowCase();
    }


    private function newLevel():void {
        switchState(STATE_GAME_PAUSED);
        uiMsgBox.show();
        if(level == levelData.length-1) level = 0;
        level++;
        enemyFlightCount = 0;
        enemyFlightArray = [];
        enemyFlightWaveDelay = (enemyFlightWaveDelay < 8) ? enemyFlightWaveDelay = 8 : enemyFlightWaveDelay = 11-(level*2);     //todo: need to change this
        numEnemyFlights      = (numEnemyFlights > 100 ) ? numEnemyFlights = 100 : numEnemyFlights  = 2;//level*10+3;
        numEnemyFlights      =  numEnemyFlights / levelData[level].enemyFlights.length;           //Re-calculate num Enemies based on level Data
        enemyFlightPool      = new EntityPool(numEnemyFlights, levelData[level].enemyFlights);
    }

    private function switchState(state:int):void {
        if(state != currentState){
            prevState = currentState;
            currentState = state;

            switch (currentState) {
                case STATE_GAME_PLAY:
                    gameStarted = true;
                    currStateFunction = runGame;
                break;

                case STATE_GAME_PAUSED:
                    gameStarted = false;
                    currStateFunction = checkForGameStart;
                break;

                case STATE_GAME_SHOP:
                     gameStarted = false;
                     currStateFunction = stubFunction;
                break;

                case STATE_NEW_LEVEL:
                    currStateFunction = stubFunction;
                    newLevel();
                break;
            }
        }

    }

    private function stubFunction():void {

    }

    private function checkForGameStart():void {
        if(Input.mousePressed){
            switchState(STATE_GAME_PLAY);
            uiMsgBox.hide();
        }
    }


    override public function begin():void {
        init();
        //GameConfig.getInstance().muteSounds(false);
        if(GameConfig.getInstance().isSoundOn()) gameMusic.loop();
        addGraphic(backgroundImage).layer = BG_STACK_ORDER;
        add(player);
        add(gameHud);
        gameHud.addUI(new Image(EmbededAssets.GAME_HUD_ICON_1),GameHud.HUD_UI_INFO_ITEM,"Fire Speed");
        gameHud.addUI(new Image(EmbededAssets.GAME_HUD_ICON_2),GameHud.HUD_UI_INFO_ITEM,"Primary weapon");
        gameHud.addUI(new Image(EmbededAssets.GAME_HUD_ICON_3),GameHud.HUD_UI_INFO_ITEM,"Seconday weapon");
        gameHud.show();

        gamePlayArea.x = 0;
        gamePlayArea.y = gameHud.y+gameHud.height;
        gamePlayArea.width = GAME_PLAY_WIDTH;
        gamePlayArea.height = GAME_PLAY_HEIGHT-gamePlayArea.x;

        switchState(STATE_NEW_LEVEL);
    }


    override public function update():void {
        currStateFunction();
        super.update();
    }
    private function checkForLevelEnd():void {
        checkEnemyFlights();
        if(enemyFlightArray.length == 0 && enemyFlightCount == numEnemyFlights){
            cleanUpLevel();
            player.cleanUp();
            switchState(STATE_GAME_SHOP);
            shopShowCase.showShopShowCase();
        }
    }

    private function checkEnemyFlights():void {
        for (var i:int = enemyFlightArray.length - 1; i >= 0; i--) {
            var enemyFlight:AbsFlight = enemyFlightArray[i];
            if(enemyFlight.isFinished()){
                enemyFlightArray.splice(i,1);
            }
        }
    }

    private function cleanUpLevel():void {
        enemyFlightPool.destroy();
    }

    private function generateEnemies():void {
        enemyTimeCount += FP.elapsed;

        if(enemyTimeCount > enemyFlightWaveDelay && enemyFlightCount < numEnemyFlights){
            enemyTimeCount -= enemyTimeCount;
            var rand:int = Math.floor(Math.random()*numEnemyFlights);
            tempEnemyFlight = AbsFlight(enemyFlightPool.getEntity(rand));
            var randomYPos:Number = gamePlayArea.y +tempEnemyFlight.height+ (Math.random()*(gamePlayArea.height/2));
            tempEnemyFlight.deploy(FP.width,randomYPos);
            tempEnemyFlight.destination(-tempEnemyFlight.width,randomYPos);
            enemyFlightArray.push(tempEnemyFlight);
            FP.world.add(tempEnemyFlight);
            enemyFlightCount++;
        }
    }

    public function isGameStarted():Boolean{
        return gameStarted;
    }

    public function updateScoreBoard(element:String,val:int):void {
       var targetValue:int;
       switch (element) {
           case GameConstants.PLAYER_SCORE:
               player.setScore(val);
               targetValue = player.getScore();
               break;
       }

       scoreBoardElementDict[element].setText(targetValue);
    }

    private function runGame():void {
        generateEnemies();
        checkForLevelEnd();
    }

    public function processEvent(type:String):void {
        switch (type){
            case EventConstants.SHOP_OK_BUTTON_CLICK:
                    shopShowCase.hideShopShowCase();
                    switchState(STATE_NEW_LEVEL);
                break;
        }
    }
}
}
