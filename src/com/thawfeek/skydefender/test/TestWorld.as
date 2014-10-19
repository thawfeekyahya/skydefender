/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 17/4/14
 * Time: 4:48 PM
 *
 */
package com.thawfeek.skydefender.test {
import com.thawfeek.skydefender.flights.AbsFlight;
import com.thawfeek.skydefender.flights.low.RedBarron;
import com.thawfeek.skydefender.player.weapons.bullets.BulletMedium;
import com.thawfeek.skydefender.player.weapons.bullets.BulletSmall;

import net.flashpunk.Entity;

import net.flashpunk.World;
import net.flashpunk.utils.Input;

public class TestWorld extends World {
    private var bulletArray:Array = [];

    private var bulletPoolArray = [];
    public function TestWorld() {

        super();
        init();
    }

    private function init():void {

        for (var i:int = 0; i < 500; i++) {
            var e:Entity = create(BulletSmall);
            bulletPoolArray.push(e);
        }

        var testEntity = new TestEntity();
        add(testEntity);

        testEntity.x = 100;
        testEntity.y = 200;
    }


    override public function update():void {
        super.update();
        checkInput();
        checkBullet();
    }

    private function checkBullet():void {
        for (var i:int = bulletArray.length - 1; i >= 0; i--) {
            var bulletSmall:BulletSmall = bulletArray[i];
            if(bulletSmall.isFinished()){
                remove(bulletSmall);
                bulletArray.splice(i,1);
                bulletPoolArray.push(bulletSmall);
            }

        }
    }

    private function checkInput():void {
        if(Input.mouseDown){
            var bullet:BulletSmall = bulletPoolArray.pop() as BulletSmall;
            bulletArray.push(bullet);
            bullet.finished = false;
            bullet.x = 0;
            bullet.y = 0;
            bullet.setSpeed(4);
            bullet.setAngle(Math.atan2(mouseY,mouseX));
            add(bullet);
        }
    }
}
}
