/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 3/19/14
 * Time: 10:15 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.flights.low {
import com.thawfeek.EmbededAssets;
import com.thawfeek.flights.AbsFlight;

import net.flashpunk.FP;
import net.flashpunk.Tween;
import net.flashpunk.graphics.Graphiclist;

import net.flashpunk.graphics.Image;
import net.flashpunk.graphics.Spritemap;
import net.flashpunk.tweens.motion.LinearPath;

public class BellP39 extends AbsFlight{

    private var linearPath:LinearPath;
    private var graphicList:Graphiclist;

    private static var EXPLODE_ANIM:String="explodeAnim";

    public function BellP39(moveSpeed:int=5) {
        super(moveSpeed);
        var img:Image = new Image(EmbededAssets.ENEMY_FLIGHT_P39);
        graphicList = new Graphiclist(img)
        this.graphic = graphicList;
        this.width = img.width;
        this.height= img.height;
        health = 1;

    }


    override public function update():void {
        if(!isShotDown){
            this.moveTowards(getDestinationPoint().x,getDestinationPoint().y,getSpeed());
        }
        if(this.finished){
            FP.world.remove(this);
        }
        super.update();
    }


    override protected function shotDown():void {
        super.shotDown();
        linearPath = new LinearPath(explode,Tween.ONESHOT);
        linearPath.addPoint(this.x-30,this.y+100);
        var duration:Number = Math.random() * 2 + 1.5;
        linearPath.setMotion(duration);
        addTween(linearPath,true);
    }

    private function explode():void {
        var onAnimComplete:Function = function(){finished = true}
        var explodeAnim:Spritemap = new Spritemap(EmbededAssets.ENEMY_FLIGHT_EXPLODE_ANIM,120,120,onAnimComplete);
        explodeAnim.add(EXPLODE_ANIM,[0,1,2,3,4,5,6,7],6,false);
        this.graphicList.add(explodeAnim);
        explodeAnim.play(EXPLODE_ANIM);
    }
}
}
