package com.lauvan.base.dao;

import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.Serializable;
import java.lang.reflect.Method;
import java.util.LinkedHashMap;
import java.util.List;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.util.DataGrid;
import com.lauvan.util.GenericsUtils;
/**
 * DAO基础实现
 * ClassName: BaseDAOSupport 
 * @Description: 封装JPA连接数据库操作的CRUD，同时可提供service层来继承
 * @author 钮炜炜
 * @date 2015年9月11日 下午2:45:22
 */
@Repository
public class EntityManageTemplate<T> implements BaseDAO1<T> {
	/**
	 * 泛型工具：用来获取<T>中 T 对应的实体类
	 */
	@SuppressWarnings("unchecked")
	private Class<T> entityClass = GenericsUtils.getSuperClassGenricType(this.getClass());
	/**
	 * jpa的实体管理器
	 */
	@PersistenceContext(unitName="mysqldb")
	protected EntityManager em;
	
	public void clear(){
		em.clear();
	}
	
	public void batchUpdate(List<T> list) {
		for (int i = 0,h=list.size(); i < h; i++) {
			em.merge(list.get(i));
			if (i%30==0) {
				em.flush();
				em.clear();
			}
		}
	}

	public void delete(Serializable ... entityids) {
		for(Object id : entityids){
			em.remove(em.getReference(this.entityClass, id));
		}
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<T> findByBetWeen(String propertyName,Object beginDate,Object endDate) {
		return em.createQuery("select o from "+getEntityName(this.entityClass)+" o where o."+propertyName+" between ?1 and ?2").setParameter(1, beginDate).setParameter(2, endDate).getResultList();
	}
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<T> getListIsNull(String propertyName) {
		return em.createQuery("select o from "+getEntityName(this.entityClass)+" o where o."+propertyName+" is null").getResultList();
	}
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<T> getListIsNull(String property,Object value,String propertyName) {
		return em.createQuery("select o from "+getEntityName(this.entityClass)+" o where o."+property+"=?1 and o."+propertyName+" is null").setParameter(1, value).getResultList();
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public List<T> getListEntitys(String wherejpql, Object[] queryParams,LinkedHashMap<String, String> orderby) {
		Query query = em.createQuery("select o from "+getEntityName(this.entityClass)+" o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql)+ buildOrderby(orderby));
		setQueryParams(query, queryParams);
		return query.getResultList();
	}
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public List<T> getListEntitys() {
		return getListEntitys(null, null, null);
	}
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public List<T> getListEntitys(String wherejpql, Object[] queryParams) {
		return getListEntitys(wherejpql, queryParams, null);
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public List<T> findByProperty(String property,Object value) {
		String sql = "select o from "+getEntityName(this.entityClass)+" o where o."+property+"=?1";
		return em.createQuery(sql).setParameter(1, value).getResultList();
	}
	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public List<T> findByProperty(String property,Object value,String property2,Object value2) {
		String sql = "select o from "+getEntityName(this.entityClass)+" o where o."+property+"=?1 and o."+property2+"=?2";
		return em.createQuery(sql).setParameter(1, value).setParameter(2, value2).getResultList();
	}
	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public T findEntity(String property,Object value) {
		String sql = "select count(o) from "+getEntityName(this.entityClass)+" o where o."+property+"=?1";
		long count = (Long)em.createQuery(sql).setParameter(1, value).getSingleResult();
		if (count>0) {
			sql = "select o from "+getEntityName(this.entityClass)+" o where o."+property+"=?1";
			return (T) em.createQuery(sql).setParameter(1, value).getSingleResult();
		}else {
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public T findEntity(String property,Object value,String property2,Object value2) {
		String sql = "select count(o) from "+getEntityName(this.entityClass)+" o where o."+property+"=?1 and o."+property2+"=?2";
		long count = (Long)em.createQuery(sql).setParameter(1, value).setParameter(2, value2).getSingleResult();
		if (count>0) {
			sql = "select o from "+getEntityName(this.entityClass)+" o where o."+property+"=?1 and o."+property2+"=?2";
			return (T) em.createQuery(sql).setParameter(1, value).setParameter(2, value2).getSingleResult();
		}else {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public List<T> findByPropertyauto(String property,Object value) {
		String sql = "select o from "+getEntityName(this.entityClass)+" o where o."+property+" like ?1";
		value = "%"+value+"%";
		return em.createQuery(sql).setParameter(1, value).getResultList();
	}
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public Object getMax(String field){
		String sql = "select max("+field+") from "+getEntityName(this.entityClass)+"";
		Object o = "";
		if (em.createQuery(sql).getSingleResult()!=null) {
			o = em.createQuery(sql).getSingleResult();
		}
		return o;
	}
	
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public boolean exsit(String field,Object value){
		String sql = "select count(o) from "+getEntityName(this.entityClass)+" o where o."+field+"=?1";
		long count = (Long)em.createQuery(sql).setParameter(1, value).getSingleResult();
		return count>0;
	}
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	public boolean exsit(String field,Object value,String field1,Object value1){
		String sql = "select count(o) from "+getEntityName(this.entityClass)+" o where o."+field+"=?1 and o."+field1+"=?2";
		long count = (Long)em.createQuery(sql).setParameter(1, value).setParameter(2, value1).getSingleResult();
		return count>0;
	}
	
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public T find(Serializable entityId) {
		if(entityId==null) throw new RuntimeException(this.entityClass.getName()+ ":传入的实体id不能为空");
		return em.find(this.entityClass, entityId);
	}

	public void save(Object entity) {
		em.persist(entity);
	}
	
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public long getCount() {
		return (Long)em.createQuery("select count("+ getCountField(this.entityClass) +") from "+ getEntityName(this.entityClass)+ " o").getSingleResult();
	}
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public long getCount(String field,Object value) {
		return (Long)em.createQuery("select count("+ getCountField(this.entityClass) +") from "+ getEntityName(this.entityClass)+ " o where o."+field+"=?1").setParameter(1, value).getSingleResult();
	}
	
	public void update(Object entity) {
		em.merge(entity);
		em.flush();
	}
	
	/**
	 * 拼接条件
	 * @param query
	 * @param queryParams
	 */
	protected static void setQueryParams(Query query, Object[] queryParams){
		if(queryParams!=null && queryParams.length>0){
			for(int i=0; i<queryParams.length; i++){
				query.setParameter(i+1, queryParams[i]);
			}
		}
	}
	/**
	 * 组装order by语句
	 * @param orderby
	 * @return
	 */
	protected static String buildOrderby(LinkedHashMap<String, String> orderby){
		StringBuffer orderbyql = new StringBuffer("");
		if(orderby!=null && orderby.size()>0){
			orderbyql.append(" order by ");
			for(String key : orderby.keySet()){
				orderbyql.append("o.").append(key).append(" ").append(orderby.get(key)).append(",");
			}
			orderbyql.deleteCharAt(orderbyql.length()-1);
		}
		return orderbyql.toString();
	}
	/**
	 * 获取实体的名称
	 * @param <E>
	 * @param clazz 实体类
	 * @return
	 */
	protected static <E> String getEntityName(Class<E> clazz){
		String entityname = clazz.getSimpleName();
		Entity entity = clazz.getAnnotation(Entity.class);
		if(entity.name()!=null && !"".equals(entity.name())){
			entityname = entity.name();
		}
		return entityname;
	}
	/**
	 * 复合主键匹配
	 * @param clazz
	 * @return
	 */
	protected static <E> String getCountField(Class<E> clazz){
		String out = "o";
		try {
			PropertyDescriptor[] propertyDescriptors = Introspector.getBeanInfo(clazz).getPropertyDescriptors();
			for(PropertyDescriptor propertydesc : propertyDescriptors){
				Method method = propertydesc.getReadMethod();
				if(method!=null && method.isAnnotationPresent(EmbeddedId.class)){					
					PropertyDescriptor[] ps = Introspector.getBeanInfo(propertydesc.getPropertyType()).getPropertyDescriptors();
					out = "o."+ propertydesc.getName()+ "." + (!ps[1].getName().equals("class")? ps[1].getName(): ps[0].getName());
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        return out;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> getSqlQuery(String sql){
		return em.createNativeQuery(sql).getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> getSqlQuery(String sql,Object[] queryParams){
		Query query = em.createNativeQuery(sql);
		setQueryParams(query, queryParams);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public DataGrid<T> getScrollData(int firstindex, int maxresult,
			String wherejpql, Object[] queryParams,
			LinkedHashMap<String, String> orderby) {
		DataGrid<T> dataGrid = new DataGrid<T>();
		String entityname = getEntityName(this.entityClass);
		Query query = em.createQuery("select o from "+ entityname+ " o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql)+ buildOrderby(orderby));
		setQueryParams(query, queryParams);
		firstindex = firstindex-1;
		if(firstindex!=-1 && maxresult!=-1) query.setFirstResult(firstindex*maxresult).setMaxResults(maxresult);
		dataGrid.setRows(query.getResultList());
		query = em.createQuery("select count("+ getCountField(this.entityClass)+ ") from "+ entityname+ " o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql));
		setQueryParams(query, queryParams);
		dataGrid.setTotal((Long)query.getSingleResult());
		return dataGrid;
	}

	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public DataGrid<T> getScrollData(int page, int rows,String wherejpql, Object[] queryParams) {
		return getScrollData(page, rows, wherejpql, queryParams, null);
	}
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public DataGrid<T> getScrollData(int page, int rows) {
		return getScrollData(page, rows, null, null, null);
	}
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public DataGrid<T> getScrollData(int page, int rows,LinkedHashMap<String, String> orderby) {
		return getScrollData(page, rows, null, null, orderby);
	}
	
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<Object> getObjects(String propertyNames,String wherejpql, Object[] queryParams,String propertyNames2,LinkedHashMap<String, String> orderby){
		Query query = em.createQuery("select "+propertyNames+" from "+getEntityName(this.entityClass)+" o "+(wherejpql==null || "".equals(wherejpql.trim())? "":"where "+wherejpql)+
				(propertyNames2==null || "".equals(propertyNames2.trim()) ? "":"group by "+propertyNames2)+buildOrderby(orderby));
		setQueryParams(query, queryParams);
		return query.getResultList();
	}
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<Object> getObjects(String propertyNames,String wherejpql, Object[] queryParams,String propertyNames2){
		return getObjects(propertyNames,wherejpql, queryParams,propertyNames2,null);
	}
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<Object> getObjects(String propertyNames,String wherejpql, Object[] queryParams,LinkedHashMap<String, String> orderby){
		return getObjects(propertyNames,wherejpql, queryParams,null,orderby);
	}
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<Object> getObjects(String propertyNames,String wherejpql, Object[] queryParams){
		return getObjects(propertyNames,wherejpql, queryParams,null,null);
	}
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<Object> getObjects(String propertyNames,String propertyNames2){
		return getObjects(propertyNames,null, null,propertyNames2,null);
	}
	
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public QueryResult<T> getScrollList(int firstindex, int maxresult, LinkedHashMap<String, String> orderby) {
		return getScrollList(firstindex,maxresult,null,null,orderby);
	}
	
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public QueryResult<T> getScrollList(int firstindex, int maxresult, String wherejpql, Object[] queryParams) {
		return getScrollList(firstindex,maxresult,wherejpql,queryParams,null);
	}
	
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public QueryResult<T> getScrollList(int firstindex, int maxresult) {
		return getScrollList(firstindex,maxresult,null,null,null);
	}
	
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public QueryResult<T> getScrollList() {
		return getScrollList(-1, -1);
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public QueryResult<T> getScrollList(int firstindex, int maxresult, String wherejpql, Object[] queryParams,LinkedHashMap<String, String> orderby) {
		QueryResult<T> qr = new QueryResult<T>();
		String entityname = getEntityName(this.entityClass);
		Query query = em.createQuery("select o from "+ entityname+ " o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql)+ buildOrderby(orderby));
		setQueryParams(query, queryParams);
		if(firstindex!=-1 && maxresult!=-1) query.setFirstResult(firstindex).setMaxResults(maxresult);
		qr.setResultlist(query.getResultList());
		query = em.createQuery("select count("+ getCountField(this.entityClass)+ ") from "+ entityname+ " o "+(wherejpql==null || "".equals(wherejpql.trim())? "": "where "+ wherejpql));
		setQueryParams(query, queryParams);
		qr.setTotalrecord(((Long)query.getSingleResult()).intValue());
		return qr;
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<T> getResultList(String qlString,List<Object> params) {
		try{
			Query query=em.createQuery(qlString);
			for(int index=0;index<params.size();index++){
				query.setParameter(index, params.get(index));
			}
			return (List<T>) query.getResultList();
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(readOnly=true,propagation=Propagation.REQUIRED)
	public List<T> getResultList(String qlString) {
		try{
			Query query=em.createQuery(qlString);
			return (List<T>) query.getResultList();
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
}
