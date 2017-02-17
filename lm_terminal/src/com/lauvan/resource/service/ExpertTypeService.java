package com.lauvan.resource.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.resource.entity.R_Expert_Type;
import com.lauvan.system.vo.TreeVo;

public interface ExpertTypeService extends BaseDAO<R_Expert_Type>{
	public List<TreeVo> tree();
	

}
