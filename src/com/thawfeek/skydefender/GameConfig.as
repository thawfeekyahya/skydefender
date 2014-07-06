/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 7/6/14
 * Time: 11:21 AM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender {
import flash.utils.Dictionary;

import net.flashpunk.Sfx;

public class GameConfig {


    private static var instance:GameConfig;
    private var soundDict:Dictionary;
    private var muted:Boolean;

    public function GameConfig(dummy:Dummy) {
        soundDict = new Dictionary(true);
        muted = false;
    }

    public static function getInstance():GameConfig {
        if(!instance){
            instance = new GameConfig(new Dummy());
        }
        return instance;
    }

    public function addSound(SoundClass:Class,complete:Function=null,type:String=null):Sfx {
        if (!soundDict[SoundClass]) {
            soundDict[SoundClass] = new Sfx(SoundClass, complete, type);
        }
        return soundDict[SoundClass];
    }

    public function muteSounds(mute:Boolean):void {
        this.muted = mute;
        for each(var snd:Sfx in soundDict) {
            if (mute) {
                snd.stop();
            } else {
               if(!snd.playing) snd.resume();
            }
        }
    }

    public function isSoundOn():Boolean {
        return !muted;
    }

}
}

class Dummy {

}
