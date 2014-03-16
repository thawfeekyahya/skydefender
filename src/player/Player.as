/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/24/14
 * Time: 9:52 PM
 * To change this template use File | Settings | File Templates.
 */
package player {
import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.Sfx;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Input;

import utils.EntityPool;
import weapons.Bullet;

public class Player extends Entity {

    public static var FIRE_DELAY_TIME:Number = 0.30;

    private var bulletSpeed:int = 5;
    private var turretBase:Image;
    private var turret:Image;
    private var bulletPool:EntityPool;
    private var bulletVect:Vector.<Bullet> = new Vector.<Bullet>();
    private var delayTime:Number = 0;
    private var sfxShoot:Sfx;

    public function Player(x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null) {
        super(x, y, graphic, mask);
        init();
    }


    override public function added():void {
        super.added();
    }


    private function init():void {
        turretBase = new Image(Assets.PLAYER_TURRET_BASE);
        turret     = new Image(Assets.PLAYER_TURRET);

        graphic = new Graphiclist(turret,turretBase);

        //Set Base in Center
        turretBase.x = 0;
        turretBase.y = FP.height - turretBase.height - 20;

        //Set Turret Position
        turret.originY = turret.height/2 ;
        turret.originX = -20;
        turret.x = turretBase.x+turretBase.width/2;
        turret.y = turretBase.y + 30;
        turret.smooth = true;
        turret.angle = 90;

        //Create Pool Objects
        bulletPool = new EntityPool(Bullet,500);

        //Create Sounds
        sfxShoot =new Sfx(Assets.PLAYER_SHOOT_BASIC);
    }


    override public function update():void {
        moveTurret();
        checkBullets();
        checkMouseInput();
        super.update();
    }

    private function checkBullets():void {
        for (var i:int = bulletVect.length - 1; i >= 0; i--) {
            var bullet:Bullet = bulletVect[i];
            if(bullet.x > FP.width || bullet.x <0 || bullet.y > FP.height || bullet.y < 0){
                bulletPool.putEntity(bullet);
                FP.world.remove(bullet);
                bulletVect.splice(i,1);
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
        if(delayTime > FIRE_DELAY_TIME) {
            sfxShoot.play();
            delayTime -= FIRE_DELAY_TIME;
            var bullet:Bullet = Bullet(FP.world.add(bulletPool.getEntity()));
            bullet.x = turret.x;
            bullet.y = turret.y;
            var dx:Number = Input.mouseX - turret.x;
            var dy:Number = Input.mouseY - turret.y;
            var angle:Number = Math.atan2(dy,dx);
            bullet.setAngle(angle);
            Image(bullet.graphic).angle  = turret.angle;
            bullet.setSpeed(bulletSpeed);
            bulletVect.push(bullet);
        }
    }

    private function moveTurret():void {
        turret.angle = FP.angle(turret.x,turret.y,Input.mouseX,Input.mouseY);
    }

    public function setBulletSpeed(value:int):void {
        this.bulletSpeed = value;
    }
}
}
