/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 3/19/14
 * Time: 10:08 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.flights {

import com.thawfeek.GameConstants;

import flash.geom.Point;

import net.flashpunk.Entity;

public class AbsFlight extends Entity {

    private var deployX:int;
    private var deployY:int;
    private var destinationX:int;
    private var destinationY:int;
    private var moveSpeed:int;
    protected var finished:Boolean;
    protected var health:int;
    protected var isShotDown:Boolean;

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

    protected function getCurrentPos():Point {
       return new Point(this.x,this.y);
    }


    override public function update():void {
        super.update();
        if(getCurrentPos().x == getDestinationPoint().x && getCurrentPos().y == getDestinationPoint().y){
            finished = true;
        }
        checkCollision();

    }

    protected function checkCollision():void {
        if (this.collide(GameConstants.PLAYER_BULLET, this.x, this.y)) {
            this.health -= 2;
            if(health <= 0){
                isShotDown = true;
                shotDown();
            }
        }
    }

    protected function shotDown():void {

    }
}
}
