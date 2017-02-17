package com.lauvan.dutymanage1.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.dutymanage1.entity.D_Handover_Info;
import com.lauvan.system.entity.T_User_Info;

public interface HandoverInfoService extends BaseDAO<D_Handover_Info> {
	public void addAll(D_Handover_Info handover_Info, T_User_Info user_Info1,T_User_Info user_Info2);
}
