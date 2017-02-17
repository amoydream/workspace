package com.lauvan.apps.communication.gpsinfo.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.util.ArrayUtils;

@TableBind(name="t_userreallocator",pk="id")
public class T_UserRealLocator extends Model<T_UserRealLocator> {

	private static final long serialVersionUID = 1L;

	public static final T_UserRealLocator dao=new T_UserRealLocator();
	
	public List<Record> getAll(){
		String sql="select l.*,m.realname from t_userreallocator l,t_mobileuser m where l.userid=m.id";
		return Db.find(sql);
	}
	
	public List<Record> getByUserId(Integer[] userIdList){
		if(userIdList==null)
			return getAll();
		else{
			String sql="select l.*,m.realname from t_userreallocator l,t_mobileuser m where l.userid=m.id and userid in ("+ArrayUtils.ArrayToString(userIdList)+")";
			return Db.find(sql);
		}
	}
}
