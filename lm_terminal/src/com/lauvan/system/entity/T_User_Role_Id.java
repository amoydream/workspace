package com.lauvan.system.entity;

import javax.persistence.Embeddable;

@Embeddable
public class T_User_Role_Id implements java.io.Serializable {

	private static final long serialVersionUID = 2813558891850831249L;
	private Integer usId;
	private Integer roId;

	public T_User_Role_Id() {
	}

	public T_User_Role_Id(Integer usId, Integer roId) {
		this.usId = usId;
		this.roId = roId;
	}

	public Integer getUsId() {
		return this.usId;
	}

	public void setUsId(Integer usId) {
		this.usId = usId;
	}

	public Integer getRoId() {
		return this.roId;
	}

	public void setRoId(Integer roId) {
		this.roId = roId;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof T_User_Role_Id))
			return false;
		T_User_Role_Id castOther = (T_User_Role_Id) other;

		return ((this.getUsId() == castOther.getUsId()) || (this.getUsId() != null
				&& castOther.getUsId() != null && this.getUsId().equals(
				castOther.getUsId())))
				&& ((this.getRoId() == castOther.getRoId()) || (this.getRoId() != null
						&& castOther.getRoId() != null && this.getRoId()
						.equals(castOther.getRoId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getUsId() == null ? 0 : this.getUsId().hashCode());
		result = 37 * result
				+ (getRoId() == null ? 0 : this.getRoId().hashCode());
		return result;
	}

}