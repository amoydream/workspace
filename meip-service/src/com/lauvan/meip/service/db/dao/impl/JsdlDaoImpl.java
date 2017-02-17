package com.lauvan.meip.service.db.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.lauvan.meip.service.db.dao.CommonDao;
import com.lauvan.meip.service.db.dao.JsdlDao;
import com.lauvan.meip.service.db.entity.Jsdl;
import com.lauvan.meip.service.item.JsdlItem;
import com.lauvan.meip.service.item.JsdlResult;
import com.lauvan.meip.service.util.Utils;

@Repository("jsdlDao")
@SuppressWarnings("unchecked")
public class JsdlDaoImpl extends CommonDao<Jsdl, JsdlItem> implements JsdlDao {
	@Override
	public JsdlResult updateJsdlStatus(Integer id) {
		JsdlResult result = new JsdlResult();
		try {
			Jsdl e = get(Jsdl.class, id);
			if(e != null) {
				e.setStatus(Integer.valueOf(1));
				save(e);
				result.setMsg("操作成功");
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
	public JsdlResult getLatestJsdl() {
		JsdlResult result = new JsdlResult();
		JsdlItem item = null;
		try {
			List<Jsdl> list = list("select a from Jsdl as a where status = 0 and a.id = (select max(id) from Jsdl)", null, null);

			if(list != null && list.size() == 1) {
				item = entityToItem(list.get(0));
			} else {
				item = new JsdlItem();
				item.setId(Integer.valueOf(0));
			}
			result.setItem(item);
			result.setSuccess(true);
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}

		return result;
	}

	@Override
	public JsdlResult getJsdlById(Integer id) {
		JsdlResult result = new JsdlResult();
		JsdlItem item = null;
		try {
			Jsdl e = get(Jsdl.class, id);
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
	public JsdlItem entityToItem(Jsdl entity) {
		if(entity != null) {
			JsdlItem item = new JsdlItem();
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
	public JsdlResult getALLJsdl() {
		JsdlResult result = new JsdlResult();
		try {
			List<Jsdl> list = super.getAll(Jsdl.class);
			if(list != null && list.size() > 0) {
				List<JsdlItem> items = new ArrayList<>();
				for(Jsdl e : list) {
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
	public JsdlResult getJsdlByItem(JsdlItem item) {
		JsdlResult result = new JsdlResult();
		try {
			if(item != null) {
				StringBuffer sql = new StringBuffer("");
				sql.append("select a from Jsdl as a where status = 0");
				buildSql(sql, item);
				sql.append(" order by a.recetime desc");
				List<Jsdl> list = find(sql.toString());
				if(list != null && list.size() > 0) {
					List<JsdlItem> items = new ArrayList<>();
					for(Jsdl e : list) {
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
	public JsdlResult getJsdlPage(JsdlItem item) {
		JsdlResult result = new JsdlResult();
		try {
			if(item != null) {
				StringBuffer totalSql = new StringBuffer("");
				totalSql.append("select count(a.id) from Jsdl as a where status = 0");
				buildSql(totalSql, item);
				Long total = longValue(totalSql.toString());

				result.setTotal(total.intValue());

				StringBuffer recordsSql = new StringBuffer("");
				recordsSql.append("select a from Jsdl as a where  status = 0");
				buildSql(recordsSql, item);
				recordsSql.append(" order by a.recetime desc");

				List<Jsdl> list = list(recordsSql.toString(), item.getFirstResult(), item.getMaxResults());

				if(list != null && list.size() > 0) {
					List<JsdlItem> items = new ArrayList<>();
					for(Jsdl e : list) {
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
	public void buildSql(StringBuffer sql, JsdlItem item) {
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
	public JsdlResult delete(Integer[] idArr) {
		JsdlResult result = new JsdlResult();
		try {
			if(idArr != null && idArr.length > 0) {
				Long l = executeUpdate("update Jsdl set deleted = 1, status = 1 where id in (" + Utils.arrToStr(idArr) + ")");
				if(l != null) {
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
	public JsdlResult physicalDelete(Integer[] idArr) {
		JsdlResult result = new JsdlResult();
		try {
			if(idArr != null && idArr.length > 0) {
				List<Jsdl> list = list("select a from Jsdl as a where a.id in (" + Utils.arrToStr(idArr) + ")", null, null);

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
	public List<Jsdl> list(String sql, Integer firstResult, Integer maxResults) {
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