/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 3/19/14
 * Time: 10:08 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.flights {

import com.thawfeek.skydefender.GameConfig;
import com.thawfeek.skydefender.GameConstants;
import com.thawfeek.skydefender.player.weapons.AbsWeapon;
import com.thawfeek.skydefender.worlds.GamePlay;

import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Graphiclist;

public class AbsFlight extends Entity {

    private var deployX:int;
    private var deployY:int;
    private var destinationX:int;
    private var destinationY:int;
    private var moveSpeed:int;
    private var scoreBoardUpdated:Boolean;
    protected var graphicList:Graphiclist;
    protected var finished:Boolean;
    protected var health:int;
    protected var hitScore:int;
    protected var isShotDown:Boolean;

    public function AbsFlight(moveSpeed:int) {
        this.moveSpeed = moveSpeed;
        this.graphicList = new Graphiclist();
        this.graphic = graphicList;
    }

    public function deploy(targetX:int, targetY:int):void {
        finished = false;
        isShotDown = false;
        scoreBoardUpdated = false;
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
        var weapon:AbsWeapon = AbsWeapon(this.collide(GameConstants.PLAYER_BULLET, this.x, this.y));
        if (weapon) {
            this.health -= weapon.getPower();

            if(GameConfig.getInstance().isSoundOn()) weapon.playHitSound();

            FP.world.remove(weapon);
            if(health <= 0 && !isShotDown){
                isShotDown = true;
                shotDown();
                dropReward();
                if(!scoreBoardUpdated) {
                    updateScoreBoard();
                }
            }
        }
    }

    protected function updateScoreBoard():void {
        scoreBoardUpdated = true;
        GamePlay(world).updateScoreBoard(GameConstants.PLAYER_SCORE,hitScore);
    }

    protected function dropReward():void {

    }

    protected function shotDown():void {

    }

    protected function cleanUp():void {
        FP.world.remove(this);
    }

    public function isFinished():Boolean {
        return this.finished;
    }



}
}
