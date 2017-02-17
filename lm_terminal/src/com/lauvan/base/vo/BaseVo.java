package com.lauvan.base.vo;

import java.io.Serializable;

/**
 * 
 * ClassName: BaseVo 
 * @Description: 封装easyui参数
 * @author 钮炜炜
 * @date 2015年9月9日 上午11:27:47
 */
public class BaseVo implements Serializable{
	private static final long serialVersionUID = -7665000204896097505L;
	private Integer us_Id;
	/**
	 * 分页的当前页
	 */
	private int page;
	/**
	 * 分页的每页显示记录数
	 */
	private int rows;
	
	private String searchType;
	private String searchValue;
	
	public Integer getUs_Id() {
		return us_Id;
	}
	
	public void setUs_Id(Integer us_Id) {
		this.us_Id = us_Id;
	}
	
	public Integer getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	
}
