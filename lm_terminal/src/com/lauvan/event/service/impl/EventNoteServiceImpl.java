package com.lauvan.event.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.event.entity.E_EventNote;
import com.lauvan.event.service.EventNoteService;
@Service("eventNoteService")
public class EventNoteServiceImpl extends BaseDAOSupport<E_EventNote> implements
		EventNoteService {

}
