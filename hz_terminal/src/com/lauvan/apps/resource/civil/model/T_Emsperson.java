package com.lauvan.apps.resource.civil.model;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;

/**
 *民间救援组织人员
 *
 */
@TableBind(name = "t_emsperson", pk = "id")
public class T_Emsperson extends Model<T_Emsperson> {

	private static final long	serialVersionUID	= 1L;
	public static T_Emsperson	dao					= new T_Emsperson();

	public boolean insert(T_Emsperson e) {
		e.set("id", AutoId.nextval(e));
		e.set("recordtime", DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT));
		return e.save();
	}

	public Page<Record> getPage(Integer pageSize, Integer pageNum, String deptid, String type) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		//String select = "select ep.*, p1.p_name as mz ";
		//StringBuffer sb = new StringBuffer(" from t_emsperson ep left join t_sys_parameter p1 on ep.persnationid= p1.p_acode");
		//sb.append(" where p1.sup_id = 90 ");
		String select = "select ep.* ";
		StringBuffer sb = new StringBuffer(" from t_emsperson ep where 1=1 ");
		if(deptid != null && !"".equals(deptid)) {
			sb.append(" and ep.equteamno =").append(deptid);
		}
		if(type != null && !"".equals(type)) {
			sb.append(" and ep.equteamtype ='").append(type).append("' ");
		}
		sb.append(" order by ep.id desc");
		//sb.append(" left join t_sys_parameter p2 on ep.persduty = p2.p_acode ");
		//sb.append(" left join t_sys_parameter p3 on ep.techpostid = p3.p_acode where p1.sup_id = 90 and p2.sup_id = 237 and p3.sup_id =108 ");
		return Db.paginate(pageNum, pageSize, select, sb.toString());
	}

	public T_Emsperson getById(String id) {
		String sql = "select e.*, a.url from t_emsperson e left join t_attachment a on e.persphoto= a.id where e.id=" + id;
		return dao.findFirst(sql);
	}

	public void delByIds(String ids) {
		String sql = "delete from t_emsperson where id in (" + ids + ")";
		Db.update(sql);
	}

	//根据id获取附件对应记录
	public String getfjidsByids(String ids) {
		String sql = "select wm_concat(ep.persphoto) as fjids from t_emsperson ep where ep.id in (" + ids + ")";
		return Db.queryStr(sql);
	}

	public String getOpidsbyIds(String ids) {
		String sql = "select wm_concat(ep.opid) as opids from t_emsperson ep where ep.id in(" + ids + ")";
		return Db.queryStr(sql);
	}

	//根据民间救援组织ID获取人员id字符串
	public String getIdStrByCivids(String cids) {
		String sql = "select wm_concat(ep.id) from t_emsperson ep where ep.equteamno in (" + cids + ")";
		return Db.queryStr(sql);
	}
}
