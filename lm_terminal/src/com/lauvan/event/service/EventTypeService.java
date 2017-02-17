package com.lauvan.event.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.event.entity.T_Event_Type;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;

public interface EventTypeService extends BaseDAO<T_Event_Type> {
	public List<TreeVo> tree();
	public void deleteAll(Integer id);
	/**
	 * ztree 树
	 * @return
	 */
	public List<Tree2Vo> tree2();
}
