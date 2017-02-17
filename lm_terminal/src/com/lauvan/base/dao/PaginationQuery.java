package com.lauvan.base.dao;

import javax.persistence.EntityManager;
import javax.persistence.Query;

public class PaginationQuery {
   private Query resultQuery;
   private Query countQuery;

   public PaginationQuery() {
   }

   public PaginationQuery(EntityManager entityManager, String resultSql, int firstResult,
         int maxResults, String countSql) {
      resultQuery = entityManager.createQuery(resultSql);
      resultQuery.setFirstResult(firstResult).setMaxResults(maxResults);
      countQuery = entityManager.createQuery(countSql);
   }

   public PaginationQuery(Query resultQuery, Query countQuery) {
      super();
      this.resultQuery = resultQuery;
      this.countQuery = countQuery;
   }

   public Query getResultQuery() {
      return resultQuery;
   }

   public void setResultQuery(Query resultQuery) {
      this.resultQuery = resultQuery;
   }

   public Query getCountQuery() {
      return countQuery;
   }

   public void setCountQuery(Query countQuery) {
      this.countQuery = countQuery;
   }

}
