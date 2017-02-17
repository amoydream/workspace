package com.lauvan.apps.geographic.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Clear;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.comdecivemanagement.model.T_DeviceInfo;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.apps.geographic.model.T_Bus_MapConfig;
import com.lauvan.apps.resource.assets.model.T_Bus_Cases;
import com.lauvan.apps.resource.assets.model.T_Bus_Equipstore;
import com.lauvan.apps.resource.assets.model.T_Bus_Expert;
import com.lauvan.apps.resource.assets.model.T_Bus_Shelter;
import com.lauvan.apps.resource.assets.model.T_Bus_Team;
import com.lauvan.apps.resource.material.model.T_Bus_Repertory;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.core.annotation.RouteBind;

/**
 * 全景地图控制类
 * @author chen  2016/06/08
 *
 */
@SuppressWarnings("deprecation")
@RouteBind(path = "Main/geographic/overall", viewPath = "/geographic/overall")
public class OverallViewController extends BaseController {

	public void index() {

	}

	public void main() {
		T_Bus_MapConfig config = T_Bus_MapConfig.dao.getData();
		if(config == null) {
			renderText("未配置地图基本信息！");
			return;
		}

		boolean isOnline = !config.getStr("onlinemap").equals("0");

		setAttr("lng", config.get("lng"));
		setAttr("lat", config.get("lat"));
		setAttr("zoom", config.get("zoom"));

		if(!isOnline) {
			String apiUrl = config.getStr("apiurl"), gisUrl = config.getStr("gisurl");
			if(apiUrl.isEmpty()) {
				renderText("未配置离线地图api地址");
				return;
			}
			if(gisUrl.isEmpty()) {
				renderText("未配置离线地图地址");
				return;
			}
			setAttr("gisUrl", gisUrl);
			setAttr("apiUrl", apiUrl);
			render("offline_main.jsp");
		} else {
			render("online_main.jsp");
		}

	}

	/**
	 * 获取通信设备信息
	 */
	@Clear
	public void getCommEqu() {
		List<Record> deviceList = T_DeviceInfo.dao.getGridPage(1, 10000, null, null, null).getList();

		List<T_Sys_Parameter> typeList = T_Sys_Parameter.dao.getChildByAcode("TXSBLX");

		Map<String, Object> treeNode = new HashMap<String, Object>();
		List<Map<String, Object>> nodeList = new ArrayList<Map<String, Object>>();

		for(T_Sys_Parameter type : typeList) {
			treeNode = new HashMap<String, Object>();
			String typeCode = type.getStr("p_acode");
			treeNode.put("id", typeCode);
			treeNode.put("pId", 0);
			treeNode.put("root", true);
			treeNode.put("name", type.getStr("p_name"));

			nodeList.add(treeNode);
		}

		for(Record device : deviceList) {
			treeNode = new HashMap<String, Object>();
			treeNode.put("id", device.getNumber("id"));
			treeNode.put("pId", device.getStr("dtype"));
			treeNode.put("name", device.getStr("dname"));
			treeNode.put("code", device.getStr("dcode"));
			treeNode.put("address", device.getStr("address"));
			treeNode.put("ip", device.getStr("ip"));
			treeNode.put("port", device.getStr("port"));
			treeNode.put("lat", device.getStr("pointy"));
			treeNode.put("lng", device.getStr("pointx"));
			nodeList.add(treeNode);
		}

		String json = JsonKit.toJson(nodeList);
		System.out.println(json);
		renderJson(nodeList);
	}

