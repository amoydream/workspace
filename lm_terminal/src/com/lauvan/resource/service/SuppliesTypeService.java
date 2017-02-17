package com.lauvan.resource.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.resource.entity.R_Supplies_Type;
import com.lauvan.system.vo.TreeVo;

public interface SuppliesTypeService extends BaseDAO<R_Supplies_Type>{
	
	public List<TreeVo> tree();

	public void deleteAll(Integer id);

}
