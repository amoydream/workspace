package com.lauvan.organ.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.entity.V_Person;
import com.lauvan.organ.service.PersonService;
import com.lauvan.organ.vo.OrganPersonVo;
import com.lauvan.util.ValidateUtil;

@Service("personService")
public class PersonServiceImpl extends BaseDAOSupport<V_Person>
	implements PersonService {

	@SuppressWarnings("unchecked")
	@Override
	public QueryResult<V_Person> getPersonPage(OrganPersonVo c) {
		StringBuffer jpql = new StringBuffer("from V_Person where pe_del = 0");
		List<Object> paramList = new ArrayList<Object>();
		int i = 1;
		if(c != null) {
			if(!ValidateUtil.isEmpty(c.getOr_id())) {
				jpql.append(" and or_id = ?" + i++);
				paramList.add(c.getOr_id());
			} else {
				if(!ValidateUtil.isEmpty(c.getPe_id())) {
					jpql.append(" and pe_id = ?" + i++);
					paramList.add(c.getPe_id());
				} else {
					if(!ValidateUtil.isEmpty(c.getPe_name())) {
						jpql.append(" and pe_name like ?" + i++);
						paramList.add("%" + c.getPe_name() + "%");
					}

					if(!ValidateUtil.isEmpty(c.getOr_name())) {
						jpql.append(" and or_name like ?" + i++);
						paramList.add("%" + c.getOr_name() + "%");
					}
				}
			}
		}
		
		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult((c.getPage() - 1) * c.getRows()).setMaxResults(c.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(pe_id) " + jpql.toString());
		setQueryParams(cQuery, params);

		QueryResult<V_Person> queryResult = new QueryResult<V_Person>();

		queryResult.setResultlist(rQuery.getResultList());
		queryResult.setTotalrecord((long)cQuery.getSingleResult());

		return queryResult;
	}
}
