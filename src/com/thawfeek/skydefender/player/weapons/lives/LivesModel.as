/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 7/5/15
 * Time: 9:33 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.player.weapons.lives {
import com.thawfeek.skydefender.player.weapons.lives.LivesModel;

import flash.events.Event;
import flash.events.EventDispatcher;

internal class LivesModel extends EventDispatcher{

    private var lives:int;
    public static const INTIALIZE:String = "intializeLives";

    public function LivesModel() {
    }

    public function getLives():int {
         return lives;
    }

    public function setLives(lives:int):void {
        this.lives = lives;
        dispatchEvent(new Event(Event.CHANGE));
    }

    internal function intialize():void {
        dispatchEvent(new Event(INTIALIZE));
    }
}
}
