/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 3:35 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import net.flashpunk.Sfx;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;

public class GamePlay extends World {

    private var backgroundImage:Backdrop;
    private var gameMusic:Sfx;


    public function GamePlay() {
        init();
    }


    override public function begin():void {
        addGraphic(backgroundImage);
        gameMusic.loop();
    }

    private function init():void {
        backgroundImage = new Backdrop(Assets.GAME_BG_IMAGE);
        gameMusic = new Sfx(Assets.GAME_MUSIC);
    }
}
}
