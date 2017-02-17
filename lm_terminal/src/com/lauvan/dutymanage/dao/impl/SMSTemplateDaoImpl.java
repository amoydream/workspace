package com.lauvan.dutymanage.dao.impl;

import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.lauvan.base.dao.DAOTemplate;
import com.lauvan.base.dao.PaginationQuery;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.dao.SMSTemplateDao;
import com.lauvan.dutymanage.entity.SMS_Template;

/**
 * @describe 短信调度Dao层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Repository(value = "smsTemplateDao")
public class SMSTemplateDaoImpl extends DAOTemplate<SMS_Template> implements SMSTemplateDao {
	@Override
	public QueryResult<SMS_Template> getTemplates(Integer firstResult, Integer maxResults) {
		String jpql = "from SMS_Template";

		Query rQuery = em.createQuery(jpql);
		rQuery.setFirstResult(firstResult).setMaxResults(maxResults);
		Query cQuery = em.createQuery("select count(tmpl_id) " + jpql);

		return getPagingRecords(new PaginationQuery(rQuery, cQuery));
	}
}
