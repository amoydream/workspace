package com.lauvan.organ.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.organ.vo.OrganVo;
import com.lauvan.system.vo.TreeVo;

public interface OrganService extends BaseDAO<C_Organ> {
	/**
	 * 组织机构树
	 * @return
	 */
	public List<TreeVo> tree();
	
	public void deleteAll(Integer id);
	
	public List<C_Organ> findByPid(Integer pid);

	List<C_Organ> listAll();

	List<C_Organ> getListNullParent();

	public QueryResult<C_Organ> getOrganPage(OrganVo vo);
}
