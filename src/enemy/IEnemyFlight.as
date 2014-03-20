/**
 * Created with IntelliJ IDEA.
 * User: Yahya
 * Date: 3/19/14
 * Time: 10:03 PM
 * To change this template use File | Settings | File Templates.
 */
package enemy {
public interface IEnemyFlight {

    function deploy(targetX:int,targetY:int):void;
    function destination(targetX:int,targetY:int):void;
    function attack():void;

}
}
