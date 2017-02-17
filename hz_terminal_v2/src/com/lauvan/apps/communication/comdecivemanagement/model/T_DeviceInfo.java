package com.lauvan.apps.communication.comdecivemanagement.model;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
@TableBind(name="t_deviceinfo",pk="id")
public class T_DeviceInfo extends Model<T_DeviceInfo> {
	private static final long serialVersionUID = 1L;
	public static T_DeviceInfo dao = new T_DeviceInfo();
	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String type,
			String code, String name) {
			pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
			pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
			String sql = "select t.*";
			StringBuffer str = new StringBuffer();
			str.append(" from t_deviceinfo t where 1=1");
			if(type!=null && !"".equals(type)){
				str.append(" and t.dtype=").append(type);
			}
			if(code!=null && !"".equals(code)){
				str.append(" and t.dcode like '%").append(code).append("%'");
			}
			if(name!=null && !"".equals(name)){
				str.append(" and t.dname like '%").append(name).append("%'");
			}
			str.append(" order by t.id desc");
			return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
}
