package jason.ss.tao.designpattern.creational.factory.factorymethod;

public class CarFactory implements VehicleFactory<Car> {

	@Override
	public Car create() {
		return new Car();
	}

}
