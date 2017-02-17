package com.lauvan.apps.autocreate.model;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.autocreate.utils.AutoCreate;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_autotable", pk = "id")
public class T_AutoTable extends Model<T_AutoTable> {
	private static final long	serialVersionUID	= 1L;
	public static T_AutoTable	dao					= new T_AutoTable();

	public void insert(T_AutoTable t) {
		t.set("id", AutoId.nextval(t));
		t.save();
	}

	/**
	 *删除实体表
	 * */
	public void deletTable(String table, String dbaname, String path) {
		String sql = "drop table " + table;
		AutoCreate.execute(sql, dbaname);
		//删除文件
		if(path != null && !"".equals(path)) {
			path = path.replace(".", "/");
			File file = new File(PathKit.getWebRootPath().replace("\\WebRoot", "") + "/src/" + path + "/" + table.replaceFirst(table.substring(0, 1), table.substring(0, 1).toUpperCase()) + ".java");
			if(file.exists()) {
				file.delete();
			}
		}
	}

	/**
	 * 查询对象是否存在
	 * */
	public boolean isExit(String code, String dbaname) {
		boolean flag = false;
		String sql = "";
		String dba = JFWebConfig.attrMap.get("dbaType");
		if("mysql".equals(dba)) {
			sql = "SELECT *   FROM INFORMATION_SCHEMA.TABLES WHERE  LOWER(TABLE_NAME)=LOWER('" + code + "')";
		} else if("sqlseerver".equals(dba)) {
			sql = "select * from sysobjects where lower(name)=lower('" + code + "')";
		} else {
			sql = "select * from USER_TABLES where lower(table_name) = lower('" + code + "')";
		}
		List<Record> list = AutoCreate.executeQuery(sql, dbaname);
		if(list != null && list.size() > 0) {
			flag = true;
		}
		return flag;
	}

