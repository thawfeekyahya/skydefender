/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 12:28 PM
 * To change this template use File | Settings | File Templates.
 */
package com.thawfeek.skydefender {
public class EmbededAssets {


    //Graphic Assets

    [Embed(source="../../../../assets/splashscreen.jpg")]
    public static const SPLASH_SCREEN_IMAGE:Class;

    [Embed(source="../../../../assets/background.jpg")]
    public static const GAME_BG_IMAGE:Class;

    [Embed(source="../../../../assets/shop/shopMenu.png")]
    public static const SHOP_BG:Class;

    [Embed(source="../../../../assets/shop/btn.png")]
    public static const SHOP_FW_BTN:Class;

    //Sound Assets
    [Embed(source="../../../../assets/sounds/gamemusic.mp3")]
    public static const GAME_MUSIC:Class;

    [Embed(source="../../../../assets/player/turetBase.png")]
    public static const PLAYER_TURRET_BASE:Class;

    [Embed(source="../../../../assets/player/turet.png")]
    public static const TURRET_BASIC:Class;

    [Embed(source="../../../../assets/player/turret_rapid_fire.png")]
    public static const TURRET_RAPID_FIRE:Class;

    [Embed(source="../../../../assets/player/bullet.png")]
    public static const PLAYER_BULLET_SMALL:Class;

    [Embed(source="../../../../assets/player/bullet_medium.png")]
    public static const PLAYER_BULLET_MEDIUM:Class;

    [Embed(source="../../../../assets/player/bullet_heavy.png")]
    public static const PLAYER_BULLET_HEAVY:Class;

    [Embed(source="../../../../assets/sounds/player_shoot_basic.mp3")]
    public static const PLAYER_SHOOT_BASIC:Class;

    //Enemy
    [Embed(source="../../../../assets/enemy/plane3.png")]
    public static const ENEMY_FLIGHT_P39:Class;

    [Embed(source="../../../../assets/enemy/plane3_bomb.png")]
    public static const BOMB_P39:Class;

    [Embed(source="../../../../assets/enemy/plane5.png")]
    public static const ENEMY_FLIGHT_RED_BARRON:Class;


    [Embed(source="../../../../assets/effects/airplaneexplosion2.png")]
    public static const ENEMY_FLIGHT_EXPLODE_ANIM:Class;

    [Embed(source="../../../../assets/sounds/explosion_sound.mp3")]
   public static const SFX_ENEMY_EXPLODE:Class;

    [Embed(source="../../../../assets/sounds/bullet_hit.mp3")]
    public static const SFX_BULLET_HIT:Class;

    [Embed(source="../../../../assets/sounds/flightEngineSound.mp3")]
    public static const SFX_RED_BARRON_ENGINE:Class;

    [Embed(source="../../../../assets/player/hud.jpg")]
    public static const GAME_HUD_BG:Class;

    [Embed(source="../../../../assets/player/hud_icon1.png")]
    public static const GAME_HUD_ICON_1:Class;

    [Embed(source="../../../../assets/player/hud_icon2.png")]
    public static const GAME_HUD_ICON_2:Class;

    [Embed(source="../../../../assets/player/hud_icon3.png")]
    public static const GAME_HUD_ICON_3:Class;

    [Embed(source="../../../../assets/fonts/arial.ttf",embedAsCFF="false",fontFamily="Arial")]
    public static const FONT_HUD:Class;


}
}
