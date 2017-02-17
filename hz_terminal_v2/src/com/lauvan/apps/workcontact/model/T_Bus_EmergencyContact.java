package com.lauvan.apps.workcontact.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;

/**
 * @author Bob
 * 应急通讯录联络关系表
 */
@TableBind(name="t_bus_emergencycontact",pk="e_id")
public class T_Bus_EmergencyContact extends Model<T_Bus_EmergencyContact> {

	private static final long serialVersionUID = 1L;
	public static T_Bus_EmergencyContact dao = new T_Bus_EmergencyContact();
	
	/**
	 * 获取所有应急分组
	 * 
	 * @return				返回List对象
	 */
	public List<Record> getAllEmergencys(){
		String sql="select * from t_bus_emergencycontact order by e_id";
		return Db.find(sql);		
	}
	
	/**
	 * 根据通讯bookids获取通讯列表
	 * @param bookids 	通讯录ids
	 * */
	public Page<Record> getUserPage(Integer pageSize,Integer pageNumber,String objName,String user,String bookids,String notid){
		String select="select * ";
		StringBuffer  str = new StringBuffer();
		str.append("from t_bus_bookcontact b ");
		if(bookids!=null && !"".equals(bookids)){
			str.append(" where b.bo_id in("+bookids+")");
		}
		str.append(" order by b.bo_id desc");
		return Db.paginate(pageNumber, pageSize, select, str.toString());
	}
	
	/**
	 * 根据系统用户bookids，机构人员personids获取通讯信息
	 * @param bookids 	
	 * @param personids 	
	 * */
	public Page<Record> getContactPage(Integer pageSize,Integer pageNumber,String bookids,String personids){
		String select="select *";
		StringBuffer  str = new StringBuffer();
		str.append(" from (");
		if(bookids!=null && !"".equals(bookids)){
			str.append("select 'b_'||bo_id as id,u.user_name as name,decode(b.bo_position,null,null,("
	         +"select to_char(wmsys.wm_concat(a1.p_name)) from"
		     +"(select * from t_sys_parameter start with  p_acode = 'EMPOSITION' connect by prior id=sup_id) a1 " 
			 +"where ','||b.bo_position||',' like '%,'||a1.p_acode||',%'" 
             +")) as position,bo_worknumber as worknumber,bo_homenumber as homenumber,"
             + "bo_mobile as mobile,bo_fax as fax,bo_email as email,bo_address as address"
             +" from t_bus_contactbook b ,t_sys_user u where b.bo_userid=u.user_id and b.bo_id in("+bookids+")");
			str.append(" union ");		 
		}
			str.append("select 'p_'||p_id as id,p_name as name,decode(p.p_position,null,null,("
             +"select to_char(wmsys.wm_concat(a1.p_name)) from" 
             +"(select * from t_sys_parameter start with  p_acode = 'RPOSITION' connect by prior id=sup_id) a1 " 
             +"where ','||p.p_position||',' like '%,'||a1.p_acode||',%'"
             +")) as position,p_worknumber as worknumber,p_homenumber as homenumber,p_mobile as mobile,"
             + "p_fax as fax,p_email as email,p_address as address "
		  +"from t_bus_organperson p where p_id in("+personids+"))");
			
		return Db.paginate(pageNumber, pageSize, select, str.toString());
	}
	
	/**
	 * 判断是否存在子分组
	 * 		
	 */
	public boolean hasSonGroup(Integer id){
		String sql="select count(*) from t_bus_emergencycontact where e_pid in ("+id+")";
		return Db.queryNumber(sql).intValue()>0;
	}
	
	public boolean delete(Integer[] ids) throws Exception{
		try{
			boolean flag=false;
			for(Integer id:ids){
				flag=dao.deleteById(id);
			}
			return flag;
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception(e);
		}
	}

}
