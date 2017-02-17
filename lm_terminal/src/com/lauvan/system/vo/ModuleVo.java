package com.lauvan.system.vo;

import java.util.List;
/**
 * @describe 封装导航菜单类
 * @author 钮炜炜,陈存登
 * @version 1.1 26-8-2015
 */
public class ModuleVo {

	private Integer id;
	/**
	 * 菜单名称
	 */
	private String name;
	/**
	 * 路径
	 */
	private String url;
	/**
	 * 图标样式
	 */
	private String icon;
	/**
	 * 二级目录集
	 */
	private List<ModuleVo> ms;

	public ModuleVo() {
		super();
	}

	public ModuleVo(Integer id, String name, String url,String icon) {
		super();
		this.id = id;
		this.name = name;
		this.url = url;
		this.icon = icon;
	}

	public ModuleVo(Integer id, String name,String icon) {
		super();
		this.id = id;
		this.name = name;
		this.icon = icon;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public List<ModuleVo> getMs() {
		return ms;
	}

	public void setMs(List<ModuleVo> ms) {
		this.ms = ms;
	}

}
