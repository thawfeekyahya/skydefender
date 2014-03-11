/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 3:35 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;

import player.Player;

import weapons.Bullet;

public class GamePlay extends World {

    private var backgroundImage:Backdrop;
    private var gameMusic:Sfx;
    private var _player;
    private const IMAGE_STACK_ORDER:int = 100;

    public function GamePlay() {
        init();
    }


    override public function begin():void {
        addGraphic(backgroundImage).layer = IMAGE_STACK_ORDER;
        add(_player);
//        gameMusic.loop();
    }

    private function init():void {
        _player = new Player();

        backgroundImage = new Backdrop(Assets.GAME_BG_IMAGE);
        gameMusic = new Sfx(Assets.GAME_MUSIC);

    }


}
}
