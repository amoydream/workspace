package com.lauvan.apps.communication.smsmanagement.model;

/**
 * 短信发件箱model类
 * */
import java.util.Date;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_moblie_to", pk = "mobileid")
public class T_Bus_Moblie_To extends Model<T_Bus_Moblie_To> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_Moblie_To	dao					= new T_Bus_Moblie_To();

	//获取发件箱列表
	public Page<Record> getPageList(Integer pageSize, Integer pageNumber, String swhere) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select s.*,r.rpt_desc,e.ev_name ";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_eventinfo e right join t_bus_moblie_to s on s.eventid=e.id ");
		str.append(" left join t_bus_moblie_rpt r on s.sm_id=r.sm_id and s.mobile=r.mobile ");
		str.append("where 1=1 ");
		if(swhere != null && !"".equals(swhere)) {
			str.append(swhere);
		}
		str.append(" order by s.send_time desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	//获取发件箱列表（根据流水号归类）
	public Page<Record> getSmIdPageList(Integer pageSize, Integer pageNumber, String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select s.*,e.ev_name,e.ev_state,decode(r.rcount,null,null,r.sm_id) as repsmid,decode(rec.reccount,null,null,rec.sm_id) as recsmid "
					+",case when length(s.content)>20 then substr(s.content,1,20)||'...' else s.content end as simplecont"
					+",case when length(s.phone)>24 then substr(s.phone,1,23)||'...' else s.phone end as simplephone"
					+",case when length(s.pname)>20 then substr(s.pname,1,20)||'...' else s.pname end as simplepname";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_eventinfo e right join ");
		str.append("(select s1.*,t.phone,t.pname from t_bus_moblie_to s1, ");
		str.append("(select sm_id, to_char(wmsys.wm_concat(mobile)) as phone,to_char(wmsys.wm_concat(mobname)) as pname,max(mobileid) as mobileid");
		str.append(" from t_bus_moblie_to group by sm_id) t where s1.mobileid=t.mobileid and s1.sm_id=t.sm_id) s on s.eventid=e.id ");
		str.append(" left join (select sm_id,count(repeatid) as rcount from t_bus_moblie_rpt group by sm_id) r on r.sm_id=s.sm_id ");
		str.append(" left join (select sm_id,count(mobileid) as reccount from t_bus_moblie_rev  group by sm_id) rec on rec.sm_id=s.sm_id ");
		str.append("where 1=1 ");
		if(swhere != null && !"".equals(swhere)) {
			str.append(swhere);
		}
		str.append(" order by s.send_time desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	//根据id删除发件箱列表
	public boolean deleteByIDS(String ids, String user_id) {
		String sql = "delete from t_bus_moblie_to where mobileid in (" + ids + ") and user_id=" + user_id;
		return Db.update(sql) > 0;
	}

	public boolean insert(T_Bus_Moblie_To t) {
		t.set("mobileid", AutoId.nextval(t));
		t.set("send_time", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return t.save();
	}

	public T_Bus_Moblie_To getBySmId(String sm_id, String mobile) {
		String sql = "select * from T_Bus_Moblie_To where sm_id='" + sm_id + "' and mobile='" + mobile + "'";
		return dao.findFirst(sql);
	}

	//根据ids和 事件ID建立关联关系
	public boolean relaEvent(String ids, String eventid) {
		String sql = "update T_Bus_Moblie_To t set t.eventid=" + eventid + " where t.mobileid in (" + ids + ")";
		return Db.update(sql) > 0;
	}
	//根据smid和 事件ID建立关联关系
	public boolean relaEventSmid(String smid, String eventid) {
		String sql = "update T_Bus_Moblie_To t set t.eventid=" + eventid + " where t.sm_id in('" + smid.replaceAll(",", "','") + "')";
		return Db.update(sql) > 0;
	}
	//根据smid和 事件ID建立关联关系
	public String getIdsBySmid(String smid) {
		String sql = "select to_char(wmsys.wm_concat(mobileid)) from t_bus_moblie_to where sm_id in('" + smid.replaceAll(",", "','")+ "')";
		String str = Db.queryStr(sql);
		if(str==null){
			str = "";
		}
		return str;
	}
	public T_Bus_Moblie_To getSendBySmId(String sm_id, String mobile) {
		String sql = "select * from t_bus_smssendrd where smsid='" + sm_id + "' and callno='" + mobile + "'";
		Record r = Db.findFirst(sql);
		if(r!=null){
			T_Bus_Moblie_To t = new T_Bus_Moblie_To();
			t.set("content", r.getStr("smsdata"));
			t.set("eventid", r.get("eventid"));
			t.set("send_time", r.get("sendtime"));
			t.set("mobile", r.get("callno"));
			t.set("mobname", r.get("callname"));
			return t;
		}else{
			return null;
		}
		
	}
	//根据流水号获取接收人信息记录
	public Record getBySmId(String sm_id) {
		String sql = "select * from (select sm_id, wmsys.wm_concat(mobile) as phone,wmsys.wm_concat(mobname) as pname"
					+" from t_bus_moblie_to group by sm_id) where sm_id='" + sm_id + "'" ;
		Record r = Db.findFirst(sql);
		if(r==null){
			//查询反馈短信表
			sql = "select * from (select smsid as sm_id, wmsys.wm_concat(callno) as phone,wmsys.wm_concat(callname) as pname"
					+"from t_bus_smssendrd group by smsid) where sm_id='"+sm_id+"'";
			r = Db.findFirst(sql);
		}
		return r;
	}
	
	public List<Record> getListBySmid(String sm_id){
		String sql = "select t.*,t.mobile as phonenum,t.mobname as smsname from"
				+" t_bus_moblie_to t where t.sm_id='" + sm_id + "'" ;
		List<Record> rlist = Db.find(sql);
		if(rlist==null || rlist.size()==0){
			sql = "select t.*,t.callno as phonenum,t.callname as smsname from "
					+" t_bus_smssendrd t where t.sm_id='"+sm_id+"'";
			rlist = Db.find(sql);
		}
		return rlist;
	}
	
	//根据smid和 事件ID建立关联关系
		public boolean unrelaEventSmid(String smid) {
			String sql = "update T_Bus_Moblie_To t set t.eventid = null  where t.sm_id in('" + smid.replaceAll(",", "','") + "')";
			return Db.update(sql) > 0;
		}
}
