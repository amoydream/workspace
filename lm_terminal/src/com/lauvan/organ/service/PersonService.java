package com.lauvan.organ.service;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.entity.V_Person;
import com.lauvan.organ.vo.OrganPersonVo;

public interface PersonService extends BaseDAO<V_Person> {
	QueryResult<V_Person> getPersonPage(OrganPersonVo vo);
}
