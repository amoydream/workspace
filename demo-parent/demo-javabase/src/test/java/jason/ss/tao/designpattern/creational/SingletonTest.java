package jason.ss.tao.designpattern.creational;

import jason.ss.tao.designpattern.creational.singleton.EagerSingleton;
import jason.ss.tao.designpattern.creational.singleton.EnumSingleton;
import jason.ss.tao.designpattern.creational.singleton.LazySingleton;
import junit.framework.TestCase;

public class SingletonTest extends TestCase {
	public void testLazySingleton() {
		LazySingleton instance = LazySingleton.getInstance();
		instance.func();
	}

	public void testEagerSingleton() {
		EagerSingleton instance = EagerSingleton.getInstance();
		instance.func();
	}

	public void testEnumSingleton() {
		EnumSingleton instance = EnumSingleton.INSTANCE;
		instance.func();
	}
}
