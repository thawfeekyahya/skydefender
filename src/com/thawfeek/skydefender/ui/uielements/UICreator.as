/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 6/5/14
 * Time: 10:01 AM
 *
 */
package com.thawfeek.skydefender.ui.uielements {

import flash.geom.Point;

import net.flashpunk.graphics.Image;

public class UICreator {

    public function UICreator() {
    }

    public static function createInfoUI(graphic:Image,title:String):IUserInterfaceItem {
        var uiInfoItem:IUserInterfaceItem = new UIInfo(new Dummy(),graphic,title);
        return uiInfoItem;
    }

    public static function createMsgBoxUI(text:String, point:Point):IUserInterfaceItem {
        return new UIMsgBox(new Dummy(),text,point);
    }
}
}
