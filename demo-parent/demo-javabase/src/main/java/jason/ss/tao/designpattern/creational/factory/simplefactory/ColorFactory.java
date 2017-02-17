package jason.ss.tao.designpattern.creational.factory.simplefactory;

import java.awt.Color;

public class ColorFactory {
	public Color getColor(String color) {
		switch(color) {
		case "red":
			return Color.RED;
		case "blue":
			return Color.BLUE;
		case "green":
			return Color.GREEN;
		default:
			return Color.BLACK;
		}
	}
}
