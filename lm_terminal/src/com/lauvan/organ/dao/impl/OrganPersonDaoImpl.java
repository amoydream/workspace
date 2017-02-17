package com.lauvan.organ.dao.impl;

import org.springframework.stereotype.Repository;

import com.lauvan.base.dao.DAOTemplate;
import com.lauvan.base.dao.PaginationQuery;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.organ.criteria.OrganPersonCriteria;
import com.lauvan.organ.dao.OrganPersonDao;
import com.lauvan.organ.entity.C_Organ_Person;

/**
 * @describe OrganPersonDao实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Repository(value = "organPersonDao")
public class OrganPersonDaoImpl extends DAOTemplate<C_Organ_Person> implements OrganPersonDao {
}
