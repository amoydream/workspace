package jason.ss.tao.designpattern.structural.adapter.defaultadapter;

public class Swan extends DefaultBirds {
	@Override
	public void fly() {
		System.out.println("天鹅得这么飞！");
	}

	@Override
	public void walk() {
		System.out.println("天鹅得这么走！");
	}

	@Override
	public void swim() {
		System.out.println("天鹅得这么游！");
	}
}
