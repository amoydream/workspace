package com.lauvan.apps.event.model;

/**
 * 事件model类
 * */
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_eventinfo", pk = "id")
public class T_Bus_EventInfo extends Model<T_Bus_EventInfo> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_EventInfo	dao					= new T_Bus_EventInfo();

	public void insert(T_Bus_EventInfo t) {
		Number id = Db.queryBigDecimal("SELECT S_EVENTINFO.nextval FROM DUAL");
		t.set("id", id);
		t.set("marktime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
	}

	public boolean deleteByIDs(String ids) {
		String sql = "delete from t_bus_eventinfo where id in (" + ids + ")";
		return Db.update(sql) > 0;
	}

	public List<T_Bus_EventInfo> getListByIds(String ids) {
		String sql = "select * from t_bus_eventinfo where id in (" + ids + ")";
		return dao.find(sql);
	}

	//查询ids的状态
	public boolean isStatus(String ids, String status, String uid) {
		boolean flag = true;
		String sql = "select * from t_bus_eventinfo where id in (" + ids + ") ";
		if(uid != null && !"".equals(uid)) {
			sql = sql + " and user_id<> " + uid;
		}
		if(status != null && !"".equals(status)) {
			sql = sql + " and ev_status not in (" + status + ")";
		}
		T_Bus_EventInfo t = dao.findFirst(sql);
		if(t != null) {
			flag = false;
		}
		return flag;
	}

	//根据用户id，时间，获取当天的事件
	public List<T_Bus_EventInfo> getlistbyut(Number userid, String time) {
		String sql = "select * from t_bus_eventinfo where user_id=" + userid + " and marktime>='" + time + " 00:00:00' and marktime<='" + time + " 23:59:59'";
		return T_Bus_EventInfo.dao.find(sql);
	}
	
	//根据值班时间，获取在时间段内的事件
	public List<T_Bus_EventInfo> getListByTime(String startDate,String endDate){
		String sql = "select ei.* from t_bus_eventinfo ei where ei.ev_type not in(07) and ei.marktime between '" + startDate + "' and '" + endDate + "'";
		return T_Bus_EventInfo.dao.find(sql);
	}

	//根据事件ids和事件名称查询事件
	public Page<Record> geteventlist(Integer pageSize, Integer pageNumber, String eventids, String ename) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select *";
		StringBuffer str = new StringBuffer();
		str.append("  from t_bus_eventinfo e where 1=1");
		if(eventids != null && !"".equals(eventids)) {
			str.append(" and e.id in(").append(eventids).append(")");
		} else {
			str.append(" and 1=0");
		}
		if(ename != null && !"".equals(ename)) {
			str.append(" and e.ev_name like '%").append(ename).append("%'");
		}
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}

	//获取所有事件
	public Page<Record> getalleventlist(Integer pageSize, Integer pageNumber, String ename) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select *";
		StringBuffer str = new StringBuffer();
		str.append("  from t_bus_eventinfo e where 1=1");
		if(ename != null && !"".equals(ename)) {
			str.append(" and e.ev_name like '%").append(ename).append("%'");
		}
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}

	public Record getByid(String id) {
		String sql = "select t.* ,decode(t.ev_type,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.ev_type" + " Start With a.p_acode='EVTP' Connect By  Prior a.id = a.sup_id  ))  as evtype_name" + ",decode(t.ev_type,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.ev_level" + " Start With a.p_acode='EVLV' Connect By  Prior a.id = a.sup_id  ))  as evlevel_name" + " from t_bus_eventinfo t where id=" + id;
		return Db.findFirst(sql);
	}

	/**
	 * 根据事件名称获取事件详情
	 * */
	public List<Record> getListByName(String name, String flag) {
		String sql = "select t.* ,decode(t.ev_type,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.ev_type" + " Start With a.p_acode='EVTP' Connect By  Prior a.id = a.sup_id  ))  as evtype_name" + ",decode(t.ev_type,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.ev_level" + " Start With a.p_acode='EVLV' Connect By  Prior a.id = a.sup_id  ))  as evlevel_name" + ", decode(t.ev_reportmode,null,'',(select a.p_name from t_sys_parameter a," + "t_sys_parameter p where p.id=a.sup_id and p.p_acode='EVRP' and a.p_acode=t.ev_reportmode)) as reportmode_name" + ",decode(t.occurarea,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.occurarea" + " Start With a.p_acode='EVQY' Connect By  Prior a.id = a.sup_id  ))  as evqy_address" + " from t_bus_eventinfo t where 1=1 ";
		if(flag == null || "".equals(flag)) {
			sql = sql + " and t.ev_longitude is not null and t.ev_latitude is not null ";
		}
		if(name != null && !"".equals(name)) {
			sql = sql + " and t.ev_name like '%" + name + "%' ";
		}
		return Db.find(sql);
	}

	public Page<Record> getPageByDate(Integer pageSize, Integer pageNumber, String sdate, String edate, String occurarea) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select e.* ,p.p_name as areaname ";
		StringBuffer sb = new StringBuffer("from t_bus_eventinfo e,(select * from t_sys_parameter start with p_acode ='EVQY' connect by prior id = sup_id) p  where e.occurarea=p.p_acode and e.ev_state = '00X' ");
		if(StringUtils.isNotBlank(sdate)) {
			sb.append(" and substr(e.ev_date,0,10)>='").append(sdate).append("'");
		}
		if(StringUtils.isNotBlank(edate)) {
			sb.append(" and substr(e.ev_date,0,10) <= '").append(edate).append("'");
		}
		if(StringUtils.isNotBlank(occurarea)) {
			sb.append(" and p.p_name ='").append(occurarea).append("'");
		}
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}

	/**
	 *
	 * @param yearmonth 事件发生年月
	 * @param sumColumn 分组字段
	 * @return
	 */
	public List<Record> groupByEventArea(String yearmonth, String sumColumn) {
		StringBuffer sb = new StringBuffer("select decode(occurarea, null, '',(select p.p_name from t_sys_parameter p where t.occurarea=p.p_acode start with p.p_acode ='EVQY' connect by prior p.id = p.sup_id )) as occurarea");
		if(StringUtils.isNotBlank(sumColumn)) {
			sb.append(", sum(").append(sumColumn).append(") as total");
		}
		sb.append(" from ( select  to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'yyyy-MM') as month ,e.*  from t_bus_eventinfo e ) t where t.ev_state='00X' ");
		if(StringUtils.isNotBlank(sumColumn)) {
			sb.append(" and ").append(sumColumn).append(" is not null ");
		}
		if(StringUtils.isNotBlank(yearmonth)) {
			sb.append(" and t.month ='").append(yearmonth).append("'");
		}
		sb.append(" group by occurarea");
		return Db.find(sb.toString());
	}

	/**
	 *
	 * @param sdate  开始时间
	 * @param edate 结束时间
	 * @param sumColumn 统计字段
	 * @return
	 */
	public List<Record> groupByMonth(String sdate, String edate, String sumColumn) {
		StringBuffer sb = new StringBuffer("select month ");
		if(StringUtils.isNotBlank(sumColumn)) {
			sb.append(", sum(").append(sumColumn).append(") as total");
		}
		sb.append(" from ( select  to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'yyyy-MM') as month ,e.*  from t_bus_eventinfo e where e.ev_state='00X' ");
		if(StringUtils.isNotBlank(sumColumn)) {
			sb.append(" and ").append(sumColumn).append(" is not null");
		}
		if(StringUtils.isNotBlank(sdate)) {
			sb.append(" and substr(e.ev_date,0,10)>='").append(sdate).append("'");
		}
		if(StringUtils.isNotBlank(edate)) {
			sb.append(" and substr(e.ev_date,0,10) <= '").append(edate).append("'");
		}
		sb.append(" ) group by month order by month");
		return Db.find(sb.toString());
	}

	/**
	 * 用于事件统计分析模块
	 * @param sdate 开始时间
	 * @param edate 结束时间
	 * @param xy 分组字段
	 * @return
	 */
	public List<Record> groupBy(String sdate, String edate, String xy) {
		StringBuffer sql = new StringBuffer("select ");
		StringBuffer sb = new StringBuffer(" (select e.*, to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'yyyy') as year ");
		//sb.append("to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'Q') as quarter, to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'mm') as mouth from t_bus_eventinfo e) e2 where ev_state='00X' ");
		if(StringUtils.isNotBlank(sdate) && StringUtils.isNotBlank(edate)) {
			if(sdate.substring(0, 4).equals(edate.substring(0, 4))) {
				sb.append(" ,to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'Q') as quarter, to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'mm') as month ");
			} else {
				sb.append(" ,(substr(e.ev_date,0,4) ||'年' ||to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'Q') ||'季度') as quarter, (substr(e.ev_date,0,4) ||'-' ||to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'mm')) as month ");
			}
		}
		sb.append(" from t_bus_eventinfo e) e2 where ev_state='00X'");
		if(StringUtils.isNotBlank(sdate)) {
			sb.append(" and substr(ev_date,0,10)>='").append(sdate).append("'");
		}
		if(StringUtils.isNotBlank(edate)) {
			sb.append(" and substr(ev_date,0,10) <= '").append(edate).append("'");
		}
		if(StringUtils.isNotBlank(xy)) {
			if("ev_level".equals(xy) || "ev_type".equals(xy) || "occurarea".equals(xy) || "ev_reportmode".equals(xy)) {
				String p_acode = "ev_level".equals(xy) ? "EVLV" : "ev_type".equals(xy) ? "EVTP" : "occurarea".equals(xy) ? "EVQY" : "EVRP";
				sql.append("decode(").append(xy).append(", null,'', (select p.p_name from t_sys_parameter p where e2.");
				sql.append(xy).append(" = p.p_acode start with p.p_acode = '").append(p_acode).append("' connect by prior p.id = p.sup_id )) as xy from");
			} else {
				sql.append(xy).append(" as xy from");
			}
			sb.append(" group by ").append(xy);

			if("year".equals(xy) || "quarter".equals(xy) || "month".equals(xy)) {
				sb.append(" order by ").append(xy);
			}
		}

		return Db.find(sql.toString() + sb.toString());
	}

	/**
	 * 用于事件统计分析模块
	 * @param sdate 开始日期
	 * @param edate  结束日期
	 * @param xval x维度
	 * @param yval y维度
	 * @param dlval 度量
	 * @return
	 */
	public List<Record> statsEvent(String sdate, String edate, String xval, String yval, String dlval) {
		StringBuffer sql = new StringBuffer();
		;
		StringBuffer sb = new StringBuffer(" (select e.*, to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'yyyy') as year ");
		if(StringUtils.isNotBlank(sdate) && StringUtils.isNotBlank(edate)) {
			if(sdate.substring(0, 4).equals(edate.substring(0, 4))) {
				sb.append(",to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'Q') as quarter, to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'mm') as month");
			} else {
				sb.append(",(substr(e.ev_date,0,4) ||'年' ||to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'Q')||'季度') as quarter, (substr(e.ev_date,0,4) ||'-' ||to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'mm')) as month ");
			}
		}

		sb.append(" from t_bus_eventinfo e ) e2 where ev_state='00X' ");
		if(StringUtils.isNotBlank(sdate)) {
			sb.append(" and substr(ev_date,0,10)>='").append(sdate).append("'");
		}
		if(StringUtils.isNotBlank(edate)) {
			sb.append(" and substr(ev_date,0,10) <= '").append(edate).append("'");
		}

		if(StringUtils.isBlank(xval) || StringUtils.isBlank(yval) || StringUtils.isBlank(dlval)) {
			sql.append("select * from ");

		} else {
			sb.append(" group by ").append(yval).append(",").append(xval);
			sql.append("select ");
			if("ev_level".equals(yval) || "ev_type".equals(yval) || "occurarea".equals(yval) || "ev_reportmode".equals(yval)) {
				String p_acode = "ev_level".equals(yval) ? "EVLV" : "ev_type".equals(yval) ? "EVTP" : "occurarea".equals(yval) ? "EVQY" : "EVRP";
				sql.append("decode(").append(yval).append(", null,'', (select p.p_name from t_sys_parameter p where e2.");
				sql.append(yval).append(" = p.p_acode start with p.p_acode = '").append(p_acode).append("' connect by prior p.id = p.sup_id )) as yval,");
			} else {
				sql.append(yval).append(" as yval ,");
			}
			if("ev_level".equals(xval) || "ev_type".equals(xval) || "occurarea".equals(xval) || "ev_reportmode".equals(xval)) {
				String p_acode = "ev_level".equals(xval) ? "EVLV" : "ev_type".equals(xval) ? "EVTP" : "occurarea".equals(xval) ? "EVQY" : "EVRP";
				sql.append("decode(").append(xval).append(", null,'', (select p.p_name from t_sys_parameter p where e2.");
				sql.append(xval).append(" = p.p_acode start with p.p_acode = '").append(p_acode).append("' connect by prior p.id = p.sup_id )) as xval,");
			} else {
				sql.append(xval).append(" as xval, ");
			}
			if("count".equals(dlval)) {
				sql.append("count(1) as total from ");
			} else {
				sql.append("sum(").append(dlval).append(") as total from ");
			}

		}

		return Db.find(sql.toString() + sb.toString());
	}

	public List<Record> groupByEventArea2(String yearmonth) {
		StringBuffer sb = new StringBuffer("select decode(ev_type, null, '',(select p.p_name from t_sys_parameter p where t.ev_type=p.p_acode start with p.p_acode ='EVTP' connect by prior p.id = p.sup_id )) as ev_type, count(*) as total");
		sb.append(" from ( select  to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'yyyy-MM') as month ,e.*  from t_bus_eventinfo e ) t where t.ev_state='00X' ");
		if(StringUtils.isNotBlank(yearmonth)) {
			sb.append(" and t.month ='").append(yearmonth).append("'");
		}
		sb.append(" group by ev_type");
		return Db.find(sb.toString());
	}

	public List<Record> groupByMonth2(String sdate, String edate) {
		StringBuffer sb = new StringBuffer("select month, count(*) as total");
		sb.append(" from ( select  to_char(to_date(e.ev_date, 'yyyy-MM-dd hh24:mi:ss'), 'yyyy-MM') as month ,e.*  from t_bus_eventinfo e where e.ev_state='00X' ");
		if(StringUtils.isNotBlank(sdate)) {
			sb.append(" and substr(e.ev_date,0,10)>='").append(sdate).append("'");
		}
		if(StringUtils.isNotBlank(edate)) {
			sb.append(" and substr(e.ev_date,0,10) <= '").append(edate).append("'");
		}
		sb.append(" ) group by month order by month");
		return Db.find(sb.toString());
	}

	public Page<Record> getPageByDate2(Integer pageSize, Integer pageNumber, String sdate, String edate, String evtype) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select e.* ,p.p_name as typename ";
		StringBuffer sb = new StringBuffer("from t_bus_eventinfo e,(select * from t_sys_parameter start with p_acode ='EVTP' connect by prior id = sup_id) p  where e.ev_type=p.p_acode ");
		if(StringUtils.isNotBlank(sdate)) {
			sb.append(" and substr(e.ev_date,0,10)>='").append(sdate).append("'");
		}
		if(StringUtils.isNotBlank(edate)) {
			sb.append(" and substr(e.ev_date,0,10) <= '").append(edate).append("'");
		}
		if(StringUtils.isNotBlank(evtype)) {
			sb.append(" and p.p_name ='").append(evtype).append("'");
		}
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}
	
	public List<Record> getEventList(String ids,String model){
		String sql = "select ei.ev_name,ei.ev_reportdate,ei.ev_reporttel,(select p1.p_name from t_sys_parameter p1,t_sys_parameter p2 where "
				+ "p1.sup_id=p2.id and p1.p_acode=ei.EV_REPORTMODE and p2.p_acode='EVRP') as reportmode,"
				+ "(select p3.p_name from t_sys_parameter p3,t_sys_parameter p4 where p3.sup_id=p4.id and p3.p_acode=ei.ev_type and p4.p_acode='EVTP') as evtp"
				+ ",o.or_name,ars.p_name as area from t_bus_eventinfo ei left join t_bus_organ o on ei.organid = o.or_id left join (select a.* from t_sys_parameter a where "  
                + "a.p_acode<>'EVQY' Start With a.p_acode='EVQY' Connect By Prior a.id = a.sup_id) ars on ei.OCCURAREA=ars.p_acode where ei.ev_reportmode='"+model+"' and ei.id in("+ids+") order by ei.ev_date ASC";
		return Db.find(sql);
	} 
	
	public Map<String,List<Record>> getAllDairyEvent(String ids){
		Map<String,List<Record>> map = new LinkedHashMap<String,List<Record>>();
		List<Record> modellist = getAllEventReportModel(ids);
		for(int i=0;i<modellist.size();i++){
			String model = modellist.get(i).getStr("model");
			List<Record> list = getEventList(ids, model);
			map.put(model, list);
		}
		return map;
	}
	//所有接报类型
	public List<Record> getAllEventReportModel(String ids){
		String sql = "select distinct ei.ev_reportmode as model from t_bus_eventinfo ei where ei.id in("+ids+")";
		return Db.find(sql);
	}
		
	public List<Record> getEVtjList(String stime,String etime){
		String sql = "select t.*,decode(t.ev_bssx,null,null,(select p1.p_name from t_sys_parameter p1,t_sys_parameter p2"
					+" where p1.sup_id=p2.id and p2.p_acode='EVSX' and p1.p_acode=t.ev_bssx)) as bssx"
					+",case  when t.ev_bssx='001' then (t.zb*5+t.cy*4+t.zh*2+t.bc*1+t.yg*3+t.guops*5+shengps*4+ships*3+evimg*1)"
					+" when t.ev_bssx in ('002','003','004') then (t.zb*5+t.cy*4+t.zh*2+t.bc*1+t.yg*3+t.guops*5+t.shengps*4+t.ships*3+t.evimg*1)/2"
					+" else (t.zb*5+t.cy*4+t.zh*2+t.bc*1+t.yg*3+t.guops*5+shengps*4+ships*3+evimg*1)-10 end  as df from "
					+"(select decode(e.organid,null,(decode(e.occurcity,null,null,(select p_name from t_sys_parameter where p_acode=e.occurcity)))"
					+",(select or_name from t_bus_organ where or_id=e.organid)) as organname,e.ev_name as title,e.ev_bssx"
					+",decode(e.ev_usestatus,'001',1,0) zb,decode(e.ev_usestatus,'002',1,0) cy,decode(e.ev_usestatus,'003',1,0) zh"
					+",decode(e.ev_usestatus,'004',1,0) bc,decode(e.ev_usestatus,'005',1,0) yg,decode(e.ev_guops,null,0,1) guops"
					+",decode(e.ev_shengps,null,0,1) shengps,decode(e.ev_ships,null,0,1) ships,decode(e.ev_img,null,0,1) evimg"
					+",e.id from t_bus_eventinfo e  where  e.ev_date <='"+etime+"' and e.ev_date>='"+stime+"' and e.ev_state='00X' ) t where t.organname is not null order by organname desc";
		return Db.find(sql);
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNum,
			StringBuffer sqlWhere) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*,o.or_name";
		StringBuffer str = new StringBuffer();
		str.append(" from (select * from t_bus_eventinfo e where 1=1 and ");
		if(sqlWhere != null && !"".equals(sqlWhere)) {
			str.append(sqlWhere);
		}
		str.append(" )t left join t_bus_organ o on t.organid=o.or_id");
		str.append(" order by t.Ev_date desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
}
