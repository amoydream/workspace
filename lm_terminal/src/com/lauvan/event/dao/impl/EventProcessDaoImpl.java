package com.lauvan.event.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.lauvan.base.dao.DAOTemplate;
import com.lauvan.base.dao.PaginationQuery;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.event.criteria.EventProcessCriteria;
import com.lauvan.event.dao.EventProcessDao;
import com.lauvan.event.entity.T_Event_Process;
import com.lauvan.util.ValidateUtil;

/**
 * @describe 事务处置过程Dao层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Repository(value = "eventProcessDao")
public class EventProcessDaoImpl extends DAOTemplate<T_Event_Process>
	implements EventProcessDao {
	@Override
	public QueryResult<T_Event_Process> getEventProcessList(EventProcessCriteria c) {
		return getPagingRecords(createPaginationQuery(c));
	}

	private PaginationQuery createPaginationQuery(EventProcessCriteria c) {
		List<Object> paramList = new ArrayList<Object>();
		StringBuffer jpql = new StringBuffer("from T_Event_Process where 1 = 1");
		int i = 1;
		if(c != null) {
			if(!ValidateUtil.isEmpty(c.getEntity().getT_eventinfo().getEv_id())) {
				jpql.append(" and ev_id = ?" + i++);
				paramList.add(c.getEntity().getT_eventinfo().getEv_id());
			} else if(!ValidateUtil.isEmpty(c.getEntity().getT_eventinfo().getEv_name())) {
				jpql.append(" and ev_name like ?" + i++);
				paramList.add("%" + c.getEntity().getT_eventinfo().getEv_name() + "%");
			}

			if(!ValidateUtil.isEmpty(c.getEntity().getPr_phase())) {
				jpql.append(" and pr_phase = ?" + i++);
				paramList.add(c.getEntity().getPr_phase());
			}

			if(!ValidateUtil.isEmpty(c.getEntity().getPr_content())) {
				jpql.append(" and pr_content like ?" + i++);
				paramList.add("%" + c.getEntity().getPr_content() + "%");
			}

			if(c.getPr_date_start() != null) {
				jpql.append(" and pr_date >= ?" + i++);
				paramList.add(c.getPr_date_start());
			}

			if(c.getPr_date_end() != null) {
				jpql.append(" and pr_date <= ?" + i++);
				paramList.add(c.getPr_date_end());
			}
		}

		jpql.append(" order by pr_date desc");

		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult(c.getFirstResult()).setMaxResults(c.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(pr_id) " + jpql.toString());
		setQueryParams(cQuery, params);

		return new PaginationQuery(rQuery, cQuery);
	}
}
