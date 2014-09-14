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
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Button;

public class ShopMenu extends Entity implements  IShopDelegate,IShopMenu{

    private var forwardBtn:Button;
    private var backwardBtn:Button;
    private var data:Vector.<ItemData>;
    private var gridSize:int = 6;

    public function ShopMenu() {
        data = new Vector.<ItemData>();
        var bkgImg:Image = new Image(EmbededAssets.SHOP_BG);
        super(0,0,bkgImg);

        gridSize = 6;

        this.width = 400;
        this.height = 300;

        forwardBtn = new Button("forward",forwardClick,0,0,100,50);
        backwardBtn = new Button("backward",backwardClick,0,0,100,50);

        forwardBtn.x = 300;

        createGrids();

    }

    private function createGrids():void {
        for (var i:int = 0; i < gridSize; i++) {
//            var grid:UIShopItem = new UIShopItem()
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

    public function showShop():void {
    }

    public function hideShop():void {
    }
}
}
