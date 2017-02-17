package com.lauvan.organ.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.organ.service.OrganPersonService;
import com.lauvan.organ.vo.OrganPersonVo;
import com.lauvan.util.ValidateUtil;

@Service("organPersonService")
public class OrganPersonServiceImpl extends BaseDAOSupport<C_Organ_Person>
	implements OrganPersonService {

	@SuppressWarnings("unchecked")
	@Override
	public QueryResult<C_Organ_Person> pagingQuery(OrganPersonVo c) {
		StringBuffer jpql = new StringBuffer("from C_Organ_Person where 1 = 1");
		List<Object> paramList = new ArrayList<Object>();
		int i = 1;
		if(c != null) {
			if(!ValidateUtil.isEmpty(c.getPe_id())) {
				jpql.append(" and pe_id = ?" + i++);
				paramList.add(c.getPe_id());
			} else if(!ValidateUtil.isEmpty(c.getPe_name())) {
				jpql.append(" and pe_name like ?" + i++);
				paramList.add("%" + c.getPe_name() + "%");
			}

			if(!ValidateUtil.isEmpty(c.getOr_id())) {
				jpql.append(" and (organ.organ.or_id = ?" + i++ + " or organ.or_id = ?" + i++ + ")");
				paramList.add(c.getOr_id());
				paramList.add(c.getOr_id());
			}

			if(!ValidateUtil.isEmpty(c.getPe_jobs())) {
				jpql.append(" and pe_jobs like ?" + i++);
				paramList.add("%" + c.getPe_jobs() + "%");
			}

			// if(!ValidateUtil.isEmpty(c.getPe_mobilephone())) {
			// jpql.append(" and pe_mobilephone like ?" + i++);
			// paramList.add("%" + c.getPe_mobilephone() + "%");
			// }
		}

		jpql.append(" order by organ.organ.or_sort, organ.or_sort, pe_sort");

		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		// rQuery.setFirstResult((c.getPage() - 1) *
		// c.getRows()).setMaxResults(c.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(pe_id) " + jpql.toString());
		setQueryParams(cQuery, params);

		QueryResult<C_Organ_Person> queryResult = new QueryResult<C_Organ_Person>();

		queryResult.setResultlist(rQuery.getResultList());
		queryResult.setTotalrecord((long)cQuery.getSingleResult());

		return queryResult;
	}

	@Override
	public List<C_Organ_Person> getPersonsByIds(Integer[] pe_id_arr) {
		List<C_Organ_Person> personList = new ArrayList<C_Organ_Person>();
		String inStr = "";
		if(pe_id_arr != null && pe_id_arr.length > 0) {
			for(Integer pe_id : pe_id_arr) {
				if(pe_id != null) {
					inStr += "," + pe_id;
				}
			}

			if(inStr.length() > 0) {
				inStr = inStr.substring(1);
				String jpql = "pe_id in (" + inStr + ")";
				personList = getListEntitys(jpql, null);
			}
		}

		return personList;
	}

	public void addEmePerson(List<C_Organ_Person> ops) {
		for(C_Organ_Person c_Organ_Person : ops) {
			update(c_Organ_Person);
		}
	}
	
	
}
