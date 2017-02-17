package com.lauvan.base.basemodel.model;


import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "t_sys_userroles", pk = "id")
public class T_Sys_UserRoles extends Model<T_Sys_UserRoles> {


	private static final long serialVersionUID = 1L;
	
	public static final T_Sys_UserRoles dao=new T_Sys_UserRoles();
	
	/**
	 * 根据角色ID删除
	 * 
	 * @param    roleId    角色id
	 * @return			
	 */
	public boolean deleteByRoleId(int roleId){
		String sql="delete from t_sys_userroles where role_id=?";
		return Db.update(sql, roleId)>-1;
	}
	
	public boolean deleteByRoleIds(Integer[] roleId){
		if(roleId==null)
			return true;
		for(Integer rid:roleId){
			if(!deleteByRoleId(rid))
				return false;
		}
		return true;
	}
	
	/**
	 * 插入数据
	 * 
	 * @param    userIdList    用户id数组
	 * @param	 roleId	                   角色id 
	 * @return			
	 */
	public boolean insert(Integer[] userIdList,int roleId){
		if(userIdList==null)
			return true;
		for(Integer uid:userIdList){
			if(!insert(uid,roleId))
				return false;
		}
		return true;
	}
	
	/**
	 * 插入数据
	 * 
	 * @param    userId    用户id
	 * @param	 roleId	        角色id 
	 * @return			
	 */
	public boolean insert(int userId,int roleId){
		T_Sys_UserRoles ur=new T_Sys_UserRoles();
		ur.set("id", AutoId.nextval(ur));
		ur.set("user_id", userId);
		ur.set("role_id", roleId);
		return ur.save();
	}
	
	/**
	 * 根据角色ID获取用户ID数组
	 * 
	 * @param	 roleId	        角色id 
	 * @return			
	 */
	public Integer[] getUserId(int roleId){
		String sql="select * from t_sys_userroles where role_id=?";
		List<T_Sys_UserRoles> list= dao.find(sql, roleId);
		Integer[] ids=null;
		if(list.size()!=0)
			ids=new Integer[list.size()];
		for(int i=0;i<list.size();i++){
			ids[i]=list.get(i).getNumber("user_id").intValue();
		}
		return ids;
		
	}
	
	/**
	 * 判断角色是否在被引用
	 * 
	 * @param    roleId    角色id
	 * @return			
	 */
	public boolean isUseRoleId(String roleId){
		boolean flag = false;
		String sql="select ur.* from t_sys_userroles ur ,(select distinct r.role_id from t_sys_role  r start with r.role_id in ("
					+roleId+") connect by  prior r.role_id = r.pid)  rid where ur.role_id=rid.role_id ";
		List<Record> list = Db.find(sql);
		if(list!=null && list.size()>0){
			flag = true;
		}
		return flag;
	}
}
