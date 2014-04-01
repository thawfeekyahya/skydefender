/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 3:35 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import enemy.flights.AbsFlight;
import enemy.flights.low.BellP39;
import enemy.flights.low.RedBarron;

import net.flashpunk.Entity;

import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;

import player.Player;

import utils.EntityPool;

import weapons.Bullet;

public class GamePlay extends World {

    private var backgroundImage:Backdrop;
    private var gameMusic:Sfx;
    private var player;
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
        backgroundImage = new Backdrop(Assets.GAME_BG_IMAGE);
        gameMusic = new Sfx(Assets.GAME_MUSIC);

    }

    private function newLevel():void {
        level++;
        enemyFlightWaveDelay = (enemyFlightWaveDelay < 8) ? enemyFlightWaveDelay = 8 : enemyFlightWaveDelay = 20-(level*2);     //todo: need to change this
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
