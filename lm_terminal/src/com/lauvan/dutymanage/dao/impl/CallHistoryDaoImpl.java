package com.lauvan.dutymanage.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.lauvan.base.dao.DAOTemplate;
import com.lauvan.base.dao.PaginationQuery;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.criteria.CallHistoryCriteria;
import com.lauvan.dutymanage.dao.CallHistoryDao;
import com.lauvan.dutymanage.entity.V_Call_History;
import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.util.ValidateUtil;

/**
 * @describe 电话调度Dao层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Repository(value = "callHistoryDao")
public class CallHistoryDaoImpl extends DAOTemplate<V_Call_History>
	implements CallHistoryDao {
	@Override
	public QueryResult<V_Call_History> getCallHistoryList(CallHistoryCriteria c) {
		return getPagingRecords(createPaginationQuery(c));
	}

	@Override
	public QueryResult<V_Call_History> getPersonalCallHistoryList(CallHistoryCriteria c) {
		List<Object> paramList = new ArrayList<Object>();
		StringBuffer jpql = new StringBuffer("from V_Call_History where 1 = 1");
		int i = 1;
		V_Call_History h = c.getEntity();
		C_Organ_Person p = c.getEntity().getOrganPerson();
		T_EventInfo e = c.getEntity().getEventInfo();
		if(!ValidateUtil.isEmpty(h.getVo_thatNo())) {
			jpql.append(" and vo_thatNo = ?" + i++);
			paramList.add(h.getVo_thatNo());
		} else if(!ValidateUtil.isEmpty(p.getPe_id())) {
			jpql.append(" and organPerson.pe_id = ?" + i++);
			paramList.add(p.getPe_id());
		}

		if(!ValidateUtil.isEmpty(h.getVo_state())) {
			jpql.append(" and vo_state = ?" + i++);
			paramList.add(h.getVo_state());
		}

		if(!ValidateUtil.isEmpty(h.getVo_callerFlag())) {
			jpql.append(" and vo_callerFlag = ?" + i++);
			paramList.add(h.getVo_callerFlag());
		}

		if(!ValidateUtil.isEmpty(e.getEv_id())) {
			jpql.append(" and eventInfo.ev_id = ?" + i++);
			paramList.add(e.getEv_id());
		} else if(!ValidateUtil.isEmpty(e.getEv_name())) {
			jpql.append(" and eventInfo.ev_name like ?" + i++);
			paramList.add("%" + e.getEv_name() + "%");
		}

		if(c.getVo_time_start() != null) {
			jpql.append(" and vo_time >= ?" + i++);
			paramList.add(c.getVo_time_start());
		}

		if(c.getVo_time_end() != null) {
			jpql.append(" and vo_time <= ?" + i++);
			paramList.add(c.getVo_time_end());
		}

		jpql.append(" order by vo_time desc");
		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult((c.getPage() - 1) * c.getRows()).setMaxResults(c.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(vo_id) " + jpql);
		setQueryParams(cQuery, params);

		return getPagingRecords(new PaginationQuery(rQuery, cQuery));
	}

	@Override
	public QueryResult<V_Call_History> getEventCallHistoryList(CallHistoryCriteria c) {
		List<Object> paramList = new ArrayList<Object>();
		StringBuffer jpql = new StringBuffer("from V_Call_History where 1 = 1");
		int i = 1;
		V_Call_History h = c.getEntity();
		C_Organ_Person p = c.getEntity().getOrganPerson();
		T_EventInfo e = c.getEntity().getEventInfo();
		if(!ValidateUtil.isEmpty(e.getEv_id())) {
			jpql.append(" and eventInfo.ev_id = ?" + i++);
			paramList.add(e.getEv_id());
		}

		if(!ValidateUtil.isEmpty(h.getVo_thatNo())) {
			jpql.append(" and vo_thatNo like ?" + i++);
			paramList.add("%" + h.getVo_thatNo() + "%");
		} else if(!ValidateUtil.isEmpty(p.getPe_id())) {
			jpql.append(" and organPerson.pe_id = ?" + i++);
			paramList.add(p.getPe_id());
		} else if(!ValidateUtil.isEmpty(p.getPe_name())) {
			jpql.append(" and organPerson.pe_name like ?" + i++);
			paramList.add("%" + p.getPe_name() + "%");
		}

		if(!ValidateUtil.isEmpty(h.getVo_state())) {
			jpql.append(" and vo_state = ?" + i++);
			paramList.add(h.getVo_state());
		}

		if(!ValidateUtil.isEmpty(h.getVo_callerFlag())) {
			jpql.append(" and vo_callerFlag = ?" + i++);
			paramList.add(h.getVo_callerFlag());
		}

		if(c.getVo_time_start() != null) {
			jpql.append(" and vo_time >= ?" + i++);
			paramList.add(c.getVo_time_start());
		}

		if(c.getVo_time_end() != null) {
			jpql.append(" and vo_time <= ?" + i++);
			paramList.add(c.getVo_time_end());
		}

		jpql.append(" order by vo_time desc");
		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult((c.getPage() - 1) * c.getRows()).setMaxResults(c.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(vo_id) " + jpql);
		setQueryParams(cQuery, params);

		return getPagingRecords(new PaginationQuery(rQuery, cQuery));
	}

	public Integer getCallHistoryCount(String vo_thatNo, String vo_state) {
		String jpql = "select count(vo_id) from V_Call_History where vo_thatNo='" + vo_thatNo + "'";
		if(!ValidateUtil.isEmpty(vo_state)) {
			jpql += " and vo_state='" + vo_state + "'";
		}

		return ((Long)em.createQuery(jpql).getSingleResult()).intValue();
	}

	private PaginationQuery createPaginationQuery(CallHistoryCriteria c) {
		List<Object> paramList = new ArrayList<Object>();
		StringBuffer jpql = new StringBuffer("from V_Call_History where 1 = 1");
		int i = 1;
		if(c != null) {
			V_Call_History h = c.getEntity();
			C_Organ_Person p = c.getEntity().getOrganPerson();
			T_EventInfo e = c.getEntity().getEventInfo();
			if(!ValidateUtil.isEmpty(p.getPe_id())) {
				jpql.append(" and organPerson.pe_id = ?" + i++);
				paramList.add(p.getPe_id());
			} else if(!ValidateUtil.isEmpty(p.getPe_name())) {
				jpql.append(" and organPerson.pe_name like ?" + i++);
				paramList.add("%" + p.getPe_name() + "%");
			}

			if(!ValidateUtil.isEmpty(h.getVo_thatNo())) {
				jpql.append(" and vo_thatNo like ?" + i++);
				paramList.add("%" + h.getVo_thatNo() + "%");
			}

			if(!ValidateUtil.isEmpty(e.getEv_id())) {
				jpql.append(" and eventInfo.ev_id = ?" + i++);
				paramList.add(e.getEv_id());
			} else if(!ValidateUtil.isEmpty(e.getEv_name())) {
				jpql.append(" and eventInfo.ev_name like ?" + i++);
				paramList.add("%" + e.getEv_name() + "%");
			}

			if(!ValidateUtil.isEmpty(h.getVo_callerFlag())) {
				jpql.append(" and vo_callerFlag = ?" + i++);
				paramList.add(h.getVo_callerFlag());
			}

			if(!ValidateUtil.isEmpty(h.getVo_state())) {
				jpql.append(" and vo_state = ?" + i++);
				paramList.add(h.getVo_state());
			}

			if(c.getVo_time_start() != null) {
				jpql.append(" and vo_time >= ?" + i++);
				paramList.add(c.getVo_time_start());
			}

			if(c.getVo_time_end() != null) {
				jpql.append(" and vo_time <= ?" + i++);
				paramList.add(c.getVo_time_end());
			}
		}

		jpql.append(" order by vo_time desc");
		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult(c.getFirstResult()).setMaxResults(c.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(vo_id) " + jpql.toString());
		setQueryParams(cQuery, params);

		return new PaginationQuery(rQuery, cQuery);
	}
}
