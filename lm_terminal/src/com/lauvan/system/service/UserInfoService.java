package com.lauvan.system.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.entity.T_User_Role;

public interface UserInfoService extends BaseDAO<T_User_Info> {
	/**
	 * 删除用户
	 * @param id 用户ID
	 * @param urs 用户角色中间表
	 */
	public void deleteAll(Integer id,List<T_User_Role> urs);
}
