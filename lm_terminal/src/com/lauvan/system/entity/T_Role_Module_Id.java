package com.lauvan.system.entity;

import javax.persistence.Embeddable;

@Embeddable
public class T_Role_Module_Id implements java.io.Serializable {

	private static final long serialVersionUID = -8330240264396835132L;
	private Integer mo_Id;
	private Integer ro_Id;

	public T_Role_Module_Id() {
	}

	public T_Role_Module_Id(Integer moId, Integer roId) {
		this.mo_Id = moId;
		this.ro_Id = roId;
	}

	public Integer getMo_Id() {
		return this.mo_Id;
	}

	public void setMo_Id(Integer moId) {
		this.mo_Id = moId;
	}

	public Integer getRo_Id() {
		return this.ro_Id;
	}

	public void setRo_Id(Integer roId) {
		this.ro_Id = roId;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof T_Role_Module_Id))
			return false;
		T_Role_Module_Id castOther = (T_Role_Module_Id) other;

		return ((this.getMo_Id() == castOther.getMo_Id()) || (this.getMo_Id() != null
				&& castOther.getMo_Id() != null && this.getMo_Id().equals(
				castOther.getMo_Id())))
				&& ((this.getRo_Id() == castOther.getRo_Id()) || (this.getRo_Id() != null
						&& castOther.getRo_Id() != null && this.getRo_Id()
						.equals(castOther.getRo_Id())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getMo_Id() == null ? 0 : this.getMo_Id().hashCode());
		result = 37 * result
				+ (getRo_Id() == null ? 0 : this.getRo_Id().hashCode());
		return result;
	}
}