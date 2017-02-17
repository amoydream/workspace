package com.lauvan.apps.resource.safeguardorg.model;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

@TableBind(name = "t_bus_firedept", pk = "deptid")
public class T_Bus_FireDept extends Model<T_Bus_FireDept> {

	private static final long		serialVersionUID	= 1L;

	public static T_Bus_FireDept	dao					= new T_Bus_FireDept();

	public boolean insert(T_Bus_FireDept fd) {
		fd.set("deptid", AutoId.nextval(fd));
		fd.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return fd.save();
	}

	public boolean upd(T_Bus_FireDept fd) {
		fd.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return fd.update();
	}

	public List<T_Bus_FireDept> getListById(String pid) {
		String sql = "select f.*, case when(select count(0) from t_bus_firedept f2 where f2.superdept_id = f.deptid ) >0 then 1 else 0 end as isleaf from t_bus_firedept f ";
		if(StringUtils.isNotBlank(pid)) {
			sql += " start with f.superdept_id=" + pid + " connect by prior f.deptid = f.superdept_id";
		}
		sql += "  order by f.deptid ";
		return dao.find(sql);
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNumber, Integer pid, String firedeptname, String levelcode) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select f.* ";
		StringBuffer sb = new StringBuffer(" from t_bus_firedept f where 1=1 ");
		if(pid != null) {
			sb.append(" and f.superdept_id =").append(pid);
		}
		if(StringUtils.isNotBlank(firedeptname)) {
			sb.append(" and f.deptname like '%").append(firedeptname).append("%' ");
		}
		if(StringUtils.isNotBlank(levelcode)) {
			sb.append(" and f.levelcode ='").append(levelcode).append("' ");
		}
		sb.append(" order by f.updatetime desc ");
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}

	public void deleteByIds(String deptids) {
		String sql = "delete from t_bus_firedept f where f.deptid in (" + deptids + ")";
		Db.update(sql);
	}

	public String getfjidsByIds(String deptids) {
		String sql = "select wm_concat(f.fjid) as fjids from t_bus_firedept f where f.deptid in (" + deptids + ")";
		return Db.queryStr(sql);
	}

	public T_Bus_FireDept getById(String deptid) {
		String sql = "select f.* , a.name as fjname , a.url, a.m_size from t_bus_firedept f left join t_attachment a on f.fjid = a.id  where f.deptid=" + deptid;
		return dao.findFirst(sql);
	}

	////根据部门id查找下属所有机构id（包含自身id）
	public String getChildIdsByDeptids(String deptids) {
		String sql = "select wm_concat(f.deptid) from t_bus_firedept f start with f.deptid in (" + deptids + ") connect by prior f.deptid = f.superdept_id";
		return Db.queryStr(sql);
	}
}
