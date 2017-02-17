package com.lauvan.base.dao;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.util.DataGrid;

/**
 * DAO基础接口
 * ClassName: BaseDAO 
 * @Description: 提供给service层继承使用
 * @author 钮炜炜
 * @date 2015年9月11日 下午2:21:02
 */
public interface BaseDAO<T> {
	/**
	 * 批量更新
	 * @param list 实体集合
	 */
	public void batchUpdate(List<T> list);
	/**
	 * 封装between查询
	 * @param propertyName
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<T> findByBetWeen(String propertyName,Object beginDate,Object endDate);
	/**
	 * 原生sql查询
	 * @param sql 原生sql语句
	 * @return
	 */
	public List<Object> getSqlQuery(String sql);
	/**
	 * 安全的原生sql查询(可防止sql注入)
	 * @param sql
	 * @param queryParams
	 * @return
	 */
	public List<Object> getSqlQuery(String sql,Object[] queryParams);
	/**
	 * 一个属性条件的实体集查询
	 * @param property 对应实体属性
	 * @param value 传值
	 * @return
	 */
	public List<T> findByProperty(String property,Object value);
	/**
	 * 两个属性条件的实体集查询
	 * @param property 对应实体属性1
	 * @param value 传值1
	 * @param property2 对应实体属性2
	 * @param value2 传值2
	 * @return
	 */
	public List<T> findByProperty(String property,Object value,String property2,Object value2);
	/**
	 * 一个属性(不等于)条件的实体集查询
	 * @param property 对应实体属性
	 * @param value 传值
	 * @return
	 */
	public List<T> findByNotProperty(String property,Object value);
	/**
	 * 两个属性(第二个不等于)条件的实体集查询
	 * @param property 对应实体属性1
	 * @param value 传值1
	 * @param property2 对应实体属性2(不等于)
	 * @param value2 传值2
	 * @return
	 */
	public List<T> findByNotProperty(String property,Object value,String property2,Object value2);
	/**
	 * 一个属性条件的模糊实体集查询
	 * @param property
	 * @param value
	 * @return
	 */
	public List<T> findByPropertyauto(String property,Object value);
	/**
	 * 带有条件和排序的实体集查询
	 * @param wherejpql 属性
	 * @param queryParams 属性传值集合
	 * @param orderby 排序
	 * @return
	 */
	public List<T> getListEntitys(String wherejpql, Object[] queryParams,LinkedHashMap<String, String> orderby);
	/**
	 * 无任何条件的实体查询等同于全表查询
	 * @return
	 */
	public List<T> getListEntitys();
	/**
	 * 带有条件的实体集查询
	 * @param wherejpql
	 * @param queryParams
	 * @return
	 */
	public List<T> getListEntitys(String wherejpql, Object[] queryParams);
	/**
	 * 一个属性的单实体查询,没有返回null
	 * @param property 属性必须具有唯一性约束才可以
	 * @param value
	 * @return
	 */
	public T findEntity(String property,Object value);
	/**
	 * 两个属性的单实体查询,没有返回null
	 * @param property 属性必须具有唯一性约束才可以
	 * @param value
	 * @return
	 */
	public T findEntity(String property,Object value,String property2,Object value2);
	/**
	 * 查询某个属性值为null的实体集
	 * @param propertyName
	 * @return
	 */
	public List<T> getListIsNull(String propertyName);
	public List<T> getListIsNull(String property,Object value,String propertyName);
	/**
	 * 判断唯一性
	 * @param field
	 * @param value
	 * @return
	 */
	public boolean exsit(String field,Object value);
	/**
	 * 多条件判断唯一性
	 * @param field
	 * @param value
	 * @param field1
	 * @param value1
	 * @return
	 */
	public boolean exsit(String field,Object value,String field1,Object value1);

	/**
	 * 获取记录总数
	 * @return
	 */
	public long getCount();
	
	public long getCount(String field,Object value);
	/**
	 * 清除一级缓存的数据
	 */
	public void clear();
	/**
	 * 保存实体
	 * @param entity
	 */
	public void save(Object entity);
	/**
	 * 更新实体
	 * @param entity
	 */
	public void update(Object entity);
	/**
	 * 删除实体
	 * @param entityids id集合
	 */
	public void delete(Serializable ... entityids);
	/**
	 * 获取实体
	 * @param entityId
	 * @return
	 */
	public T find(Serializable entityId);
	/**
	 * 获取某一属性的最大值
	 * @param field
	 * @return
	 */
	public Integer getMax(String field);
	/**
	 * 针对easyui datagrid的查询分页封装接口
	 * @param firstindex 第几页
	 * @param maxresult 每页显示数
	 * @param wherejpql 查询条件组装
	 * @param queryParams 条件值集合
	 * @param orderby 排序
	 * @return
	 */
	public DataGrid<T> getScrollData(int firstindex, int maxresult, String wherejpql, Object[] queryParams,LinkedHashMap<String, String> orderby);
	public DataGrid<T> getScrollData(int page, int rows);
	public DataGrid<T> getScrollData(int page, int rows,LinkedHashMap<String, String> orderby);
	public DataGrid<T> getScrollData(int page, int rows,String wherejpql, Object[] queryParams);
	/**
	 * 查询封装
	 * @param propertyNames 自定义要查询出来的字段
	 * @param wherejpql 查询条件组装
	 * @param queryParams 条件值集合
	 * @param propertyNames2 group by条件
	 * @param orderby 排序
	 * @return
	 */
	public List<Object> getObjects(String propertyNames,String wherejpql, Object[] queryParams,String propertyNames2,LinkedHashMap<String, String> orderby);
	public List<Object> getObjects(String propertyNames,String wherejpql, Object[] queryParams,String propertyNames2);
	public List<Object> getObjects(String propertyNames,String wherejpql, Object[] queryParams,LinkedHashMap<String, String> orderby);
	public List<Object> getObjects(String propertyNames,String wherejpql, Object[] queryParams);
	public List<Object> getObjects(String propertyNames,String propertyNames2);
	
	/**
	 * 获取分页数据
	 * @param <T>
	 * @param entityClass 实体类
	 * @param firstindex 开始索引
	 * @param maxresult 需要获取的记录数
	 * @return
	 */
	public QueryResult<T> getScrollList(int firstindex, int maxresult, String wherejpql, Object[] queryParams,LinkedHashMap<String, String> orderby);
	
	public QueryResult<T> getScrollList(int firstindex, int maxresult, String wherejpql, Object[] queryParams);
	
	public QueryResult<T> getScrollList(int firstindex, int maxresult, LinkedHashMap<String, String> orderby);
	
	public QueryResult<T> getScrollList(int firstindex, int maxresult);
	
	public QueryResult<T> getScrollList();
	
	/**
	 * 根据JPA的ql语句查询数据
	 * @param qlString ql语句查询数据
	 * @param params 参数
	 * @return 结果集
	 */
	public List<T> getResultList(String qlString,List<Object> params);
	
	/**
	 * 根据JPA的ql语句查询数据
	 * @param qlString ql语句查询数据
	 * @return 结果集
	 */
	public List<T> getResultList(String qlString);
	
}
