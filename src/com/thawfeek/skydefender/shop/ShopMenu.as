/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 5/8/14
 * Time: 10:10 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.shop {
import com.thawfeek.skydefender.EmbededAssets;
import com.thawfeek.skydefender.ui.uielements.IUserInterfaceItem;
import com.thawfeek.skydefender.ui.uielements.UICreator;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Button;

public class ShopMenu extends Entity implements  IShopDelegate,IShopMenu{

    private var forwardBtn:Button;
    private var backwardBtn:Button;
    private var data:Vector.<ItemData>;
    private var gridSize:int;
    private var totalCount:int;
    private var gridArray:Array;
    private var bufferWidth:int;
    private var bufferHeight:int;
    private var gridStartX:int;
    private var gridStartY:int

    public function ShopMenu(x:int=0,y:int=0) {

        this.x = x;
        this.y = y;
        gridStartX = this.x + 100;
        gridStartY = this.y + 5;

        gridSize = 3;
        totalCount = 9;

        bufferHeight = 10;
        bufferWidth  = 10;

        data = new Vector.<ItemData>();
        gridArray = [];

        var bkgImg:Image = new Image(EmbededAssets.SHOP_BG);
        super(x,y,bkgImg);

        this.width = 400;
        this.height = 300;


        forwardBtn = new Button("forward",forwardClick,0,0,100,50);
        backwardBtn = new Button("backward",backwardClick,0,0,100,50);

        forwardBtn.x = 300;

        createGrids();

    }

    private function createGrids():void {
        for (var i:int = 0; i < totalCount; i++) {
            var grid:UIShopItem = new UIShopItem(null,this);
            grid.x = gridStartX + grid.width  * int(i % gridSize);
            grid.y = gridStartY + grid.height * int(i / gridSize);
            gridArray.push(grid);
        }
    }

    private function backwardClick():void {

    }

    private function forwardClick():void {

    }

    public function onShopItemAction(itemID:int):void {
        switch (itemID){

        }
    }

    public function addShopItem(item:ItemData) {
        data.push(item);
    }

    public function removeShopItem(id:int) {
    }

    public function showShopShowCase():void {
        FP.world.add(this);
        for (var i:int = 0; i < gridArray.length; i++) {
            var grid:UIShopItem = gridArray[i];
            FP.world.add(grid);
        }
    }

    public function hideShopShowCase():void {
    }
}
}
