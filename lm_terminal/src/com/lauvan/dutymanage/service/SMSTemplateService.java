package com.lauvan.dutymanage.service;

import org.springframework.stereotype.Service;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.entity.SMS_Template;

/**
 * @describe 短信调度service层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service
public interface SMSTemplateService {
	QueryResult<SMS_Template> getTemplates(Integer firstResult, Integer maxResults);

	SMS_Template saveTemplate(Integer tmpl_id, String content);

	SMS_Template findById(Integer tmpl_id);

	void delete(SMS_Template template);
}
