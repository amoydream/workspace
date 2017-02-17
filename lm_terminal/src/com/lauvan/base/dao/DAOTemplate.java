package com.lauvan.base.dao;

import javax.persistence.Query;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lauvan.base.vo.QueryResult;

public class DAOTemplate<T> extends EntityManageTemplate<T> {
   @SuppressWarnings("unchecked")
   @Transactional(readOnly = true, propagation = Propagation.REQUIRED)
   public QueryResult<T> getPagingRecords(PaginationQuery paginationQuery) {
      QueryResult<T> queryResult = new QueryResult<T>();

      Query resultQuery = paginationQuery.getResultQuery();
      Query countQuery = paginationQuery.getCountQuery();
      queryResult.setResultlist(resultQuery.getResultList());
      queryResult.setTotalrecord((Long)countQuery.getSingleResult());

      return queryResult;
   }
}