package jason.ss.tao.designpattern.creational.builder;

public abstract class Component {
	protected String	type;
	protected String	model;

	public Component(String type, String model) {
		this.type = type;
		this.model = model;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

}
