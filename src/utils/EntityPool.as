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
    private var watchList:Vector.<int>;

    public function EntityPool(numCount:int,classType:Array) {
        pool = new Array();
         watchList = new Vector.<int>();
         counter = numCount *classType.length


         if(classType.length == 0) throw new Error("Pass At least 1 class type");

         var i:int = counter;
         for (var classCount:int=classType.length-1;classCount >= 0; classCount--) {
            while (--i >= numCount*classCount) {
                pool[i] = new classType[classCount];
            }
            i++ //Todo:  Bad Hack Need find a way to fix this.
         }
    }

    public function getEntity(index:int=-1):Entity {
        if(counter > 0){
            if(index != -1 && watchList.indexOf(index) == -1){
                watchList.push(index);
                counter--;
                return pool[index];
            } else {
                var targetIndex:int = --counter;
                while(watchList.indexOf(targetIndex) != -1){
                    (targetIndex <= 0) ? targetIndex = counter :targetIndex--;
                }
                watchList.push(targetIndex);
                return pool[targetIndex];
            }
        } else {
            throw new Error("Pool Exhausted");
        }
    }

    public function putEntity(entity:Entity):void {
        if(watchList.length > 0){
            pool[watchList.shift()] = entity;
            counter++;
        } else {
            pool[counter++] = entity;
        }
    }


}
}
