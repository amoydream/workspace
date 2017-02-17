package com.lauvan.resource.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Equipment_Type;
import com.lauvan.resource.service.EquipmentTypeService;

@Service("equipmentTypeService")
public class EquipmentTypeServiceImpl extends BaseDAOSupport<R_Equipment_Type> 
implements EquipmentTypeService{

}
