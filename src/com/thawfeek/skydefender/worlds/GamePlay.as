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
import com.thawfeek.skydefender.flights.AbsFlight;
import com.thawfeek.skydefender.flights.low.BellP39;
import com.thawfeek.skydefender.flights.low.RedBarron;
import com.thawfeek.skydefender.hud.GameHud;
import com.thawfeek.skydefender.player.Player;
import com.thawfeek.skydefender.ui.uielements.IUserInterfaceItem;
import com.thawfeek.skydefender.ui.uielements.UICreator;
import com.thawfeek.skydefender.ui.uielements.UIMsgBox;
import com.thawfeek.skydefender.utils.EntityPool;

import flash.geom.Point;

import flash.geom.Rectangle;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Input;

public class GamePlay extends World {

    private var backgroundImage:Backdrop;
    private var gameMusic:Sfx;
    private var player:Entity   ;
    private var gameHud:GameHud;

    private const IMAGE_STACK_ORDER:int = 100;
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
    private var uiMsgBox:IUserInterfaceItem;


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
        init();
    }

    private function init():void {
        player = new Player();
        gameHud = new GameHud(0,20);
        gamePlayArea = new Rectangle();
        uiMsgBox = UICreator.createMsgBoxUI("Click to Start",new Point(FP.halfWidth,FP.halfHeight));
        backgroundImage = new Backdrop(EmbededAssets.GAME_BG_IMAGE);
        gameMusic = GameConfig.getInstance().addSound(EmbededAssets.GAME_MUSIC);
    }


    private function newLevel():void {
        level++;
        enemyFlightCount = 0;
        enemyFlightArray = [];
        enemyFlightWaveDelay = (enemyFlightWaveDelay < 8) ? enemyFlightWaveDelay = 8 : enemyFlightWaveDelay = 11-(level*2);     //todo: need to change this
        numEnemyFlights      = (numEnemyFlights > 100 ) ? numEnemyFlights = 100 : numEnemyFlights  = 2;//level*10+3;
        numEnemyFlights      =  numEnemyFlights / levelData[level].enemyFlights.length;           //Re-calculate num Enemies based on level Data
        enemyFlightPool      = new EntityPool(numEnemyFlights, levelData[level].enemyFlights);
    }


    override public function begin():void {
        //GameConfig.getInstance().muteSounds(false);
        if(GameConfig.getInstance().isSoundOn()) gameMusic.loop();
        addGraphic(backgroundImage).layer = IMAGE_STACK_ORDER;
        add(player);
        add(gameHud);
        add(uiMsgBox as Entity);
        uiMsgBox.show();
        gameHud.addUI(new Image(EmbededAssets.GAME_HUD_ICON_1),GameHud.HUD_UI_INFO_ITEM,"Fire Speed");
        gameHud.addUI(new Image(EmbededAssets.GAME_HUD_ICON_2),GameHud.HUD_UI_INFO_ITEM,"Primary weapon");
        gameHud.addUI(new Image(EmbededAssets.GAME_HUD_ICON_3),GameHud.HUD_UI_INFO_ITEM,"Seconday weapon");
        gameHud.show();

        gamePlayArea.x = 0;
        gamePlayArea.y = gameHud.y+gameHud.height;
        gamePlayArea.width = GAME_PLAY_WIDTH;
        gamePlayArea.height = GAME_PLAY_HEIGHT-gamePlayArea.x;

        newLevel();
    }


    override public function update():void {
        if(!gameStarted){
            if(Input.mousePressed){
                gameStarted = true;
                uiMsgBox.hide();
            }
        }
        if (gameStarted) {
            generateEnemies();
            checkForLevelEnd();
            super.update();
        }
    }

    private function checkForLevelEnd():void {
        checkEnemyFlights();
        if(enemyFlightArray.length == 0 && enemyFlightCount == numEnemyFlights){
            gameStarted = false;
            cleanUpLevel();
            newLevel();
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
}
}
