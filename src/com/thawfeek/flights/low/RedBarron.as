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
import net.flashpunk.graphics.Spritemap;

public class RedBarron extends AbsFlight {


    private static var ANIMATE_MOVE:String = "animateMove";


    public function RedBarron(moveSpeed:int=2) {
        super(moveSpeed);
        var spriteMap:Spritemap =   new Spritemap(EmbededAssets.ENEMY_FLIGHT_RED_BARRON,70,28);
        this.graphic =  spriteMap;
        this.graphic = spriteMap;
        this.width = 70;
        this.height= 28;
        this.health = 1;

        spriteMap.add(ANIMATE_MOVE,[0,1],20);
        spriteMap.play(ANIMATE_MOVE);
    }


    override public function update():void {
        this.moveTowards(getDestinationPoint().x,getDestinationPoint().y,getSpeed());
        if(this.finished){
            FP.world.remove(this);
        }
        super.update();
    }
}
}
