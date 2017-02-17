package com.lauvan.dutymanage.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.lauvan.base.dao.DAOTemplate;
import com.lauvan.base.dao.PaginationQuery;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.criteria.DutyScheduleCriteria;
import com.lauvan.dutymanage.dao.DutyScheduleDao;
import com.lauvan.dutymanage.entity.T_Duty_Schedule;
import com.lauvan.util.ValidateUtil;

/**
 * @describe 值班排班Dao层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Repository(value = "dutyScheduleDao")
public class DutyScheduleDaoImpl extends DAOTemplate<T_Duty_Schedule>
	implements DutyScheduleDao {
	@Override
	public QueryResult<T_Duty_Schedule> getScheduleRecords(DutyScheduleCriteria c) {
		StringBuffer jpql = new StringBuffer("from T_Duty_Schedule where 1 = 1");

		return getPagingRecords(createPaginationQuery(jpql, c));
	}

	private PaginationQuery createPaginationQuery(StringBuffer jpql, DutyScheduleCriteria c) {
		List<Object> paramList = new ArrayList<Object>();
		int i = 1;
		if(c != null) {
			if(!ValidateUtil.isEmpty(c.getEntity().getDuty_prop())) {
				jpql.append(" and duty_prop = ?" + i++);
				paramList.add(c.getEntity().getDuty_prop());
			}

			if(!ValidateUtil.isEmpty(c.getEntity().getDuty_type())) {
				jpql.append(" and duty_type = ?" + i++);
				paramList.add(c.getEntity().getDuty_type());
			}

			if(!ValidateUtil.isEmpty(c.getPe_id())) {
				jpql.append(" and organPerson.pe_id = ?" + i++);
				paramList.add(c.getPe_id());
			} else {
				if(!ValidateUtil.isEmpty(c.getPe_name())) {
					jpql.append(" and organPerson.pe_name like ?" + i++);
					paramList.add("%" + c.getPe_name() + "%");
				}

				if(!ValidateUtil.isEmpty(c.getPe_mobilephone())) {
					jpql.append(" and organPerson.pe_mobilephone like ?" + i++);
					paramList.add("%" + c.getPe_mobilephone() + "%");
				}
			}

			if(c.getEntity().getDuty_date() != null) {
				jpql.append(" and duty_date = ?" + i++);
				paramList.add(c.getEntity().getDuty_date());
			} else {
				if(c.getDuty_date_start() != null) {
					jpql.append(" and duty_date >= ?" + i++);
					paramList.add(c.getDuty_date_start());
				}

				if(c.getDuty_date_end() != null) {
					jpql.append(" and duty_date <= ?" + i++);
					paramList.add(c.getDuty_date_end());
				}
			}
		}

		jpql.append(" order by duty_date desc");

		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult(c.getFirstResult()).setMaxResults(c.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(duty_sch_id) " + jpql.toString());
		setQueryParams(cQuery, params);

		return new PaginationQuery(rQuery, cQuery);
	}

	@Override
	public List<T_Duty_Schedule> getCalendarSchedules(DutyScheduleCriteria c) {
		List<Object> paramList = new ArrayList<Object>();
		StringBuffer jpql = new StringBuffer(" 1 = 1");
		int i = 1;
		if(c != null) {
			if(c.getDuty_date_start() != null) {
				jpql.append(" and duty_date >= ?" + i++);
				paramList.add(c.getDuty_date_start());
			}

			if(c.getDuty_date_end() != null) {
				jpql.append(" and duty_date <= ?" + i++);
				paramList.add(c.getDuty_date_end());
			}
		}

		Object[] params = paramList.toArray(new Object[paramList.size()]);

		return getListEntitys(jpql.toString(), params);
	}

	@Override
	public List<T_Duty_Schedule> getScheduleTemplates() {
		return getResultList("from T_Duty_Schedule");
	}
}
