package com.lauvan.apps.communication.smsmanagement.model;

/**
 *短信收信箱model类
 * */
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_bus_moblie_rev", pk = "mobileid")
public class T_Bus_Moblie_Rev extends Model<T_Bus_Moblie_Rev> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_Moblie_Rev	dao					= new T_Bus_Moblie_Rev();

	//获取收件箱列表
	public Page<Record> getPageList(Integer pageSize, Integer pageNumber, String swhere) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select r.* "
					+",case when length(r.content)>25 then substr(r.content,1,25)||'...' else r.content end as simplecont";
					//+",case when length(r.mobile)>24 then substr(r.mobile,1,23)||'...' else r.mobile end as simplephone"
					//+",case when length(r.mobname)>20 then substr(r.mobname,1,20)||'...' else r.mobname end as simplepname";
		StringBuffer str = new StringBuffer();
		str.append(" from (select s.*,decode(s.mobile,null,null," 
				+"decode((select name from t_bus_linkman where tel = s.mobile),null,"
				+ "(select add_name from vw_address  where add_code=" 
				+ "(select max(add_code) from vw_address v  where  v.telphone=s.mobile or v.worknum=s.mobile))"
				+",(select name from t_bus_linkman where tel = s.mobile))"
				+") as mobname ");
		str.append("  from  t_bus_moblie_rev s ) r ");
		str.append("where 1=1 ");
		if(swhere != null && !"".equals(swhere)) {
			str.append(swhere);
		}
		str.append(" order by r.mo_time desc");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}

	//根据id删除收件箱列表
	public boolean deleteByIDS(String ids) {
		String sql = "delete from t_bus_moblie_rev where mobileid in (" + ids + ") ";
		return Db.update(sql) > 0;
	}

	//根据ID获取收件信息
	public Record getBYid(String id) {
		String sql = "select s.*,decode(s.mobile,null,null," + "(select add_name from vw_address  where add_code=" + "(select max(add_code) from vw_address v where  v.telphone=s.mobile or v.worknum=s.mobile))) as mobname " + " from  t_bus_moblie_rev s  where s.mobileid=" + id;
		return Db.findFirst(sql);
	}

	public void insert(T_Bus_Moblie_Rev r) {
		r.set("mobileid", AutoId.nextval(r));
		r.set("state", "0");
		r.save();
	}

	//根据sm_id查询回复信息
	public List<Record> getListBySMID(String sm_id) {
		String sql = "select s.*,decode(s.mobile,null,null,"
				+"decode((select name from t_bus_linkman where tel = s.mobile),null,"
				+ "(select add_name from vw_address  where add_code=" 
				+ "(select max(add_code) from vw_address v where  v.telphone=s.mobile or v.worknum=s.mobile))"
				+",(select name from t_bus_linkman where tel = s.mobile))"
				+") as mobname  from  t_bus_moblie_rev s  where s.sm_id='" + sm_id + "'";
		return Db.find(sql);
	}
	
	//根据流水号查询是否关联事件，若是，则插入到市领导审批中
	public void moRelatEvent(String smid,String content,String phone,String motime){
		String sql = "select wmsys.wm_concat(eventid) as eid  from (select m.eventid from t_bus_moblie_to m where m.sm_id='"
					+smid+"' union select s.eventid from t_bus_smssendrd s where s.smsid='"+smid+"')";
		String eids = Db.queryStr(sql);
		if(eids!=null && !"".equals(eids)){
			//查询回复人名称
			sql = "select * from t_bus_linkman where tel='"+phone+"'";
			Record r = Db.findFirst(sql);
			String name = phone;
			if(r!=null){
				name = r.getStr("name");
			}
			String pscontent = name+" ["+motime+"]："+content;
			//更新市领导审批
			sql = "select wmsys.wm_concat(id) as eid_no  from t_bus_eventinfo where ev_ships is null and id in ("+eids+")";
			String eids_no = Db.queryStr(sql);
			String updsql = "update t_bus_eventinfo set ev_ships=ev_ships||chr(13)||chr(10)||'"+pscontent+"' where id in ("+eids+")";
			if(eids_no!=null && !"".equals(eids_no)){
				sql = "update t_bus_eventinfo set ev_ships='"+pscontent+"' where id in ("+eids_no+")";
				Db.update(sql);
				updsql = updsql + " and id not in ("+eids_no+")";
			}
			Db.update(updsql);
		}
	}
	
	public Number  getUnReadNum(){
		String sql = "select count(*) from t_bus_moblie_rev where state='0'";
		return Db.queryNumber(sql);
	}
	
	public String  getmaxNum(){
		String sql = "select max(mobileid) from t_bus_moblie_rev";
		Number max = Db.queryNumber(sql);
		String r = "0";
		if(max!=null){
			r = max.toString();
		}
		return r;
	}
	
	public Number  getUnReadNum2(String state,String max){
		String sql = "select count(*) from t_bus_moblie_rev where 1=1 ";
		if(state!=null && !"".equals(state)){
			sql = sql + " and state='"+state+"'";
		}
		sql = sql + " and mobileid>"+max;
		return Db.queryNumber(sql);
	}
}
