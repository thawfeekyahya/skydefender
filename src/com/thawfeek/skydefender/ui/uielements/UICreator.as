/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 6/5/14
 * Time: 10:01 AM
 *
 */
package com.thawfeek.skydefender.ui.uielements {

import com.thawfeek.skydefender.shop.IShopDelegate;

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

    public static function createScoreElement(elementName:String,value:String,pos:Point):IUserInterfaceItem {
        return new UIScoreElement(new Dummy(),elementName,value,pos);
    }

    public static function createShopItem(graphic:Image,name:String,shopDelegate:IShopDelegate,itemID:int):IUserInterfaceItem {
        return new UIShopItem(new Dummy(),graphic,name,shopDelegate,itemID);
    }
}
}
