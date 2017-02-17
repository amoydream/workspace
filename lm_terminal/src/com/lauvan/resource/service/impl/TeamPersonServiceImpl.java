package com.lauvan.resource.service.impl;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAOSupport;
import com.lauvan.resource.entity.R_Team_Person;
import com.lauvan.resource.service.TeamPersonService;

@Service("teamPersonService")
public class TeamPersonServiceImpl extends BaseDAOSupport<R_Team_Person> implements TeamPersonService{

}
