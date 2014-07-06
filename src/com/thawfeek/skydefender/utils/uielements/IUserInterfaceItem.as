/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 6/5/14
 * Time: 10:08 AM
 *
 */
package com.thawfeek.skydefender.utils.uielements {
import flash.geom.Point;

public interface IUserInterfaceItem {
    function show():void;
    function hide():void;
    function enable():void;
    function disable():void;
    function setText(val:String):void;
    function setPosition(val:Point):void
}
}
