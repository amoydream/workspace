package com.lauvan.event.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.event.entity.T_Event_Voice;
import com.lauvan.event.service.EventVoiceService;
@Service("eventVoiceService")
public class EventVoiceServiceImpl extends BaseDAOSupport<T_Event_Voice>
		implements EventVoiceService {

}
