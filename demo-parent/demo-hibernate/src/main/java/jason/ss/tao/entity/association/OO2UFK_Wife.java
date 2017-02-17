package jason.ss.tao.entity.association;

import java.io.Serializable;

public class OO2UFK_Wife implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;
	private OO2UFK_Husband		husband;

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

	public OO2UFK_Husband getHusband() {
		return husband;
	}

	public void setHusband(OO2UFK_Husband husband) {
		this.husband = husband;
	}
}
