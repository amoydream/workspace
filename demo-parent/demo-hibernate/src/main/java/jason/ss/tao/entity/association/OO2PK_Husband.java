package jason.ss.tao.entity.association;

import java.io.Serializable;

public class OO2PK_Husband implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;
	private OO2PK_Wife			wife;

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

	public OO2PK_Wife getWife() {
		return wife;
	}

	public void setWife(OO2PK_Wife wife) {
		this.wife = wife;
	}
}
