package jason.ss.tao.entity.association;

import java.io.Serializable;
import java.util.Set;

public class MM2_Student implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;
	private Set<MM2_Teacher>	teachers;

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

	public Set<MM2_Teacher> getTeachers() {
		return teachers;
	}

	public void setTeachers(Set<MM2_Teacher> teachers) {
		this.teachers = teachers;
	}
}
