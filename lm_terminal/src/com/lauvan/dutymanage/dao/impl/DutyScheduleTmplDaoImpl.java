package com.lauvan.dutymanage.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lauvan.base.dao.DAOTemplate;
import com.lauvan.dutymanage.dao.DutyScheduleTmplDao;
import com.lauvan.dutymanage.entity.T_Duty_Schedule_Tmpl;

/**
 * @describe 值班排班Dao层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Repository(value = "dutyScheduleTmplDao")
public class DutyScheduleTmplDaoImpl extends DAOTemplate<T_Duty_Schedule_Tmpl>
	implements DutyScheduleTmplDao {
	@Override
	public T_Duty_Schedule_Tmpl getScheduleTemplate(Integer pe_id, String duty_prop, String duty_type) {
		String jpql = "pe_id = ?1 and duty_prop = ?2 and duty_type = ?3";

		List<T_Duty_Schedule_Tmpl> list = getListEntitys(jpql, new Object[]{pe_id, duty_prop, duty_type});

		if(list != null && list.size() > 0) {
			return list.get(0);
		}

		return null;
	}
}
