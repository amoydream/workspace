package com.lauvan.event.service;

import org.springframework.stereotype.Service;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.event.entity.T_Event_Process;
import com.lauvan.event.vo.EventProcessVo;

/**
 * @describe 值守日志service层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service
public interface EventProcessService {
	QueryResult<EventProcessVo> getEventProcessList(EventProcessVo vo);

	void save(EventProcessVo eventProcessVo);

	T_Event_Process getEventProcessById(Integer pr_id);
}
