package jason.ss.tao.designpattern.structural.composite;

import java.util.ArrayList;
import java.util.List;

public abstract class Employee {
	private String			name;
	private float			salary;
	private Employee		leader;
	private List<Employee>	subordinates	= new ArrayList<Employee>();
	private boolean			isLeaf			= false;

	public Employee(String name, float salary, Employee leader, boolean isLeaf) {
		if(leader == null && getClass() != Boss.class) {
			throw new RuntimeException("Employee must have a leader!");
		}
		this.name = name;
		this.salary = salary;
		this.leader = leader;
		this.isLeaf = isLeaf;
	}

	public void addSubordinate(Employee employee) {
		if(isLeaf) {
			throw new RuntimeException("Can not add subordinate to a non-leader!");
		}

		subordinates.add(employee);
	}

	public void removeSubordinate(Employee employee) {
		if(isLeaf) {
			throw new RuntimeException("Can not remove subordinate from a non-leader!");
		}

		subordinates.remove(employee);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getSalary() {
		return salary;
	}

	public void setSalary(float salary) {
		this.salary = salary;
	}

	public Employee getLeader() {
		return leader;
	}

	public void setLeader(Employee leader) {
		this.leader = leader;
	}

	public List<Employee> getSubordinates() {
		return subordinates;
	}

	public void setSubordinates(List<Employee> subordinates) {
		if(subordinates == null) {
			subordinates = new ArrayList<Employee>();
		}

		if(isLeaf && subordinates.size() > 0) {
			throw new RuntimeException("Can not add subordinate to a non-leader!");
		}

		this.subordinates = subordinates;
	}

	public boolean isLeaf() {
		return isLeaf;
	}
}
