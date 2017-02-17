package com.lauvan.event.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.event.criteria.EventProcessCriteria;
import com.lauvan.event.dao.EventProcessDao;
import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.event.entity.T_Event_Process;
import com.lauvan.event.service.EventProcessService;
import com.lauvan.event.vo.EventProcessVo;
import com.lauvan.system.entity.T_User_Info;

/**
 * @describe 事务处置过程service层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service(value = "eventProcessService")
public class EventProcessServiceImpl implements EventProcessService {
	@Autowired
	private EventProcessDao eventProcessDao;

	@Override
	public QueryResult<EventProcessVo> getEventProcessList(EventProcessVo eventProcessVo) {
		QueryResult<EventProcessVo> queryResult = new QueryResult<EventProcessVo>();

		QueryResult<T_Event_Process> result = eventProcessDao.getEventProcessList(new EventProcessCriteria().copyProperties(eventProcessVo));

		if(result != null) {
			List<EventProcessVo> voList = new ArrayList<EventProcessVo>();
			List<T_Event_Process> resultList = result.getResultlist();
			for(T_Event_Process eventProcess : resultList) {
				EventProcessVo vo = new EventProcessVo();

				BeanUtils.copyProperties(eventProcess, vo);
				BeanUtils.copyProperties(eventProcess.getT_eventinfo(), vo);
				BeanUtils.copyProperties(eventProcess.getT_user_info(), vo);

				voList.add(vo);
			}

			queryResult.setResultlist(voList);
			queryResult.setTotalrecord(result.getTotalrecord());
		}

		return queryResult;
	}

	@Override
	public T_Event_Process getEventProcessById(Integer pr_id) {
		return eventProcessDao.find(pr_id);
	}

	@Override
	public void save(EventProcessVo eventProcessVo) {
		T_Event_Process t_event_process = new T_Event_Process();
		BeanUtils.copyProperties(eventProcessVo, t_event_process);

		T_EventInfo t_eventInfo = new T_EventInfo();
		t_eventInfo.setEv_id(eventProcessVo.getEv_id());
		t_event_process.setT_eventinfo(t_eventInfo);

		T_User_Info t_user_info = new T_User_Info();
		t_user_info.setUs_Id(eventProcessVo.getUs_Id());
		t_event_process.setT_user_info(t_user_info);

		eventProcessDao.save(t_event_process);
	}
}
