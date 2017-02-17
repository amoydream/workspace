package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
public class E_Plan_Organ_Id implements Serializable{
	private static final long serialVersionUID = -1721095926970179802L;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	/**
	 * 组织ID
	 */
	private Integer or_id;
	public E_Plan_Organ_Id() {
		super();
	}
	public E_Plan_Organ_Id(Integer pi_id, Integer or_id) {
		super();
		this.pi_id = pi_id;
		this.or_id = or_id;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	public Integer getOr_id() {
		return or_id;
	}
	public void setOr_id(Integer or_id) {
		this.or_id = or_id;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((or_id == null) ? 0 : or_id.hashCode());
		result = prime * result + ((pi_id == null) ? 0 : pi_id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		E_Plan_Organ_Id other = (E_Plan_Organ_Id) obj;
		if (or_id == null) {
			if (other.or_id != null)
				return false;
		} else if (!or_id.equals(other.or_id))
			return false;
		if (pi_id == null) {
			if (other.pi_id != null)
				return false;
		} else if (!pi_id.equals(other.pi_id))
			return false;
		return true;
	}
}
