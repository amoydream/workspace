package com.lauvan.apps.communication.gpsinfo.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_userlocator", pk = "id")
public class T_UserLocator extends Model<T_UserLocator> {
	private static final long	serialVersionUID	= 1L;
	public static T_UserLocator	dao					= new T_UserLocator();

	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String id) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_userlocator t where 1=1");
		if(id != null && !"".equals(id)) {
			str.append(" and t.userid=").append(id);
		}
		str.append(" order by t.time desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

	public Page<Record> getfileGridPage(Integer pageNum, Integer pageSize, String id) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_userlocator t where t.isupload=1");
		if(id != null && !"".equals(id)) {
			str.append(" and t.userid=").append(id);
		}
		str.append(" order by t.time desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
	}

	public List<Record> getListByUid(String uid) {
		String sql = "select t.* from t_userlocator t,(select max(time) as maxtime,userid from t_userlocator group by userid) u where t.userid=u.userid and substr(t.time,0,10) = substr(u.maxtime,0,10)";
		if(uid != null && !"".equals(uid)) {
			sql += " and t.userid=" + uid;
		}
		return Db.find(sql);
	}

	public List<Record> getListUidAndTime(String uid, String btime, String etime) {
		String sql = "select * from t_userlocator where userid=" + uid + " and  time between '" + btime + "' and '" + etime + "' order by time";
		return Db.find(sql);
	}
}
