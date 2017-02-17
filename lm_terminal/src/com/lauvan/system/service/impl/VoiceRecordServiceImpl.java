package com.lauvan.system.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.system.entity.T_Voice_Record;
import com.lauvan.system.service.VoiceRecordService;

@Service("voiceRecordService")
public class VoiceRecordServiceImpl extends BaseDAOSupport<T_Voice_Record>
		implements VoiceRecordService {
	private static final String sql = "select count(o) from T_Voice_Record o where o.vo_callid=?1";

	public Long count(Integer id) {
		return (Long) em.createQuery(sql).setParameter(1, id).getSingleResult();
	}
}
