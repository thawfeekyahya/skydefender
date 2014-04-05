/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 3/20/14
 * Time: 8:59 PM
 * To change this template use File | Settings | File Templates.
 */
package enemy.flights.low {
import enemy.flights.AbsFlight;

import net.flashpunk.FP;

import net.flashpunk.graphics.Image;

public class RedBarron extends AbsFlight {


    public function RedBarron(moveSpeed:int=2) {
        super(moveSpeed);
        this.graphic = new Image(EmbededAssets.ENEMY_FLIGHT_RED_BARRON);
    }


    override public function update():void {
        this.moveTowards(getDestinationPoint().x,getDestinationPoint().y,getSpeed());
        super.update();
    }
}
}
