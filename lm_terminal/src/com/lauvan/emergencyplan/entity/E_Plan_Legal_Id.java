package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
public class E_Plan_Legal_Id implements Serializable{
	private static final long serialVersionUID = -8995264586425812502L;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	/**
	 * 法律法规ID
	 */
	private Integer le_id;
	public E_Plan_Legal_Id() {
		super();
	}
	public E_Plan_Legal_Id(Integer pi_id, Integer le_id) {
		super();
		this.pi_id = pi_id;
		this.le_id = le_id;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	public Integer getLe_id() {
		return le_id;
	}
	public void setLe_id(Integer le_id) {
		this.le_id = le_id;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((le_id == null) ? 0 : le_id.hashCode());
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
		E_Plan_Legal_Id other = (E_Plan_Legal_Id) obj;
		if (le_id == null) {
			if (other.le_id != null)
				return false;
		} else if (!le_id.equals(other.le_id))
			return false;
		if (pi_id == null) {
			if (other.pi_id != null)
				return false;
		} else if (!pi_id.equals(other.pi_id))
			return false;
		return true;
	}
}
