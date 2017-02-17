package com.lauvan.system.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.system.entity.T_Module_Info;
import com.lauvan.system.vo.TreeVo;

public interface ModuleInfoService extends BaseDAO<T_Module_Info> {
	/**
	 * 菜单删除
	 * @param id
	 */
	public void deleteAll(Integer id);
	/**
	 * 菜单树
	 * @return
	 */
	public List<TreeVo> tree();
	
	/**
	 * 根据查询属性获取菜单信息
	 * @param step 级别
	 * @param attr 属性
	 * @return
	 */
	public List<T_Module_Info> findByAttr(String attr,int step);
	
}
