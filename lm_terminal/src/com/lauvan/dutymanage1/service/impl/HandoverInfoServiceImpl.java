package com.lauvan.dutymanage1.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.dutymanage1.entity.D_Handover_Info;
import com.lauvan.dutymanage1.service.HandoverInfoService;
import com.lauvan.system.entity.T_User_Info;

@Service("handoverInfoService")
public class HandoverInfoServiceImpl extends BaseDAOSupport<D_Handover_Info>
		implements HandoverInfoService {

	public void addAll(D_Handover_Info handover_Info, T_User_Info user_Info1,
			T_User_Info user_Info2) {
		update(handover_Info);
		update(user_Info1);
		update(user_Info2);
	}
}
