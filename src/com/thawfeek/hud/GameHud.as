
/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 6/5/14
 * Time: 9:34 AM
 *
 */
package com.thawfeek.hud {
import com.thawfeek.EmbededAssets;

import flash.utils.Dictionary;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Draw;

public class GameHud extends Entity {

    private var hudGraphic:Graphic;
    private var uiDict:Dictionary;

    public function GameHud(x:Number = 0, y:Number = 0) {
        super(x, y);
        hudGraphic = new Image(EmbededAssets.GAME_HUD_BG);
        uiDict = new Dictionary();
    }

    public function show():void {

    }

    public function hide():void {

    }
}
}
