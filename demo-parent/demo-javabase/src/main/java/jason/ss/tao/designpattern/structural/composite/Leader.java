package jason.ss.tao.designpattern.structural.composite;

public class Leader extends Employee {
	public Leader(String name, float salary, Employee leader) {
		super(name, salary, leader, false);
	}
}
