package com.lauvan.system.vo;

import java.io.Serializable;
import java.util.List;
/**
 * 
 * ClassName: Tree2Vo 
 * @Description: 系统菜单树
 * @author 钮炜炜
 * @date 2015年11月26日 下午4:01:32
 */
public class Tree2Vo implements Serializable{
	private static final long serialVersionUID = 3311551685982779776L;
	
	private Integer id;
    private Integer pId;
    private String name;
    private Boolean checked;
    private Boolean open;
    
    private List<Tree2Vo> children;
    
	public Tree2Vo() {
		super();
	}
	public Tree2Vo(Integer id, Integer pId, String name) {
		super();
		this.id = id;
		this.pId = pId;
		this.name = name;
	}
	public Tree2Vo(Integer id, String name) {
		super();
		this.id = id;
		this.name = name;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getpId() {
		return pId;
	}
	public void setpId(Integer pId) {
		this.pId = pId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Boolean getChecked() {
		return checked;
	}
	public void setChecked(Boolean checked) {
		this.checked = checked;
	}
	public Boolean getOpen() {
		return open;
	}
	public void setOpen(Boolean open) {
		this.open = open;
	}
	public List<Tree2Vo> getChildren() {
		return children;
	}
	public void setChildren(List<Tree2Vo> children) {
		this.children = children;
	}
}