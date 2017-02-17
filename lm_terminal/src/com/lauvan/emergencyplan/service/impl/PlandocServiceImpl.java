package com.lauvan.emergencyplan.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Plandoc;
import com.lauvan.emergencyplan.service.PlandocService;
@Service("plandocService")
public class PlandocServiceImpl extends BaseDAOSupport<E_Plandoc> implements
		PlandocService {

}
