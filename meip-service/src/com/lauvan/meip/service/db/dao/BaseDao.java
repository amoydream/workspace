package com.lauvan.meip.service.db.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.Filter;
import org.hibernate.LockMode;
import org.hibernate.ReplicationMode;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate5.HibernateCallback;

import com.lauvan.meip.service.db.entity.BaseEntity;

public interface BaseDao {
	SessionFactory getSessionFactory();

	void setMaxResults(int maxResults);

	int getMaxResults();

	<T> T execute(HibernateCallback<T> hibernateCallback)
		throws DataAccessException;

	<T> T executeWithNativeSession(HibernateCallback<T> hibernateCallback);

	<T> T get(Class<T> paramClass, Serializable id)
		throws DataAccessException;

	<T> T get(Class<T> paramClass, Serializable id, LockMode lockMode)
		throws DataAccessException;

	Object get(String param, Serializable id)
		throws DataAccessException;

	Object get(String param, Serializable id, LockMode lockMode)
		throws DataAccessException;

	<T> T load(Class<T> paramClass, Serializable id)
		throws DataAccessException;

	<T> T load(Class<T> paramClass, Serializable id, LockMode lockMode)
		throws DataAccessException;

	Object load(String param, Serializable id)
		throws DataAccessException;

	Object load(String param, Serializable id, LockMode lockMode)
		throws DataAccessException;

	<T> List<T> loadAll(Class<T> paramClass)
		throws DataAccessException;

	void load(BaseEntity entity, Serializable id)
		throws DataAccessException;

	void refresh(BaseEntity entity)
		throws DataAccessException;

	void refresh(BaseEntity entity, LockMode lockMode)
		throws DataAccessException;

	boolean contains(BaseEntity entity)
		throws DataAccessException;

	void evict(BaseEntity entity)
		throws DataAccessException;

	void initialize(Object paramObject)
		throws DataAccessException;

	Filter enableFilter(String param)
		throws IllegalStateException;

	void lock(BaseEntity entity, LockMode lockMode)
		throws DataAccessException;

	void lock(String param, BaseEntity entity, LockMode lockMode)
		throws DataAccessException;

	Serializable save(BaseEntity entity)
		throws DataAccessException;

	Serializable save(String param, BaseEntity entity)
		throws DataAccessException;

	void update(BaseEntity entity)
		throws DataAccessException;

	void update(BaseEntity entity, LockMode lockMode)
		throws DataAccessException;

	void update(String param, BaseEntity entity)
		throws DataAccessException;

	void update(String param, BaseEntity entity, LockMode lockMode)
		throws DataAccessException;

	void saveOrUpdate(BaseEntity entity)
		throws DataAccessException;

	void saveOrUpdate(String param, BaseEntity entity)
		throws DataAccessException;

	void replicate(BaseEntity entity, ReplicationMode replicationMode)
		throws DataAccessException;

	void replicate(String param, BaseEntity entity, ReplicationMode replicationMode)
		throws DataAccessException;

	void persist(BaseEntity entity)
		throws DataAccessException;

	void persist(String param, BaseEntity entity)
		throws DataAccessException;

	<T> T merge(T entity)
		throws DataAccessException;

	<T> T merge(String param, T entity)
		throws DataAccessException;

	void delete(BaseEntity entity)
		throws DataAccessException;

	void delete(BaseEntity entity, LockMode lockMode)
		throws DataAccessException;

	void delete(String param, BaseEntity entity)
		throws DataAccessException;

	void delete(String param, BaseEntity entity, LockMode lockMode)
		throws DataAccessException;

	void deleteAll(Collection<?> paramCollection)
		throws DataAccessException;

	void flush()
		throws DataAccessException;

	void clear()
		throws DataAccessException;

	List<?> find(String param, Object[] params)
		throws DataAccessException;
}