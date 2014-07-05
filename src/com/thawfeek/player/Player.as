/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/24/14
 * Time: 9:52 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.player {
import com.thawfeek.EmbededAssets;
import com.thawfeek.player.weapons.BulletHeavy;
import com.thawfeek.player.weapons.BulletMedium;
import com.thawfeek.player.weapons.BulletSmall;
import com.thawfeek.utils.EntityPool;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.Sfx;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Input;

public class Player extends Entity {

    public static const TURRET_BASIC:int = 0;
    public static const TURRET_RAPID_FIRE:int = 1;
    public static const TURRET_SILVER_KILLER:int = 2;
    public static const TURRET_THUNDER_BOLT:int = 3;

    public static const BULLET_SMALL:int = 0;
    public static const BULLET_MEDIUM:int = 1;
    public static const BULLET_HEAVY:int = 3;

    private var fireDelay:Number;
    private var bulletSpeed:int;
    private var turretBase:Image;
    private var turret:Image;
    private var bulletPool:EntityPool;
    private var bulletVect:Vector.<BulletSmall> = new Vector.<BulletSmall>();
    private var delayTime:Number = 0;
    private var sfxShoot:Sfx;
    private const BULLET_COUNT:int = 500;

    public function Player(x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null) {
        super(x, y, graphic, mask);
        init();
    }


    override public function added():void {
        super.added();
    }


    private function init():void {
        setTurret(TURRET_RAPID_FIRE);

        turretBase = new Image(EmbededAssets.PLAYER_TURRET_BASE);

        graphic = new Graphiclist(turret,turretBase);

        //Set Base in Center
        turretBase.x = 0;
        turretBase.y = FP.height - turretBase.height - 8;

        //Set Turret Position
        turret.originY = turret.height/2 ;
        turret.originX = -20;
        turret.x = turretBase.x+turretBase.width/2;
        turret.y = turretBase.y+22;
        turret.smooth = true;
        turret.angle = 90;

        //Create Pool Objects
        setBullet(BULLET_MEDIUM);

        //Create Sounds
        sfxShoot =new Sfx(EmbededAssets.PLAYER_SHOOT_BASIC);
    }


    override public function update():void {
        moveTurret();
        checkBullets();
        checkMouseInput();
        super.update();
    }

    private function checkBullets():void {
        for (var i:int = bulletVect.length - 1; i >= 0; i--) {
            var bullet:BulletSmall = bulletVect[i];
            if(bullet.x > FP.width || bullet.x <0 || bullet.y > FP.height || bullet.y < 0 ){
                bulletPool.putEntity(bullet);
                bulletVect.splice(i,1);
                FP.world.remove(bullet);
            }
        }
    }

    private function checkMouseInput():void {
        if(Input.mouseDown){
           fireBullets();
        }
    }

    private function fireBullets():void {
        delayTime += FP.elapsed;
        if(delayTime > fireDelay) {
            sfxShoot.play();
            delayTime -= fireDelay;
            var rand:int =  Math.random()*BULLET_COUNT;
            var bullet:BulletSmall = BulletSmall(FP.world.add(bulletPool.getEntity(rand)));
            var dx:Number = Input.mouseX - turret.x;
            var dy:Number = Input.mouseY - turret.y;
            var angle:Number = Math.atan2(dy,dx);
            bullet.x = turret.x;
            bullet.y = turret.y;
            bullet.setAngle(angle);
            Image(bullet.graphic).angle  = turret.angle;
            bullet.setSpeed(bulletSpeed);
            bulletVect.push(bullet);
        }
    }

    private function moveTurret():void {
        turret.angle = FP.angle(turret.x,turret.y,Input.mouseX,Input.mouseY);
    }

    public function setBullet(type:int):void {
        switch (type){

            case BULLET_HEAVY:
                 if(bulletPool !=null) bulletPool.destroy();
                 bulletPool = new EntityPool(BULLET_COUNT,[BulletHeavy]);
            break;

            case BULLET_MEDIUM:
                if(bulletPool !=null) bulletPool.destroy();
                bulletPool = new EntityPool(BULLET_COUNT,[BulletMedium]);
            break;

            case BULLET_SMALL:
                if(bulletPool !=null) bulletPool.destroy();
                bulletPool = new EntityPool(BULLET_COUNT,[BulletSmall]);
            break;
        }
    }


    public function setTurret(type:int):void {
        switch (type){

            case TURRET_BASIC:
                fireDelay = 0.30;
                bulletSpeed = 5;
                turret     = new Image(EmbededAssets.TURRET_BASIC);
            break;

            case TURRET_RAPID_FIRE:
                fireDelay = 0.20;
                bulletSpeed = 10;
                turret     = new Image(EmbededAssets.TURRET_RAPID_FIRE);
            break;

            case TURRET_SILVER_KILLER:
                fireDelay = 0.15;
                bulletSpeed = 15;
                turret     = new Image(EmbededAssets.TURRET_BASIC);
            break;

            case TURRET_THUNDER_BOLT:
                fireDelay = 0.10;
                bulletSpeed = 20;
                turret     = new Image(EmbededAssets.TURRET_BASIC);
            break;
        }

    }
}
}
