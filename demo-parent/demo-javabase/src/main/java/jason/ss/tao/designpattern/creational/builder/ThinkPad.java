package jason.ss.tao.designpattern.creational.builder;

import java.util.ArrayList;
import java.util.List;

public abstract class ThinkPad {
	private String			model;
	private List<Component>	components	= new ArrayList<Component>();

	public ThinkPad(String model) {
		this.model = model;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public List<Component> getComponents() {
		return components;
	}

	public void setComponents(List<Component> components) {
		this.components = components;
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("Model: " + model + "\n");
		if(components != null) {
			sb.append("Components:\n");
			for(Component c : components) {
				sb.append("Type: " + c.getType() + "\n");
				sb.append("Model: " + c.getModel() + "\n");
			}
		}
		return sb.toString();
	}
}
