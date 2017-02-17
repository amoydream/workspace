package jason.ss.tao.entity.association;

import java.io.Serializable;
import java.util.Set;

public class MM1_Teacher implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;
	private Set<MM1_Student>	students;

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

	public Set<MM1_Student> getStudents() {
		return students;
	}

	public void setStudents(Set<MM1_Student> students) {
		this.students = students;
	}
}
