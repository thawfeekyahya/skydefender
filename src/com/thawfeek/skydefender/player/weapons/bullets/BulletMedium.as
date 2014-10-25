/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 6/21/14
 * Time: 5:36 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.player.weapons.bullets {
import com.thawfeek.skydefender.EmbededAssets;

import net.flashpunk.graphics.Image;

public class BulletMedium extends BulletSmall {
    public function BulletMedium() {
        super();
        this.graphic = new Image(EmbededAssets.PLAYER_BULLET_MEDIUM);
        this.power = 4;
    }
}
}
