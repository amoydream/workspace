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

/**
 * 司法行政机关
 *
 */
@TableBind(name = "t_bus_juddept", pk = "deptid")
public class T_Bus_JudDept extends Model<T_Bus_JudDept> {

	private static final long	serialVersionUID	= 1L;

	public static T_Bus_JudDept	dao					= new T_Bus_JudDept();

	public boolean insert(T_Bus_JudDept juddept) {
		juddept.set("deptid", AutoId.nextval(juddept));
		juddept.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return juddept.save();
	}

	public boolean upd(T_Bus_JudDept juddept) {
		juddept.set("updatetime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return juddept.update();
	}

	public List<T_Bus_JudDept> getListById(String pid) {
		String sql = "select j.*,case when(select count(0) from t_bus_juddept j2 where j2.superdept_id = j.deptid)>0 then 1 else 0 end as isleaf from t_bus_juddept j ";
		if(StringUtils.isNotBlank(pid)) {
			sql += " start with j.superdept_id =" + pid + " connect by prior j.deptid = j.superdept_id ";
		}
		sql += " order by j.deptid";
		return dao.find(sql);
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNumber, Integer pid, String juddeptname, String levelcode) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select j.* ";
		StringBuffer sb = new StringBuffer(" from t_bus_juddept j where 1=1 ");
		if(pid != null) {
			sb.append(" and j.superdept_id =").append(pid);
		}
		if(StringUtils.isNotBlank(juddeptname)) {
			sb.append(" and j.deptname like '%").append(juddeptname).append("%' ");
		}
		if(StringUtils.isNotBlank(levelcode)) {
			sb.append(" and j.levelcode ='").append(levelcode).append("' ");
		}
		sb.append(" order by j.updatetime desc ");
		return Db.paginate(pageNumber, pageSize, sql, sb.toString());
	}

	public void deleteByIds(String deptids) {
		String sql = "delete from t_bus_juddept j where j.deptid in (" + deptids + ")";
		Db.update(sql);
	}

	public String getfjidsByIds(String deptids) {
		String sql = "select wm_concat(j.fjid) as fjids from t_bus_juddept j where j.deptid in (" + deptids + ")";
		return Db.queryStr(sql);
	}

	public T_Bus_JudDept getById(String deptid) {
		String sql = "select j.* , a.name as fjname , a.url, a.m_size from t_bus_juddept j left join t_attachment a on j.fjid = a.id  where j.deptid=" + deptid;
		return dao.findFirst(sql);
	}

	//根据部门id查找下属所有机构id（包含自身ID）
	public String getChildIdsByDeptids(String deptids) {
		String sql = "select wm_concat(j.deptid) from t_bus_juddept j start with j.deptid in (" + deptids + ") connect by prior j.deptid = j.superdept_id";
		return Db.queryStr(sql);
	}

}
