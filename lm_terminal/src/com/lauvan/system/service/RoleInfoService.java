package com.lauvan.system.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.system.entity.T_Role_Info;
import com.lauvan.system.entity.T_Role_Module;
import com.lauvan.system.entity.T_User_Role;

public interface RoleInfoService extends BaseDAO<T_Role_Info> {
	public void saveAll(T_Role_Info r,String[] moids);
	public void deleteAll(List<T_User_Role> urs,Integer id,List<T_Role_Module> rms);
}
