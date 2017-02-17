package com.lauvan.meip.service.db.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "dfsdlseq")
public class DfsdlSeq
	implements BaseEntity {
	private static final long	serialVersionUID	= -6589578817394855758L;
	private Integer				dfsdlid;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getDfsdlid() {
		return dfsdlid;
	}

	public void setDfsdlid(Integer dfsdlid) {
		this.dfsdlid = dfsdlid;
	}
}