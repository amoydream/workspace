package jason.ss.tao.designpattern.creational.singleton;

public class EagerSingleton {
	private static final EagerSingleton instance = new EagerSingleton();

	static {
	}

	private EagerSingleton() {
	}

	public static EagerSingleton getInstance() {
		return instance;
	}

	public void func() {
		System.out.println("EagerSingleton");
	}
}
