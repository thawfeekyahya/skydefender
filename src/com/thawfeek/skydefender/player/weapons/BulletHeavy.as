/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 6/21/14
 * Time: 5:37 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.player.weapons {
import com.thawfeek.skydefender.EmbededAssets;

import net.flashpunk.graphics.Image;

public class BulletHeavy extends BulletSmall {
    public function BulletHeavy() {
        super();
        this.graphic = new Image(EmbededAssets.PLAYER_BULLET_HEAVY);
        this.power = 6;
    }
}
}
