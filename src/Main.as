/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 11/23/13
 * Time: 12:35 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import net.flashpunk.Engine;
import net.flashpunk.FP;

public class Main extends Engine {
    public function Main() {
        super(600, 400, 60, false);
    }

    override public function init():void {
        super.init();
        FP.console.enable();
    }
}
}
