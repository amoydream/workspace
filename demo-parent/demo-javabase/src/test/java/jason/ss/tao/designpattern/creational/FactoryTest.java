package jason.ss.tao.designpattern.creational;

import java.awt.Color;

import jason.ss.tao.designpattern.creational.factory.factorymethod.Bicycle;
import jason.ss.tao.designpattern.creational.factory.factorymethod.BicycleFactory;
import jason.ss.tao.designpattern.creational.factory.factorymethod.Car;
import jason.ss.tao.designpattern.creational.factory.factorymethod.CarFactory;
import jason.ss.tao.designpattern.creational.factory.factorymethod.VehicleFactory;
import jason.ss.tao.designpattern.creational.factory.simplefactory.ColorFactory;
import junit.framework.TestCase;

public class FactoryTest extends TestCase {
	public void testFactoryMethod() {
		ColorFactory colorFactory = new ColorFactory();
		assertEquals(colorFactory.getColor("red"), Color.RED);
		assertEquals(colorFactory.getColor("blue"), Color.BLUE);
	}

	public void testAbstractFactory() {
		VehicleFactory<Bicycle> bicycleFactory = new BicycleFactory();
		Bicycle bicycle = bicycleFactory.create();
		bicycle.use();

		VehicleFactory<Car> carFactory = new CarFactory();
		Car car = carFactory.create();
		car.use();
	}
}
