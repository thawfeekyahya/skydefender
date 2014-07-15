
/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 6/5/14
 * Time: 9:34 AM
 *
 */
package com.thawfeek.skydefender.hud {
import com.thawfeek.skydefender.EmbededAssets;
import com.thawfeek.skydefender.ui.UICreator;
import com.thawfeek.skydefender.ui.uielements.IUserInterfaceItem;

import flash.geom.Point;
import flash.utils.Dictionary;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.graphics.Image;

public class GameHud extends Entity {

    public static const HUD_UI_INFO_ITEM:String = "infoItem";
    public static const HUD_UI_TEXT_ITEM:String;
    public static const HUD_UI_BUTTON_ITEM:String;

    private var hudGraphic:Graphic;
    private var uiDict:Dictionary;
    private var bufferWidth:int;
    private var bufferHeight:int;
    private var position:Point;
    private var iconWidth:int;
    private var iconHeight:int;

    public function GameHud(x:Number = 0, y:Number = 0) {

        this.graphic = new Image(EmbededAssets.GAME_HUD_BG);
        uiDict = new Dictionary();
        position = new Point();
        position.x = x;
        position.y = y;
        iconWidth  = 40;
        iconHeight = 40;
        bufferWidth = 10;
        bufferHeight = 10;
        this.width  = Image(this.graphic).width;
        this.height = Image(this.graphic).height;
        super(x, y);
    }

    public function addUI(graphic:Image,type:String,key:String):void {
        var uiItem:IUserInterfaceItem;
        if(uiDict[key]){
           throw new Error("Key already exits in dictionary");
        }
        switch (type){
            case HUD_UI_INFO_ITEM:
                uiItem = UICreator.createInfoUI(graphic,key);
            break;

            default:
                trace("Type Not Found in HUD");
                return;
            break;
        }

         var count:int = getDictCount();
         uiDict[key] = uiItem;
         var posX:int = position.x + iconWidth * count + bufferWidth * count;
         var posY:int = position.y;
         uiItem.setPosition(new Point(posX,posY));

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


    public function setBuffers(width:int,height:int):void {
        this.bufferWidth = width;
        this.bufferHeight = height
    }

    public function setIconSize(width:int,height:int):void {
        this.iconWidth =  width;
        this.iconHeight = height;
    }

    public function getPosition():Point {
        return this.position;
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
