package com.lauvan.apps.focusmanager.troubleobj.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.focusmanager.protectobj.model.T_Bus_DefenceObj;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_bus_hidtrub", pk = "id")
public class T_Bus_Hidtrub extends Model<T_Bus_Hidtrub> {
	private static final long	serialVersionUID	= 1L;
	public static T_Bus_Hidtrub	dao					= new T_Bus_Hidtrub();

	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String type, String name, String isvail) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_hidtrub t where 1=1");
		if(type != null && !"".equals(type)) {
			str.append(" and t.hidtrubtype='").append(type).append("'");
		}
		if(name != null && !"".equals(name)) {
			str.append(" and t.hidtrubname like '%").append(name).append("%'");
		}
		if(isvail != null && !"".equals(isvail)) {
			str.append(" and t.isvail ='").append(isvail).append("'");
		}
		str.append(" order by t.id desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

	public Page<Record> getGridPage2(Integer pageNum, Integer pageSize, String type, String name, String did) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_hidtrub t where 1=1");
		if(type != null && !"".equals(type)) {
			str.append(" and t.hidtrubtype=").append(type);
		}
		if(name != null && !"".equals(name)) {
			str.append(" and t.hidtrubname like '%").append(name).append("%'");
		}
		if(did != null && !"".equals(did)) {
			str.append(" and t.hidtrubdeptid ='").append(did).append("'");
		}
		str.append(" order by t.id desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

	public List<Record> getListByName(String name) {
		String sql = "select t.*,decode(t.hidtrubtype,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.hidtrubtype  Start With a.p_acode='YHDLB' Connect By  Prior a.id = a.sup_id  ))  as hidtrubtype_name " + " from t_bus_hidtrub t where 1=1";
		if(name != null && !"".equals(name)) {
			sql = sql + " and t.hidtrubname like '%" + name + "%' ";
		}
		return Db.find(sql);
	}
	public List<T_Bus_Hidtrub> getListByids(String ids){
		String sql="select * from T_Bus_Hidtrub where id in ("+ids+")";
		return dao.find(sql);
	}
}
