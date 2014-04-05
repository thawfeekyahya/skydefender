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

import net.flashpunk.graphics.Image;

public class BellP39 extends AbsFlight{

    public function BellP39(moveSpeed:int=5) {
        super(moveSpeed);
        this.graphic = new Image(EmbededAssets.ENEMY_FLIGHT_P39);
    }


    override public function update():void {
        this.moveTowards(getDestinationPoint().x,getDestinationPoint().y,getSpeed());
        super.update();
    }
}
}
