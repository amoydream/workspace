package com.lauvan.base.basemodel.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_sys_user", pk = "user_id")
public class T_Sys_User extends Model<T_Sys_User> {


	private static final long serialVersionUID = 1L;
	
	public static final T_Sys_User dao=new T_Sys_User();

	/**
	 * 判断帐号是否存在
	 * 
	 * @param    account    帐号
	 * @param    userId		用户id(可以为null)
	 * @return			
	 */
	public boolean ifExsitAccount(String account,Integer userId){
		String sql="select * from t_sys_user where user_account='"+account+"'";
		if(userId!=null){
			sql+=" and user_id!="+userId;
		}
		return dao.findFirst(sql)!=null?true:false;
	}
	
	
	/**
	 * 删除用户
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
	 * 获取可用的用户
	 * 
	 * @param  
	 * @return			
	 */
	public List<Record> getUsableUser(){
		String sql="select * from t_sys_user where status='1'";
		return Db.find(sql);
	}
	
	/**
	 * 根据用户帐号获取信息
	 * 
	 * @param  		account		登录帐号
	 * @return			
	 */
	public T_Sys_User getUserByAccount(String account){
		return dao.findFirst("select * from t_sys_user where user_account=?", account);
	}
	
	/**
	 * 判断是否为超级管理员
	 * 
	 * @param  		account		登录帐号
	 * @return			
	 */
	public boolean isSuperAdmin(String userId){
		//超级管理员ID,16  
		boolean flag = false;
		Integer roleId=Integer.parseInt(JFWebConfig.attrMap.get("superAdminRoleID"));
		String sql = "select * from t_sys_userroles where role_id =? and user_id=?";
		T_Sys_UserRoles ur = T_Sys_UserRoles.dao.findFirst(sql,roleId,userId);
		if(ur!=null){
			flag = true;
		}
		return flag;
	}
	/**
	 * 获取可用的用户
	 * 
	 * @param  
	 * @return			
	 */
	public List<Record> getUsableUser(String suporg){
		String sql="";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = "select * from t_sys_user where status='1' and dept_id in(select a.d_id from t_sys_department a Start With a.d_id =? Connect By  Prior a.d_id = a.d_pid) ";
			
		}else{
			//循环获得当前节点下的所有子节点
			sql = "select * from t_sys_user where status='1' and dept_id in(SELECT d_id FROM t_sys_department WHERE FIND_IN_SET(d_id, getChildLst(?)))";
		}
		return Db.find(sql,suporg);
	}
	

	/**
	 * 根据用户ID获取用户名称
	 * 
	 * @param    ids    用户id
	 * @return			
	 */
	public String getUserName(String ids){
		String name = "";
		String sql = "";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = "select to_char(wmsys.wm_concat(user_name)) from t_sys_user where user_id in ("+ids+")";
			name = Db.queryStr(sql);
		}else if("mysql".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = "SELECT  GROUP_CONCAT(user_name SEPARATOR ',') AS NAME FROM t_sys_user WHERE user_id IN ("+ids+")";
			name = Db.queryStr(sql);
		}else{
			sql = "select * from t_sys_user where user_id in ("+ids+")";
			List<T_Sys_User> list = dao.find(sql);
			if(list!=null && list.size()>0){
				for(T_Sys_User t : list){
					name = name+","+t.getStr("user_name");
				}
				name = name.substring(1);
			}
		}
		return name;
	}
	
	/**
	 * 根据用户ids，角色ids，获取用户列表
	 * @param objName 	用户名称
	 * @param user 		用户IDs
	 * @param role 		角色IDs
	 * @param notid 	过滤用户IDs
	 * */
	public Page<Record> getUserPage(Integer pageSize,Integer pageNumber,String objName,String user,String role,String notid){
		String select="select u.* ";
		StringBuffer  str = new StringBuffer();
		str.append("from t_sys_user u ");
		if(role!=null && !"".equals(role)){
			str.append(" ,t_sys_userroles ur where u.user_id=ur.user_id and ur.role_id in("+role+")");
		}else{
			str.append(" where u.user_id in ("+user+")");
		}
		if(notid!=null && !"".equals(notid)){
			str.append(" and u.user_id not in("+notid+")");
		}
		if(objName!=null && !"".equals(objName)){
			str.append(" and u.user_name like '%"+objName+"%'");
		}
		str.append(" order by u.user_id desc");
		return Db.paginate(pageNumber, pageSize, select, str.toString());
	}
	
	/**
	 * 根据部门列表，获取列表下的用户
	 * @param	deptlist	部门列表
	 * @param	user		过滤用户
	 * */
	public List<Record> getDeptUser(List<Record> deptlist,String user){
		if(deptlist!=null && deptlist.size()>0){
			String sql = "select * from t_sys_user where 1=1";
			if(user!=null && !"".equals(user)){
				sql = sql + " and user_id not in ("+user+")";
			}
			for(Record dept : deptlist){
				List<Record> ulist = Db.find(sql+" and dept_id="+dept.get("d_id").toString());
				if(ulist!=null && ulist.size()>0){
					dept.set("userlist", ulist);
				}
			}
		}
		return deptlist;
	}
	/**
	 * 根据用户ID，和角色IDs，获取同一个部门的拥有改角色的非当前用户
	 * @param	userid	用户ID
	 * @param	roleids	角色ids
	 * */
	public List<T_Sys_User> getRoleUser(String userid,String roleids){
		String sql = "select distinct u2.* from t_sys_user u1,t_sys_user u2,t_sys_userroles ur where u1.dept_id=u2.dept_id and u1.user_id="+userid
					+" and u2.userid<>"+userid+" and u2.user_id=ur.user_id and ur.role_id in ("+roleids+") order by u2.user_id asc";
		return dao.find(sql);
	}
	/**
	 *根据用户ID，部门id，角色id 获取拥有该角色的所有上级用户
	 *@param	userid	用户ID
	 *@param	roleids	角色ids
	 *@param	deptid	部门ID
	 * */
	public List<T_Sys_User> getRoleUserDept(String userid,String roleids,String deptid){
		String sql = "select distinct u.* from t_sys_user u ,t_sys_userroles ur where u.user_id=ur.user_id and u.dept_id in(";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = sql  +"select distinct d_id from t_sys_department start with d_id="+deptid+" connect by prior d_pid = d_id ";
		}else if("mysql".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = sql +"SELECT distinct d_id FROM t_sys_department WHERE FIND_IN_SET(d_id,getRootLst('"+deptid+"'))";
		}else{
			sql = sql+deptid;
		} 
		sql= sql +") and u.user_id<>"+userid+" and ur.role_id in ("+roleids+") order by u.user_id asc";
		return dao.find(sql);
	} 
	/**
	 *根据用户名获取用户,不包括用户id
	 **@param	name	用户名
	 * @param id 
	 *@param	id	排除用户id
	 * */
	public Page<Record> getUserlist(Integer pageSize,Integer pageNumber,String pid, Number id) {
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize
				: pageSize;
		String sql = "select u.*,d.d_name,c.bo_mobile";
		StringBuffer  str = new StringBuffer();
		str.append("  from t_sys_user u left join t_bus_contactbook c on u.user_id=c.bo_userid,t_sys_department d where  u.dept_id=d.d_id");
		if(pid!=null && !"".equals(pid)){
			str.append(" and u.dept_id=").append(pid);
		}
		if(id!=null && !"".equals(id)){
			str.append(" and u.user_id <>").append(id);
		}
		return Db.paginate(pageNumber, pageSize, sql, str.toString());
	}
	
}
