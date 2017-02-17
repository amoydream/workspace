package com.lauvan.apps.focusmanager.protectobj.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_bus_tableattr", pk = "id")
public class T_Bus_TableAttr extends Model<T_Bus_TableAttr> {
	private static final long		serialVersionUID	= 1L;
	public static T_Bus_TableAttr	dao					= new T_Bus_TableAttr();

	public List<Record> getListByfcode(String fcode) {
		String sql = "select * from t_bus_tableattr where fcode='" + fcode + "' order by id asc";
		return Db.find(sql);
	}

	public void insert(T_Bus_TableAttr t) {
		t.set("id", AutoId.nextval(t));
		t.save();
	}

	public List<T_Bus_TableAttr> getListByFcode(String fcode) {
		String sql = "select * from t_bus_tableattr where fcode='" + fcode + "' order by id";
		return dao.find(sql);
	}

	public void deleteByFcode(String fcode) {
		String sql = "delete from t_bus_tableattr where fcode='" + fcode + "'";
		Db.update(sql);

	}

	public List<Record> getViewByFcode(String fcode) {
		String sql = "select * from t_bus_tableattr where fcode='" + fcode + "' order by id desc";
		List<Record> list = Db.find(sql);
		if(list != null && list.size() > 0) {
			int count = 0;
			for(int i = 0; i < list.size(); i++) {
				Record r = list.get(i);
				String type = r.getStr("sqltype");
				if("005".equals(type)) {
					count++;
				}
				r.set("seq", i + 1 - count);
			}
		}
		return list;
	}

	public List<Record> getattrByFcode(String tablename) {
		String sql = "select acode from t_bus_tableattr t where fcode='" + tablename + "' order by id desc";
		return Db.find(sql);
	}

	//获取需要展示的字段
	public List<T_Bus_TableAttr> getListisview(String tablecode) {
		String sql = "select t.*,upper(t.acode) as upperacode from t_bus_tableattr t where t.fcode='" + tablecode + "' and t.isview=1 order by t.id desc";
		return dao.find(sql);
	}
}
