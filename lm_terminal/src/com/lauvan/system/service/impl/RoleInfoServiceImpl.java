package com.lauvan.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.system.entity.T_Role_Info;
import com.lauvan.system.entity.T_Role_Module;
import com.lauvan.system.entity.T_Role_Module_Id;
import com.lauvan.system.entity.T_User_Role;
import com.lauvan.system.service.RoleInfoService;
@Service("roleInfoService")
public class RoleInfoServiceImpl extends BaseDAOSupport<T_Role_Info> implements
		RoleInfoService {

	public void saveAll(T_Role_Info r,String[] moids) {
		update(r);
		@SuppressWarnings("unchecked")
		List<T_Role_Module> rms = em.createQuery("select o from T_Role_Module o where o.id.ro_Id=?1").setParameter(1, r.getRo_Id()).getResultList();
		if (!rms.isEmpty()) {
			for (T_Role_Module rm : rms) {
				em.remove(rm);
			}
		}
		if (moids!=null) {
			for (String id : moids) {
				update(new T_Role_Module(new T_Role_Module_Id(Integer.valueOf(id), r.getRo_Id())));
			}
		}
		
	}
	
	public void deleteAll(List<T_User_Role> urs,Integer id,List<T_Role_Module> rms) {
		for (T_User_Role ur : urs) {
			em.remove(ur);
		}
		for (T_Role_Module rm : rms) {
			em.remove(rm);
		}
		delete(id);
	}
	
}
