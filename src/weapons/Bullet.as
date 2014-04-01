/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 7/3/14
 * Time: 3:18 PM
 *
 */
package weapons {
import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Image;

public class Bullet extends Entity {

    private var angle:Number;
    private var speed:Number = 0.2;
    private var finished:Boolean;
    private var STACK_ORDER:int = 90;



    public function Bullet() {
        this.layer = STACK_ORDER;
        this.speed = speed;
        this.angle = angle;
        this.graphic = new Image(EmbededAssets.PLAYER_BULLET);
        Image(this.graphic).centerOrigin();
    }


    override public function update():void {
        this.x += Math.cos(angle)*speed;
        this.y += Math.sin(angle)*speed;
        if(this.x > FP.width || this.x < 0 || this.y > FP.height || this.y < 0){
            this.finished = true;
        }
        super.update();
    }

    public function setSpeed(value:Number):void {
        this.speed = value;
    }
    public function setAngle(value:Number):void {
        this.angle = value;
    }

    public function isFinished():Boolean {
       return this.finished;
    }
}
}
