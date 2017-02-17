package com.lauvan.meip.service.db.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.lauvan.meip.service.db.dao.CommonDao;
import com.lauvan.meip.service.db.dao.MsgDao;
import com.lauvan.meip.service.db.entity.Msg;
import com.lauvan.meip.service.db.entity.MsgGroup;
import com.lauvan.meip.service.item.MsgItem;
import com.lauvan.meip.service.item.MsgResult;
import com.lauvan.meip.service.util.Utils;

@Repository("msgDao")
@SuppressWarnings("unchecked")
public class MsgDaoImpl extends CommonDao<Msg, MsgItem> implements MsgDao {
	@Override
	public MsgResult getMsgById(Integer id) {
		MsgResult result = new MsgResult();
		MsgItem item = null;
		try {
			Msg e = get(Msg.class, id);
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
	public MsgItem entityToItem(Msg entity) {
		if(entity != null) {
			MsgItem item = new MsgItem();
			item.setContent(entity.getContent());
			item.setDeleted(entity.getDeleted());
			item.setId(entity.getId());
			item.setMobile(entity.getMobile());
			item.setMsgtime(entity.getMsgtime());
			item.setMsgtype(entity.getMsgtype());
			return item;
		}
		return null;
	}

	public MsgItem msgGroupToItem(MsgGroup entity) {
		if(entity != null) {
			MsgItem item = new MsgItem();
			item.setContent(entity.getContent());
			item.setDeleted(entity.getDeleted());
			item.setId(entity.getId());
			item.setMobile(entity.getMobile());
			item.setMsgtime(entity.getMsgtime());
			item.setMsgtype(entity.getMsgtype());
			item.setCount(entity.getCount());
			return item;
		}
		return null;
	}

	@Override
	public MsgResult getALLMsg() {
		MsgResult result = new MsgResult();
		try {
			List<Msg> list = super.getAll(Msg.class);
			if(list != null && list.size() > 0) {
				List<MsgItem> items = new ArrayList<>();
				for(Msg e : list) {
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
	public MsgResult getMsgByItem(MsgItem item) {
		MsgResult result = new MsgResult();
		try {
			if(item != null) {
				StringBuffer sql = new StringBuffer("");
				sql.append("select a from Msg as a where 1 = 1");
				buildSql(sql, item);
				List<Msg> list = find(sql.toString());
				if(list != null && list.size() > 0) {
					List<MsgItem> items = new ArrayList<>();
					for(Msg e : list) {
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
	public MsgResult getMsgPage(MsgItem item) {
		MsgResult result = new MsgResult();
		try {
			if(item != null) {
				StringBuffer totalSql = new StringBuffer("");
				totalSql.append("select count(a.id) from Msg as a where 1 = 1");
				buildSql(totalSql, item);
				Long total = longValue(totalSql.toString());

				result.setTotal(total.intValue());

				StringBuffer recordsSql = new StringBuffer("");
				recordsSql.append("select a from Msg as a where 1 = 1");
				buildSql(recordsSql, item);

				List<Msg> list = list(recordsSql.toString(), item.getFirstResult(), item.getMaxResults());

				if(list != null && list.size() > 0) {
					List<MsgItem> items = new ArrayList<>();
					for(Msg e : list) {
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
	public MsgResult getMsgGroupPage(MsgItem item) {
		MsgResult result = new MsgResult();
		try {
			if(item != null) {
				StringBuffer totalSql = new StringBuffer("");
				totalSql.append("select count(a.id) from MsgGroup as a where 1 = 1");
				buildSql(totalSql, item);
				Long total = longValue(totalSql.toString());

				if(total != null) {
					result.setTotal(total.intValue());
				} else {
					result.setTotal(Integer.valueOf(0));
				}

				StringBuffer recordsSql = new StringBuffer("");
				recordsSql.append("select a from MsgGroup as a where 1 = 1");
				buildSql(recordsSql, item);
				recordsSql.append(" order by a.msgtime desc");

				List<MsgGroup> list = listGroup(recordsSql.toString(), item.getFirstResult(), item.getMaxResults());

				if(list != null && list.size() > 0) {
					List<MsgItem> items = new ArrayList<>();
					for(MsgGroup e : list) {
						items.add(msgGroupToItem(e));
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
	public void buildSql(StringBuffer sql, MsgItem item) {
		String mobile = item.getMobile();
		String[] mobiles = item.getMobiles();
		String content = item.getContent();
		Date msgtimeStart = item.getMsgtimeStart();
		Date msgtimeEnd = item.getMsgtimeEnd();
		Integer deleted = item.getDeleted();

		if(!StringUtils.isEmpty(mobile)) {
			sql.append(" and a.mobile like '%" + mobile + "%'");
		} else if(mobiles != null && mobiles.length > 0) {
			sql.append(" and a.mobile in (" + Utils.arrToStr(mobiles) + ")");
		}

		if(!StringUtils.isEmpty(content)) {
			sql.append(" and a.content like '%" + content + "%'");
		}

		if(msgtimeStart != null) {
			sql.append(" and a.msgtime >= todate('" + Utils.sdf.format(msgtimeStart) + "')");
		}

		if(msgtimeEnd != null) {
			sql.append(" and a.msgtime <= todate('" + Utils.sdf.format(msgtimeEnd) + "')");
		}

		if(deleted != null) {
			sql.append(" and a.deleted = " + deleted);
		}
	}

	@Override
	public List<Msg> list(String sql, Integer firstResult, Integer maxResults) {
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

	public List<MsgGroup> listGroup(String sql, Integer firstResult, Integer maxResults) {
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