package com.lauvan.system.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Version;

/**
 * 
 * ClassName: T_Sequence 
 * @Description: ID生成器
 * @author 钮炜炜
 * @date 2015年9月7日 下午4:05:20
 */
@Entity
@Table(name = "sequence")
public class T_Sequence implements java.io.Serializable {

	private static final long serialVersionUID = 2303482150956338238L;
	/**
	 * 表名
	 */
	private String name;
	/**
	 * ID值
	 */
	private Long seq;
	
	private Integer version;

	public T_Sequence() {
	}

	public T_Sequence(String name) {
		this.name = name;
	}

	public T_Sequence(String name, Long seq) {
		this.name = name;
		this.seq = seq;
	}

	@Id
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getSeq() {
		return this.seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}

	@Version
	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

}