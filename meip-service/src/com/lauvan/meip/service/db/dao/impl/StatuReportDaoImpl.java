package com.lauvan.meip.service.db.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.lauvan.meip.service.db.dao.CommonDao;
import com.lauvan.meip.service.db.dao.StatuReportDao;
import com.lauvan.meip.service.db.entity.StatuReport;
import com.lauvan.meip.service.item.StatuReportItem;
import com.lauvan.meip.service.item.StatuReportResult;
import com.lauvan.meip.service.util.Utils;

@Repository("statuReportDao")
@SuppressWarnings("unchecked")
public class StatuReportDaoImpl extends CommonDao<StatuReport, StatuReportItem> implements StatuReportDao {
	@Override
	public StatuReportResult getStatuReportById(Integer id) {
		StatuReportResult result = new StatuReportResult();
		StatuReportItem item = null;
		try {
			StatuReport e = get(StatuReport.class, id);
			if(e != null) {
				item = entityToItem(e);
				result.setItem(item);
			} else {
				result.setMsg("无数据");
			}
			result.setSuccess(true);
		} catch(Exception e) {
			result.setMsg("短信服务异常: " + e.getMessage());
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public StatuReportItem entityToItem(StatuReport entity) {
		if(entity != null) {
			StatuReportItem item = new StatuReportItem();
			item.setClient_id(entity.getClient_id());
			item.setContent(entity.getContent());
			item.setDeleted(entity.getDeleted());
			item.setEid(entity.getEid());
			item.setId(entity.getId());
			item.setReceiver(entity.getReceiver());
			item.setSmsstatu(entity.getSmsstatu());
			item.setUpdateTime(entity.getUpdateTime());
			item.setUserid(entity.getUserid());
			return item;
		}
		return null;
	}

	@Override
	public StatuReportResult getALLStatuReport() {
		StatuReportResult result = new StatuReportResult();
		try {
			List<StatuReport> list = super.getAll(StatuReport.class);
			if(list != null && list.size() > 0) {
				List<StatuReportItem> items = new ArrayList<>();
				for(StatuReport e : list) {
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
	public StatuReportResult getStatuReportByItem(StatuReportItem item) {
		StatuReportResult result = new StatuReportResult();
		try {
			if(item != null) {
				StringBuffer sql = new StringBuffer("");
				sql.append("select a from StatuReport as a where 1 = 1");
				buildSql(sql, item);
				sql.append(" order by a.updateTime desc");
				List<StatuReport> list = find(sql.toString());
				if(list != null && list.size() > 0) {
					List<StatuReportItem> items = new ArrayList<>();
					for(StatuReport e : list) {
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
	public StatuReportResult getStatuReportPage(StatuReportItem item) {
		StatuReportResult result = new StatuReportResult();
		try {
			if(item != null) {
				StringBuffer totalSql = new StringBuffer("");
				totalSql.append("select count(a.id) from StatuReport as a where 1 = 1");
				buildSql(totalSql, item);

				Long total = longValue(totalSql.toString());

				result.setTotal(total.intValue());

				StringBuffer recordsSql = new StringBuffer("");
				recordsSql.append("select a from StatuReport as a where 1 = 1");
				buildSql(recordsSql, item);
				recordsSql.append(" order by a.updateTime desc");

				List<StatuReport> list = list(recordsSql.toString(), item.getFirstResult(), item.getMaxResults());

				if(list != null && list.size() > 0) {
					List<StatuReportItem> items = new ArrayList<>();
					for(StatuReport e : list) {
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
	public void buildSql(StringBuffer sql, StatuReportItem item) {
		String content = item.getContent();
		String mobile = item.getReceiver();
		String[] mobiles = item.getMobiles();
		Date updateTimeStart = item.getUpdateTimeStart();
		Date updateTimeEnd = item.getUpdateTimeEnd();
		Integer deleted = item.getDeleted();

		if(!StringUtils.isEmpty(content)) {
			sql.append(" and a.content like '%" + content + "%'");
		}

		if(!StringUtils.isEmpty(mobile)) {
			sql.append(" and a.receiver like '%" + mobile + "%'");
		} else if(mobiles != null && mobiles.length > 0) {
			sql.append(" and a.receiver in (" + Utils.arrToStr(mobiles) + ")");
		}

		if(updateTimeStart != null) {
			sql.append(" and a.updateTime >= todate('" + Utils.sdf.format(updateTimeStart) + "')");
		}

		if(updateTimeEnd != null) {
			sql.append(" and a.updateTime <= todate('" + Utils.sdf.format(updateTimeEnd) + "')");
		}

		if(deleted != null) {
			sql.append(" and a.deleted = " + deleted);
		}
	}

	@Override
	public StatuReportResult delete(Integer[] idArr) {
		StatuReportResult result = new StatuReportResult();
		try {
			if(idArr != null && idArr.length > 0) {
				Long l = executeUpdate("update StatuReport set deleted = 1 where id in (" + Utils.arrToStr(idArr) + ")");
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
	public StatuReportResult physicalDelete(Integer[] idArr) {
		StatuReportResult result = new StatuReportResult();
		try {
			if(idArr != null && idArr.length > 0) {
				List<StatuReport> list = list("select a from StatuReport as a where a.id in (" + Utils.arrToStr(idArr) + ")", null, null);
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
	public List<StatuReport> list(String sql, Integer firstResult, Integer maxResults) {
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