/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 3/19/14
 * Time: 10:08 PM
 * To change this template use File | Settings | File Templates.
 */
package enemy.flights {
import enemy.IEnemyFlight;

import flash.geom.Point;

import net.flashpunk.Entity;

public class AbsFlight extends Entity implements IEnemyFlight{

    private var deployX:int;
    private var deployY:int;
    private var destinationX:int;
    private var destinationY:int;
    private var moveSpeed:int;

    public function AbsFlight(moveSpeed:int) {
        this.moveSpeed = moveSpeed;
    }

    public function deploy(targetX:int, targetY:int):void {
        deployX = targetX;
        deployY = targetY;
        this.x = targetX;
        this.y = targetY;
    }

    public function destination(targetX:int, targetY:int):void {
        destinationX = targetX;
        destinationY = targetY;
    }

    public function attack():void {
    }

    public function getDeployPoint():Point {
        return new Point(deployX,deployY);
    }

    public function getDestinationPoint():Point {
        return new Point(destinationX,destinationY);
    }

    public function getSpeed():int {
        return moveSpeed;
    }
}
}
