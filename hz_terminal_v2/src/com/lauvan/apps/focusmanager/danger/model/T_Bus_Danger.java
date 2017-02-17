package com.lauvan.apps.focusmanager.danger.model;
import java.math.BigDecimal;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
@TableBind(name="t_bus_danger",pk="dangerid")
public class T_Bus_Danger extends Model<T_Bus_Danger> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_Danger dao = new T_Bus_Danger();
	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String dangername, String depart) {
		pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
		String sql = "select t.*";
		StringBuffer str = new StringBuffer();
		str.append(" from t_bus_danger t where 1=1");
		if(dangername!=null && !"".equals(dangername)){
			str.append(" and t.dangername like '%").append(dangername).append("%'");
		}
		if(depart != null && !"".equals(depart)){
			str.append(" and t.deptid='").append(depart).append("'");
		}
		str.append(" order by t.dangerid desc");
		return Db.paginate(pageNum, pageSize, sql, str.toString());
}
	public List<Record> getTypeList() {
		String sql="select  p_acode as checkcode,p_name as checkname,id,sup_id as pid from t_sys_parameter start with id=(select id from t_sys_parameter where P_ACODE='WXYFXYHQFL') connect by prior id=sup_id  order by id asc";
		return Db.find(sql);
	}
	public List<Record> getListByName(String name) {
		String sql="select t.*,decode(t.dangertypecode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.dangertypecode  Start With a.p_acode='WXYFXYHQFL' Connect By  Prior a.id = a.sup_id  ))  as dangertypecode_name "
				+",decode(t.levelcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.levelcode  Start With a.p_acode='ZDFHJBDM' Connect By  Prior a.id = a.sup_id  ))  as levelcode_name "
				+",decode(t.classcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.classcode  Start With a.p_acode='ZDFHMJDM' Connect By  Prior a.id = a.sup_id  ))  as classcode_name "
				+",decode(t.districtcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.districtcode  Start With a.p_acode='EVQY' Connect By  Prior a.id = a.sup_id  ))  as districtcode_name "
				+",decode(t.elevadatumcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.elevadatumcode  Start With a.p_acode='ZDFHGCJZ' Connect By  Prior a.id = a.sup_id  ))  as elevadatumcode_name "
				+",decode(t.coordsyscode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.coordsyscode  Start With a.p_acode='ZDFHZBXT' Connect By  Prior a.id = a.sup_id  ))  as coordsyscode_name "
				+",decode(t.hazardlevelcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.hazardlevelcode  Start With a.p_acode='WXDJDM' Connect By  Prior a.id = a.sup_id  ))  as hazardlevelcode_name "
				+" from t_bus_danger t where 1=1";
		if(name!=null && !"".equals(name)){
			sql = sql + " and t.dangername like '%"+name+"%' ";
		}
		return Db.find(sql);
	}
	
	/**
	 * 应急案例获得危险源名称——周志高
	 * @param dan_id
	 * @return
	 */
	public T_Bus_Danger getDangerByDanid(BigDecimal dan_id) {
		return dao.findFirst(
				"select * from t_bus_danger where dangerid=?", dan_id);
	}
}
