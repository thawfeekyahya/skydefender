/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 5/8/14
 * Time: 10:10 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.shop {
import com.thawfeek.skydefender.EmbededAssets;

import net.flashpunk.Entity;
import net.flashpunk.graphics.Image;

public class ShopMenu extends Entity implements  IShopDelegate{

    public function ShopMenu() {
        var bkgImg:Image = new Image(EmbededAssets.SHOP_BG);
        super(0,0,bkgImg);
    }

    public function onShopItemAction(itemID:int):void {
        switch (itemID){

        }
    }
}
}
