package jason.ss.tao.designpattern.creational.factory.factorymethod;

public class Car extends Vehicle {

	public Car() {
		super("Car");
	}

	@Override
	public void use() {
		System.out.println(getName() + " for drive!");
	}

}
