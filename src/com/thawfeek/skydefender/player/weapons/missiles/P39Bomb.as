/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 10/19/14
 * Time: 7:49 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.player.weapons.missiles {
import com.thawfeek.skydefender.EmbededAssets;
import com.thawfeek.skydefender.player.weapons.AbsWeapon;

import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;
import net.flashpunk.graphics.Spritemap;

public class P39Bomb extends AbsWeapon {

    private var speed:int;
    private var finished:Boolean;
    private var explodeAnim:Spritemap;
    private static var EXPLODE_ANIM:String = "explodeAnim";
    private var graphicList:Graphiclist;

    public function P39Bomb() {

        this.power = 12;
        this.speed = 4;

        var e:Entity = this;

        var onAnimComplete:Function = function ():void {
            cleanUp();
            FP.world.remove(e);
        }
        this.graphicList = new Graphiclist();
        this.graphicList.add(new Image(EmbededAssets.BOMB_P39));

        var frameWidth:int = 200;
        var frameHeight:int = 200;
        explodeAnim = new Spritemap(EmbededAssets.ENEMY_FLIGHT_EXPLODE_ANIM, frameWidth, frameHeight, onAnimComplete);
        explodeAnim.originX = frameWidth >> 1;
        explodeAnim.originY = frameHeight >> 1;
        explodeAnim.add(EXPLODE_ANIM, [0, 1, 2, 3, 4, 5, 6, 7], 12, false);
        explodeAnim.visible = false;
        this.graphicList.add(explodeAnim);

        this.graphic = graphicList;
    }

    override public function setPos(pos:Point):void {
        this.x = pos.x;
        this.y = pos.y;
    }


    override public function update():void {
        if (!finished) {
            moveTowards(Math.random()*100, FP.height, speed);
            if(this.y > FP.height - 20){
                this.finished = true;
                explode();
            }
        }
    }

    private function explode():void {
        explodeAnim.visible = true;
        explodeAnim.setAnimFrame(EXPLODE_ANIM, 0);
        explodeAnim.play(EXPLODE_ANIM);
    }

    override protected function cleanUp():void {
        this.graphic = null;
        explodeAnim.visible = false;
        explodeAnim.clear();
        graphicList.removeAll();
        explodeAnim = null;
        super.cleanUp();
    }

    override public function removed():void {
        super.removed();
    }
}
}
