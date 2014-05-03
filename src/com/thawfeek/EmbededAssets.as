/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 12:28 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek {
public class EmbededAssets {


    //Graphic Assets

    [Embed(source="../../../assets/splashscreen.jpg")]
    public static const SPLASH_SCREEN_IMAGE:Class;

    [Embed(source="../../../assets/background.jpg")]
    public static const GAME_BG_IMAGE:Class;


    //Sound Assets
    [Embed(source="../../../assets/sounds/gamemusic.mp3")]
    public static const GAME_MUSIC:Class;

    [Embed(source="../../../assets/player/turetBase.png")]
    public static const PLAYER_TURRET_BASE:Class;

    [Embed(source="../../../assets/player/turet.png")]
    public static const PLAYER_TURRET:Class;

    [Embed(source="../../../assets/player/bullet.png")]
    public static const PLAYER_BULLET:Class;

    [Embed(source="../../../assets/sounds/player_shoot_basic.mp3")]
    public static const PLAYER_SHOOT_BASIC:Class;

    //Enemy
    [Embed(source="../../../assets/enemy/plane3.png")]
    public static const ENEMY_FLIGHT_P39:Class;

    [Embed(source="../../../assets/enemy/plane5.png")]
    public static const ENEMY_FLIGHT_RED_BARRON:Class;


    [Embed(source="../../../assets/effects/airplaneexplosion2.png")]
    public static const ENEMY_FLIGHT_EXPLODE_ANIM:Class;

    [Embed(source="../../../assets/sounds/explosion_sound.mp3")]
   public static const SFX_ENEMY_EXPLODE:Class;

    [Embed(source="../../../assets/sounds/bullet_hit.mp3")]
    public static const SFX_BULLET_HIT:Class;



}
}
