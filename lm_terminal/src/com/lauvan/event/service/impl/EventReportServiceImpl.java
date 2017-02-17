package com.lauvan.event.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.event.entity.E_EventReport;
import com.lauvan.event.service.EventReportService;
@Service("eventReportService")
public class EventReportServiceImpl extends BaseDAOSupport<E_EventReport>
		implements EventReportService {

}
