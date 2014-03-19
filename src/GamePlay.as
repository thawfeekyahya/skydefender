/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 3:35 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import enemy.flights.AbsFlight;

import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;

import player.Player;

import weapons.Bullet;

public class GamePlay extends World {

    private var backgroundImage:Backdrop;
    private var gameMusic:Sfx;
    private var player;
    private const IMAGE_STACK_ORDER:int = 100;

    private var enemyFightList:Vector.<AbsFlight>;
    private var enemyWaveDelay:int;
    private var enemyTimeCount:Number=0;
    private var level:int;

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
            trace("FIRE");
            enemyTimeCount -= enemyTimeCount;
        }
    }
}
}
