package com.lauvan.meip.service.db.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.lauvan.meip.service.db.dao.CommonDao;
import com.lauvan.meip.service.db.dao.YfsdlDao;
import com.lauvan.meip.service.db.entity.Yfsdl;
import com.lauvan.meip.service.item.YfsdlItem;
import com.lauvan.meip.service.item.YfsdlResult;
import com.lauvan.meip.service.util.Utils;

@Repository("yfsdlDao")
@SuppressWarnings("unchecked")
public class YfsdlDaoImpl extends CommonDao<Yfsdl, YfsdlItem> implements YfsdlDao {
	@Override
	public YfsdlResult getYfsdlById(Integer id) {
		YfsdlResult result = new YfsdlResult();
		YfsdlItem item = null;
		try {
			Yfsdl e = get(Yfsdl.class, id);
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
	public YfsdlItem entityToItem(Yfsdl entity) {
		if(entity != null) {
			YfsdlItem item = new YfsdlItem();
			item.setId(entity.getId());
			item.setContent(entity.getContent());
			item.setMobile(entity.getMobile());
			item.setDeadtime(entity.getDeadtime());
			item.setStatus(entity.getStatus());
			item.setEid(entity.getEid());
			item.setMsgid(entity.getMsgid());
			item.setUserid(entity.getUserid());
			item.setPassword(entity.getPassword());
			item.setUserport(entity.getUserport());
			item.setDeleted(entity.getDeleted());
			return item;
		}
		return null;
	}

	@Override
	public YfsdlResult getALLYfsdl() {
		YfsdlResult result = new YfsdlResult();
		try {
			List<Yfsdl> list = super.getAll(Yfsdl.class);
			if(list != null && list.size() > 0) {
				List<YfsdlItem> itemList = new ArrayList<>();
				for(Yfsdl e : list) {
					itemList.add(entityToItem(e));
				}
				result.setItems(itemList);
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
	public YfsdlResult getYfsdlByItem(YfsdlItem item) {
		YfsdlResult result = new YfsdlResult();
		try {
			if(item != null) {
				StringBuffer sql = new StringBuffer("");
				sql.append("select a from Yfsdl as a where 1 = 1");
				buildSql(sql, item);
				sql.append(" order by a.deadtime desc");
				List<Yfsdl> list = find(sql.toString());
				if(list != null && list.size() > 0) {
					List<YfsdlItem> items = new ArrayList<>();
					for(Yfsdl e : list) {
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
	public YfsdlResult getYfsdlPage(YfsdlItem item) {
		YfsdlResult result = new YfsdlResult();
		try {
			if(item != null) {
				StringBuffer totalSql = new StringBuffer("");
				totalSql.append("select count(a.id) from Yfsdl as a where 1 = 1");
				buildSql(totalSql, item);

				Long total = longValue(totalSql.toString());

				result.setTotal(total.intValue());

				StringBuffer recordsSql = new StringBuffer("");
				recordsSql.append("select a from Yfsdl as a where 1 = 1");
				buildSql(recordsSql, item);
				recordsSql.append(" order by a.deadtime desc");

				List<Yfsdl> list = list(recordsSql.toString(), item.getFirstResult(), item.getMaxResults());

				if(list != null && list.size() > 0) {
					List<YfsdlItem> items = new ArrayList<>();
					for(Yfsdl e : list) {
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
	public void buildSql(StringBuffer sql, YfsdlItem item) {
		String content = item.getContent();
		String mobile = item.getMobile();
		String[] mobiles = item.getMobiles();
		Date deadtimeStart = item.getDeadtimeStart();
		Date deadtimeEnd = item.getDeadtimeEnd();
		Integer deleted = item.getDeleted();

		if(!StringUtils.isEmpty(mobile)) {
			sql.append(" and a.mobile like '%" + mobile + "%'");
		} else if(mobiles != null && mobiles.length > 0) {
			sql.append(" and a.mobile in (" + Utils.arrToStr(mobiles) + ")");
		}
		if(!StringUtils.isEmpty(content)) {
			sql.append(" and a.content like '%" + content + "%'");
		}
		if(deadtimeStart != null) {
			sql.append(" and a.deadtime >= todate('" + Utils.sdf.format(deadtimeStart) + "')");
		}

		if(deadtimeEnd != null) {
			sql.append(" and a.deadtime <= todate('" + Utils.sdf.format(deadtimeEnd) + "')");
		}

		if(deleted != null) {
			sql.append(" and a.deleted = " + deleted);
		}
	}

	@Override
	public YfsdlResult delete(Integer[] idArr) {
		YfsdlResult result = new YfsdlResult();
		try {
			if(idArr != null && idArr.length > 0) {
				Long l = executeUpdate("update Yfsdl set deleted = 1 where id in (" + Utils.arrToStr(idArr) + ")");
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
	public YfsdlResult physicalDelete(Integer[] idArr) {
		YfsdlResult result = new YfsdlResult();
		try {
			if(idArr != null && idArr.length > 0) {
				List<Yfsdl> list = list("select a from Yfsdl as a where a.id in (" + Utils.arrToStr(idArr) + ")", null, null);
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
	public List<Yfsdl> list(String sql, Integer firstResult, Integer maxResults) {
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