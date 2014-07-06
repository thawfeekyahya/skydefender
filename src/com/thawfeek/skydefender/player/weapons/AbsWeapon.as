/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 5/3/14
 * Time: 10:45 AM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.player.weapons {
import net.flashpunk.Entity;
import net.flashpunk.Sfx;

public class AbsWeapon extends Entity {

    protected var power:int;
    protected var weaponHitSound:Sfx;

    public function AbsWeapon(x:Number = 0, y:Number = 0) {
        super(x, y);
    }

    public function getPower():int {
        return this.power;
    }

    public function playHitSound():void {
       weaponHitSound.play();
    }
}
}