	/**
	 * 返回ztree对象json
	 * @param rootNode 		对象数组
	 * @param rootCode		根节点ID
	 * @param rootName		根节点名称
	 * @param typeList		数据对应分类集合
	 * @param dataList		数据对象
	 * @param relationAttr	关联属性名
	 * @param flag			是否为存储类型数据id  true:存储id  false:p_acode
	 */
	public void addTreeRoot(List<Map<String, Object>> rootNode, String rootCode, String rootName, List<Record> typeList, List<Record> dataList, String relationAttr, boolean flag) {

		Map<String, Object> treeNode = new HashMap<String, Object>();
		List<Object> tempList = new ArrayList<Object>();
		String paramsAttr = flag ? "id" : "p_acode";
		String parentId = rootCode;

		T_Sys_Parameter paramsRoot = T_Sys_Parameter.dao.getByCode3(rootCode);

		treeNode.put("id", rootCode);
		treeNode.put("name", rootName);
		treeNode.put("pId", 0);
		treeNode.put("root", true);
		rootNode.add(treeNode);

		for(Record tempType : typeList) {
			tempList = new ArrayList<Object>();
			treeNode = new HashMap<String, Object>();

			if(!tempType.get("sup_id").equals(paramsRoot.get("id"))) {
				parentId = rootCode + "_" + tempType.getNumber("sup_id");
			} else {
				parentId = rootCode;
			}

			for(Record temp : dataList) {
				if(tempType.get(paramsAttr).equals(temp.get(relationAttr))) {
					tempList.add(temp);
				}
			}

			treeNode.put("id", rootCode + "_" + tempType.get("id"));
			treeNode.put("pId", parentId);
			treeNode.put("name", tempType.get("p_name"));
			treeNode.put("data", tempList);
			rootNode.add(treeNode);
		}
	}

	public void getResource() {
		//获取应急队伍类型
		String typeName = "YJDW";
		List<Record> typeList = T_Sys_Parameter.dao.getParamByCode(typeName, false);
		List<Record> dataList = T_Bus_Team.dao.getPage(10000, 1, null, typeName).getList();

		List<Map<String, Object>> nodeList = new ArrayList<Map<String, Object>>();

		addTreeRoot(nodeList, typeName, "应急队伍", typeList, dataList, "type", false);

		//获取应急专家
		typeName = "YJZJ";
		typeList = T_Sys_Parameter.dao.getParamByCode(typeName, false);
		dataList = T_Bus_Expert.dao.getPage(10000, 1, null).getList();
		addTreeRoot(nodeList, typeName, "应急专家", typeList, dataList, "typeid", true);

		//获取物资仓库
		typeName = "MALEVE";
		typeList = T_Sys_Parameter.dao.getParamByCode(typeName, false);
		dataList = T_Bus_Repertory.dao.getPage(10000, 1, null, typeName, "MADEFE").getList();
		addTreeRoot(nodeList, typeName, "物资仓库", typeList, dataList, "levelcode", false);

		//获取应急装备
		typeName = "EQTYPE";
		typeList = T_Sys_Parameter.dao.getParamByCode(typeName, false);
		dataList = T_Bus_Equipstore.dao.getPage(10000, 1, typeName).getList();
		addTreeRoot(nodeList, typeName, "应急装备", typeList, dataList, "p_id", true);

		//获取避难场所
		typeName = "SHTYPE";
		typeList = T_Sys_Parameter.dao.getParamByCode(typeName, false);
		dataList = T_Bus_Shelter.dao.getPage(10000, 1, null, typeName).getList();
		addTreeRoot(nodeList, typeName, "应急避难所", typeList, dataList, "type", false);

		//应急案例
		typeName = "EVTP";
		typeList = T_Sys_Parameter.dao.getParamByCode(typeName, false);
		dataList = T_Bus_Cases.dao.getPage(10000, 1, null, typeName, "EVLV").getList();
		addTreeRoot(nodeList, typeName, "应急案例", typeList, dataList, "type", false);

		String json = JsonKit.toJson(nodeList);
		System.out.println(json);
		renderJson(nodeList);
	}

	/**
	 * 更新事件经纬度
	 */
	@Clear
	public void updateEventLocation() {
		Integer id = getParaToInt("id");
		String lng = getPara("lng");
		String lat = getPara("lat");
		Integer flag = getParaToInt("flag"); //0：更新  1：删除

		if(id == null || flag == 0 && (lng.isEmpty() || lat.isEmpty())) {
			renderFail("传递参数不正确！");
			return;
		}

		T_Bus_EventInfo info = T_Bus_EventInfo.dao.findById(id);
		if(info != null) {
			if(flag == 1) {
				lng = "";
				lat = "";
			}
			info.set("EV_LONGITUDE", lng).set("EV_LATITUDE", lat).update();
			renderSuccess();

		} else {
			renderFail("该事件不存在!");
		}
	}

	public void renderSuccess() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", true);
		renderJson(map);
	}

	public void renderFail(String msg) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", false);
		map.put("msg", msg);
		renderJson(map);
	}

}
