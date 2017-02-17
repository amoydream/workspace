package com.lauvan.resource.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Supplies;
import com.lauvan.resource.service.SuppliesService;

@Service("suppliesService")
public class SuppliesServiceImpl extends BaseDAOSupport<R_Supplies> 
implements SuppliesService {

}
