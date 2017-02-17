package com.lauvan.event.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.event.entity.E_Eventdoc;
import com.lauvan.event.service.EventdocService;
@Service("eventdocService")
public class EventdocServiceImpl extends BaseDAOSupport<E_Eventdoc> implements
		EventdocService {

}
