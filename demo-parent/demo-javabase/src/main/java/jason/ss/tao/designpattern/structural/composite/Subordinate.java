package jason.ss.tao.designpattern.structural.composite;

public class Subordinate extends Employee {
	public Subordinate(String name, float salary, Employee leader) {
		super(name, salary, leader, true);
	}
}
