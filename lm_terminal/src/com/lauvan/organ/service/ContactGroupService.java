package com.lauvan.organ.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.organ.entity.T_Contact_Group;
import com.lauvan.system.vo.TreeVo;

public interface ContactGroupService extends BaseDAO<T_Contact_Group> {
	public TreeVo tree();
}
