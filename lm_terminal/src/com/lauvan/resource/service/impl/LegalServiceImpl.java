package com.lauvan.resource.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Legal;
import com.lauvan.resource.service.LegalService;

@Service("legalService")
public class LegalServiceImpl extends BaseDAOSupport<R_Legal> 
implements LegalService{

}
