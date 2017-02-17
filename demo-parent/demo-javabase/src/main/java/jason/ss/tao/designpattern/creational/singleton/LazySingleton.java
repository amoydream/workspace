package jason.ss.tao.designpattern.creational.singleton;

public class LazySingleton {
	private volatile static LazySingleton instance;

	private LazySingleton() {
	}

	public static LazySingleton getInstance() {
		if(instance == null) {
			synchronized(LazySingleton.class) {
				if(instance == null) {
					instance = new LazySingleton();
				}
			}
		}

		return instance;
	}

	public void func() {
		System.out.println("LazySingleton");
	}
}
