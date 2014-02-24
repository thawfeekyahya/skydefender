/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 2/24/14
 * Time: 9:52 PM
 * To change this template use File | Settings | File Templates.
 */
package player {
import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.Graphic;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Graphiclist;
import net.flashpunk.graphics.Image;
import net.flashpunk.utils.Input;

public class Player extends Entity {

    private var turretBase:Image;
    private var turret:Image;

    public function Player(x:Number = 0, y:Number = 0, graphic:Graphic = null, mask:Mask = null) {
        super(x, y, graphic, mask);
        init();
    }


    override public function added():void {
        super.added();
    }

    private function init():void {
        turretBase = new Image(Assets.PLAYER_TURRET_BASE);
        turret     = new Image(Assets.PLAYER_TURRET);

        graphic = new Graphiclist(turret,turretBase);

        //Set Base in Center
        turretBase.x = 0;
        turretBase.y = FP.height - turretBase.height - 20;

        //Set Turret Position
        turret.originY = turret.height/2 ;
        turret.originX = -20;
        turret.x = turretBase.x+turretBase.width/2;
        turret.y = turretBase.y + 30;
        turret.smooth = true;
        turret.angle = 90;
    }


    override public function update():void {
        turret.angle = FP.angle(turret.x,turret.y,Input.mouseX,Input.mouseY);
        super.update();
    }
}
}
