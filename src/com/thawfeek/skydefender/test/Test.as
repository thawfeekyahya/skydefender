/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 5/9/14
 * Time: 10:02 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.test {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

public class Test extends Sprite {
    public function Test() {
       init();
    }

    private var hero:Sprite;
    private var bullets:Array=[];

    private function init():void {
        hero = new Sprite();
        hero.graphics.beginFill(0xff0000);
        hero.graphics.drawRect(0,0,50,50);
        hero = hero;
        hero.graphics.endFill();
        hero.y = stage.stageHeight-hero.height;
        addChild(hero);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
        addEventListener(Event.ENTER_FRAME, update);

        stage.addChild(new Bullet(300,200));
        stage.removeChildAt(1);
    }

    private function update(e:Event):void {
        var count:int = bullets.length-1;
        for (var i:int = count; i >= 0; i--) {
            var bullet:Sprite = bullets[i];
            bullet.x += 5;
            if(bullet.x > stage.stageWidth || bullet.x < 0 ){
                bullets.splice(i,1);
                removeChild(bullet);
            }
        }
    }

    private function keyHandler(event:KeyboardEvent):void {
        switch (event.keyCode){
            case Keyboard.SPACE:
                    fireBullets();
                break;
            case Keyboard.RIGHT:
                    hero.x += 10;
                break;
            case Keyboard.LEFT:
                   hero.x -= 10;
                break;
        }

    }

    private function fireBullets():void {
        var fireBullet:Sprite = new Bullet(hero.x,hero.y);
        addChild(fireBullet);
        bullets.push(fireBullet);
    }
}
}

import flash.display.Sprite;

class Bullet extends Sprite{
    public function Bullet(x:Number,y:Number){
        this.x = x;
        this.y = y;
        with (this) {
            graphics.beginFill(0xff0000);
            graphics.drawRect(0, 0, 5, 5);
            graphics.endFill();
        }
    }
}