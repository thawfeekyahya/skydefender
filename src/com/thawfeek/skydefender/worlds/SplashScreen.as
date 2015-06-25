/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 11:13 AM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.worlds {
import com.thawfeek.skydefender.EmbededAssets;

import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.graphics.Backdrop;
import net.flashpunk.graphics.Text;
import net.flashpunk.utils.Button;

public class SplashScreen extends World {


    private var startButton:Button;
    private var creditsButton:Button;
    private var image:Backdrop;


    public function SplashScreen() {
        init();
    }

    private function init():void {
        image = new Backdrop(EmbededAssets.SPLASH_SCREEN_IMAGE);
        addGraphic(image);
        startButton     = new Button("Play",startButtonClicked,FP.halfWidth,FP.halfHeight,100,50);
        creditsButton   = new Button("Credits",creditClicked,FP.halfWidth,FP.halfHeight+20,100,50);
    }

    private function startButtonClicked():void {
        removeAll();
        FP.world = new GamePlay();
    }

    private function creditClicked():void {

    }

    override public function end():void {
        removeAll();
        super.end();
    }

    override public function begin():void {
        add(startButton);
        add(creditsButton)
    }
}
}
