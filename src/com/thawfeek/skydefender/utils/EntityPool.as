/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 7/3/14
 * Time: 8:47 AM
 *
 */
package com.thawfeek.skydefender.utils {
import net.flashpunk.Entity;

public class EntityPool {

    private var pool:Array;
    private var counter:int;
    private var totalCount:int;
    private var watchList:Vector.<int>;

    public function EntityPool(numCount:int,classType:Array) {
        pool = new Array();
         watchList = new Vector.<int>();
         counter = numCount *classType.length
         totalCount = counter;


         if(classType.length == 0) throw new Error("Pass At least 1 class type");

         var i:int = counter;
         for (var classCount:int=classType.length-1;classCount >= 0; classCount--) {
            while (--i >= numCount*classCount) {
                pool[i] = new classType[classCount];
            }
            i++ //Todo:  Bad Hack Need find a way to fix this.
         }
    }

    public function getEntity(index:int):Entity {
        if(counter > 0 && index > -1 && index < pool.length){
            if(watchList.indexOf(index) == -1){
                watchList.push(index);
                counter--;
                return pool[index];
            } else {
                var targetIndex:int = index;
                while(watchList.indexOf(targetIndex) != -1){
                    (targetIndex <= 0) ? targetIndex = totalCount-1 :targetIndex--;
                }
                watchList.push(targetIndex);
                counter--;
                return pool[targetIndex];
            }
        } else {
            throw new Error("Pool Exhausted or Invalid Index");
        }
    }

    public function putEntity(entity:Entity):void {
        counter++;
        if(watchList.length > 0){
            var targetIndex:int = pool.indexOf(entity);
            watchList.splice(watchList.indexOf(targetIndex),1);
            pool[targetIndex] = entity;
        } else {
            pool[counter] = entity;
        }
        if(counter > totalCount){
            throw new Error("Counter value cannot go beyond total count");
        }
    }

    public function destroy():void {
        for (var i:int = pool.length - 1; i >= 0; i--) {
            pool.splice(i,1);
        }
        pool = null;
        for (i = watchList.length - 1; i >= 0; i--) {
            watchList.splice(i,1);
        }
        watchList = null;
        counter = 0;
        totalCount = 0;
    }


}
}
