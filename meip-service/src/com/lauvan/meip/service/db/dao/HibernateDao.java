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
import org.springframework.orm.hibernate5.HibernateTemplate;

import com.lauvan.meip.service.db.entity.BaseEntity;

@SuppressWarnings("hiding")
public abstract class HibernateDao<E extends BaseEntity> implements BaseDao {
	HibernateTemplate hibernateTemplate = null;

	public abstract void setHibernateTemplate(HibernateTemplate hibernateTemplate);

	@Override
	public SessionFactory getSessionFactory() {
		return this.hibernateTemplate.getSessionFactory();
	}

	@Override
	public void setMaxResults(int maxResults) {
		this.hibernateTemplate.setMaxResults(maxResults);
	}

	@Override
	public int getMaxResults() {
		return this.hibernateTemplate.getMaxResults();
	}

	@Override
	public <E> E execute(HibernateCallback<E> action) throws DataAccessException {
		return this.hibernateTemplate.execute(action);
	}

	@Override
	public <E> E executeWithNativeSession(HibernateCallback<E> action) {
		return this.hibernateTemplate.executeWithNativeSession(action);
	}

	@Override
	public <E> E get(Class<E> entityClass, Serializable id) throws DataAccessException {
		return this.hibernateTemplate.get(entityClass, id);
	}

	@Override
	public <E> E get(Class<E> entityClass, Serializable id, LockMode lockMode) throws DataAccessException {
		return this.hibernateTemplate.get(entityClass, id, lockMode);
	}

	@Override
	public Object get(String entityName, Serializable id) throws DataAccessException {
		return this.hibernateTemplate.get(entityName, id);
	}

	@Override
	public Object get(String entityName, Serializable id, LockMode lockMode) throws DataAccessException {
		return this.hibernateTemplate.get(entityName, id, lockMode);
	}

	@Override
	public <E> E load(Class<E> entityClass, Serializable id) throws DataAccessException {
		return this.hibernateTemplate.load(entityClass, id);
	}

	@Override
	public <E> E load(Class<E> entityClass, Serializable id, LockMode lockMode) throws DataAccessException {
		return this.hibernateTemplate.load(entityClass, id, lockMode);
	}

	@Override
	public Object load(String entityName, Serializable id) throws DataAccessException {
		return this.hibernateTemplate.load(entityName, id);
	}

	@Override
	public Object load(String entityName, Serializable id, LockMode lockMode) throws DataAccessException {
		return this.hibernateTemplate.load(entityName, id, lockMode);
	}

	@Override
	public <E> List<E> loadAll(Class<E> entityClass) throws DataAccessException {
		return this.hibernateTemplate.loadAll(entityClass);
	}

	@Override
	public void load(BaseEntity entity, Serializable id) throws DataAccessException {
		this.hibernateTemplate.load(entity, id);
	}

	@Override
	public void refresh(BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.refresh(entity);
	}

	@Override
	public void refresh(BaseEntity entity, LockMode lockMode) throws DataAccessException {
		this.hibernateTemplate.refresh(entity, lockMode);
	}

	@Override
	public boolean contains(BaseEntity entity) throws DataAccessException {
		return this.hibernateTemplate.contains(entity);
	}

	@Override
	public void evict(BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.evict(entity);
	}

	@Override
	public void initialize(Object proxy) throws DataAccessException {
		this.hibernateTemplate.initialize(proxy);
	}

	@Override
	public Filter enableFilter(String filterName) throws IllegalStateException {
		return this.hibernateTemplate.enableFilter(filterName);
	}

	@Override
	public void lock(BaseEntity entity, LockMode lockMode) throws DataAccessException {
		this.hibernateTemplate.lock(entity, lockMode);
	}

	@Override
	public void lock(String entityName, BaseEntity entity, LockMode lockMode) throws DataAccessException {
		this.hibernateTemplate.lock(entityName, entity, lockMode);
	}

	@Override
	public Serializable save(BaseEntity entity) throws DataAccessException {
		return this.hibernateTemplate.save(entity);
	}

	@Override
	public Serializable save(String entityName, BaseEntity entity) throws DataAccessException {
		return this.hibernateTemplate.save(entityName, entity);
	}

	@Override
	public void update(BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.update(entity);
	}

	@Override
	public void update(BaseEntity entity, LockMode lockMode) throws DataAccessException {
		this.hibernateTemplate.update(entity, lockMode);
	}

	@Override
	public void update(String entityName, BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.update(entityName, entity);
	}

	@Override
	public void update(String entityName, BaseEntity entity, LockMode lockMode) throws DataAccessException {
		this.hibernateTemplate.update(entityName, entity, lockMode);
	}

	@Override
	public void saveOrUpdate(BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.saveOrUpdate(entity);
	}

	@Override
	public void saveOrUpdate(String entityName, BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.saveOrUpdate(entityName, entity);
	}

	@Override
	public void replicate(BaseEntity entity, ReplicationMode replicationMode) throws DataAccessException {
		this.hibernateTemplate.replicate(entity, replicationMode);
	}

	@Override
	public void replicate(String entityName, BaseEntity entity, ReplicationMode replicationMode)
		throws DataAccessException {
		this.hibernateTemplate.replicate(entityName, entity, replicationMode);
	}

	@Override
	public void persist(BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.persist(entity);
	}

	@Override
	public void persist(String entityName, BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.persist(entityName, entity);
	}

	public E merge(E entity) throws DataAccessException {
		return this.hibernateTemplate.merge(entity);
	}

	public E merge(String entityName, E entity) throws DataAccessException {
		return this.hibernateTemplate.merge(entityName, entity);
	}

	@Override
	public void delete(BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.delete(entity);
	}

	@Override
	public void delete(BaseEntity entity, LockMode lockMode) throws DataAccessException {
		this.hibernateTemplate.delete(entity, lockMode);
	}

	@Override
	public void delete(String entityName, BaseEntity entity) throws DataAccessException {
		this.hibernateTemplate.delete(entityName, entity);
	}

	@Override
	public void delete(String entityName, BaseEntity entity, LockMode lockMode) throws DataAccessException {
		this.hibernateTemplate.delete(entityName, entity, lockMode);
	}

	@Override
	public void deleteAll(Collection<?> entities) throws DataAccessException {
		this.hibernateTemplate.deleteAll(entities);
	}

	@Override
	public void flush() throws DataAccessException {
		this.hibernateTemplate.flush();
	}

	@Override
	public void clear() throws DataAccessException {
		this.hibernateTemplate.clear();
	}

	@Override
	public <T> T merge(T entity) throws DataAccessException {
		return this.hibernateTemplate.merge(entity);
	}

	@Override
	public <T> T merge(String paramString, T entity) throws DataAccessException {
		return this.hibernateTemplate.merge(paramString, entity);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<E> find(String queryString, Object[] values) throws DataAccessException {
		return (List<E>)this.hibernateTemplate.find(queryString, values);
	}
}