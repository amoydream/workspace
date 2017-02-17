package jason.ss.tao.entity.association;

import java.io.Serializable;

public class OO2UFK_Husband implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;
	private OO2UFK_Wife			wife;

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

	public OO2UFK_Wife getWife() {
		return wife;
	}

	public void setWife(OO2UFK_Wife wife) {
		this.wife = wife;
	}
}
