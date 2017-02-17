package com.lauvan.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.system.entity.T_User_Role;
import com.lauvan.system.entity.T_User_Role_Id;
import com.lauvan.system.service.UserRoleService;
@Service("userRoleService")
public class UserRoleServiceImpl extends BaseDAOSupport<T_User_Role> implements
		UserRoleService {

	public void saveRole(Integer id,String[] roids) {
		List<T_User_Role> urs = findByProperty("id.usId", id);
		for (T_User_Role ur : urs) {
			delete(ur.getId());
		}
		for (String roid : roids) {
			save(new T_User_Role(new T_User_Role_Id(id, Integer.valueOf(roid))));
		}
	}
}
