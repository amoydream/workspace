package com.lauvan.dutymanage.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lauvan.base.service.BaseService;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.dao.SMSTemplateDao;
import com.lauvan.dutymanage.entity.SMS_Template;
import com.lauvan.dutymanage.service.SMSTemplateService;

/**
 * @describe 短信调度service层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service(value = "smsDispatchService")
public class SMSTemplateServiceImpl extends BaseService
	implements SMSTemplateService {
	@Autowired
	private SMSTemplateDao smsTemplateDao;

	@Override
	public QueryResult<SMS_Template> getTemplates(Integer firstResult, Integer maxResults) {
		return smsTemplateDao.getTemplates(firstResult, maxResults);
	}

	@Override
	public SMS_Template saveTemplate(Integer tmpl_id, String content) {
		SMS_Template template = null;
		if(tmpl_id != null) {
			template = smsTemplateDao.find(tmpl_id);
		}
		if(template == null) {
			List<SMS_Template> tmplList = smsTemplateDao.findByProperty("content", content);
			if(tmplList != null && tmplList.size() > 0) {
				throw new RuntimeException("模板已存在");
			}
		}
		if(template != null) {
			template.setContent(content);
			smsTemplateDao.update(template);
		} else {
			template = new SMS_Template();
			template.setContent(content);
			smsTemplateDao.save(template);
		}
		return template;
	}

	@Override
	public SMS_Template findById(Integer tmpl_id) {
		return smsTemplateDao.find(tmpl_id);
	}

	@Override
	public void delete(SMS_Template template) {
		smsTemplateDao.delete(template.getTmpl_id());
	}
}
