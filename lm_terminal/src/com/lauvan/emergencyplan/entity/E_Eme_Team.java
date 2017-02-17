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

import com.lauvan.resource.entity.R_Team;
/**
 * 
 * ClassName: E_Eme_Team 
 * @Description: 预案应急队伍关联表
 * @author 钮炜炜
 * @date 2015年12月11日 下午2:37:40
 */
@Entity
@Table(name = "e_eme_team")
@DynamicInsert(true)
@DynamicUpdate(true)
public class E_Eme_Team implements Serializable{

	private static final long serialVersionUID = 7957012793856586777L;
	private Integer et_id;
	/**
	 * 预案ID
	 */
	private Integer pi_id;
	
	private R_Team team;

	public E_Eme_Team() {
		super();
	}

	public E_Eme_Team(Integer pi_id, R_Team team) {
		super();
		this.pi_id = pi_id;
		this.team = team;
	}

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getEt_id() {
		return et_id;
	}

	public void setEt_id(Integer et_id) {
		this.et_id = et_id;
	}

	public Integer getPi_id() {
		return pi_id;
	}

	public void setPi_id(Integer pi_id) {
		this.pi_id = pi_id;
	}

	@ManyToOne
	@JoinColumn(name="te_id")
	public R_Team getTeam() {
		return team;
	}

	public void setTeam(R_Team team) {
		this.team = team;
	}
}
