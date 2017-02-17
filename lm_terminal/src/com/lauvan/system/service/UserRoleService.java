package com.lauvan.system.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.system.entity.T_User_Role;

public interface UserRoleService extends BaseDAO<T_User_Role> {

	/**
	 * 保存用户角色
	 * @param id
	 * @param roids
	 */
	public void saveRole(Integer id,String[] roids);
}
