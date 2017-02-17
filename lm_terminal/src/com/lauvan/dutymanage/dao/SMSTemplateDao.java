package com.lauvan.dutymanage.dao;

import com.lauvan.base.dao.BaseDAO1;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.entity.SMS_Template;

/**
 * @describe 短信调度Dao层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
public interface SMSTemplateDao extends BaseDAO1<SMS_Template> {
	QueryResult<SMS_Template> getTemplates(Integer firstResult, Integer maxResults);
}