/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 9/13/14
 * Time: 8:44 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.shop {
import com.thawfeek.skydefender.ui.uielements.IUserInterfaceItem;

public interface IShopMenu {
    function addShopItem(item:ItemData);
    function removeShopItem(id:int);
    function showShopShowCase():void;
    function hideShopShowCase():void;
}
}
