/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 11/23/13
 * Time: 12:35 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek {
import com.thawfeek.test.TestWorld;
import com.thawfeek.worlds.SplashScreen;

import net.flashpunk.Engine;
import net.flashpunk.FP;

[SWF(width=640,height=480)]
public class SkyDefender extends Engine {
    public function SkyDefender() {
        super(640, 480, 60, false);
    }

    override public function init():void {
        super.init();
        FP.console.enable();
        FP.world = new TestWorld();
//        FP.world = new SplashScreen();
    }
}
}
