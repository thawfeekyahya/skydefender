/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 9/14/14
 * Time: 12:14 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.shop {
import net.flashpunk.Graphic;
import net.flashpunk.graphics.Image;

public class ItemData {

    private var title:String;
    private var icon:Image;
    private var price:int;
    private var description:String;
    private var id:int;

    public function ItemData(title:String,icon:*,description:String,price:int,id:int) {
        this.title= title;
        (icon is Class) ? this.icon = new Image(icon) : this.icon = icon ;
        this.description = description;
        this.price = price;
        this.id = id;
    }

    public function getID():int {
        return id;
    }

    public function getDescription():String {
        return this.description;
    }

    public function getTitle():String {
        return this.title;
    }

    public function getPrice():int {
        return this.price;
    }

    public function getIcon():Image {
        return this.icon;
    }



}
}
