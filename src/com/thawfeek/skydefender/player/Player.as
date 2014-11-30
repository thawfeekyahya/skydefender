/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/24/14
 * Time: 9:52 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.player {
import com.thawfeek.skydefender.EmbededAssets;
import com.thawfeek.skydefender.SoundManager;
import com.thawfeek.skydefender.GameConstants;
import com.thawfeek.skydefender.player.weapons.AbsWeapon;
import com.thawfeek.skydefender.player.weapons.WeaponConstants;
import com.thawfeek.skydefender.player.weapons.bullets.BulletHeavy;
import com.thawfeek.skydefender.player.weapons.bullets.BulletMedium;
import com.thawfeek.skydefender.player.weapons.bullets.BulletSmall;
import com.thawfeek.skydefender.shop.ItemData;
import com.thawfeek.skydefender.utils.EntityPool;
import com.thawfeek.skydefender.worlds.GamePlay;

import flash.utils.Dictionary;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.Sfx;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Input;

public class Player extends Entity {


    private const BULLET_COUNT:int = 500;
    private static var instance:Player;

    public static function getInstance():Player {
        if (!Player.instance) {
            Player.instance = new Player(new Dummy());
        }
        return Player.instance;
    }

    public function Player(dummy:Dummy, x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null) {
        bulletVect = new Vector.<BulletSmall>();
        super(x, y, graphic, mask);
        init();
    }

    private var fireDelay:Number;
    private var bulletSpeed:int;
    private var turretBase:Image;
    private var turret:Image;
    private var bulletPool:EntityPool;
    private var bulletVect:Vector.<BulletSmall>;
    private var delayTime:Number = 0;
    private var sfxShoot:Sfx;
    private var score:int;
    private var gList:Graphiclist;
    private var weaponNameList:Dictionary;
    private var currPrimaryWep:String;
    private var currSecondaryWep:String;
    private var currTurret:String;
    private var _health:int;

    override public function added():void {
        health = 10;
        super.added();
    }

    override public function update():void {
        moveTurret();
        checkBullets();
        checkMouseInput();
        checkCollision();
        super.update();
    }

    private function checkCollision():void {
        var enemyBullet:AbsWeapon = this.collide(GameConstants.ENEMY_BULLET,this.x,this.y) as AbsWeapon;
        if(enemyBullet){
            checkHealth(enemyBullet.getPower());
            enemyBullet.collidable = false;
        }
    }

    private function checkHealth(power:int):void {
        if (health - power > 0) {
            health -= power;
        }  else {
            health = 0;
        }

        GamePlay(world).updateScoreBoard(GameConstants.PLAYER_HEALTH, health);
    }

    public function buyShopItem(itemData:ItemData):void {
        var id:int = itemData.getID();
        var price:int = itemData.getPrice();
        switch (id) {
            case WeaponConstants.BULLET_HEAVY:
                setBullet(WeaponConstants.BULLET_HEAVY);
                break;
            case WeaponConstants.BULLET_MEDIUM:
                setBullet(WeaponConstants.BULLET_MEDIUM);
                break;
            case WeaponConstants.BULLET_SMALL:
                setBullet(WeaponConstants.BULLET_SMALL);
                break;
            case WeaponConstants.TURRET_RAPID_FIRE:
                setTurret(WeaponConstants.TURRET_RAPID_FIRE);
                break;
            case WeaponConstants.TURRET_SILVER_KILLER:
                setTurret(WeaponConstants.TURRET_SILVER_KILLER);
                break;
            case WeaponConstants.TURRET_THUNDER_BOLT:
                setTurret(WeaponConstants.TURRET_THUNDER_BOLT);
                break;

        }
        GamePlay(world).updateScoreBoard(GameConstants.PLAYER_SCORE, -price);
    }

    public function setScore(val:int):void {
        this.score += val;
    }

    public function getScore():int {
        return this.score;
    }

    public function cleanUp():void {
        for (var i:int = bulletVect.length - 1; i >= 0; i--) {
            var bullet:BulletSmall = bulletVect[i];
            bulletVect.splice(i, 1);
            FP.world.remove(bullet);
        }
    }

    public function getWeaponInfo():Object {
        return {primeWep: currPrimaryWep, secWep: currSecondaryWep, turret: currTurret};
    }

    private function init():void {

        currPrimaryWep = "";
        currSecondaryWep = "";
        currTurret = "";

        gList = new Graphiclist();

        turretBase = new Image(EmbededAssets.PLAYER_TURRET_BASE);
        turretBase.x = 0;
        turretBase.y = FP.height - turretBase.height - 8;

        //Create Sounds
        sfxShoot = SoundManager.getInstance().addSound(EmbededAssets.PLAYER_SHOOT_BASIC);
        weaponNameList = new Dictionary();
        weaponNameList[WeaponConstants.BULLET_HEAVY] = "120m";
        weaponNameList[WeaponConstants.BULLET_MEDIUM] = "40m";
        weaponNameList[WeaponConstants.BULLET_SMALL] = "20m";
        weaponNameList[WeaponConstants.TURRET_RAPID_FIRE] = "Rapid Fire";
        weaponNameList[WeaponConstants.TURRET_BASIC] = "Turret Basic";
        weaponNameList[WeaponConstants.TURRET_THUNDER_BOLT] = "Thunder Bolt";
        weaponNameList[WeaponConstants.TURRET_SILVER_KILLER] = "Silver Killer";

        setTurret(WeaponConstants.TURRET_BASIC);
        setBullet(WeaponConstants.BULLET_SMALL);

        this.graphic = gList;
    }

    private function checkBullets():void {
        for (var i:int = bulletVect.length - 1; i >= 0; i--) {
            var bullet:BulletSmall = bulletVect[i];
            if (bullet.isFinished()) {
                bulletPool.putEntity(bullet);
                bulletVect.splice(i, 1);
                FP.world.remove(bullet);
            }
        }
    }

    private function checkMouseInput():void {
        if (Input.mouseDown && GamePlay(FP.world).isGameStarted()) {
            fireBullets();
        }
    }

    private function fireBullets():void {
        delayTime += FP.elapsed;
        if (delayTime > fireDelay) {
            if (SoundManager.getInstance().isSoundOn()) sfxShoot.play();
            delayTime -= fireDelay;
            var rand:int = Math.random() * BULLET_COUNT;
            var bullet:BulletSmall = BulletSmall(FP.world.add(bulletPool.getEntity(rand)));
            var dx:Number = Input.mouseX - turret.x;
            var dy:Number = Input.mouseY - turret.y;
            var angle:Number = Math.atan2(dy, dx);
            bullet.x = turret.x;
            bullet.y = turret.y;
            bullet.setAngle(angle);
            Image(bullet.graphic).angle = turret.angle;
            bullet.setSpeed(bulletSpeed);
            bulletVect.push(bullet);
        }
    }

    private function moveTurret():void {
        if (GamePlay(FP.world).isGameStarted()) {
            turret.angle = FP.angle(turret.x, turret.y, Input.mouseX, Input.mouseY);
        }
    }

    private function setBullet(type:int):void {
        if (bulletPool != null) bulletPool.destroy();

        switch (type) {

            case WeaponConstants.BULLET_HEAVY:
                bulletPool = new EntityPool(BULLET_COUNT, [BulletHeavy]);
                break;

            case WeaponConstants.BULLET_MEDIUM:
                bulletPool = new EntityPool(BULLET_COUNT, [BulletMedium]);
                break;

            case WeaponConstants.BULLET_SMALL:
                bulletPool = new EntityPool(BULLET_COUNT, [BulletSmall]);
                break;
        }

        currPrimaryWep = weaponNameList[type];
    }

    private function setTurret(type:int):void {
        switch (type) {

            case WeaponConstants.TURRET_BASIC:
                fireDelay = 0.30;
                bulletSpeed = 5;
                turret = new Image(EmbededAssets.TURRET_BASIC);
                break;

            case WeaponConstants.TURRET_RAPID_FIRE:
                fireDelay = 0.20;
                bulletSpeed = 10;
                turret = new Image(EmbededAssets.TURRET_RAPID_FIRE);
                break;

            case WeaponConstants.TURRET_SILVER_KILLER:
                fireDelay = 0.15;
                bulletSpeed = 15;
                turret = new Image(EmbededAssets.TURRET_BASIC);
                break;

            case WeaponConstants.TURRET_THUNDER_BOLT:
                fireDelay = 0.10;
                bulletSpeed = 20;
                turret = new Image(EmbededAssets.TURRET_BASIC);
                break;
        }

        currTurret = weaponNameList[type];

        //Set Turret Position
        turret.originY = turret.height / 2;
        turret.originX = -20;
        turret.x = turretBase.x + turretBase.width / 2;
        turret.y = turretBase.y + 22;
        turret.smooth = true;
        turret.angle = 90;

        if (gList.count > 0) gList.removeAll();
        gList.add(turret);
        gList.add(turretBase);
        setHitboxTo(turretBase);
    }

    public function get health():int {
        return _health;
    }

    public function set health(value:int):void {
        _health = value;
    }
}
}

internal class Dummy {

}
