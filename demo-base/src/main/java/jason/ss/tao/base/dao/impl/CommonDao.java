package jason.ss.tao.base.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Repository;

import jason.ss.tao.base.entity.BaseEntity;

@SuppressWarnings("unchecked")
@Repository(value = "commonDao")
public class CommonDao<E extends BaseEntity> extends HibernateDao {
	public Serializable save(E entity) {
		return getHibernateTemplate().save(entity);
	}

	public void delete(E entity) {
		getHibernateTemplate().delete(entity);
	}

	public void delete(Class<E> clazz, Serializable id) {
		getHibernateTemplate().delete(get(clazz, id));
	}

	public void update(E entity) {
		getHibernateTemplate().saveOrUpdate(entity);
	}

	public E get(Class<E> clazz, Serializable id) {
		return getHibernateTemplate().get(clazz, id);
	}

	public List<E> getAll(Class<E> clazz) {
		return (List<E>)getHibernateTemplate().find("select en from " + clazz.getSimpleName() + " en");
	}

	public List<E> getAll(Class<E> clazz, String where) {
		return (List<E>)getHibernateTemplate().find("select en from " + clazz.getSimpleName() + " en where " + where);
	}
}
