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

import com.lauvan.resource.entity.R_Expert;
/**
 * 
 * ClassName: E_Eme_Expert 
 * @Description: 预案-应急资源-专家
 * @author 钮炜炜
 * @date 2015年12月24日 下午4:11:36
 */
@Entity
@Table(name = "e_eme_expert")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Eme_Expert implements Serializable{

	private static final long serialVersionUID = 8007605201976439571L;
	private Integer ex_id;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	
	private R_Expert expert;

	public E_Eme_Expert() {
		super();
	}

	public E_Eme_Expert(Integer pi_id, R_Expert expert) {
		super();
		this.pi_id = pi_id;
		this.expert = expert;
	}

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEx_id() {
		return ex_id;
	}

	public void setEx_id(Integer ex_id) {
		this.ex_id = ex_id;
	}

	public Integer getPi_id() {
		return pi_id;
	}

	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}
	@ManyToOne
	@JoinColumn(name="rex_id")
	public R_Expert getExpert() {
		return expert;
	}

	public void setExpert(R_Expert expert) {
		this.expert = expert;
	}
}
