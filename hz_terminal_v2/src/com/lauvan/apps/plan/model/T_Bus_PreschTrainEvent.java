package com.lauvan.apps.plan.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
@TableBind(name="t_bus_preschtrainevent",pk="id")
public class T_Bus_PreschTrainEvent extends Model<T_Bus_PreschTrainEvent> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_PreschTrainEvent dao = new T_Bus_PreschTrainEvent();
	public Page<Record> getPageList(Integer pageSize,Integer pageNumber,String swhere){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select p.*";
		StringBuffer  str = new StringBuffer();
		str.append(" from t_bus_preschtrainevent p where 1=1 ");
		if(swhere!=null && !"".equals(swhere)){
			str.append(swhere);
		}
		str.append(" order by p.marktime  desc ");
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	public String insert(T_Bus_PreschTrainEvent t){
		String id = AutoId.nextval(t).toString();
		t.set("id", id);
		t.set("marktime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		t.save();
		return id;
	}
}
