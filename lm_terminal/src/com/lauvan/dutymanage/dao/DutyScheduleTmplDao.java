package com.lauvan.dutymanage.dao;

import com.lauvan.base.dao.BaseDAO1;
import com.lauvan.dutymanage.entity.T_Duty_Schedule_Tmpl;

/**
 * @describe 值班排班Dao层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
public interface DutyScheduleTmplDao extends BaseDAO1<T_Duty_Schedule_Tmpl> {
	T_Duty_Schedule_Tmpl getScheduleTemplate(Integer personId, String dutyProp, String dutyType);
}