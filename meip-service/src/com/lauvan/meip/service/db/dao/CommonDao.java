package com.lauvan.meip.service.db.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;

import com.lauvan.meip.service.db.entity.BaseEntity;
import com.lauvan.meip.service.item.Item;

@SuppressWarnings("unchecked")
public abstract class CommonDao<E extends BaseEntity, I extends Item> extends HibernateDao<BaseEntity> {
	public abstract I entityToItem(E paramE);

	public abstract void buildSql(StringBuffer paramStringBuffer, I paramI);

	public List<E> find(String sql) {
		return (List<E>)super.find(sql, new Object[0]);
	}

	public List<E> getAll(Class<E> clazz) {
		return (List<E>)super.find("select a from " + clazz.getSimpleName() + " a", new Object[0]);
	}

	public List<E> getAll(Class<E> clazz, String where) {
		return (List<E>)super.find("select a from " + clazz.getSimpleName() + " a where " + where, new Object[0]);
	}

	@Override
	@Autowired
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public Long executeUpdate(String sql) {
		Session session = getSessionFactory().getCurrentSession();
		Query query = session.createQuery(sql);
		return (long)query.executeUpdate();
	}

	public Integer intValue(String sql) {
		Session session = getSessionFactory().getCurrentSession();
		if(!session.isOpen()) {
			session = getSessionFactory().openSession();
		}
		Query query = session.createQuery(sql);
		Integer i = (Integer)query.uniqueResult();
		return i;
	}

	public Long longValue(String sql) {
		Session session = getSessionFactory().getCurrentSession();
		if(!session.isOpen()) {
			session = getSessionFactory().openSession();
		}
		Query query = session.createQuery(sql);
		Long l = (Long)query.uniqueResult();
		return l;
	}

	public abstract List<E> list(String sql, Integer firstResult, Integer maxResults);
}