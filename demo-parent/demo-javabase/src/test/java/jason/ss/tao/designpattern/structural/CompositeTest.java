package jason.ss.tao.designpattern.structural;

import java.util.List;

import org.junit.Test;

import jason.ss.tao.designpattern.structural.composite.Boss;
import jason.ss.tao.designpattern.structural.composite.Employee;
import jason.ss.tao.designpattern.structural.composite.Leader;
import jason.ss.tao.designpattern.structural.composite.Subordinate;
import junit.framework.TestCase;

public class CompositeTest extends TestCase {
	@Test
	public void testEmployee() {
		Boss jason = Boss.getBoss();

		Leader devLeader = new Leader("Dev Leader 1", 15000.0f, jason);
		Subordinate dev1 = new Subordinate("Dev1", 7000.f, devLeader);
		Subordinate dev2 = new Subordinate("Dev2", 7000.f, devLeader);
		devLeader.addSubordinate(dev1);
		devLeader.addSubordinate(dev2);

		Leader salesLeader = new Leader("Sales Leader 1", 10000.0f, jason);
		Subordinate sales1 = new Subordinate("Sales1", 5000.f, salesLeader);
		Subordinate sales2 = new Subordinate("Sales2", 5000.f, salesLeader);
		salesLeader.addSubordinate(sales1);
		salesLeader.addSubordinate(sales2);

		jason.addSubordinate(devLeader);
		jason.addSubordinate(salesLeader);

		assertEquals(sumSalary(jason), 49000.0f);
	}

	private float sumSalary(Employee emp) {
		float sum = emp.getSalary();
		if(!emp.isLeaf()) {
			List<Employee> subordinates = emp.getSubordinates();
			for(Employee sub : subordinates) {
				sum += sumSalary(sub);
			}
		}

		return sum;
	}
}
