package com.lauvan.resource.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Expert;
import com.lauvan.resource.service.ExpertService;

@Service("expertService")
public class ExpertServiceImpl extends BaseDAOSupport<R_Expert> 
implements ExpertService{

}
