/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 7/5/15
 * Time: 9:39 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.player.weapons.lives {
internal class LivesCtrl {

    private var model:LivesModel;

    public function LivesCtrl(model:LivesModel) {
        this.model = model;
    }

    public function updateLives(lives:int):void {
        model.setLives(lives);
    }
}
}
