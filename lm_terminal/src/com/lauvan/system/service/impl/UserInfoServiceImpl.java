package com.lauvan.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.entity.T_User_Role;
import com.lauvan.system.service.UserInfoService;
@Service("userInfoService")
public class UserInfoServiceImpl extends BaseDAOSupport<T_User_Info> implements
		UserInfoService {
	public void deleteAll(Integer id,List<T_User_Role> urs) {
		for (T_User_Role ur : urs) {
			em.remove(ur);
		}
		delete(id);
	}
}
