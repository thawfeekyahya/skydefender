/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 17/4/14
 * Time: 4:48 PM
 *
 */
package com.thawfeek.test {
import com.thawfeek.EmbededAssets;

import net.flashpunk.Entity;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Image;
import net.flashpunk.tweens.misc.VarTween;

public class TestEntity extends Entity {
    private var angleTween:VarTween;

    public function TestEntity(x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null) {
        super(x, y, graphic, mask);

        /*this.graphic = new Image(EmbededAssets.PLAYER_TURRET_BASE);

        angleTween = new VarTween();
        angleTween.tween(Image(this.graphic),"angle",380,9);
        angleTween.start();*/
    }


    override public function update():void {
        super.update();
        angleTween.update();
    }
}
}
