package com.lauvan.resource.entity;

import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.lauvan.organ.entity.C_Organ_Person;


@Embeddable
public class R_Team_Person_Id implements java.io.Serializable {

	private static final long serialVersionUID = -2146728767963573135L;
	
	private R_Team te_Id;
	private C_Organ_Person pe_Id;

	public R_Team_Person_Id() {
	}

	public R_Team_Person_Id(R_Team te_Id, C_Organ_Person pe_Id) {
		this.te_Id = te_Id;
		this.pe_Id = pe_Id;
	}

	@ManyToOne
	@JoinColumn(name = "te_Id", nullable = false)
	public R_Team getTe_Id() {
		return this.te_Id;
	}

	public void setTe_Id(R_Team te_Id) {
		this.te_Id = te_Id;
	}

	@ManyToOne
	@JoinColumn(name = "pe_Id", nullable = false)
	public C_Organ_Person getPe_Id() {
		return this.pe_Id;
	}

	public void setPe_Id(C_Organ_Person pe_Id) {
		this.pe_Id = pe_Id;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof R_Team_Person_Id))
			return false;
		R_Team_Person_Id castOther = (R_Team_Person_Id) other;

		return ((this.getTe_Id() == castOther.getTe_Id()) || (this.getTe_Id() != null
				&& castOther.getTe_Id() != null && this.getTe_Id().equals(
				castOther.getTe_Id())))
				&& ((this.getPe_Id() == castOther.getPe_Id()) || (this.getPe_Id() != null
						&& castOther.getPe_Id() != null && this.getPe_Id()
						.equals(castOther.getPe_Id())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getTe_Id() == null ? 0 : this.getTe_Id().hashCode());
		result = 37 * result
				+ (getPe_Id() == null ? 0 : this.getPe_Id().hashCode());
		return result;
	}

}