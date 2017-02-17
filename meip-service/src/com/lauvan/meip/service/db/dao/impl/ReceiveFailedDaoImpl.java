package com.lauvan.meip.service.db.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.lauvan.meip.service.db.dao.CommonDao;
import com.lauvan.meip.service.db.dao.ReceiveFailedDao;
import com.lauvan.meip.service.db.entity.ReceiveFailed;
import com.lauvan.meip.service.item.ReceiveFailedItem;
import com.lauvan.meip.service.item.ReceiveFailedResult;
import com.lauvan.meip.service.util.Utils;

@Repository("receiveFailedDao")
@SuppressWarnings("unchecked")
public class ReceiveFailedDaoImpl extends CommonDao<ReceiveFailed, ReceiveFailedItem> implements ReceiveFailedDao {
	@Override
	public ReceiveFailedResult getReceiveFailedById(Integer id) {
		ReceiveFailedResult result = new ReceiveFailedResult();
		ReceiveFailedItem item = null;
		try {
			ReceiveFailed e = get(ReceiveFailed.class, id);
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
	public ReceiveFailedItem entityToItem(ReceiveFailed entity) {
		if(entity != null) {
			ReceiveFailedItem item = new ReceiveFailedItem();
			item.setId(entity.getId());
			item.setFcontent(entity.getFcontent());
			item.setFmobile(entity.getFmobile());
			item.setFsendtime(entity.getFsendtime());
			item.setFstate(entity.getFstate());
			item.setRemark(entity.getRemark());
			return item;
		}
		return null;
	}

	@Override
	public ReceiveFailedResult getALLReceiveFailed() {
		ReceiveFailedResult result = new ReceiveFailedResult();
		try {
			List<ReceiveFailed> list = super.getAll(ReceiveFailed.class);
			if(list != null && list.size() > 0) {
				List<ReceiveFailedItem> items = new ArrayList<>();
				for(ReceiveFailed e : list) {
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
	public ReceiveFailedResult getReceiveFailedByItem(ReceiveFailedItem item) {
		ReceiveFailedResult result = new ReceiveFailedResult();
		try {
			if(item != null) {
				StringBuffer sql = new StringBuffer("");
				sql.append("select a from ReceiveFailed as a where 1 = 1");
				buildSql(sql, item);
				sql.append(" order by a.fsendtime desc");
				List<ReceiveFailed> list = find(sql.toString());
				if(list != null && list.size() > 0) {
					List<ReceiveFailedItem> items = new ArrayList<>();
					for(ReceiveFailed e : list) {
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
	public ReceiveFailedResult getReceiveFailedPage(ReceiveFailedItem item) {
		ReceiveFailedResult result = new ReceiveFailedResult();
		try {
			if(item != null) {
				StringBuffer totalSql = new StringBuffer("");
				totalSql.append("select count(a.id) from ReceiveFailed as a where 1 = 1");
				buildSql(totalSql, item);

				Long total = longValue(totalSql.toString());

				result.setTotal(total.intValue());

				StringBuffer recordsSql = new StringBuffer("");
				recordsSql.append("select a from ReceiveFailed as a where 1 = 1");
				buildSql(recordsSql, item);
				recordsSql.append(" order by a.fsendtime desc");

				List<ReceiveFailed> list = list(recordsSql.toString(), item.getFirstResult(), item.getMaxResults());

				if(list != null && list.size() > 0) {
					List<ReceiveFailedItem> items = new ArrayList<>();
					for(ReceiveFailed e : list) {
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
	public void buildSql(StringBuffer sql, ReceiveFailedItem item) {
		String fcontent = item.getFcontent();
		String[] fmobiles = item.getFmobiles();
		Date fsendtimeStart = item.getFsendtimeStart();
		Date fsendtimeEnd = item.getFsendtimeEnd();
		Integer deleted = item.getDeleted();

		if(!StringUtils.isEmpty(fcontent)) {
			sql.append(" and a.fcontent like '%" + fcontent + "%'");
		}
		if(fmobiles != null && fmobiles.length > 0) {
			sql.append(" and a.fmobile in (" + Utils.arrToStr(fmobiles) + ")");
		}

		if(fsendtimeStart != null) {
			sql.append(" and a.fsendtime >= todate('" + Utils.sdf.format(fsendtimeStart) + "')");
		}

		if(fsendtimeEnd != null) {
			sql.append(" and a.fsendtime <= todate('" + Utils.sdf.format(fsendtimeEnd) + "')");
		}

		if(deleted != null) {
			sql.append(" and a.deleted = " + deleted);
		}
	}

	@Override
	public ReceiveFailedResult delete(Integer[] idArr) {
		ReceiveFailedResult result = new ReceiveFailedResult();
		try {
			if(idArr != null && idArr.length > 0) {
				Long l = executeUpdate("update ReceiveFailed set deleted = 1 where id in (" + Utils.arrToStr(idArr) + ")");
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
	public ReceiveFailedResult physicalDelete(Integer[] idArr) {
		ReceiveFailedResult result = new ReceiveFailedResult();
		try {
			if(idArr != null && idArr.length > 0) {
				List<ReceiveFailed> list = list("select a from ReceiveFailed as a where a.id in (" + Utils.arrToStr(idArr) + ")", null, null);
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
	public List<ReceiveFailed> list(String sql, Integer firstResult, Integer maxResults) {
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