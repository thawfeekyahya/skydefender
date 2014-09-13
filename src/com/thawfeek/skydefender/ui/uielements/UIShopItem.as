/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 9/13/14
 * Time: 6:29 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.ui.uielements {
import com.thawfeek.skydefender.shop.IShopDelegate;

import flash.events.MouseEvent;

import net.flashpunk.FP;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Input;

public class UIShopItem extends UIInfo implements IUserInterfaceItem {

    private var intialized:Boolean;
    private var delegate:IShopDelegate;
    private var itemID:int;

    public function UIShopItem(dummy:Dummy, iconImage:Image, title:String,delegate:IShopDelegate,itemID:int) {
        super(dummy, iconImage, title);
        this.delegate = delegate;
        this.itemID = itemID;
    }


    override public function update():void {
        if(!intialized){
            if(FP.stage != null){
                FP.stage.addEventListener(MouseEvent.CLICK, onUIClicked);
                intialized = true;
            }
        }
        super.update();
    }

    private function onUIClicked(e:MouseEvent):void {
        if(collidePoint(x,y,Input.mouseX,Input.mouseY)){
            delegate.onShopItemAction(itemID);
        }
    }
}
}
