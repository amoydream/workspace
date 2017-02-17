package jason.ss.tao.designpattern.creational.factory.factorymethod;

public class BicycleFactory implements VehicleFactory<Bicycle> {

	@Override
	public Bicycle create() {
		return new Bicycle();
	}

}
