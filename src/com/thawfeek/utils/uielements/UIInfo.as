/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 6/5/14
 * Time: 10:03 AM
 *
 */
package com.thawfeek.utils.uielements {
import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;

import net.flashpunk.Entity;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Canvas;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;
import net.flashpunk.graphics.Text;

public class UIInfo extends Entity implements IUserInterfaceItem{

    private var icon:Image;
    private var title:String;
    private var dispText:String;
    private var gListData:Array;
    private var disableImg:Image;
    private var isEnabled:Boolean;
    private var msgText:Text;

    public function UIInfo(iconImage:Image,title:String) {
        this.icon = iconImage;
        this.title = title;

        //Title Text
        var titleText:Text = new Text(title)
        titleText.centerOrigin();
        titleText.x = (iconImage.width >> 1);

        //Msg Text
        msgText = new Text("");
        msgText.centerOrigin();
        msgText.x = (iconImage.width >> 1);

        //Disable State Image
        var bitmapData:BitmapData = icon.getSrcBitmapData().clone();
        var colorTransform:ColorTransform  = new ColorTransform(0.5,0.5,0.5);
        bitmapData.colorTransform(new Rectangle(0,0,icon.width,icon.height),colorTransform);
        disableImg = new Image(bitmapData);

        this.graphic = new Graphiclist(icon,titleText,disableImg);
    }


    public function show():void {
        if(!visible) visible = true;
    }

    public function hide():void {
        if(visible) visible = false;
    }

    public function enable():void {
        if(!isEnabled){
            isEnabled = true;
            disableImg.visible = false;
        }
    }

    public function disable():void {
        if(isEnabled){
            isEnabled = false;
            disableImg.visible = true;
        }
    }

    public function setText(val:String):void {
        msgText.text = val;
    }

    public function setPosition(val:Point):void {
        this.x = val.x;
        this.y = val.y;
    }
}
}
