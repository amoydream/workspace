package com.lauvan.system.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.system.entity.T_Syslog_Info;
import com.lauvan.system.service.SyslogInfoService;
@Service("syslogInfoService")
public class SyslogInfoServiceImpl extends BaseDAOSupport<T_Syslog_Info>
		implements SyslogInfoService {

}
