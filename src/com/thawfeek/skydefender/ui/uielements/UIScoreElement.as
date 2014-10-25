/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 8/12/14
 * Time: 6:19 AM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.ui.uielements {
import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Text;

public class UIScoreElement extends Entity implements IUserInterfaceItem {

    public static const SIDE_BY_SIDE:int = 0;
    public static const VERTICAL_DOWN:int = 1;


    private var elementName:String;
    private var value:int;
    private var txtField:Text;

    public function UIScoreElement(dummy:Dummy,elementName:String,value:String,pos:Point,type:int=0) {
        //TODO: Type ( side by side , vertical) needs to implemented
        this.elementName = elementName;
        txtField = new Text(elementName+ " "+value);
        txtField.width = 300;
        txtField.wordWrap = true;
        this.x = pos.x;
        this.y = pos.y;
        this.value = parseInt(value);
        txtField.text = elementName+ " "+value;
        this.graphic = txtField;
    }

    public function show():void {
        FP.world.add(this);
    }

    public function hide():void {
        FP.world.remove(this);
    }

    public function enable():void {
    }

    public function disable():void {
    }

    public function setText(val:String):void {
        txtField.text = elementName + " "+ val;
    }

    public function setPosition(val:Point):void {
        this.x = val.x;
        this.y = val.y;
    }

    public function getPosition():Point {
        return null;
    }
}
}
