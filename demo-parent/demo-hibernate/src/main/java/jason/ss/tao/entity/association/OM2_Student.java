package jason.ss.tao.entity.association;

import java.io.Serializable;

public class OM2_Student implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;
	private OM2_Class			clazz;

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

	public OM2_Class getClazz() {
		return clazz;
	}

	public void setClazz(OM2_Class clazz) {
		this.clazz = clazz;
	}
}
