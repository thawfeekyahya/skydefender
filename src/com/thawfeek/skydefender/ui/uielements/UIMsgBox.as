/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 7/15/14
 * Time: 9:03 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender.ui.uielements {
import com.thawfeek.skydefender.ui.uielements.Dummy;

import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.FP;

import net.flashpunk.graphics.Text;

public class UIMsgBox extends Entity implements IUserInterfaceItem {


    private var msgTxt:Text;

    public function UIMsgBox(dummy:Dummy,msg:String,pos:Point,msgWidth:int=300) {
        msgTxt = new Text(msg);
        this.x = pos.x;
        this.y = pos.y;
        msgTxt.width = msgWidth;
        msgTxt.wordWrap = true;
//        msgTxt.x = (icon.width >> 1 - titleText.textWidth >> 1);
        msgTxt.text = msg;
        this.graphic = msgTxt;
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
        msgTxt.text = val;
    }

    public function setPosition(val:Point):void {
        this.x = val.x;
        this.y = val.y;
    }

    public function getPosition():Point {
        return new Point(this.x,this.y);
    }
}
}
