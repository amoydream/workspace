package jason.ss.tao.designpattern.creational.factory.factorymethod;

public abstract class Vehicle {
	private String name;

	public Vehicle(String name) {
		this.name = name;
	}

	public abstract void use();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
