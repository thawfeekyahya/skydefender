/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 7/6/14
 * Time: 11:21 AM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender {
import flash.media.Sound;
import flash.utils.Dictionary;

import net.flashpunk.Sfx;

public class SoundManager {


    private static var instance:SoundManager;
    private var soundDict:Dictionary;
    private var musicDict:Dictionary;
    private var muted:Boolean;

    public function SoundManager(dummy:Dummy) {
        soundDict = new Dictionary(true);
        musicDict = new Dictionary(true);
        muted = false;
    }

    public static function getInstance():SoundManager {
        if(!instance){
            instance = new SoundManager(new Dummy());
        }
        return instance;
    }

    public function addSound(SoundClass:Class,complete:Function=null,type:String=null):Sfx {
        if (!soundDict[SoundClass]) {
            soundDict[SoundClass] = new Sfx(SoundClass, complete, type);
        }
        return soundDict[SoundClass];
    }

    public function addMusic(SoundClass:Class):Class {
        if(!musicDict[SoundClass]) {
            musicDict[SoundClass] = new Sfx(SoundClass);
        }
        return SoundClass;
    }

    public function playMusic(musicClass:Class):void {
        if (!muted) {
            for each(var snd:Sfx in musicDict) {
                snd.stop();
            }
            musicDict[musicClass].loop();
        }
    }

    public function stopMusic(SoundClass:Class=null):void {
        if (!SoundClass) {
            for each(var snd:Sfx in musicDict) {
                snd.stop();
            }
        } else {
             musicDict[SoundClass].stop();
        }
    }


    public function muteSounds(mute:Boolean):void {
        this.muted = mute;
        for each(var snd:Sfx in soundDict) {
            if (mute) {
                snd.stop();
            }
        }
        stopMusic();
    }

    public function isSoundOn():Boolean {
        return !muted;
    }

    public  function playSound(aClass:Class):void {
        if(!muted) {
            soundDict[aClass].play();
        }
    }
}
}

class Dummy {

}
