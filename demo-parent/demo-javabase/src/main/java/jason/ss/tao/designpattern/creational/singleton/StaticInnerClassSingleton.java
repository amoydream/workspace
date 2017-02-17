package jason.ss.tao.designpattern.creational.singleton;

public class StaticInnerClassSingleton {
	private StaticInnerClassSingleton() {
	}

	//静态内部类在被使用时才加载
	private static class InstanceHolder {
		private static final StaticInnerClassSingleton instance = new StaticInnerClassSingleton();
	}

	public static StaticInnerClassSingleton getInstance() {
		return InstanceHolder.instance;
	}
}