	/**
	 * 根据字段属性建表
	 * */
	public boolean createOracleTable(String tcode, String dbaname) {
		List<Record> alist = T_AutoAttr.dao.getListByCode(tcode);
		StringBuffer str = new StringBuffer();
		List<String> sqlList = new ArrayList<String>();
		boolean flag = false;
		if(alist != null && alist.size() > 0) {
			//建表语句
			str.append("create table ").append(tcode).append("(");
			for(int i = 0; i < alist.size(); i++) {
				Record attr = alist.get(i);
				String type = attr.getStr("attrtype");
				String acode = attr.getStr("attrcode");
				String alen = attr.getStr("acodelen");
				String remark = attr.getStr("remark");
				String ispkid = attr.getStr("ispkid");
				if(i > 0) {
					str.append(",");
				}
				if("001".equals(type)) {
					str.append(acode).append("  varchar2");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen.split(",")[0]).append(")");
					} else {
						str.append("(255)");
					}
				}
				if("011".equals(type)) {
					str.append(acode).append("  char");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen.split(",")[0]).append(")");
					} else {
						str.append("(3)");
					}
				}
				if("002".equals(type)) {
					str.append(acode).append("  number");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen.split(",")[0]).append(")");
					}
				}
				if("003".equals(type)) {
					str.append(acode).append("  date");
				}
				if("004".equals(type)) {
					str.append(acode).append("  clob");
				}
				if("005".equals(type)) {//小数类型
					str.append(acode).append("  number");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen).append(")");
					}
				}
				if("1".equals(ispkid) && "002".equals(type)) {
					str.append(" primary key");
				}
				StringBuffer comm = new StringBuffer();
				comm.append("comment on column ").append(tcode).append(".");
				comm.append(acode).append(" is '").append(attr.getStr("attrname"));
				if(remark != null && !"".equals(remark)) {
					comm.append(" ").append(remark);
				}
				comm.append("'");
				sqlList.add(comm.toString());
			}
			str.append(") ");
			flag = AutoCreate.execute(str.toString(), dbaname);
			//添加备注
			Db.batch(sqlList, sqlList.size());
		}
		return flag;
	}

	/**
	 * 根据字段属性建表
	 * */
	public boolean createMySqlTable(String tcode, String dbaname) {
		List<Record> alist = T_AutoAttr.dao.getListByCode(tcode);
		StringBuffer str = new StringBuffer();
		String pkid = "";
		boolean flag = false;
		if(alist != null && alist.size() > 0) {
			//建表语句
			str.append("create table ").append(tcode).append("(");
			for(int i = 0; i < alist.size(); i++) {
				Record attr = alist.get(i);
				String type = attr.getStr("attrtype");
				String acode = attr.getStr("attrcode");
				String alen = attr.getStr("acodelen");
				String remark = attr.getStr("remark");
				String ispkid = attr.getStr("ispkid");

				if("001".equals(type)) {
					str.append(acode).append("  varchar");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen.split(",")[0]).append(")");
					} else {
						str.append("(255)");
					}
				}
				if("011".equals(type)) {
					str.append(acode).append("  char");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen.split(",")[0]).append(")");
					} else {
						str.append("(3)");
					}
				}
				if("002".equals(type)) {
					str.append(acode).append("  int");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen.split(",")[0]).append(")");
					}
				}
				if("003".equals(type)) {
					str.append(acode).append("  datetime");
				}
				if("004".equals(type)) {
					str.append(acode).append("  text");
				}
				if("005".equals(type)) {
					str.append(acode).append("  float");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen).append(")");
					}
				}
				if("1".equals(ispkid) && "002".equals(type)) {
					str.append(" NOT NULL AUTO_INCREMENT");
					pkid = pkid + "," + acode;
				}
				str.append(" COMMENT '").append(attr.getStr("attrname"));
				if(remark != null && !"".equals(remark)) {
					str.append(" ").append(remark);
				}
				str.append("',");
			}
			str.append(" PRIMARY KEY (").append(pkid.substring(1)).append(")");
			str.append(") ");
			flag = AutoCreate.execute(str.toString(), dbaname);
		}
		return flag;
	}

	/**
	 * 根据字段属性建表
	 * */
	public boolean createSQLServerTable(String tcode, String dbaname) {
		List<Record> alist = T_AutoAttr.dao.getListByCode(tcode);
		StringBuffer str = new StringBuffer();
		List<String> sqlList = new ArrayList<String>();
		boolean flag = false;
		if(alist != null && alist.size() > 0) {
			//建表语句
			str.append("create table ").append(tcode).append("(");
			for(int i = 0; i < alist.size(); i++) {
				Record attr = alist.get(i);
				String type = attr.getStr("attrtype");
				String acode = attr.getStr("attrcode");
				String alen = attr.getStr("acodelen");
				String remark = attr.getStr("remark");
				String ispkid = attr.getStr("ispkid");
				if(i > 0) {
					str.append(",");
				}
				if("001".equals(type)) {
					str.append(acode).append("  varchar");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen.split(",")[0]).append(")");
					} else {
						str.append("(255)");
					}
				}
				if("011".equals(type)) {
					str.append(acode).append("  char");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen.split(",")[0]).append(")");
					} else {
						str.append("(3)");
					}
				}
				if("002".equals(type)) {
					str.append(acode).append("  int");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen.split(",")[0]).append(")");
					}
				}
				if("003".equals(type)) {
					str.append(acode).append("  datetime");
				}
				if("004".equals(type)) {
					str.append(acode).append("  text");
				}
				if("005".equals(type)) {
					str.append(acode).append("  float");
					if(alen != null && !"".equals(alen)) {
						str.append("(").append(alen).append(")");
					}
				}
				if("1".equals(ispkid) && "002".equals(type)) {
					str.append(" IDENTITY(1,1) primary key");
				}
				StringBuffer comm = new StringBuffer();
				comm.append("comment on column ").append(tcode).append(".");
				comm.append(acode).append(" is '").append(attr.getStr("attrname"));
				if(remark != null && !"".equals(remark)) {
					comm.append(" ").append(remark);
				}
				comm.append("'");
				sqlList.add(comm.toString());
			}
			str.append(") ");
			flag = AutoCreate.execute(str.toString(), dbaname);
			//添加备注
			Db.batch(sqlList, sqlList.size());
		}
		return flag;
	}
}
