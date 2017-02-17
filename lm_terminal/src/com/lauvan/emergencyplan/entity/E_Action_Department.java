package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.organ.entity.C_Address_Book;

/**
 * 
 * ClassName: E_Action_Department 
 * @Description: 预案应急处置阶段流程-行动清单-执行人员表
 * @author 钮炜炜
 * @date 2015年12月12日 下午2:27:31
 */
@Entity
@Table(name = "e_action_department")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Action_Department implements Serializable{

	private static final long serialVersionUID = -8191155111944595067L;
	private Integer ead_id;
	/**
	 * 备注
	 */
	private String ead_remark;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	/**
	 * 行动清单
	 */
	private Integer eal_id;
	/**
	 * 执行人员
	 */
	private C_Address_Book aBooks;
	
	@Id
	public Integer getEad_id() {
		return ead_id;
	}
	public void setEad_id(Integer ead_id) {
		this.ead_id = ead_id;
	}
	
	@Column(length=200)
	public String getEad_remark() {
		return ead_remark;
	}
	public void setEad_remark(String ead_remark) {
		this.ead_remark = ead_remark;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	public Integer getEal_id() {
		return eal_id;
	}
	public void setEal_id(Integer eal_id) {
		this.eal_id = eal_id;
	}
	@ManyToOne
	@JoinColumn(name = "bo_id")
	public C_Address_Book getaBooks() {
		return aBooks;
	}
	public void setaBooks(C_Address_Book aBooks) {
		this.aBooks = aBooks;
	}
}
