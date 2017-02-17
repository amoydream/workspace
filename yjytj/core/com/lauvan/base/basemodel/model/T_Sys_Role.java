package com.lauvan.base.basemodel.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_sys_role", pk = "role_id")
public class T_Sys_Role extends Model<T_Sys_Role> {

	private static final long serialVersionUID = 1L;
	
	public static final T_Sys_Role dao=new T_Sys_Role();

	
	/**
	 * 删除角色
	 * 
	 * @param    ids    用户id
	 * @return			
	 */
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
	
	
	/**
	 * 获取启用角色
	 * 
	 * @param    userId    用户id
	 * @return			
	 */
	public List<T_Sys_Role> getRoles(String userId){
		String sql="select r.* from t_sys_role r,t_sys_userroles ur where r.role_id=ur.role_id and r.status='1' and ur.user_id=? ";
		return dao.find(sql,userId);
	}

	/**
	 * 根据角色ID获取角色名称
	 * 
	 * @param    ids    角色id
	 * @return			
	 */
	public String getRoleName(String ids){
		String name = "";
		String sql = "";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = "select to_char(wmsys.wm_concat(role_name)) from t_sys_role where role_id in ("+ids+")";
			name = Db.queryStr(sql);
		}else if("mysql".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = "SELECT  GROUP_CONCAT(role_name SEPARATOR ',') AS NAME FROM t_sys_role WHERE role_id IN ("+ids+")";
			name = Db.queryStr(sql);
		}else{
			sql = "select * from t_sys_role where role_id in ("+ids+")";
			List<T_Sys_Role> list = dao.find(sql);
			if(list!=null && list.size()>0){
				for(T_Sys_Role t : list){
					name = name+","+t.getStr("role_name");
				}
				name = name.substring(1);
			}
		}
		return name;
	}
	
	/***
	 * 根据用户ID和角色IDs，判断用户是否拥有当中的角色
	 * @param userid	用户ID
	 * @param roleids	角色ids
	 * */
	public List<T_Sys_Role> getRoleUser(String userid,String roleids){
		String sql = "select r.* from t_sys_role r,t_sys_userroles ur where r.role_id=ur.role_id and ur.user_id="
					+userid+" and r.role_id in ("+roleids+")";
		return dao.find(sql);
	}
	
	public T_Sys_Role getroleccms(String userid) {
		String sql="select r.* from t_sys_role r,t_sys_userroles ur where r.role_name='CCMS' and r.role_id=ur.role_id and r.status='1' and ur.user_id="+userid;
		return dao.findFirst(sql);
	}
}
