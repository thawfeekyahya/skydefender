/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 6/5/14
 * Time: 10:03 AM
 *
 */
package com.thawfeek.utils.uielements {
import com.thawfeek.EmbededAssets;

import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;

import net.flashpunk.Entity;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;
import net.flashpunk.graphics.Text;

public class UIInfo extends Entity implements IUserInterfaceItem{

    private var icon:Image;
    private var title:String;
    private var disableImg:Image;
    private var isEnabled:Boolean;
    private var msgText:Text;

    public function UIInfo(iconImage:Image,title:String) {
        this.icon = iconImage;
        this.title = title;

        //Title Text
        Text.font = "Arial"
        Text.size = 10;
        var titleText:Text = new Text("");
        titleText.width = icon.width;
        titleText.wordWrap = true;
        titleText.x = (icon.width >> 1 - titleText.textWidth >> 1);
        titleText.text = title;



        //Msg Text
        msgText = new Text("value");
        msgText.y =  iconImage.height-msgText.textHeight;
        msgText.x = (icon.width >> 1 - msgText.textWidth >> 1);

        //Disable State Image
        var bitmapData:BitmapData = icon.getSrcBitmapData().clone();
        var colorTransform:ColorTransform  = new ColorTransform(0.5,0.5,0.5,0.5);
        bitmapData.colorTransform(new Rectangle(0,0,icon.width,icon.height),colorTransform);
        disableImg = new Image(bitmapData);

        enable(); //enable by default
        this.graphic = new Graphiclist(icon,disableImg,titleText,msgText);
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
