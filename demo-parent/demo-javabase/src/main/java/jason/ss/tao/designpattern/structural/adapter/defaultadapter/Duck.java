package jason.ss.tao.designpattern.structural.adapter.defaultadapter;

public class Duck extends DefaultBirds {
	@Override
	public void walk() {
		System.out.println("鸭得这么走！");
	}

	@Override
	public void swim() {
		System.out.println("鸭得这么游！");
	}
}
