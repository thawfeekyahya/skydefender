/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/22/14
 * Time: 12:28 PM
 * To change this template use File | Settings | File Templates.
 */
package {
public class Assets {


    //Graphic Assets

    [Embed(source="../assets/splashscreen.jpg")]
    public static const SPLASH_SCREEN_IMAGE:Class;

    [Embed(source="../assets/background.jpg")]
    public static const GAME_BG_IMAGE:Class;


    //Sound Assets
    [Embed(source="../assets/sounds/gamemusic.mp3")]
    public static const GAME_MUSIC:Class;

    [Embed(source="../assets/player/turetBase.png")]
    public static const PLAYER_TURRET_BASE:Class;

    [Embed(source="../assets/player/turet.png")]
    public static const PLAYER_TURRET:Class;

    [Embed(source="../assets/player/bullet.png")]
    public static const PLAYER_BULLET:Class;

    [Embed(source="../assets/sounds/player_shoot_basic.mp3")]
    public static const PLAYER_SHOOT_BASIC:Class;


}
}
