/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 7/3/14
 * Time: 3:18 PM
 *
 */
package com.thawfeek.skydefender.player.weapons.bullets {
import com.thawfeek.skydefender.EmbededAssets;
import com.thawfeek.skydefender.SoundManager;
import com.thawfeek.skydefender.GameConstants;
import com.thawfeek.skydefender.player.weapons.*;

import net.flashpunk.FP;
import net.flashpunk.graphics.Image;

public class BulletSmall extends AbsWeapon {

    private var angle:Number;
    private var speed:Number = 0.2;
    private var finished:Boolean;
    private const LAYER_STACK_ORDER:int = 90;



    public function BulletSmall() {
        this.layer = LAYER_STACK_ORDER;
        this.speed = speed;
        this.angle = angle;
        this.graphic = new Image(EmbededAssets.PLAYER_BULLET_SMALL);
        this.type = GameConstants.PLAYER_BULLET;
        this.power = 2;
        Image(this.graphic).centerOrigin();
        weaponHitSound = SoundManager.getInstance().addSound(EmbededAssets.SFX_BULLET_HIT);
    }


    override public function added():void {
        super.added();
        this.finished = false;
    }

    override public function update():void {
        this.x += Math.cos(angle)*speed;
        this.y += Math.sin(angle)*speed;
        if(this.x > FP.width || this.x < 0 || this.y > FP.height || this.y < 0){
            this.finished = true;
        }
        super.update();
    }

    public function setSpeed(value:Number):void {
        this.speed = value;
    }
    public function setAngle(value:Number):void {
        this.angle = value;
    }

    public function isFinished():Boolean {
       return this.finished;
    }

}
}
