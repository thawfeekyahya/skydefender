/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 7/5/15
 * Time: 9:48 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.player.weapons.lives {
import com.thawfeek.skydefender.EmbededAssets;

import flash.events.Event;

import net.flashpunk.Entity;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;

public class LivesView extends Entity {

    private var model:LivesModel;
    private var ctrl:LivesCtrl;
    private var gList:Graphiclist;
    private var livesIcon:Image;

    public function LivesView(dummy:Dummy,model:LivesModel,ctrl:LivesCtrl=null) {
        this.model = model;
        this.ctrl = ctrl;

        model.addEventListener(Event.CHANGE, onLivesUpdated);
        model.addEventListener(LivesModel.INTIALIZE,intializeView);
        gList = new Graphiclist();
        this.graphic = gList;

    }

    private function intializeView(e:Event):void {
        var lives:int = 0
        while(lives <  model.getLives()){
            lives++;
            livesIcon = new Image(EmbededAssets.STAR);
            livesIcon.scale = 0.25;
            gList.add(livesIcon);
            livesIcon.x = 120 + (5+livesIcon.scaledWidth) * lives;
            livesIcon.y = 35;
        }
        model.removeEventListener(LivesModel.INTIALIZE,intializeView);
    }

    private function onLivesUpdated(e:Event):void {
        trace(model.getLives());
        gList.removeAt(gList.children.length-1);
    }
}
}
