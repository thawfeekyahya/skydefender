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
import com.thawfeek.flights.low.BellP39;
import com.thawfeek.flights.low.RedBarron;
import com.thawfeek.player.Player;
import com.thawfeek.utils.EntityPool;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;

public class GamePlay extends World {

    private var backgroundImage:Backdrop;
    private var gameMusic:Sfx;
    private var player:Entity   ;
    private const IMAGE_STACK_ORDER:int = 100;

    private var enemyFightList:Vector.<AbsFlight>;
    private var tempEnemyFlight:AbsFlight;
    private var enemyFlightWaveDelay:int = 30;
    private var enemyTimeCount:Number=0;
    private var level:int;
    private var numEnemyFlights:int;


    private var levelData:Array = [
            {
                enemyFlights:[BellP39,RedBarron]
            }
    ];

    public function GamePlay() {
        init();
    }

    private function init():void {
        player = new Player();
        backgroundImage = new Backdrop(EmbededAssets.GAME_BG_IMAGE);
        gameMusic = new Sfx(EmbededAssets.GAME_MUSIC);
    }

    private function newLevel():void {
        level++;
        enemyFlightWaveDelay = (enemyFlightWaveDelay < 8) ? enemyFlightWaveDelay = 8 : enemyFlightWaveDelay = 11-(level*2);     //todo: need to change this
        numEnemyFlights      = (numEnemyFlights > 100 ) ? numEnemyFlights = 100 : numEnemyFlights = level*10+3;
        numEnemyFlights      =  numEnemyFlights / levelData[level-1].enemyFlights.length;           //Re-calculate num Enemies based on level Data
        var enemyFlightPool:EntityPool = new EntityPool(numEnemyFlights,levelData[level-1].enemyFlights);
    }


    override public function begin():void {
        addGraphic(backgroundImage).layer = IMAGE_STACK_ORDER;
        add(player);
//        gameMusic.loop();
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
            tempEnemyFlight = new BellP39();
            tempEnemyFlight.deploy(FP.width,FP.height);
            tempEnemyFlight.destination(0,0);
            FP.world.add(tempEnemyFlight);
        }
    }
}
}
