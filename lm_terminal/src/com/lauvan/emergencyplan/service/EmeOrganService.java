package com.lauvan.emergencyplan.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.emergencyplan.entity.E_EmeOrgan;
import com.lauvan.system.vo.TreeVo;

public interface EmeOrganService extends BaseDAO<E_EmeOrgan> {

	public List<TreeVo> tree();
	
	public void deleteAll(Integer id);
}
