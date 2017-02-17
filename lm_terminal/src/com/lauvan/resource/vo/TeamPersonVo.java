package com.lauvan.resource.vo;

import java.io.Serializable;

import com.lauvan.base.vo.BaseVo;

public class TeamPersonVo extends BaseVo implements Serializable{

	private static final long serialVersionUID = 3393020855777019855L;
	
	private Integer pe_Id;
	private Integer te_Id;
	
	public Integer getPe_Id() {
		return pe_Id;
	}
	public void setPe_Id(Integer pe_Id) {
		this.pe_Id = pe_Id;
	}
	public Integer getTe_Id() {
		return te_Id;
	}
	public void setTe_Id(Integer te_Id) {
		this.te_Id = te_Id;
	}
	
	

}
