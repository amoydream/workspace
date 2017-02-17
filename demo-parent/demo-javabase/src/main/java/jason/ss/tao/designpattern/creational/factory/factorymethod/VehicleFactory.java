package jason.ss.tao.designpattern.creational.factory.factorymethod;

public interface VehicleFactory<T extends Vehicle> {
	T create();
}
