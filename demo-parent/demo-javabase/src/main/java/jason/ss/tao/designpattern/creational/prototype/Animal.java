package jason.ss.tao.designpattern.creational.prototype;

public abstract class Animal implements Cloneable {
	protected String name;

	public Animal(String name) {
		this.name = name;
	}

	@Override
	public Animal clone() {
		Animal clone = null;
		try {
			clone = (Animal)super.clone();
		} catch(CloneNotSupportedException e) {
			e.printStackTrace();
		}

		return clone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
