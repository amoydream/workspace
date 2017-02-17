package com.lauvan.resource.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Equipment;
import com.lauvan.resource.service.EquipmentService;

@Service("equipmentService")
public class EquipmentServiceImpl extends BaseDAOSupport<R_Equipment> 
implements EquipmentService{

}
