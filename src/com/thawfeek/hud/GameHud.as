
/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 6/5/14
 * Time: 9:34 AM
 *
 */
package com.thawfeek.hud {
import com.thawfeek.EmbededAssets;
import com.thawfeek.utils.UICreator;
import com.thawfeek.utils.uielements.IUserInterfaceItem;

import flash.geom.Point;

import flash.utils.Dictionary;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Image;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Draw;

public class GameHud extends Entity {

    public static const HUD_UI_INFO_ITEM;
    public static const HUD_UI_TEXT_ITEM;
    public static const HUD_UI_BUTTON_ITEM;

    private var hudGraphic:Graphic;
    private var uiDict:Dictionary;
    private var bufferWidth:int;
    private var bufferHeight:int;
    private var position:Point;
    private var iconWidth:int;
    private var iconHeight:int;

    public function GameHud(x:Number = 0, y:Number = 0) {
        super(x, y);
        hudGraphic = new Image(EmbededAssets.GAME_HUD_BG);
        uiDict = new Dictionary();
        position = new Point();
        iconWidth  = 100;
        iconHeight = 100;
    }

    public function addUI(graphic:Image,type:String,key:String):void {
       var uiItem:IUserInterfaceItem;
       switch (type){
           case HUD_UI_INFO_ITEM:
               uiItem = UICreator.createInfoUI(graphic,key);
           break;
       }
       if(uiItem){
           var count:int = getDictCount();
           uiDict[key] = uiItem;
           var posX:int = position.x + iconWidth * count + bufferWidth * count;
           var posY:int = position.y;
           uiItem.setPosition(new Point(posX,posY));
       }
    }

    public function show():void {
        for each (var entity:Object in uiDict) {
            FP.world.add(entity as Entity);
        }
    }

    public function hide():void {
        for each (var entity:Object in uiDict) {
            FP.world.remove(entity as Entity);
        }
    }

    public function setPosition(val:Point){
        this.position = val;
    }

    public function setBuffers(width:int,height:int):void {
        this.bufferWidth = width;
        this.bufferHeight = height
    }

    public function setIconSize(width:int,height:int):void {
        this.iconWidth =  width;
        this.iconHeight = height;
    }

    private function getDictCount():int {
        var n:int = 0;
        for (var key:* in uiDict) {
            n++;
        }
        return n
    }

}
}
