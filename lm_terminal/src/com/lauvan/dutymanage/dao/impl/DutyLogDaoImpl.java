package com.lauvan.dutymanage.dao.impl;

import org.springframework.stereotype.Repository;

import com.lauvan.base.dao.DAOTemplate;
import com.lauvan.dutymanage.dao.DutyLogDao;
import com.lauvan.dutymanage.entity.T_Duty_Log;

/**
 * @describe 值守日志Dao层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Repository(value = "dutyLogDao")
public class DutyLogDaoImpl extends DAOTemplate<T_Duty_Log> implements DutyLogDao {}
