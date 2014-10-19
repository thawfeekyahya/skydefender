/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 5/8/14
 * Time: 10:10 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.shop {
import com.thawfeek.skydefender.EmbededAssets;
import com.thawfeek.skydefender.event.EventConstants;
import com.thawfeek.skydefender.event.IEventDelegate;
import com.thawfeek.skydefender.player.Player;
import com.thawfeek.skydefender.ui.uielements.IUserInterfaceItem;
import com.thawfeek.skydefender.ui.uielements.UICreator;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Button;

public class ShopMenu extends Entity implements  IShopDelegate,IShopMenu{

    private var forwardBtn:Button;
    private var backwardBtn:Button;
    private var data:Array;
    private var rowColSize:int;         // row x col size // 3x3 or 4x4
    private var maxGridPerPage:int;
    private var gridArray:Array;
    private var bufferWidth:int;
    private var bufferHeight:int;
    private var gridStartX:int;
    private var gridStartY:int

    private var startIndex:int;
    private var itemIDArray:Array;
    private var displayList:Array;
    private var okBtn:Button;

    private var eventDelegate:IEventDelegate;

    public function ShopMenu(eventDelegate:IEventDelegate,x:int=0,y:int=0) {
        this.eventDelegate = eventDelegate;
        this.x = x;
        this.y = y;
        gridStartX = this.x + 80;
        gridStartY = this.y + 15;

        rowColSize = 3;
        maxGridPerPage = 9;

        bufferHeight = 10;
        bufferWidth  = 20;

        data = [];
        gridArray = [];
        itemIDArray = [];
        displayList = [];

        var bkgImg:Image = new Image(EmbededAssets.SHOP_BG);
        super(x,y,bkgImg);

        this.width = bkgImg.width;
        this.height = bkgImg.height;

        forwardBtn = new Button("forward",forwardClick,0,0,100,50);
        backwardBtn = new Button("backward",backwardClick,0,0,100,50);
        okBtn = new Button("Okay",okayClick,0,0,100,50);

        forwardBtn.setX(this.x + this.width - forwardBtn.width);
        forwardBtn.setY(this.y+20);
        backwardBtn.setX(this.x + backwardBtn.width);
        backwardBtn.setY(this.y+20);
        okBtn.setX(this.x+this.halfWidth-okBtn.halfWidth);
        okBtn.setY(this.y+this.height-okBtn.height);

        displayList.push(this);
        displayList.push(forwardBtn);
        displayList.push(backwardBtn);
        displayList.push(okBtn);
        createGrids();
    }

    private function okayClick():void {
        eventDelegate.processEvent(EventConstants.SHOP_OK_BUTTON_CLICK);
    }

    private function createGrids():void {
       // var testItemData:ItemData = new ItemData("Test",EmbededAssets.SHOP_FW_BTN,"Rapid Fire Gun",300,1);
        for (var i:int = 0; i < maxGridPerPage; i++) {
            var grid:UIShopItem = new UIShopItem(this);
            grid.x = gridStartX + (grid.width + bufferWidth)  * int(i % rowColSize);
            grid.y = gridStartY + (grid.height + bufferHeight) * int(i / rowColSize);
            gridArray.push(grid);
        }
        displayList = displayList.concat(gridArray);
    }

    private function backwardClick():void {
        if (startIndex >= 0) {
            startIndex -= maxGridPerPage;
            populateGrid(startIndex);
        }
        toggleNavButtons();
    }

    private function forwardClick():void {
        if(startIndex < data.length) {
            startIndex += maxGridPerPage;
            populateGrid(startIndex);
        }
        toggleNavButtons();
    }

    private function populateGrid(startIndex:int):void {
        for (var i:int = startIndex,j:int=0; i < startIndex+maxGridPerPage; i++,j++) {
            renderItem(j,i);
        }
    }

    private function renderItem(itemIndex:int,itemDataIndex:int):void {
        var item:UIShopItem = gridArray[itemIndex];
        var data:ItemData   = data[itemDataIndex];
        item.visible = false;
        if(data != null){
            item.loadItemData(data);
            item.visible = true;
        }
    }

    public function onShopItemAction(itemData:ItemData):void {
        var price:int = itemData.getPrice();
        var player:Player = Player.getInstance();
        var playerScore = player.getScore();
        if(playerScore >= price) {
            player.buyShopItem(itemData);
        }
    }

    public function addShopItem(item:ItemData) {
        if(isItemRegistered(item.getID())) {
            data.push(item);
        } else {
            throw new Error("Shop ID is Already Registered");
        }
    }

    private function isItemRegistered(id:int):Boolean {
        var registered:Boolean = true;
        for (var i:int = 0; i < data.length; i++) {
            var itemData:ItemData = data[i];
            if(itemData.getID() == id){
                registered = false;
                break;
            }
        }
        return registered;
    }

    public function removeShopItem(id:int) {
        for (var i:int = 0; i < data.length; i++) {
            var itemData:ItemData = data[i];
            if (itemData.getID() == id) {
                data.splice(i, 1);
                break;
            }
        }
    }

    public function showShopShowCase():void {
        for (var i:int = 0; i < displayList.length; i++) {
            var e:Entity = displayList[i];
            FP.world.add(e);
            e.visible = true;
        }
        loadShopGrids();
        toggleNavButtons();
    }

    private function loadShopGrids():void {
        if (data.length > 0) {
            startIndex = 0;
            populateGrid(startIndex);
        }
    }

    public function hideShopShowCase():void {
        startIndex  = 0;
        for (var i:int = 0; i < displayList.length; i++) {
            var e:Entity = displayList[i];
            e.visible = false;
        }
    }

    private function toggleNavButtons():void {
        if(startIndex == 0){
            backwardBtn.visible = false;
            if(data.length <= maxGridPerPage){
                forwardBtn.visible = false;
            }  else {
                forwardBtn.visible = true;
            }
        } else{
           if(startIndex+maxGridPerPage >= data.length){
               forwardBtn.visible = false;
               backwardBtn.visible = true;
           } else {
               forwardBtn.visible = true;
               backwardBtn.visible = true;
           }
        }
    }
}
}
