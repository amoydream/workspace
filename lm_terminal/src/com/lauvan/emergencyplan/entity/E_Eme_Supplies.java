package com.lauvan.emergencyplan.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.lauvan.resource.entity.R_Supplies;
/**
 * 
 * ClassName: E_Eme_Supplies 
 * @Description: 预案应急物资关联表
 * @author 钮炜炜
 * @date 2015年12月11日 下午2:30:44
 */
@Entity
@Table(name = "e_eme_supplies")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Eme_Supplies implements Serializable{

	private static final long serialVersionUID = 6235082200597451066L;
	private Integer er_id;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	/**
	 * 物资
	 */
	private R_Supplies suppliy;
	
	public E_Eme_Supplies() {
		super();
	}
	public E_Eme_Supplies(Integer pi_id, R_Supplies suppliy) {
		super();
		this.pi_id = pi_id;
		this.suppliy = suppliy;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEr_id() {
		return er_id;
	}
	public void setEr_id(Integer er_id) {
		this.er_id = er_id;
	}
	public Integer getPi_id() {
		return pi_id;
	}
	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	@ManyToOne
	@JoinColumn(name="su_id")
	public R_Supplies getSuppliy() {
		return suppliy;
	}
	public void setSuppliy(R_Supplies suppliy) {
		this.suppliy = suppliy;
	}
}
