package com.lauvan.base.basemodel.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

@TableBind(name = "t_sys_department", pk = "d_id")
public class T_Sys_Department extends Model<T_Sys_Department> {

	private static final long serialVersionUID = 1L;
	
	public static T_Sys_Department dao=new T_Sys_Department();
	
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
	 * 获取所有组织机构
	 * 
	 * @return				返回List对象
	 */
	public List<Record> getAllDepartments(){
		String sql="select * from t_sys_department order by orderid asc,d_id asc";
		return Db.find(sql);
	}
	
	public boolean ifExsitDeptCode(String code,Integer d_id){
		String sql="select * from t_sys_department where d_number='"+code+"'";
		if(d_id!=null){
			sql+=" and d_id!="+d_id;
		}
		return dao.findFirst(sql)!=null?true:false;
	}
	
	/**
	 * 根据d_pid获取组织机构对象
	 * @param		Ids		id数组
	 * @return				返回true/false
	 */
	public List<T_Sys_Department> findByPIds(Integer[] Ids){
		String idStr="";
		for(int i=0;i<Ids.length;i++){
			idStr+=Ids[i]+",";
		}
		idStr=idStr.substring(0, idStr.length()-1);
		String sql="select * from t_sys_department where d_pid in ("+idStr+")";
		return dao.find(sql);
	}
	
	public boolean hasSonDepartment(Integer[] Id){
		String idStr="";
		for(int i=0;i<Id.length;i++){
			idStr+=Id[i]+",";
		}
		idStr=idStr.substring(0, idStr.length()-1);
		String sql="select count(*) from t_sys_department where d_pid in ("+idStr+")";
		return Db.queryNumber(sql).intValue()>0;
	}
	
	/**
	 * 获取最顶层部门信息
	 * @param		deptId		部门ID
	 * @return				
	 */
	public T_Sys_Department getRootDepartment(Integer deptId){
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			String sql="select * from (select a.* from t_sys_department a Start With a.d_id =? Connect By    Prior a.d_pid = a.d_id ) where d_pid=0";
			return dao.findFirst(sql, deptId);
		}else{
			//循环获得最顶层部门信息
			T_Sys_Department t = dao.findById(deptId);
			while(t!=null){
				if(0==deptId ||"0".equals(t.get("d_pid").toString())){
					break;
				}
				t =  dao.findById(t.get("d_pid"));
			}
			return t;
		}
		
	}
	
	/**
	 * 循环获取当前节点下的所有子节点
	 * @param		deptId		当前部门ID
	 * @return				
	 */
	public List<Record> getDepartmentList(String deptId){
		String sql="";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = "select a.* from t_sys_department a Start With a.d_id =? Connect By  Prior a.d_id = a.d_pid ";
			
		}else{
			//循环获得当前节点下的所有子节点
			sql = "SELECT * FROM t_sys_department WHERE FIND_IN_SET(d_id, getChildLst(?))";
		}
		return Db.find(sql, deptId);
	}
	
	/**
	 * 循环获取当前节点下的所有子节点除特殊节点外
	 * @param		deptId		当前部门ID
	 * @param		extId		特殊节点ID
	 * @return				
	 */
	public List<Record> getDepartmentExtList(String deptId,String extId){
		String sql="";
		if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
			sql = "select a.* from t_sys_department a Start With a.d_pid =? and a.d_id<>"+extId
					+" Connect By  Prior a.d_id = a.d_pid and a.d_id<>"+extId;
			
		}else{
			//循环获得当前节点下的所有子节点
			sql = "SELECT * FROM t_sys_department WHERE FIND_IN_SET(d_id, getChildLstExt(?,"+extId+"))";
		}
		return Db.find(sql, deptId);
	}
	
	/**
	 * 获取组织机构树结构json
	 * 
	 * @param   parentRec   欲获取树的根节点对象(null为获取所有节点)
	 * @param   deptList	组织机构所有数据
	 * @return				返回树结构json
	 * @throws Exception    异常
	 */
	public String getDeptTreeData(Record parentRec,List<Record> deptList) throws Exception{
		
		try{
			List<Map<String,Object>> rootList=new ArrayList<Map<String,Object>>();
			if(deptList!=null){
				if(parentRec==null){
					for(Record dept:deptList){
						if(dept.getNumber("d_pid").intValue()==0)
							rootList.add(getChildrenNode(dept, deptList));
					}
				}else
					rootList.add(getChildrenNode(parentRec, deptList));
			}
			return JSONArray.toJSONString(rootList);
		}catch (Exception e) {
			throw e;
		}
	}
	
	/**
	 * 获取树当前节点所有子节点数据，用于递归
	 * 
	 * @param   parentRec   节点对象
	 * @param   deptList	节点所有数据对象
	 * @return				返回树结构json
	 */
	public Map<String,Object> getChildrenNode(Record parentRec,List<Record> deptList){
		List<Map<String,Object>> childList=new ArrayList<Map<String,Object>>();
		Map<String,Object> parentMap = new HashMap<String,Object>();
		
		parentMap.put("id", parentRec.get("d_id"));
		parentMap.put("text", parentRec.get("d_name"));
		
		for(Record rec:deptList){
			if(parentRec.get("d_id").equals(rec.get("d_pid"))){
				childList.add(getChildrenNode(rec, deptList));
			}
		}
		
		if(childList.size()!=0)
			parentMap.put("children", childList);
		
		return parentMap;
		
	}
	
	/**
	 * 根据部门名称和所属地获取部门
	 * @param   name   部门名称
	 * @param   supcode	根节点id
	 * @return			部门
	 * */
	public T_Sys_Department getDepartByName(String name,String supcode){
		String sql = "select d.* from t_sys_department d where d.d_name='"+name+"'";
		if(supcode!=null && !"".equals(supcode)){
			if("oracle".equals(JFWebConfig.attrMap.get("dbaType"))){
				sql = sql + " and d.d_id in (select a.d_id from t_sys_department a Start With a.d_id ="+supcode
						+" Connect By  Prior a.d_id = a.d_pid)";
				
			}else{
				//循环获得当前节点下的所有子节点
				sql = " and d.d_id in (SELECT d_id FROM t_sys_department WHERE FIND_IN_SET(d_id, getChildLst("+supcode+")))";
			}
		}
		return dao.findFirst(sql);
	}
	public List<Record> getOrgans(List<T_Sys_Department> baseorgans) {
		String sql = "select * from t_sys_department Start With d_id="+baseorgans.get(0).get("d_id")+" Connect By Prior d_id = d_pid ";
		for(int i=1;i<baseorgans.size();i++){
			sql+=" union select * from t_sys_department Start With d_id="+baseorgans.get(i).get("d_id")+" Connect By Prior d_id = d_pid ";
		}
		return Db.find(sql);
	}
}
