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
import net.flashpunk.Sfx;
import net.flashpunk.Tween;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;

import net.flashpunk.graphics.Image;
import net.flashpunk.graphics.Spritemap;
import net.flashpunk.tweens.misc.NumTween;
import net.flashpunk.tweens.misc.VarTween;
import net.flashpunk.tweens.motion.LinearPath;
import net.flashpunk.utils.Ease;

public class BellP39 extends AbsFlight{

    private var linearPath:LinearPath;
    private var graphicList:Graphiclist;
    private var angleTween:VarTween;
    private var sfxExplosion:Sfx;


    private static var EXPLODE_ANIM:String="explodeAnim";

    public function BellP39(moveSpeed:int=2) {
        super(moveSpeed);
        var img:Image = new Image(EmbededAssets.ENEMY_FLIGHT_P39);
        graphicList = new Graphiclist(img)
        this.graphic = graphicList;
        this.width = img.width;
        this.height= img.height;
        this.centerOrigin();
        img.centerOrigin();
        health = 5;
        sfxExplosion = new Sfx(EmbededAssets.SFX_ENEMY_EXPLODE);
    }


    override public function update():void {
        if(!isShotDown){
            this.moveTowards(getDestinationPoint().x,getDestinationPoint().y,getSpeed());
        } else {
            angleTween.update();
            this.x = linearPath.x;
            this.y = linearPath.y;
        }
        if(this.finished){
            FP.world.remove(this);
        }
        super.update();
    }



    override protected function shotDown():void {
        var flightImg:Image = Image(this.graphicList.children[0]);
        angleTween = new VarTween(null, Tween.ONESHOT);
        angleTween.tween(flightImg,"angle",60,1);
        angleTween.start();

        linearPath = new LinearPath(explode,Tween.ONESHOT);
        linearPath.addPoint(this.x,this.y);
        linearPath.addPoint(this.x-200,FP.height-this.height-20);
        var speed:Number;
       (this.x < FP.halfHeight) ? speed = 2 : speed = 1;
        linearPath.setMotion(speed);
        FP.log(speed);
        addTween(linearPath,true);
    }

    private function explode():void {
        if(!sfxExplosion.playing)sfxExplosion.play();
        var imgWidth:int = 200;
        var imgHeight:int = 200;
        var onAnimComplete:Function = function(){finished = true}
        var explodeAnim:Spritemap = new Spritemap(EmbededAssets.ENEMY_FLIGHT_EXPLODE_ANIM,imgWidth,imgHeight,onAnimComplete);
        explodeAnim.originX = imgWidth >> 1;
        explodeAnim.originY = imgHeight >> 1;
        explodeAnim.add(EXPLODE_ANIM,[0,1,2,3,4,5,6,7],12,false);
        this.graphicList.add(explodeAnim);
        explodeAnim.play(EXPLODE_ANIM);
    }
}
}
