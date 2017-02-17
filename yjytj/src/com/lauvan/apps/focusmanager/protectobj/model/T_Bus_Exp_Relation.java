package com.lauvan.apps.focusmanager.protectobj.model;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
@TableBind(name="t_bus_exp_relation",pk="id")
public class T_Bus_Exp_Relation extends Model<T_Bus_Exp_Relation> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_Exp_Relation dao = new T_Bus_Exp_Relation();
	public T_Bus_Exp_Relation getbybhlxcode(String bhlxcode) {
		String sql="select * from t_bus_exp_relation r where bhlxcode='"+bhlxcode+"'";
		return dao.findFirst(sql);
	}
	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String type,
			String bhlxcode, String exptablename) {
			pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
			pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
			String sql = "select t.*";
			StringBuffer str = new StringBuffer();
			str.append(" from t_bus_exp_relation t where 1=1");
			if(type!=null && !"".equals(type)){
				str.append(" and t.type='").append(type).append("'");
			}
			if(bhlxcode!=null && !"".equals(bhlxcode)){
				str.append(" and t.bhlxcode like '%").append(bhlxcode).append("%'");
			}
			if(exptablename!=null && !"".equals(exptablename)){
				str.append(" and t.exptablename like '%").append(exptablename).append("%'");
			}
			str.append(" order by t.id desc");
			return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
	//根据表名查找实体表是否存在
	public Record getexistbytablename(String tablename) {
	String sql="select * from user_tables where table_name='"+tablename.toUpperCase()+"'";
	return Db.findFirst(sql);	
	}
}
