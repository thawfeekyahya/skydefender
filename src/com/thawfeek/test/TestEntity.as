/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 17/4/14
 * Time: 4:48 PM
 *
 */
package com.thawfeek.test {
import com.thawfeek.EmbededAssets;

import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;

import net.flashpunk.Entity;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Image;
import net.flashpunk.graphics.Text;
import net.flashpunk.tweens.misc.VarTween;

public class TestEntity extends Entity {
    private var angleTween:VarTween;

    public function TestEntity(x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null) {
        super(x, y, graphic, mask);

        /*this.graphic = new Image(EmbededAssets.PLAYER_TURRET_BASE);

        angleTween = new VarTween();
        angleTween.tween(Image(this.graphic),"angle",380,9);
        angleTween.start();*/

       /* var img:Image = new Image(EmbededAssets.GAME_HUD_BG);
        var bitData:BitmapData = img.getSrcBitmapData();

        var colorTransform:ColorTransform = new ColorTransform();
        colorTransform.color = 0x00FF00;
        bitData.colorTransform(new Rectangle(0,0,img.width,img.height),colorTransform);

        var imag2:Image = new Image(bitData);
        this.graphic= imag2;*/
        EmbededAssets;
        Text.font = "Arial";
        Text.size = 6;
        var text:Text = new Text("");
        text.font = "Arial";
        text.width = 100;
        text.wordWrap = true;
        text.text= "Hi Hello this is a long word in a sing line to test flash punk text property center align";


        addGraphic(text);
    }


    override public function update():void {
        super.update();
       // angleTween.update();
    }
}
}
