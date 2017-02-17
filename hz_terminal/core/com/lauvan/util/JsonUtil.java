package com.lauvan.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.simple.JSONArray;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Record;

public class JsonUtil {
	
	/**
	 * 对象数组转成datagrid json数据
	 * @param		list		要封装的数据对象数组
	 * @param		totalCount	数据总纪录数
	 * 
	 * @return					返回json
	 */
	public static String getGridData(List<Record> list,int totalCount){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("rows", list);
		map.put("total", totalCount);
		
		String json=JsonKit.toJson(map);
		System.out.println(json);
		return  json;
	}
	
	/**
	 * 对象数组转成treegrid json数据
	 * @param		list		要封装的数据对象数组
	 * @param		totalCount	数据总纪录数
	 * 
	 * @return					返回json
	 */
	public static String getTreeGridData(List<Record> list,int totalCount,String pidKey){
		
		Map<String,Object> map = new HashMap<String,Object>();
		for(Record data:list){
			Integer pid = data.get(pidKey)==null?0:Integer.parseInt(data.get(pidKey).toString());
			data.set("_parentId", pid);
		}
		map.put("rows", list);
		map.put("total", totalCount);
		
		String json=JsonKit.toJson(map);
		System.out.println(json);
		json = json.replaceAll("_PARENTID", "_parentId");
		json = json.replaceAll("ICONCLS", "iconCls");
		json = json.replaceAll("STATE", "state");
		return  json;
	}
	
	public static String getComboxData(List<Record> list,String idName,String txtName){
		List<Map<String,Object>> resultList=new ArrayList<Map<String,Object>>();
		Map<String,Object> map=new HashMap<String, Object>();
		
		for(Record de:list){
			map=new HashMap<String, Object>();
			map.put("id", de.get(idName).toString().trim());
			map.put("text", de.get(txtName).toString().trim());
			resultList.add(map);
		}
		return JSONArray.toJSONString(resultList);
	}
	
	public static String getComboxData(Map<String,String> map){
		List<Map<String,Object>> resultList=new ArrayList<Map<String,Object>>();
		Map<String,Object> resultMap=new HashMap<String, Object>();
		Set<String> set=map.keySet();
		Iterator<String> it=set.iterator();
		while(it.hasNext()){
			String key=it.next();
			String value=map.get(key);
			
			resultMap=new HashMap<String, Object>();
			resultMap.put("id", key);
			resultMap.put("text", value);
			resultList.add(resultMap);
		}
		return JSONArray.toJSONString(resultList);
	}
	
	/**
	 * 获取easyui-tree json
	 * 
	 * @param   parentRec   欲获取树的根节点对象(null为获取所有节点)
	 * @param   deptList	组织机构所有数据
	 * @param	keyField	主键id字段名
	 * @param	pidFielid	关联父记录字段名
	 * @param	outputKey	输出json字段名与deptList对应的属性名
	 * @return				返回树结构json
	 * @throws Exception    异常
	 */
	public static String getTreeData(Record parentRec,boolean isHideRootNode,List<Record> list,String keyField,String pidFielid,Map<String, String> outputKey) throws Exception{
		
		try{
			List<Map<String,Object>> rootList=new ArrayList<Map<String,Object>>();
			if(list!=null){
				if(parentRec==null){
					for(Record dept:list){
						if("0".equals(dept.get(pidFielid).toString()))
							rootList.add(getChildrenNode(dept, list,keyField,pidFielid,outputKey));
					}
				}else{
					if(isHideRootNode){
						for(Record rec:list){
							if(rec.get(pidFielid).toString().equals(parentRec.get(keyField).toString())){
								rootList.add(getChildrenNode(rec, list,keyField,pidFielid,outputKey));
							}
						}
					}
					else
						rootList.add(getChildrenNode(parentRec, list,keyField,pidFielid,outputKey));
				}
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
	@SuppressWarnings("unchecked")
	public static Map<String,Object> getChildrenNode(Record parentRec,List<Record> list,String keyField,String pidFielid,Map<String, String> outputKey){
		List<Map<String,Object>> childList=new ArrayList<Map<String,Object>>();
		Map<String,Object> parentMap = new HashMap<String,Object>();
		
		Set set= outputKey.entrySet();
		Iterator it=set.iterator();
		while(it.hasNext()){
			Map.Entry<String, String> entry=(Map.Entry<String, String>)it.next(); 
			parentMap.put(entry.getKey(), parentRec.get(entry.getValue()));
		}
		
		for(Record rec:list){
			if(parentRec.get(keyField).toString().equals(rec.get(pidFielid).toString())){
				childList.add(getChildrenNode(rec, list,keyField,pidFielid,outputKey));
			}
		}
		
		if(childList.size()!=0){
			parentMap.put("children", childList);
			parentMap.put("state", "closed");
		}
		
		return parentMap;
		
	}
}
