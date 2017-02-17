package com.lauvan.base.basemodel.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.util.ArrayUtils;

@TableBind(name = "t_sys_module", pk = "id")
public class T_Sys_Module extends Model<T_Sys_Module> {

	private static final long serialVersionUID = 1L;
	
	public static final T_Sys_Module dao=new T_Sys_Module();

	public List<T_Sys_Module> getAllModule(){
		String sql="select * from t_sys_module order by orderindex,id";
		return dao.find(sql);
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
	
	/**
	 * 判断是否存在功能模块标识
	 * @param		mark	功能模块标识
	 * @param		Id		模块id
	 * @return				返回true/false
	 */
	public boolean ifExsitMark(String mark,Integer id){
		String sql="select * from t_sys_module where mark='"+mark+"'";
		if(id!=null){
			sql+=" and id!="+id;
		}
		return dao.findFirst(sql)!=null?true:false;
	}
	
	/**
	 * 判断是否存在子节点模块
	 * @param		Id		模块id
	 * @return				返回true/false
	 */
	public boolean hasSonModule(Integer[] Id){
		String idStr="";
		for(int i=0;i<Id.length;i++){
			idStr+=Id[i]+",";
		}
		idStr=idStr.substring(0, idStr.length()-1);
		String sql="select count(*) from t_sys_module where p_id in ("+idStr+")";
		return Db.queryNumber(sql).intValue()>0;
	}
	
	/**
	 * 根据模块类型查找
	 * @param		typeId	模块类型ID
	 * @return				
	 */
	public List<Record> getListByModelType(Integer typeId){
		String sql="select * from t_sys_module where modeltype="+typeId+" order by p_id,orderindex";
		return Db.find(sql);
	}
	
	/**
	 * 根据是否启用查找
	 * @param		usable	是否启用
	 * @return				
	 */
	public List<Record> getListByUsable(boolean usable){
		String sql="select * from t_sys_module where usable=?";
		return Db.find(sql, usable?1:0);
	}
	
	/**
	 * 根据模块id及父id获取列表
	 * @param		keyId		模块ID
	 * @return		parentId	模块父id
	 */
	public List<Record> findByListId(Integer[] keyId,Integer[] parentId){
		if(keyId==null)
			return null;
		String sql="select t.*,decode(t.id,null,null,(select to_char(wmsys.wm_concat(p.name))"
					+" from t_sys_module p  start with p.id=t.id connect by prior p.p_id=p.id ) ) as onlytext "
					+" from t_sys_module t where t.usable='1' and t.modeltype='0' and t.id in ("+ArrayUtils.ArrayToString(keyId)+")";
		if(parentId!=null)
			sql+=" and t.p_id in ("+ArrayUtils.ArrayToString(parentId)+")";
		sql+=" order by t.p_id,t.orderindex";
		return Db.find(sql);
	}
	
	/**
	 * 根据角色获取不拥有的功能点列表
	 * @param		roleList	角色列表
	 * @return				
	 */
	public List<T_Sys_Module> getExcludeModule(List<T_Sys_Role> roleList){
		if(roleList==null || roleList.size()==0)
			return null;
		
		List<Object> menuIdList=new ArrayList<Object>();
		List<Object> sqlList=new ArrayList<Object>();
		for(T_Sys_Role role:roleList){
			String menuIds=role.getStr("opt_permissions");
			String excludeFunIds=role.getStr("no_permissions");
			if(StringUtils.isNotBlank(menuIds)){
				menuIdList.add(menuIds);
				String sql="";
				sql+="select id from t_sys_module where p_id in ("+menuIds+") and modeltype=1";
				sql+=(StringUtils.isNotBlank(excludeFunIds))?" and id not in ("+excludeFunIds+")":"";
				sqlList.add(sql);
			}
		}
		if(menuIdList.size()!=0){
			String finalSql="select * from t_sys_module where modeltype=1 and p_id in ("+ArrayUtils.ListToString(menuIdList, "")+")";
			finalSql+=" and id not in ("+ArrayUtils.ListToString(sqlList, " union ")+")";
			return dao.find(finalSql);
		}
		else
			return null;
	}
	
	/**
	 * 根据角色获取不拥有的功能点列表数组
	 * @param		roleList	角色列表
	 * @return				
	 */
	public Integer[] getExcludeModuleIds(List<T_Sys_Role> roleList){
		List<T_Sys_Module> list=getExcludeModule(roleList);
		if(list==null || list.size()==0)
			return null;
		Integer[] ids=new Integer[list.size()];
		for(int i=0;i<list.size();i++){
			ids[i]=list.get(i).getBigDecimal("id").intValue();
		}
		return ids;
	}
	
	/**
	 * 根据地址获取启用的功能模块
	 * @param		address	 地址
	 * @return		T_Sys_Module		
	 */
	public T_Sys_Module getByAddress(String address){
		String sql = "select * from t_sys_module where (address = '" + address + "' or address like '" + address + "?%') and usable='1'";
		return dao.findFirst(sql);
	}
	
	/**
	 *获取所有启用的模块信息
	 * @return List<Record>
	 */
	public List<Record> getAllModel(){
		String sql = "select * from t_sys_module where  usable='1' and modeltype='0' order by id ";
		return Db.find(sql);
	}
	/**
	 * 获取一级菜单目录
	 * */
	public List<Record> getFirstMenu(){
		String sql = "select * from t_sys_module where  usable='1' and modeltype='0' and p_id=0 order by orderindex asc ";
		return Db.find(sql);
	}
	
	/**
	 * 根据mark值获取该菜单目录下所有一级目录,包括本身
	 * */
	public List<Record> getChildMenu(String mark){
		String sql = "select m.* from t_sys_module m,t_sys_module t where t.id=m.p_id and  m.usable='1' and m.modeltype='0' and m.address is null" 
				      +" and (t.mark='"+mark+"' or m.mark='"+mark+"')order by m.orderindex asc";
		return Db.find(sql);
	}
	
	/**
	 * 根据id值获取当前菜单下的最大序列
	 * */
	public Integer getMaxIndex(String id){
		String sql = "select max(orderindex) from t_sys_module where p_id="+id;
		Number index = Db.queryNumber(sql);
		if(index!=null){
			return index.intValue();
		}else{
			return 0;
		}
	}
	
	/**
	 * 根据mark值获取菜单
	 * */
	public T_Sys_Module getByMark(String mark){
		String sql = "select * from t_sys_module where mark='"+mark+"'";
		return dao.findFirst(sql);
	}
	
	/**
	 * 根据mark值获取菜单
	 * */
	public Record getByID(String id){
		String sql = "select t.*,decode(t.id,null,null,(select to_char(wmsys.wm_concat(p.name))"
					+" from t_sys_module p  start with p.id=t.id connect by prior p.p_id=p.id ) ) as onlytext "
					+"from t_sys_module t where t.id="+id+"";
		return Db.findFirst(sql);
	}
	
	public T_Sys_Module getRootModule(Integer id){
		String sql=" select * from t_sys_module p  start with p.id=? connect by prior p.p_id=p.id order by p_id";
		return dao.findFirst(sql, id);
	}
}
