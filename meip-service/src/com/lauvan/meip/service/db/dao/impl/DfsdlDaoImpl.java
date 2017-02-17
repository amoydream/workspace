package com.lauvan.meip.service.db.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.lauvan.meip.service.db.dao.CommonDao;
import com.lauvan.meip.service.db.dao.DfsdlDao;
import com.lauvan.meip.service.db.entity.Dfsdl;
import com.lauvan.meip.service.db.entity.DfsdlSeq;
import com.lauvan.meip.service.db.entity.MsgIdSeq;
import com.lauvan.meip.service.item.DfsdlItem;
import com.lauvan.meip.service.item.DfsdlResult;
import com.lauvan.meip.service.util.Utils;

@Repository("dfsdlDao")
@SuppressWarnings("unchecked")
public class DfsdlDaoImpl extends CommonDao<Dfsdl, DfsdlItem> implements DfsdlDao {
	@Override
	public DfsdlResult send(DfsdlItem item) {
		DfsdlResult result = new DfsdlResult();
		try {
			Integer msgid = intValue("select max(msgid) from MsgIdSeq");
			save(new MsgIdSeq());
			Integer dfsdlid = null;
			String[] mobiles = item.getMobiles();
			for(String mobile : mobiles) {
				dfsdlid = intValue("select max(dfsdlid) from DfsdlSeq");
				Dfsdl e = new Dfsdl();
				e.setId(dfsdlid);
				e.setContent(item.getContent());
				e.setDeadtime(item.getDeadtime());
				e.setDeleted(Integer.valueOf(0));
				e.setEid(item.getEid());
				e.setMobile(mobile);
				e.setMsgid(msgid);
				e.setPassword(item.getPassword());
				e.setStatus(Integer.valueOf(0));
				e.setUserid(item.getUserid());
				e.setUserport(item.getUserport());
				save(e);
				save(new DfsdlSeq());
			}
		} catch(Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}

		result.setMsg("信息已提交");
		result.setSuccess(true);

		return result;
	}

	@Override
	public DfsdlResult resend(Integer[] idArr) {
		DfsdlResult result = new DfsdlResult();
		try {
			if(idArr != null && idArr.length > 0) {
				Long l = executeUpdate("update Dfsdl set status = 0 where id in (" + Utils.arrToStr(idArr) + ")");

				if(l != null) {
					result.setSuccess(true);
					result.setMsg("信息已提交");
				} else {
					result.setSuccess(false);
					result.setMsg("短信服务异常: 信息提交失败");
				}
			} else {
				result.setMsg("无数据");
			}
		} catch(Exception e) {
			result.setSuccess(false);
			result.setMsg("短信服务异常: " + e.getMessage());
		}

		return result;
	}

	@Override
	public DfsdlResult getDfsdlById(Integer id) {
		DfsdlResult result = new DfsdlResult();
		DfsdlItem item = null;
		try {
			Dfsdl e = get(Dfsdl.class, id);
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
	public DfsdlItem entityToItem(Dfsdl entity) {
		if(entity != null) {
			DfsdlItem item = new DfsdlItem();
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
	public DfsdlResult getALLDfsdl() {
		DfsdlResult result = new DfsdlResult();
		try {
			List<Dfsdl> list = super.getAll(Dfsdl.class);
			if(list != null && list.size() > 0) {
				List<DfsdlItem> items = new ArrayList<>();
				for(Dfsdl e : list) {
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
	public DfsdlResult getDfsdlByItem(DfsdlItem item) {
		DfsdlResult result = new DfsdlResult();
		try {
			if(item != null) {
				StringBuffer sql = new StringBuffer("");
				sql.append("select a from Dfsdl as a where 1 = 1");
				buildSql(sql, item);
				sql.append(" order by a.msgid desc");
				List<Dfsdl> list = find(sql.toString());
				if(list != null && list.size() > 0) {
					List<DfsdlItem> items = new ArrayList<>();
					for(Dfsdl e : list) {
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
	public DfsdlResult getDfsdlPage(DfsdlItem item) {
		DfsdlResult result = new DfsdlResult();
		try {
			if(item != null) {
				StringBuffer totalSql = new StringBuffer("");
				totalSql.append("select count(a.id) from Dfsdl as a where 1 = 1");
				buildSql(totalSql, item);

				Long total = longValue(totalSql.toString());

				result.setTotal(total.intValue());

				StringBuffer recordsSql = new StringBuffer("");
				recordsSql.append("select a from Dfsdl as a where 1 = 1");
				buildSql(recordsSql, item);
				recordsSql.append(" order by a.mobile desc");
				List<Dfsdl> list = list(recordsSql.toString(), item.getFirstResult(), item.getMaxResults());

				if(list != null && list.size() > 0) {
					List<DfsdlItem> items = new ArrayList<>();
					for(Dfsdl e : list) {
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
	public void buildSql(StringBuffer sql, DfsdlItem item) {
		String mobile = item.getMobile();
		String[] mobiles = item.getMobiles();
		String content = item.getContent();
		Integer status = item.getStatus();
		if(status == null) {
			status = Integer.valueOf(0);
		}
		Integer deleted = item.getDeleted();
		if(!StringUtils.isEmpty(mobile)) {
			sql.append(" and a.mobile like '%" + mobile + "%'");
		} else if(mobiles != null && mobiles.length > 0) {
			sql.append(" and a.mobile in (" + Utils.arrToStr(mobiles) + ")");
		}

		if(!StringUtils.isEmpty(content)) {
			sql.append(" and a.content like '%" + content + "%'");
		}

		if(status.intValue() == 0 || status.intValue() == 1) {
			sql.append(" and a.status = " + status);
		} else {
			sql.append(" and a.status <> 0 and a.status <> 1");
		}

		if(deleted != null) {
			sql.append(" and a.deleted = " + deleted);
		}
	}

	@Override
	public DfsdlResult delete(Integer[] idArr) {
		DfsdlResult result = new DfsdlResult();
		try {
			if(idArr != null && idArr.length > 0) {
				Long obj = executeUpdate("update Dfsdl set deleted = 1 where id in (" + Utils.arrToStr(idArr) + ")");

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
	public DfsdlResult physicalDelete(Integer[] idArr) {
		DfsdlResult result = new DfsdlResult();
		try {
			if(idArr != null && idArr.length > 0) {
				List<Dfsdl> list = list("select a from Dfsdl as a where a.deleted = 1 and a.id in (" + Utils.arrToStr(idArr) + ")", null, null);
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
	public List<Dfsdl> list(String sql, Integer firstResult, Integer maxResults) {
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