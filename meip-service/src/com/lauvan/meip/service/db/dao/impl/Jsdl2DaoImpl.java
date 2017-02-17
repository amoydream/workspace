package com.lauvan.meip.service.db.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.lauvan.meip.service.db.dao.CommonDao;
import com.lauvan.meip.service.db.dao.Jsdl2Dao;
import com.lauvan.meip.service.db.entity.Jsdl2;
import com.lauvan.meip.service.item.Jsdl2Item;
import com.lauvan.meip.service.item.Jsdl2Result;
import com.lauvan.meip.service.util.Utils;

@Repository("jsdl2Dao")
@SuppressWarnings("unchecked")
public class Jsdl2DaoImpl extends CommonDao<Jsdl2, Jsdl2Item> implements Jsdl2Dao {
	@Override
	public Jsdl2Result getJsdl2ById(Integer id) {
		Jsdl2Result result = new Jsdl2Result();
		Jsdl2Item item = null;
		try {
			Jsdl2 e = get(Jsdl2.class, id);
			if(e != null) {
				item = entityToItem(e);
				result.setItem(item);
			} else {
				result.setMsg("无数据");
			}
			result.setSuccess(true);
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}
		return result;
	}

	@Override
	public Jsdl2Item entityToItem(Jsdl2 entity) {
		if(entity != null) {
			Jsdl2Item item = new Jsdl2Item();
			item.setContent(entity.getContent());
			item.setDeleted(entity.getDeleted());
			item.setEid(entity.getEid());
			item.setId(entity.getId());
			item.setMobile(entity.getMobile());
			item.setPassword(entity.getPassword());
			item.setUserid(entity.getUserid());
			item.setRecetime(entity.getRecetime());
			item.setStatus(entity.getStatus());
			item.setUserport(entity.getUserport());
			return item;
		}
		return null;
	}

	@Override
	public Jsdl2Result getALLJsdl2() {
		Jsdl2Result result = new Jsdl2Result();
		try {
			List<Jsdl2> list = super.getAll(Jsdl2.class);
			if(list != null && list.size() > 0) {
				List<Jsdl2Item> items = new ArrayList<>();
				for(Jsdl2 e : list) {
					items.add(entityToItem(e));
				}
				result.setItems(items);
			} else {
				result.setMsg("无数据");
			}
			result.setSuccess(true);
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}
		return result;
	}

	@Override
	public Jsdl2Result getJsdl2ByItem(Jsdl2Item item) {
		Jsdl2Result result = new Jsdl2Result();
		try {
			if(item != null) {
				StringBuffer sql = new StringBuffer("");
				sql.append("select a from Jsdl2 as a where 1 = 1");
				buildSql(sql, item);
				sql.append(" order by a.recetime desc");
				List<Jsdl2> list = find(sql.toString());
				if(list != null && list.size() > 0) {
					List<Jsdl2Item> items = new ArrayList<>();
					for(Jsdl2 e : list) {
						items.add(entityToItem(e));
					}
					result.setItems(items);
				} else {
					result.setMsg("无数据");
				}
			} else {
				result.setMsg("无数据");
			}
			result.setSuccess(true);
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}
		return result;
	}

	@Override
	public Jsdl2Result getJsdl2Page(Jsdl2Item item) {
		Jsdl2Result result = new Jsdl2Result();
		try {
			if(item != null) {
				StringBuffer totalSql = new StringBuffer("");
				totalSql.append("select count(a.id) from Jsdl2 as a where 1 = 1");
				buildSql(totalSql, item);
				Long total = longValue(totalSql.toString());

				result.setTotal(total.intValue());

				StringBuffer recordsSql = new StringBuffer("");
				recordsSql.append("select a from Jsdl2 as a where 1 = 1");
				buildSql(recordsSql, item);
				recordsSql.append(" order by a.recetime desc");

				List<Jsdl2> list = list(recordsSql.toString(), item.getFirstResult(), item.getMaxResults());

				if(list != null && list.size() > 0) {
					List<Jsdl2Item> items = new ArrayList<>();
					for(Jsdl2 e : list) {
						items.add(entityToItem(e));
					}
					result.setItems(items);
				} else {
					result.setMsg("无数据");
				}
			} else {
				result.setMsg("无数据");
			}
			result.setSuccess(true);
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}
		return result;
	}

	@Override
	public void buildSql(StringBuffer sql, Jsdl2Item item) {
		String mobile = item.getMobile();
		String[] mobiles = item.getMobiles();
		String content = item.getContent();
		Date recetimeStart = item.getRecetimeStart();
		Date recetimeEnd = item.getRecetimeEnd();
		Integer deleted = item.getDeleted();

		if(!StringUtils.isEmpty(mobile)) {
			sql.append(" and a.mobile like '%" + mobile + "%'");
		} else if(mobiles != null && mobiles.length > 0) {
			sql.append(" and a.mobile in (" + Utils.arrToStr(mobiles) + ")");
		}

		if(!StringUtils.isEmpty(content)) {
			sql.append(" and a.content like '%" + content + "%'");
		}

		if(recetimeStart != null) {
			sql.append(" and a.recetime >= todate('" + Utils.sdf.format(recetimeStart) + "')");
		}

		if(recetimeEnd != null) {
			sql.append(" and a.recetime <= todate('" + Utils.sdf.format(recetimeEnd) + "')");
		}

		if(deleted != null) {
			sql.append(" and a.deleted = " + deleted);
		}
	}

	@Override
	public Jsdl2Result delete(Integer[] idArr) {
		Jsdl2Result result = new Jsdl2Result();
		try {
			if(idArr != null && idArr.length > 0) {
				Long obj = executeUpdate("update Jsdl2 set deleted = 1 where id in (" + Utils.arrToStr(idArr) + ")");

				if(obj != null) {
					result.setSuccess(true);
					result.setMsg("删除成功");
				} else {
					result.setSuccess(true);
					result.setMsg("短信服务异常: 删除失败");
				}
			} else {
				result.setSuccess(true);
				result.setMsg("无数据");
			}
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}
		return result;
	}

	@Override
	public Jsdl2Result physicalDelete(Integer[] idArr) {
		Jsdl2Result result = new Jsdl2Result();
		try {
			if(idArr != null && idArr.length > 0) {
				List<Jsdl2> list = list("select a from Jsdl2 as a where a.id in (" + Utils.arrToStr(idArr) + ")", null, null);

				if(list != null && list.size() > 0) {
					deleteAll(list);
					result.setSuccess(true);
					result.setMsg("删除成功");
				} else {
					result.setSuccess(true);
					result.setMsg("无数据");
				}
			} else {
				result.setSuccess(true);
				result.setMsg("无数据");
			}
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}
		return result;
	}

	@Override
	public List<Jsdl2> list(String sql, Integer firstResult, Integer maxResults) {
		Session session = getSessionFactory().getCurrentSession();
		Query query = session.createQuery(sql);
		if(firstResult != null) {
			query.setFirstResult(firstResult);
		}
		if(maxResults != null) {
			query.setMaxResults(maxResults);
		}
		return query.list();
	}
}
