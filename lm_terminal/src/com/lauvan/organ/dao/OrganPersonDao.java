package com.lauvan.organ.dao;

import org.springframework.stereotype.Service;

import com.lauvan.base.dao.BaseDAO1;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.criteria.OrganPersonCriteria;
import com.lauvan.organ.entity.C_Organ_Person;

/**
 * @describe 电话调度Dao层接口
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service
public interface OrganPersonDao extends BaseDAO1<C_Organ_Person> {
}