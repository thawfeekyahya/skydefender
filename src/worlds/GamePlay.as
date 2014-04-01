/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 3:35 PM
 * To change this template use File | Settings | File Templates.
 */
package worlds {
import enemy.flights.AbsFlight;
import enemy.flights.low.BellP39;
import enemy.flights.low.RedBarron;

import net.flashpunk.Entity;

import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;

import player.Player;

import weapons.Bullet;

public class GamePlay extends World {

    private var backgroundImage:Backdrop;
    private var gameMusic:Sfx;
    private var player:Entity   ;
    private const IMAGE_STACK_ORDER:int = 100;

    private var enemyFightList:Vector.<AbsFlight>;
    private var tempEnemyFlight:AbsFlight;
    private var enemyWaveDelay:int;
    private var enemyTimeCount:Number=0;
    private var level:int;

    private var levelData:Array = [
            [{
                enemyFlights:[BellP39,RedBarron]
            }]
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
        enemyWaveDelay = (enemyWaveDelay < 30) ? enemyWaveDelay = 30 : enemyWaveDelay = 50-(level*2);     //todo: need to change this
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
        FP.log(FP.elapsed);
        if(enemyTimeCount > enemyWaveDelay){
            enemyTimeCount -= enemyTimeCount;
            tempEnemyFlight = new BellP39();
        }
    }
}
}
