/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 3/20/14
 * Time: 8:59 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.flights.low {
import com.thawfeek.EmbededAssets;
import com.thawfeek.flights.AbsFlight;

import net.flashpunk.FP;
import net.flashpunk.Sfx;
import net.flashpunk.graphics.Spritemap;

public class RedBarron extends AbsFlight {


    private static var ANIMATE_MOVE:String = "animateMove";
    private static var EXPLODE_ANIM:String="explodeAnim";

    private var explodeAnim:Spritemap;
    private var engineSound:Sfx;

    public function RedBarron(moveSpeed:int=2) {
        super(moveSpeed);
        var spriteMap:Spritemap =   new Spritemap(EmbededAssets.ENEMY_FLIGHT_RED_BARRON,70,28);
        graphicList.add(spriteMap);
        this.width = 70;
        this.height= 28;
        this.health = 8;
        this.centerOrigin();
        spriteMap.centerOrigin();

        spriteMap.add(ANIMATE_MOVE,[0,1],20);
        spriteMap.play(ANIMATE_MOVE);

        var onAnimComplete:Function = function():void{
            explodeAnim.visible = false;
            finished = true;
        };

        var frameWidth:int = 200;
        var frameHeight:int = 200;
        explodeAnim = new Spritemap(EmbededAssets.ENEMY_FLIGHT_EXPLODE_ANIM, frameWidth, frameHeight, onAnimComplete);
        explodeAnim.originX = frameWidth >> 1;
        explodeAnim.originY = frameHeight >> 1;
        explodeAnim.add(EXPLODE_ANIM,[0,1,2,3,4,5,6,7],12,false);
        explodeAnim.visible = false;
        this.graphicList.add(explodeAnim);

        engineSound = new Sfx(EmbededAssets.SFX_RED_BARRON_ENGINE);
    }


    override public function deploy(targetX:int, targetY:int):void {
        super.deploy(targetX, targetY);
        engineSound.loop()
    }

    override public function update():void {
        if(!isShotDown){
            this.moveTowards(getDestinationPoint().x,getDestinationPoint().y,getSpeed());
        } else {

        }

        if(this.finished){
            remove();
        }

        super.update();
    }


    override protected function shotDown():void {
        super.shotDown();

        explodeAnim.visible = true;
        explodeAnim.setAnimFrame(EXPLODE_ANIM,0);
        explodeAnim.play(EXPLODE_ANIM);
    }


    override protected function remove():void {
        super.remove();
    }


    override public function removed():void {
        super.removed();
        engineSound.stop();
        graphicList.removeAll();
        explodeAnim = null;
        engineSound = null;
        graphicList = null;
    }
}
}
