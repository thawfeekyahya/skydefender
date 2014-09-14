/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 9/13/14
 * Time: 6:29 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.shop {
import com.thawfeek.skydefender.ui.uielements.*;
import com.thawfeek.skydefender.shop.IShopDelegate;

import flash.display.BitmapData;

import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;

import net.flashpunk.Entity;

import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;
import net.flashpunk.graphics.Text;
import net.flashpunk.utils.Input;

public class UIShopItem extends Entity  {

    private var intialized:Boolean;
    private var delegate:IShopDelegate;
    private var itemID:int;

    private var title:String;

    private var titleText:Text;
    private var descripText:Text;
    private var disableImg:Image;
    private var isEnabled:Boolean;

    public function UIShopItem(itemData:ItemData,delegate:IShopDelegate) {

        this.delegate = delegate;

        Text.font = "Arial"
        Text.size = 10;
        titleText  = new Text(title);
        descripText = new Text("value");


        createItem(itemData);
        enable(); //enable by default
    }

    private function createItem(itemData:ItemData):void {

        titleText.text = itemData.getTitle();
        descripText.text = itemData.getDescription();

        titleText.width = itemData.getIcon().width;
        titleText.wordWrap = true;
        titleText.x = ( itemData.getIcon().width >> 1 - titleText.textWidth >> 1);

        descripText.y =  itemData.getIcon().height - descripText.textHeight;
        descripText.x = ( itemData.getIcon().width >> 1 - descripText.textWidth >> 1);

        //Disable State Image
        var bitmapData:BitmapData = itemData.getIcon().getSrcBitmapData().clone();
        var colorTransform:ColorTransform = new ColorTransform(0.5, 0.5, 0.5, 0.5);
        bitmapData.colorTransform(new Rectangle(0, 0, itemData.getIcon().width, itemData.getIcon().height), colorTransform);
        disableImg = new Image(bitmapData);

        this.graphic = new Graphiclist(itemData.getIcon(), disableImg, titleText, descripText);
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

    public function updateItem(data:ItemData):void {
        createItem(data);
    }
}
}
