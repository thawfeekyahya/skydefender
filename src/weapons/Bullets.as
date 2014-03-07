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

public class Bullets extends Entity {

    private var angle:Number;
    private var speed:Number = 0.2;
    private var finished:Boolean;



    public function Bullets() {
        this.speed = speed;
        this.angle = angle;
        this.graphic = new Image(Assets.PLAYER_BULLET);
    }


    override public function update():void {
        FP.log(angle);
        Image(this.graphic).angle = angle;
        this.x += Math.cos(angle*Math.PI/180)*speed;
        this.y += Math.sin(angle*Math.PI/180)*speed;
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
