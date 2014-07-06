/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 6/5/14
 * Time: 10:01 AM
 *
 */
package com.thawfeek.skydefender.utils {
import com.thawfeek.skydefender.utils.uielements.IUserInterfaceItem;
import com.thawfeek.skydefender.utils.uielements.UIInfo;

import net.flashpunk.graphics.Image;

public class UICreator {

    public function UICreator() {
    }

    public static function createInfoUI(graphic:Image,title:String):IUserInterfaceItem {
        var uiInfoItem:IUserInterfaceItem = new UIInfo(graphic,title);
        return uiInfoItem;
    }
}
}
