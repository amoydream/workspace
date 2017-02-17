package jason.ss.tao.designpattern.creational.factory.factorymethod;

public class Bicycle extends Vehicle {
	public Bicycle() {
		super("Bicycle");
	}

	@Override
	public void use() {
		System.out.println(getName() + " for ride!");
	}
}
