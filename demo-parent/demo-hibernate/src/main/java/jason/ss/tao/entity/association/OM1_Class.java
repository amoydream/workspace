package jason.ss.tao.entity.association;

import java.io.Serializable;
import java.util.Set;

public class OM1_Class implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;
	private Set<OM1_Student>	students;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<OM1_Student> getStudents() {
		return students;
	}

	public void setStudents(Set<OM1_Student> students) {
		this.students = students;
	}
}
