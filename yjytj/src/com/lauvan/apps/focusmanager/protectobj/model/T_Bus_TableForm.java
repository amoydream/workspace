package com.lauvan.apps.focusmanager.protectobj.model;
import java.util.ArrayList;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.workflow.utils.CreateTable;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
@TableBind(name="t_bus_tableform",pk="id")
public class T_Bus_TableForm extends Model<T_Bus_TableForm> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_TableForm dao = new T_Bus_TableForm();
	public Page<Record> getGridPage(Integer pageNum, Integer pageSize,
			String formname, String formcode) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_tableform t where 1=1");
		if(formname!=null && !"".equals(formname)){
			str.append(" and t.fname like '%").append(formname).append("%'");
		}
		if(formcode!=null && !"".equals(formcode)){
			str.append(" and t.fcode like '%").append(formcode).append("%'");
		}
		str.append(" order by t.id desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
	public T_Bus_TableForm getByFcode(String signcode) {
		String sql = "select * from  t_bus_tableform where fcode='"+signcode+"'";
		return dao.findFirst(sql);
	}
	public boolean isExit(String fcode){
		boolean flag = false;
		String sql = "";
		String dba = JFWebConfig.attrMap.get("dbaType");
		if("mysql".equals(dba)){
			sql = "SELECT *   FROM INFORMATION_SCHEMA.TABLES WHERE  LOWER(TABLE_NAME)=LOWER('"+fcode+"')";
		}else if("sqlseerver".equals(dba)){
			sql = "select * from sysobjects where lower(name)=lower('"+fcode+"')";
		}else{
			sql = "select * from USER_TABLES where lower(table_name) = lower('"+fcode+"')";
		}
		List<Record> list = CreateTable.executeQuery(sql);
		if(list!=null && list.size()>0){
			flag = true;
		}
		return flag;
	}
	public void insert(T_Bus_TableForm t) {
		t.set("id", AutoId.nextval(t));
		t.set("status", "00S");
		t.save();
	}
	public boolean createTable(String fcode) {
		List<T_Bus_TableAttr> alist = T_Bus_TableAttr.dao.getListByFcode(fcode);
		boolean flag = false;
		flag = createByOracle(alist,fcode);
		return flag;
	}
	/**oracle建表*/
	public boolean createByOracle(List<T_Bus_TableAttr> alist,String fcode){
		List<String> sqlList = new ArrayList<String>();
		StringBuffer str = new StringBuffer();
		StringBuffer comm = new StringBuffer();
		boolean flag = false;
		if(alist != null && alist.size()>0){
			//建表语句
			str.append("create table ").append(fcode);
			str.append("( id number(11) primary key ");
			//注释
			comm.append("comment on column ").append(fcode).append(".id is '属性ID'");
			sqlList.add(comm.toString());
			for(T_Bus_TableAttr attr:alist){
				String type = attr.getStr("sqltype");
				String acode = attr.getStr("acode");
				String size=attr.getStr("attrsize");
				String isnull=attr.getStr("isnull");
				str.append(", ");
				if("001".equals(type)){//时间类型
					str.append(acode).append("  varchar2(40)");
				}else if("011".equals(type)){//日期类型
					str.append(acode).append("  varchar2(20)");
				}
				else if("002".equals(type)){//数值类型
					str.append(acode).append("  number");
					if(size!=null&&!"".equals(size)){
						str.append("(").append(size).append(")");
					}
				}else if("003".equals(type)){//布尔型
					str.append(acode).append("  char(3)");
				}else if("004".equals(type)){//字符型
					if(size==null||"".equals(size)){
					str.append(acode).append("  varchar2(255)");
					}else{
					str.append(acode).append("  varchar2(").append(size).append(")");	
					}
				}else if("006".equals(type)){//下拉类型
					if(size==null||"".equals(size)){
					str.append(acode).append("  varchar2(100)");
					}else{
					str.append(acode).append("  varchar2(").append(size).append(")");		
					}
				}else{//文本类型（大字段）
					str.append(acode).append("  clob");
				}
				comm = new StringBuffer();
				comm.append("comment on column ").append(fcode).append(".");
				comm.append(acode).append(" is '").append(attr.getStr("remark"));
				comm.append("'");
				sqlList.add(comm.toString());
				if("1".equals(isnull)){
					str.append(" not null");
				}
			}
			str.append(",fkid number(11) not null) ");
			flag = CreateTable.execute(str.toString());
			//添加备注
			Db.batch(sqlList, sqlList.size());
		}
		return flag;
	}
	public void deleteByFcode(String fcode) {
		String sql = "delete from t_bus_tableform where fcode='"+fcode+"' ";
		Db.update(sql);
	}
		//查询表中是否有数据
		public boolean isData(String fcode){
			String sql = "select * from "+fcode;
			List<Record> list = Db.find(sql);
			if(list!=null && list.size()>0){
				return true;
			}else{
				return false;
			}
		}
		public void droptable(String fcode) {
			String str = "select count(*) from user_all_tables a where a.table_name = upper('"+fcode+"')";
			Integer count = Db.queryNumber(str).intValue();
			if(count!=null && count>0){//删除原有表
				str = "drop table "+fcode;
				Db.update(str);
			}
		}
		public T_Bus_TableForm findByfocde(String tablename) {
			String sql="select * from t_bus_tableform where fcode='"+tablename+"'";
			return T_Bus_TableForm.dao.findFirst(sql);
		}
		//根据表名和主表id获取扩展表内容
		public List<Record> getcontentlist(String tablecode, String defobjid) {
			String sql="select t.*,'"+tablecode+"' as tablecode  from "+tablecode+" t where t.fkid="+defobjid+" order by t.id desc";
			return Db.find(sql);
		}
	}
