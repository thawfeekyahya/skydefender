/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 11/8/14
 * Time: 1:01 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.worlds {
import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.graphics.Text;
import net.flashpunk.utils.Button;

public class GameOverScreen extends World {
    public function GameOverScreen() {
        init();
    }

    private function init():void {
        Text.font = "Arial";
        Text.size = 18;
        removeAll();
        var btn:Button = new Button("Replay",onMainMenuClick,FP.halfWidth,FP.halfHeight);
        add(btn);
    }

    private function onMainMenuClick():void {
        removeAll();
        FP.world = new SplashScreen();
    }
}
}
