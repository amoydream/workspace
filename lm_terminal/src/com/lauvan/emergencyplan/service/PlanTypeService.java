package com.lauvan.emergencyplan.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_PlanType;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;

public interface PlanTypeService extends BaseDAO<E_PlanType> {
	public List<TreeVo> tree();
	public void deleteAll(Integer id);
	/**
	 * ztree 树
	 * @return
	 */
	public List<Tree2Vo> tree2();
}
