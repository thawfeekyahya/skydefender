/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 3:35 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.worlds {
import com.thawfeek.EmbededAssets;
import com.thawfeek.flights.AbsFlight;
import com.thawfeek.flights.AbsFlight;
import com.thawfeek.flights.low.BellP39;
import com.thawfeek.flights.low.RedBarron;
import com.thawfeek.hud.GameHud;
import com.thawfeek.player.Player;
import com.thawfeek.utils.EntityPool;

import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;
import net.flashpunk.graphics.Image;

public class GamePlay extends World {

    private var backgroundImage:Backdrop;
    private var gameMusic:Sfx;
    private var player:Entity   ;
    private var gameHud:GameHud;

    private const IMAGE_STACK_ORDER:int = 100;

    private var enemyFightList:Vector.<AbsFlight>;
    private var tempEnemyFlight:AbsFlight;
    private var enemyFlightWaveDelay:int = 30;
    private var enemyFlightPool:EntityPool;
    private var enemyTimeCount:Number=0;
    private var level:int;
    private var numEnemyFlights:int;


    private var levelData:Array = [
            undefined,
            {
                enemyFlights:[BellP39]
            }
    ];

    public function GamePlay() {
        init();
    }

    private function init():void {
        player = new Player();
        gameHud = new GameHud();
        backgroundImage = new Backdrop(EmbededAssets.GAME_BG_IMAGE);
        gameMusic = new Sfx(EmbededAssets.GAME_MUSIC);
    }


    private function newLevel():void {
        level++;
        enemyFlightWaveDelay = (enemyFlightWaveDelay < 8) ? enemyFlightWaveDelay = 8 : enemyFlightWaveDelay = 11-(level*2);     //todo: need to change this
        numEnemyFlights      = (numEnemyFlights > 100 ) ? numEnemyFlights = 100 : numEnemyFlights = level*10+3;
        numEnemyFlights      =  numEnemyFlights / levelData[level].enemyFlights.length;           //Re-calculate num Enemies based on level Data

        if(enemyFlightPool != null) enemyFlightPool.destroy();
        enemyFlightPool      = new EntityPool(numEnemyFlights, levelData[level].enemyFlights);
    }


    override public function begin():void {
        //        gameMusic.loop();
        addGraphic(backgroundImage).layer = IMAGE_STACK_ORDER;
        add(player);
        add(gameHud);
        gameHud.addUI(new Image(EmbededAssets.GAME_HUD_ICON_1),GameHud.HUD_UI_INFO_ITEM,"tool");
        gameHud.show();
        gameHud.setPosition(new Point(0,100));
        newLevel();
    }


    override public function update():void {
        makeEnemies();
        super.update();
    }

    private function makeEnemies():void {
        enemyTimeCount += FP.elapsed;
        if(enemyTimeCount > enemyFlightWaveDelay){
            enemyTimeCount -= enemyTimeCount;
            tempEnemyFlight = AbsFlight(enemyFlightPool.getEntity(int(Math.random()*numEnemyFlights)));
            var randomYPos:Number = Math.random()*FP.halfHeight-tempEnemyFlight.height;
            tempEnemyFlight.deploy(FP.width,randomYPos);
            tempEnemyFlight.destination(-tempEnemyFlight.width,randomYPos);
            FP.world.add(tempEnemyFlight);
        }
    }
}
}
