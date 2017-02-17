package jason.ss.tao.designpattern.creational.prototype;

import java.util.HashMap;
import java.util.Map;

public class AnimalFactory {
	private static final Map<Class<? extends Animal>, Animal> animalPrototypes = new HashMap<Class<? extends Animal>, Animal>();

	static {
		animalPrototypes.put(Sheep.class, new Sheep("Dolly"));
		animalPrototypes.put(Pig.class, new Pig("Bajie"));
		animalPrototypes.put(Dog.class, new Dog("Snooby"));
		animalPrototypes.put(Cat.class, new Cat("Tom"));
	}

	public static Animal cloneAnimal(Class<? extends Animal> clazz) {
		return animalPrototypes.get(clazz).clone();
	}
}
