package com.lauvan.system.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.system.entity.T_Voice_Record;

public interface VoiceRecordService extends BaseDAO<T_Voice_Record> {
	public Long count(Integer id);
}
