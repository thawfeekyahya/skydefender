/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 7/5/15
 * Time: 9:53 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.player.weapons.lives {
import flash.geom.Point;

import net.flashpunk.World;

public class LivesTriad {

    private var model:LivesModel;
    private var ctrl:LivesCtrl;
    private var view:LivesView;
    private var viewIntialized:Boolean;

    public function LivesTriad(world:World,pos:Point=null) {

        model = new LivesModel();
        ctrl = new LivesCtrl(model);
        view = new LivesView(new Dummy(),model, ctrl);
        if(pos){
            view.x = pos.x;
            view.y = pos.y;
        }
        world.add(view);
    }

    public function setLives(lives:int):void {
        ctrl.updateLives(lives);
        if(!viewIntialized){
            viewIntialized = true;
            model.intialize();
        }
    }


}
}
