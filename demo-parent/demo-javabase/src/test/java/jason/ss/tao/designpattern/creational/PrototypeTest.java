package jason.ss.tao.designpattern.creational;

import jason.ss.tao.designpattern.creational.prototype.AnimalFactory;
import jason.ss.tao.designpattern.creational.prototype.Cat;
import jason.ss.tao.designpattern.creational.prototype.Dog;
import jason.ss.tao.designpattern.creational.prototype.Pig;
import jason.ss.tao.designpattern.creational.prototype.Sheep;
import junit.framework.TestCase;

public class PrototypeTest extends TestCase {
	public void testClone() {
		assertEquals(AnimalFactory.cloneAnimal(Sheep.class).getName(), "Dolly");
		assertEquals(AnimalFactory.cloneAnimal(Pig.class).getName(), "Bajie");
		assertEquals(AnimalFactory.cloneAnimal(Dog.class).getName(), "Snooby");
		assertEquals(AnimalFactory.cloneAnimal(Cat.class).getName(), "Tom");
	}
}
