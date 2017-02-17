package jason.ss.tao.entity.association;

import java.io.Serializable;

public class OO1PK_Husband implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;
	private OO1PK_Wife			wife;

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

	public OO1PK_Wife getWife() {
		return wife;
	}

	public void setWife(OO1PK_Wife wife) {
		this.wife = wife;
	}
}
