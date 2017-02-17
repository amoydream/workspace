package com.lauvan.dutymanage.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.dutymanage.entity.T_Handover;
import com.lauvan.dutymanage.service.HandoverService;

@Service("handoverService")
public class HandoverServiceImpl extends BaseDAOSupport<T_Handover> implements HandoverService{

}
