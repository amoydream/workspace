package com.lauvan.emergencyplan.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.emergencyplan.entity.E_Monitoring_Warning;
import com.lauvan.emergencyplan.service.MonitoringWarningService;
@Service("monitoringWarningService")
public class MonitoringWarningServiceImpl extends
		BaseDAOSupport<E_Monitoring_Warning> implements
		MonitoringWarningService {

}
