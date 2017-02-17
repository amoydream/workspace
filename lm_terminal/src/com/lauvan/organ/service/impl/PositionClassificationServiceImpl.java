package com.lauvan.organ.service.impl;


import org.springframework.stereotype.Service;
import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.organ.entity.C_Position_Classification;
import com.lauvan.organ.service.PositionClassificationService;

@Service("positionClassificationService")
public class PositionClassificationServiceImpl extends BaseDAOSupport<C_Position_Classification>
		implements PositionClassificationService {

}
