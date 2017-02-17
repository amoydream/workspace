package com.lauvan.apps.workcontact.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.TableBind;

/**
 * @author Bob
 * 日常应急组织机构
 */
@TableBind(name="t_bus_organ",pk="or_id")
public class T_Bus_Organ extends Model<T_Bus_Organ> {
	private static final long serialVersionUID = 1L;
	public static T_Bus_Organ dao = new T_Bus_Organ();
	
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
	public List<Record> getAllOrgans(){
		String sql="select * from t_bus_organ order by or_id";
		return Db.find(sql);		
	}
	
	/**
	 * 判断是否存在子机构
	 * 		
	 */
	public boolean hasSonOrgan(Integer[] Id){
		String idStr="";
		for(int i=0;i<Id.length;i++){
			idStr+=Id[i]+",";
		}
		idStr=idStr.substring(0, idStr.length()-1);
		String sql="select count(*) from t_bus_organ where or_pid in ("+idStr+")";
		return Db.queryNumber(sql).intValue()>0;
	}
	
	/**
	 * 获取组织机构树结构json
	 * 
	 * @param   parentRec   欲获取树的根节点对象(null为获取所有节点)
	 * @param   deptList	组织机构所有数据
	 * @return				返回树结构json
	 * @throws Exception    异常
	 */
	public String getOrganTreeData(Record parentRec,List<Record> organList) throws Exception{
		
		try{
			List<Map<String,Object>> rootList=new ArrayList<Map<String,Object>>();
			if(organList!=null){
				if(parentRec==null){
					for(Record organ:organList){
						if(organ.getNumber("or_pid").intValue()==0)
							rootList.add(getChildrenNode(organ, organList));
					}
				}else
					rootList.add(getChildrenNode(parentRec, organList));
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
	public Map<String,Object> getChildrenNode(Record parentRec,List<Record> organList){
		List<Map<String,Object>> childList=new ArrayList<Map<String,Object>>();
		Map<String,Object> parentMap = new HashMap<String,Object>();
		
		parentMap.put("id", parentRec.get("or_id"));
		parentMap.put("text", parentRec.get("or_name"));
		
		for(Record rec:organList){
			if(parentRec.get("or_id").equals(rec.get("or_pid"))){
				childList.add(getChildrenNode(rec, organList));
			}
		}
		
		if(childList.size()!=0)
			parentMap.put("children", childList);
		
		return parentMap;
		
	}
	/**
	 * 判断组织机构是否存在
	 * 
	 * @param        机构名称
	 * @param    
	 * @return			
	 */
	public boolean ifExsitOrgan(String or_name){
		String sql="select * from t_bus_organ where or_name='"+or_name+"'";
		return dao.findFirst(sql)!=null?true:false;
	}
	
	/**
	 * 根据机构名称获取信息
	 * 
	 * @param  		account		登录帐号
	 * @return			
	 */
	public T_Bus_Organ getOrganByName(String organName){
		return dao.findFirst("select * from t_bus_organ where or_name=?", organName);
	}

	/**
	 * 查找机构列表
	 * @param pageSize
	 * @param pageNumber
	 * @param pid
	 * @return
	 */
	public Page<Record> getPageByPid(Integer pageSize, Integer pageNumber, String pid){
		pageNumber = pageNumber == null || pageNumber < 1 ? 1 : pageNumber;
		pageSize = pageSize == null || pageSize < 1 ? JFWebConfig.pageSize: pageSize;
		String select = "select *";
		StringBuffer sql = new StringBuffer(" from t_bus_organ where 1=1 "); 
		if(pid !=null && !"".equals(pid)){
			sql.append("and or_pid =").append(pid);
		}
		return Db.paginate(pageNumber, pageSize, select, sql.toString());
	}
	/**
	 * 递归获取所有子id
	 */
	public List<Record> getAllChildId(String orid){
		String sql = "select o.or_id from T_BUS_ORGAN o start with o.or_id="+orid+" connect by o.or_pid=prior o.or_id";		
		return Db.find(sql);
	}
	
}
