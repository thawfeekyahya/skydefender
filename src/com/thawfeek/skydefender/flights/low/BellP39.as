/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 3/19/14
 * Time: 10:15 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.flights.low {
import com.thawfeek.skydefender.EmbededAssets;
import com.thawfeek.skydefender.GameConfig;
import com.thawfeek.skydefender.flights.AbsFlight;
import com.thawfeek.skydefender.player.Player;
import com.thawfeek.skydefender.player.weapons.AbsWeapon;
import com.thawfeek.skydefender.flights.missiles.P39Bomb;
import com.thawfeek.skydefender.flights.missiles.P39Bomb;
import com.thawfeek.skydefender.utils.EntityPool;

import flash.geom.Point;

import net.flashpunk.Entity;

import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.Tween;
import net.flashpunk.graphics.Image;
import net.flashpunk.graphics.Spritemap;
import net.flashpunk.tweens.misc.VarTween;
import net.flashpunk.tweens.motion.LinearPath;

public class BellP39 extends AbsFlight {

    private var linearPath:LinearPath;
    private var angleTween:VarTween;
    private var sfxExplosion:Sfx;
    private var missileDropDelay:int;
    private var missileArray:Array;
    private var missilePool:EntityPool;
    private var missileCount:int;
    private static var EXPLODE_ANIM:String = "explodeAnim";

    private var explodeAnim:Spritemap;

    private static var MAX_MISSILE:int = 6;


    public function BellP39(moveSpeed:int = 2) {
        super(moveSpeed);
        var img:Image = new Image(EmbededAssets.ENEMY_FLIGHT_P39);
        graphicList.add(img);
        this.width = img.width;
        this.height = img.height;
        this.centerOrigin();
        img.centerOrigin();

        missilePool = new EntityPool(MAX_MISSILE,[P39Bomb])

        sfxExplosion = GameConfig.getInstance().addSound(EmbededAssets.SFX_ENEMY_EXPLODE);

        var onAnimComplete:Function = function ():void {
            explodeAnim.visible = false;
            finished = true;
        };

        var frameWidth:int = 200;
        var frameHeight:int = 200;
        explodeAnim = new Spritemap(EmbededAssets.ENEMY_FLIGHT_EXPLODE_ANIM, frameWidth, frameHeight, onAnimComplete);
        explodeAnim.originX = frameWidth >> 1;
        explodeAnim.originY = frameHeight >> 1;
        explodeAnim.add(EXPLODE_ANIM, [0, 1, 2, 3, 4, 5, 6, 7], 12, false);
        this.graphicList.add(explodeAnim);

        var flightImg:Image = Image(this.graphicList.children[0]);
        angleTween = new VarTween(null, Tween.ONESHOT);
        angleTween.tween(flightImg, "angle", 60, 1);
    }


    override public function added():void {
        missileArray = [];
        health = 5;
        hitScore = 20;
        explodeAnim.visible = false;
        missilePool.resetPool();
        missileCount = 0;
        super.added();
    }

    override public function attack():void {
        if(this.x <  300) {
             dropMissile();
        }
    }

    private var tempMissile:AbsWeapon;
    private function dropMissile():void {
        missileDropDelay--;
         if(missileDropDelay <= 0 && missileCount < MAX_MISSILE){
             missileDropDelay = 30;
             tempMissile = missilePool.getEntity(Math.random()*missilePool.length) as AbsWeapon;
             tempMissile.setPos(new Point(this.x,this.y));
             FP.world.add(tempMissile);
             missileCount++;
         }
    }

    override public function update():void {
        if (!isShotDown) {
            this.moveTowards(getDestinationPoint().x, getDestinationPoint().y, getSpeed());
            attack();
        } else {
            angleTween.update();
            this.x = linearPath.x;
            this.y = linearPath.y;
        }
        if (this.finished) {
            cleanUp();
        }

        super.update();
    }


    override protected function cleanUp():void {
        restImage();
        clearTweens();
        clearMissiles();
        super.cleanUp();
    }

    private function clearMissiles():void {
        for (var i:int = missileArray.length - 1; i >= 0; i--) {
            var weapon:AbsWeapon = missileArray[i];
            missileArray.splice(i,1);
        }
        missileArray = [];
    }

    override protected function shotDown():void {

        angleTween.start();
        linearPath = new LinearPath(explode, Tween.ONESHOT);
        linearPath.addPoint(this.x, this.y);
        linearPath.addPoint(this.x - 200, FP.height - this.height - 20);
        var speed:Number;
        (this.x < FP.halfHeight) ? speed = 2 : speed = 1;
        linearPath.setMotion(speed);
        addTween(linearPath, true);

    }

    private function restImage():void {
        var flightImg:Image = Image(this.graphicList.children[0]);
        flightImg.angle = 0;
    }

    private function explode():void {
        if (!sfxExplosion.playing && GameConfig.getInstance().isSoundOn()) sfxExplosion.play();
        explodeAnim.visible = true;
        explodeAnim.setAnimFrame(EXPLODE_ANIM, 0);
        explodeAnim.play(EXPLODE_ANIM);
    }


    override public function removed():void {
       /* explodeAnim = null;
        angleTween = null;
        linearPath = null;
        sfxExplosion = null;
        graphicList.removeAll();*/
        sfxExplosion.stop();
        super.removed();

    }
}
}
