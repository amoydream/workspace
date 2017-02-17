package com.lauvan.emergencyplan.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Eme_Classification;
import com.lauvan.emergencyplan.service.EmeClassificationService;
@Service("emeClassificationService")
public class EmeClassificationServiceImpl extends
		BaseDAOSupport<E_Eme_Classification> implements
		EmeClassificationService {

}
