/**
 * Created with IntelliJ IDEA.
 * User: ${"thawfeek yahya"}
 * Date: 17/4/14
 * Time: 4:48 PM
 *
 */
package com.thawfeek.skydefender.test {
import net.flashpunk.World;

public class TestWorld extends World {


    public function TestWorld() {
        super();
        init();
    }

    private function init():void {
        var testEntity = new TestEntity();
        add(testEntity);

        testEntity.x = 100;
        testEntity.y = 200;


    }


}
}