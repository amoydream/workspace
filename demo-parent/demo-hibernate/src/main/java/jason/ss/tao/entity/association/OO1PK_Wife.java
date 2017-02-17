package jason.ss.tao.entity.association;

import java.io.Serializable;

public class OO1PK_Wife implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;

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
}
