/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 7/3/14
 * Time: 8:47 AM
 *
 */
package utils {
import net.flashpunk.Entity;

public class EntityPool {

    private var pool:Array;
    private var counter:int;

    public function EntityPool(type:Class,len:int) {
        pool = new Array();
        counter = len;

        var i:int = len;
        while(--i > -1){
           pool[i] = new type();
        }
    }

    public function getEntity():Entity {
        if(counter > 0){
            return pool[--counter];
        } else {
            throw new Error("Pool Exhausted");
        }
    }

    public function putEntity(entity:Entity):void {
        pool[counter++] = entity;
    }


}
}
