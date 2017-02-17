package com.lauvan.apps.focusmanager.protectobj.model;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;
@TableBind(name="t_bus_defenceobj",pk="defobjid")
public class T_Bus_DefenceObj extends Model<T_Bus_DefenceObj> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_DefenceObj dao = new T_Bus_DefenceObj();
	public Page<Record> getGridPage(Integer pageNum, Integer pageSize, String protectobjname, String depart) {
			pageNum = pageNum == null || pageNum < 1 ? 1 : pageNum;
			pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize : pageSize;
			String sql = "select t.*";
			StringBuffer str = new StringBuffer();
			str.append(" from t_bus_defenceobj t where 1=1");
			if(protectobjname!=null && !"".equals(protectobjname)){
				str.append(" and t.defobjname like '%").append(protectobjname).append("%'");
			}
			if(depart != null && !"".equals(depart)){
				str.append(" and t.deptid ='").append(depart).append("'");
			}
			str.append(" order by t.defobjid desc");
			return Db.paginate(pageNum, pageSize, sql, str.toString());
	}
	public List<Record> getTypeList() {
		String sql="select  p_acode as checkcode,p_name as checkname,id,sup_id as pid from t_sys_parameter start with id=(select id from t_sys_parameter where P_ACODE='FHMBFL') connect by prior id=sup_id  order by id asc";
		return Db.find(sql);
	}
	public List<Record> getListByName(String name) {
		String sql="select t.*,decode(t.defobjtypecode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.defobjtypecode  Start With a.p_acode='FHMBFL' Connect By  Prior a.id = a.sup_id  ))  as defobjtypecode_name "
				+",decode(t.levelcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.levelcode  Start With a.p_acode='ZDFHJBDM' Connect By  Prior a.id = a.sup_id  ))  as levelcode_name "
				+",decode(t.classcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.classcode  Start With a.p_acode='ZDFHMJDM' Connect By  Prior a.id = a.sup_id  ))  as classcode_name "
				+",decode(t.districtcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.districtcode  Start With a.p_acode='EVQY' Connect By  Prior a.id = a.sup_id  ))  as districtcode_name "
				+",decode(t.elevadatumcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.elevadatumcode  Start With a.p_acode='ZDFHGCJZ' Connect By  Prior a.id = a.sup_id  ))  as elevadatumcode_name "
				+",decode(t.coordsyscode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.coordsyscode  Start With a.p_acode='ZDFHZBXT' Connect By  Prior a.id = a.sup_id  ))  as coordsyscode_name "
				+",decode(t.deflevelcode,null,'',(select a.p_name from t_sys_parameter a where a.p_acode=t.deflevelcode  Start With a.p_acode='ZDFHFHDJ' Connect By  Prior a.id = a.sup_id  ))  as deflevelcode_name "
				+" from t_bus_defenceobj t where 1=1";
		if(name!=null && !"".equals(name)){
			sql = sql + " and t.defobjname like '%"+name+"%' ";
		}
		return Db.find(sql);
	}
}
