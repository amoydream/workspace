package com.lauvan.organ.service;

import java.util.List;

import com.lauvan.base.dao.BaseDAO;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.organ.vo.OrganPersonVo;

public interface OrganPersonService extends BaseDAO<C_Organ_Person> {
	QueryResult<C_Organ_Person> pagingQuery(OrganPersonVo vo);

	List<C_Organ_Person> getPersonsByIds(Integer[] pe_id_arr);
	
	public void addEmePerson(List<C_Organ_Person> ops);
}
