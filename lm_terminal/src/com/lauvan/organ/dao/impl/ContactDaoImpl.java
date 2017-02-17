package com.lauvan.organ.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.lauvan.base.dao.DAOTemplate;
import com.lauvan.base.dao.PaginationQuery;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.dao.ContactDao;
import com.lauvan.organ.entity.V_Contact;
import com.lauvan.organ.vo.ContactVo;
import com.lauvan.util.BaseUtil;
import com.lauvan.util.ValidateUtil;

@Repository("contactDao")
@SuppressWarnings("unchecked")
public class ContactDaoImpl extends DAOTemplate<V_Contact> implements ContactDao {
	@Override
	public List<V_Contact> getContactPage(ContactVo vo) {
		List<Object> paramList = new ArrayList<>();
		StringBuffer jpql = new StringBuffer("from V_Contact where null_number <> 'null'");
		int i = 1;
		if(!ValidateUtil.isEmpty(vo.getContact_id())) {
			jpql.append(" and contact_id = ?" + i++);
			paramList.add(vo.getPe_id());
		} else {
			if(!ValidateUtil.isEmpty(vo.getOr_id())) {
				jpql.append(" and or_id = ?" + i++);
				paramList.add(vo.getOr_id());
			}

			if(!ValidateUtil.isEmpty(vo.getPe_name())) {
				jpql.append(" and pe_name like ?" + i++);
				paramList.add("%" + vo.getPe_name() + "%");
			}
			String numberType = vo.getNumberType();
			if(numberType != null) {
				if("SMS".equals(numberType)) {
					jpql.append(" and contact_type='P' and tel_mobile like ?" + i++);
					paramList.add("%" + vo.getTel_number() + "%");
				} else if("FAX".equals(numberType)) {
					jpql.append(" and fax_number like ?" + i++);
					paramList.add("%" + vo.getTel_number() + "%");
				}
			} else if(!ValidateUtil.isEmpty(vo.getTel_number())) {
				jpql.append(" and tel_number like ?" + i++);
				paramList.add("%" + vo.getTel_number() + "%");
			}

			if(!ValidateUtil.isEmpty(vo.getOr_name())) {
				jpql.append(" and or_name like ?" + i++);
				paramList.add("%" + vo.getOr_name() + "%");
			}

			if(!ValidateUtil.isEmpty(vo.getPe_del())) {
				jpql.append(" and pe_del = ?" + i++);
				paramList.add(vo.getPe_del());
			} else {
				jpql.append(" and pe_del <> 1");
			}
		}
		jpql.append(" order by c_sort ");

		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult((vo.getPage() - 1) * vo.getRows()).setMaxResults(vo.getRows());
		setQueryParams(rQuery, params);
		return rQuery.getResultList();
	}

	@Override
	public List<V_Contact> getMobileContactPage(ContactVo vo) {
		StringBuffer jpql = new StringBuffer("from V_Contact where pe_del = 0 and tel_mobile is not null");
		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult((vo.getPage() - 1) * vo.getRows()).setMaxResults(vo.getRows());
		setQueryParams(rQuery, new Object[]{});
		return rQuery.getResultList();
	}

	@Override
	public QueryResult<V_Contact> getContacts(ContactVo vo) {
		List<Object> paramList = new ArrayList<>();
		StringBuffer jpql = new StringBuffer("from V_Contact where null_number <> 'null'");
		int i = 1;
		String numberType = vo.getNumberType();
		if(!ValidateUtil.isEmpty(numberType)) {
			if("SMS".equals(numberType)) {
				jpql.append(" and contact_type='P' and tel_mobile like ?" + i++);
				paramList.add("%" + vo.getTel_number() + "%");
			} else if("FAX".equals(numberType)) {
				jpql.append(" and fax_number like ?" + i++);
				paramList.add("%" + vo.getTel_number() + "%");
			}
		} else if(!ValidateUtil.isEmpty(vo.getTel_number())) {
			jpql.append(" and tel_number like ?" + i++);
			paramList.add("%" + vo.getTel_number() + "%");
		}
		if(!ValidateUtil.isEmpty(vo.getContact_id())) {
			jpql.append(" and contact_id = " + vo.getContact_id());
		} else if(!ValidateUtil.isEmpty(vo.getGroup_id())) {
			if(vo.getGroup_id() == 0 || ValidateUtil.isEmpty(vo.getContactIds())) {
				QueryResult<V_Contact> queryResult = new QueryResult<>();
				queryResult.setResultlist(new ArrayList<V_Contact>());
				queryResult.setTotalrecord(0);
				return queryResult;
			}
			jpql.append(" and contact_id in (" + BaseUtil.toVarcharArr(vo.getContactIds()) + ")");
		} else {
			if(!ValidateUtil.isEmpty(vo.getOr_id())) {
				jpql.append(" and or_id = ?" + i++);
				paramList.add(vo.getOr_id());
			}

			if(!ValidateUtil.isEmpty(vo.getPe_name())) {
				jpql.append(" and pe_name like ?" + i++);
				paramList.add("%" + vo.getPe_name() + "%");
			}

			if(!ValidateUtil.isEmpty(vo.getOr_name())) {
				jpql.append(" and or_name like ?" + i++);
				paramList.add("%" + vo.getOr_name() + "%");
			}

			if(!ValidateUtil.isEmpty(vo.getPe_del())) {
				jpql.append(" and pe_del = ?" + i++);
				paramList.add(vo.getPe_del());
			} else {
				jpql.append(" and pe_del <> 1");
			}
		}

		jpql.append(" order by c_sort ");
		Object[] params = paramList.toArray(new Object[paramList.size()]);

		Query rQuery = em.createQuery(jpql.toString());
		rQuery.setFirstResult((vo.getPage() - 1) * vo.getRows()).setMaxResults(vo.getRows());
		setQueryParams(rQuery, params);
		Query cQuery = em.createQuery("select count(pe_id) " + jpql);
		setQueryParams(cQuery, params);

		return getPagingRecords(new PaginationQuery(rQuery, cQuery));
	}

	@Override
	public List<V_Contact> getContactByMobiles(String[] mobiles) {
		Query q = em.createQuery("from V_Contact where contact_type='P' and tel_mobile in (" + StringUtils.arrayToDelimitedString(mobiles, ",") + ")");
		return q.getResultList();
	}

	@Override
	public List<V_Contact> getAllMobileContacts() {
		Query q = em.createQuery("from V_Contact where contact_type='P' and tel_mobile is not null");
		return q.getResultList();
	}
}
