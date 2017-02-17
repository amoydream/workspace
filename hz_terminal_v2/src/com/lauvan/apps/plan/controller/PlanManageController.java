package com.lauvan.apps.plan.controller;
/**
 * 预案综合管理控制类
 * */
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.comdecivemanagement.controller.ComDeciveMgController;
import com.lauvan.apps.plan.model.T_Bus_PlanItem;
import com.lauvan.apps.plan.model.T_Bus_PreschAction;
import com.lauvan.apps.plan.model.T_Bus_PreschActionDept;
import com.lauvan.apps.plan.model.T_Bus_PreschLaw;
import com.lauvan.apps.plan.model.T_Bus_PreschPhase;
import com.lauvan.apps.plan.model.T_Bus_Preschinfo;
import com.lauvan.apps.resource.assets.model.T_Bus_Equipstore;
import com.lauvan.apps.resource.assets.model.T_Bus_Expert;
import com.lauvan.apps.resource.assets.model.T_Bus_Team;
import com.lauvan.apps.resource.material.model.T_Bus_Store;
import com.lauvan.apps.workcontact.model.T_Bus_EmergencyContact;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;
import com.lauvan.util.StrappUtil;
@RouteBind(path="Main/planMg",viewPath="/plan/management")
public class PlanManageController extends BaseController {
	private static final Logger log = Logger.getLogger(ComDeciveMgController.class);
	public void index(){
		//预案分类
		List<Record> plist = T_Sys_Parameter.dao.getParamByCode("YAFL",false);
		setAttr("plist",plist);
		render("main.jsp");
	}
	
	public void getView(){
		String id = getPara(0);
		String flag = getPara(1);
		String type=getPara(2);
		setAttr("id",id);
		setAttr("flag",flag);
		setAttr("type",type);
		if(flag!=null&&"view".equals(flag)){
			render("view.jsp");
		}else{
			render("modelview.jsp");
		}
		
	}
	//获取应急机构
	public void getOrgan(){
		String id = getPara(0);
		//查询预案拥有的应急机构
		List<Record> list = T_Bus_PlanItem.dao.getListByIdCode(id, "2000");
		setAttr("orglist",list);
		setAttr("preschid",id);
		setAttr("flag",getPara(1));
		render("organ.jsp");
	}
	public void getOrganData(){
		String id = getPara(0);
		String jsonStr = "[]";
		T_Bus_PlanItem t = T_Bus_PlanItem.dao.findById(id);
		if(t!=null){
			String itemid = t.getStr("itemid");
			if(itemid!=null && !"".equals(itemid)){
				List<Record> list = T_Bus_PlanItem.dao.getOrgList(itemid);
				jsonStr = JsonKit.toJson(list);
			}
		}
		renderText(jsonStr);
	}
	public void getResourcelist(){
		String preschid = getPara("preschid");
		String pid = getPara("pid");
		String code = getPara("code");
		List<Record> list = T_Bus_PlanItem.dao.getListByIdResCode( preschid, pid, code);
		List<Record> datalist=new ArrayList<Record>();
		String id="";
		String type="";
		String path = getRequest().getContextPath();
		String basePath = getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort()+path+"/";
		if(!list.isEmpty()){
			for(Record r:list){
			id=r.get("id").toString();
			type=r.get("PLANITEMCODE").toString();
			T_Bus_PlanItem pi=T_Bus_PlanItem.dao.findById(id);
			int itemid=Integer.valueOf(pi.get("itemid").toString());
			if(type.equals("3020")){
			List<Record> wzlist=T_Bus_Store.dao.getListbymatid(Integer.valueOf(itemid));
			if(!wzlist.isEmpty()){
				for(Record re:wzlist){
					Record data=new Record();
					data.set("type", "yjwz");
					data.set("lng", Double.valueOf(re.get("longitude").toString()));
					data.set("lat", Double.valueOf(re.get("latitude").toString()));
					data.set("url",basePath+"Main/store/getview/"+re.getBigDecimal("sto_id"));
					datalist.add(data);
				}
			}
			}else if(type.equals("2080")){
			T_Bus_Expert zj=T_Bus_Expert.dao.findById(itemid);
			if(zj!=null){
			Record data=new Record();	
			data.set("type", "yjzj");
			data.set("lng", Double.valueOf(zj.get("longitude").toString()));
			data.set("lat", Double.valueOf(zj.get("latitude").toString()));
			data.set("url",basePath+"Main/expert/getview/"+zj.getBigDecimal("ex_id"));
			datalist.add(data);
			}
			}else if(type.equals("3010")){
			T_Bus_Team team = T_Bus_Team.dao.getById(itemid);
			if(team!=null){
			Record data=new Record();	
			data.set("type", "yjdw");
			data.set("lng", Double.valueOf(team.get("tea_longitude").toString()));
			data.set("lat", Double.valueOf(team.get("tea_latitude").toString()));
			data.set("url",basePath+"Main/team/getview/"+team.getBigDecimal("tea_id"));
			datalist.add(data);	
			}
			}else if(type.equals("3030")){
				List<Record> zblist=T_Bus_Equipstore.dao.getListbymatid(Integer.valueOf(itemid));
				if(!zblist.isEmpty()){
					for(Record re:zblist){
						Record data=new Record();
						data.set("type", "yjzb");
						data.set("lng", Double.valueOf(re.get("longitude").toString()));
						data.set("lat", Double.valueOf(re.get("latitude").toString()));
						data.set("url",basePath+"Main/equipstore/getview/"+re.getBigDecimal("eqs_id"));
						datalist.add(data);
					}
				}
			}	
			}
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("datalist", datalist);
		renderJson(map);
	}
	public void getResourceData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String itemname = getPara("itemname");
		String swhere = "";
		if(itemname!=null && !"".equals(itemname)){
			swhere = swhere +" and p.itemname like '%"+itemname+"%'";
		}
		String preschid = getPara("preschid");
		String pid = getPara("pid");
		String code = getPara("code");
		/*if("3000".equals(code)){
			code = "";
			swhere = swhere +" and p.planitemcode in('3010','3020','3030','2080')";
		}*/
		Page<Record> page = T_Bus_PlanItem.dao.getPageByIdResCode(pageSize, pageNumber, preschid, pid, code, swhere);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void getOrganTreeData(){
		String pid = getPara("id");
		String preschid = getPara("preschid");
		Record root = null;
		if(pid==null || "".equals(pid)){
			pid = "0";
			root = new Record();
			root.set("ID", "0");
			root.set("ITEMNAME", "应急机构");
			root.set("PID", "0");
			root.set("ISLEAF", 1);
		}
		List<Record> list = T_Bus_PlanItem.dao.getTreeData(pid,preschid);
		if(root!=null){
			list.add(root);
		}
		renderJson(list);
	}
	//获取资源
	public void getResource(){
		String id = getPara(0);
		setAttr("id",id);
		setAttr("flag",getPara(1));
		render("resource.jsp");
	}
	//获取事件级别
	public void getEventLevel(){
		String id = getPara(0);
		setAttr("preschid",id);
		setAttr("flag",getPara(1));
		render("eventlevel.jsp");
	}
	//获取处置过程
	public void getProcess(){
		String id = getPara(0);
		setAttr("preschid",id);
		//查询预案的所有列段流程
		List<Record> plist = T_Bus_PreschPhase.dao.getListByPresch(id, null);
		List<Record> alist = T_Bus_PreschAction.dao.getListByPresch(id, null);
		setAttr("plist",plist);
		setAttr("alist",alist);
		setAttr("flag",getPara(1));
		render("process.jsp");
	}
	public void getProcessData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String preschid = getPara(0);
		String pid = getPara(1);
		String flag = getPara(2);
		Page<Record> page = T_Bus_PreschPhase.dao.getPageByPresch(pageSize, pageNumber, preschid, pid, flag);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void getProcessTreeData(){
		String pid = getPara("id");
		String preid = getPara("preid");
		Record root = null;
		if(pid==null || "".equals(pid)){
			pid = "0";
			root = new Record();
			root.set("ID", "0");
			root.set("PROCESSNAME", "应急处置");
			root.set("PID", "0");
			root.set("ISLEAF", 1);
		}
		List<Record> list = T_Bus_PreschPhase.dao.getTreeListByPresch(preid, pid);
		if(root!=null){
			list.add(root);
		}
		renderJson(list);
	}
	
	//获取发布信息单位
	public void getInformation(){
		String id = getPara(0);
		setAttr("id",id);
		setAttr("flag",getPara(1));
		render("information.jsp");
	}
	public void getItemData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String itemname = getPara("itemname");
		String swhere = "";
		if(itemname!=null && !"".equals(itemname)){
			swhere = swhere +" and p.itemname like '%"+itemname+"%'";
		}
		String preschid = getPara("preschid");
		String pid = getPara("pid");
		String code = getPara("code");
		if("3000".equals(code)){
			code = "";
			swhere = swhere +" and p.planitemcode in('3010','3020','3030','2080')";
		}
		if("1000".equals(code)){
			code = "";
			swhere = swhere +" and p.planitemcode in('1010','8010')";
		}
		Page<Record> page = T_Bus_PlanItem.dao.getPageByIdCode(pageSize, pageNumber, preschid, pid, code, swhere);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	//获取选择机构/人员页面
	public void getOrganTree(){
		String groupid = getPara(0);
		T_Bus_PlanItem groupOrg = T_Bus_PlanItem.dao.findById(groupid);
		//获取组织机构
		List<Record> olist = T_Sys_Department.dao.getAllDepartments();
		if(olist!=null && olist.size()>0){
			for(Record organ : olist){
				String pid = organ.get("d_pid").toString();
				organ.set("pid", "d_"+pid);
				organ.set("upid", "u_"+pid);
			}
		}
		setAttr("orglist",olist);
		//日常机构人员
		List<Record> deptlist = T_Bus_Organ.dao.getAllOrgans();
		if(deptlist!=null && deptlist.size()>0){
			for(Record organ2 : deptlist){
				String pid = organ2.get("or_pid").toString();
				organ2.set("pid", "od_"+pid);
				organ2.set("upid", "ou_"+pid);
			}
		}
		setAttr("orglist2",deptlist);
		//获取群组
		List<Record> clulist = T_Bus_EmergencyContact.dao.getAllEmergencys();
		if(clulist!=null && clulist.size()>0){
			for(Record clu : clulist){
				String pid = clu.get("e_pid").toString();
				clu.set("epid", "c_"+pid);
			}
		}
		setAttr("clulist",clulist);
		setAttr("groupOrg",groupOrg);
		//已勾选机构/人员
		if(groupOrg!=null){
			if(groupOrg.getStr("itemid")!=null && !"".equals(groupOrg.getStr("itemid"))){
				List<Record> orgper = T_Bus_PlanItem.dao.getOrgList(groupOrg.getStr("itemid"));
				setAttr("orgper",orgper);
			}
		}
		if("orgper2".equals(getPara(1))){
			render("findData/organList2.jsp");
		}else{
			render("findData/organList.jsp");
		}
	}
	public void getSmsList(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String id = getPara(0);
		//String bname = getPara("bname");
		String jsonStr = "[]";
		if(!"0".equals(id)){
			Page<Record> page = T_Bus_PlanItem.dao.getPageBySmsid(pageSize, pageNumber, id);
			List<Record> list=page.getList();
			int totalCount=page.getTotalRow();
			//调用JsonUtil函数返回datagrid表格json数据
			jsonStr=JsonUtil.getGridData(list, totalCount);
		}
		renderText(jsonStr);
	}
	
	public void getResourceList(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String id = getPara(1);
		String code = getPara(0);
		String preschid = getPara(2);
		String bname = getPara("bname");
		String jsonStr = "[]";
		String swhere = "";
		if(bname!=null && !"".equals(bname)){
			swhere = swhere +" and e.name like '%"+bname+"%'";
		}
		if(!"0".equals(id)){
			Page<Record> page = T_Bus_PlanItem.dao.getPageByRecid(pageSize, pageNumber, code, id, preschid,swhere);
			List<Record> list=page.getList();
			int totalCount=page.getTotalRow();
			//调用JsonUtil函数返回datagrid表格json数据
			jsonStr=JsonUtil.getGridData(list, totalCount);
		}
		renderText(jsonStr);
	}
	//获取流程节点树
	public void getPhaseTree(){
		String jsonStr = "[]";
		try {
			String pid = getPara(0);
			List<Record> list = T_Bus_PreschPhase.dao.getPhaseTree(pid);
			Record root = new Record();
			root.set("phaseid", "0");
			root.set("phasename", "应急处置");
			Map<String,String> outputKey = new HashMap<String,String>();
			outputKey.put("id", "phaseid");
			outputKey.put("text", "phasename");
			jsonStr=JsonUtil.getTreeData(root, false, list, "phaseid", "fatherid", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}
	public void getPhaseList(){
		String jsonStr = "[]";
		try {
			String pid = getPara(0);
			String preschid = getPara(1);
			List<Record> list = T_Bus_PreschPhase.dao.getPhaseList(pid,preschid);
			jsonStr = JsonKit.toJson(list);
			jsonStr = jsonStr.replace("\"PHASEID\"", "\"id\"").replaceAll("\"PHASENAME\"", "\"text\"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}
	public void add(){
		String flag = getPara(0);
		String id = getPara(1);
		String preschid = getPara(2);
		if("organ".equals(flag)){
			//应急机构
			T_Bus_PlanItem p = T_Bus_PlanItem.dao.findById(id);
			setAttr("p",p);
			setAttr("preschid",preschid);
			render("add_organ.jsp");
		}else if("plevel".equals(flag)){
			if(id==null ||"".equals(id) || "1000".equals(id)){
				toDwzText(false, "请选择事件类型或事件级别添加！", "", "", "", "closeCurrent");
				return;
			}
			setAttr("codetype",id);
			setAttr("preschid",preschid);
			render("add_level.jsp");
		}else if("pinformation".equals(flag)){
			setAttr("preschid",preschid);
			render("add_information.jsp");
		}else if("presource".equals(flag)){
			//root
			T_Sys_Parameter root = null;
			List<Record> rlist = null;
			String pcode = "";
			if("3020".equals(id)){
				pcode = "MATYPE";
			}else if("2080".equals(id)){
				pcode = "YJZJ";
			}else if("3010".equals(id)){
				pcode = "YJDW";
			}else if("3030".equals(id)){
				pcode = "EQTYPE";
			}
			root = T_Sys_Parameter.dao.getByCode3(pcode);
			rlist = T_Sys_Parameter.dao.getParamByCode(pcode, false);
			setAttr("rlist",rlist);
			//rlist
			//获取已勾选的物资
			List<Record> reslist = T_Bus_PlanItem.dao.getListByIdCode(preschid, id);
			setAttr("preschid",preschid);
			setAttr("codetype",id);
			setAttr("reslist",reslist);
			setAttr("root",root);
			render("findData/resourceList.jsp");
		}else if("pprocess".equals(flag)){
			String codeflag = getPara(3);
			setAttr("codetype",codeflag);
			setAttr("preschid",preschid);
			String supid = "0";
			if(!"0".equals(id)){
				if(id.startsWith("p_")){
					T_Bus_PreschPhase p = T_Bus_PreschPhase.dao.findById(id.substring(2));
					supid = p.get("phaseid").toString();
					setAttr("p",p);
				}else{
					T_Bus_PreschAction p = T_Bus_PreschAction.dao.findById(id);
					supid = p.get("actid").toString();
					setAttr("p",p);
					T_Bus_PreschPhase ph = T_Bus_PreschPhase.dao.findById(p.get("actphase"));
					setAttr("actphase",ph.getStr("phasename"));
				}	
			}
			setAttr("supid",supid);
			render("add_process.jsp");
		}
	}
	public void edit(){
		String flag = getPara(0);
		String id = getPara(1);
		//String preschid = getPara(2);
		T_Bus_PlanItem t = T_Bus_PlanItem.dao.findById(id);
		if("organ".equals(flag)){
			setAttr("t",t);
			String pid = t.get("pid")==null?"0":t.get("pid").toString();
			T_Bus_PlanItem p = T_Bus_PlanItem.dao.findById(pid);
			setAttr("p",p);
			//应急机构
			String itemid = t.getStr("itemid");
			if(itemid!=null && !"".equals(itemid)){
				List<Record> olist = T_Bus_PlanItem.dao.getOrgList(itemid);
				if(olist!=null && olist.size()>0){
					StringBuffer oname = new StringBuffer();
					for(Record r : olist){
						if(oname.length()>0){
							oname.append(",");
						}
						oname.append(r.getStr("smsname"));
					}
					setAttr("organname",oname);
				}
			}
			render("edit_organ.jsp");
		}else if("plevel".equals(flag)){
			setAttr("p",t);
			render("edit_level.jsp");
		}else if("pinformation".equals(flag)){
			setAttr("p",t);
			render("edit_information.jsp");
		}else if("pprocess".equals(flag)){
			String codeflag = getPara(2);
			String supid = "0";
			if("2".equals(codeflag)){
				T_Bus_PreschAction a = T_Bus_PreschAction.dao.findById(id);
				T_Bus_PreschPhase p = T_Bus_PreschPhase.dao.findById(a.get("actphase"));
				setAttr("p",p);
				setAttr("t",a);
				supid = a.get("actphase").toString();
			}else if("3".equals(codeflag)){
				T_Bus_PreschActionDept a = T_Bus_PreschActionDept.dao.findById(id);
				setAttr("t",a);
				T_Bus_PreschAction p = T_Bus_PreschAction.dao.findById(a.get("actid"));
				setAttr("p",p);
			}else{
				T_Bus_PreschPhase a = T_Bus_PreschPhase.dao.findById(id);
				setAttr("t",a);
				supid = a.get("fatherid").toString();
			}
			setAttr("codetype",codeflag);
			setAttr("supid",supid);
			render("edit_process.jsp");
		}
	}
	public void delete(){
		String flag = getPara(0);
		String groupid = getPara("groupid");
		String[] ids=getParaValues("ids");
		if(ids!=null){
			ids = ArrayUtils.removeDuplicate(ids);
		}
		String id = ArrayUtils.ArrayToString(ids);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="删除异常，请检查！";
		String errorCode="info";
		try {
			if("organ".equals(flag)){
				if(groupid!=null && !"".equals(groupid)){
					T_Bus_PlanItem t = T_Bus_PlanItem.dao.findById(groupid);
					String supid = t.get("pid")==null?"0": t.get("pid").toString();
					if(t!=null){
						success = t.delete();
						if(success){
							msg = "删除成功！";
							map.put("idkey", "id");
							map.put("reloadid", supid);
						}
					}else{
						errorCode="error";
						msg="该分组不存在，请检查！";
					}
				}
			}else if("orgper".equals(flag)){
				//删除组内成员
				T_Bus_PlanItem t = T_Bus_PlanItem.dao.findById(groupid);
				String itemids = t.getStr("itemid");
				String[] itemid = itemids.split(",");
				String newid="";
				for(int i=0;i<itemid.length;i++){
					if((","+id+",").indexOf(","+itemid[i]+",")<0){
						if(newid.length()>0){
							newid = newid+",";
						}
						newid = newid + itemid[i];
					}
				}
				t.set("itemid", newid);
				success = t.update();
			}else if("pprocess".equals(flag)){
				//应急处置
				String preid = getPara("preid");
				String supid = getPara("groupid");
				String cflag = getPara("flag");
				if("3".equals(cflag)){
					success = T_Bus_PreschActionDept.dao.deleteByIds(id);
				}else if("2".equals(cflag)){
					success = T_Bus_PreschAction.dao.deleteByIds(id);
					supid = "p_"+supid;
				}else{
					success = T_Bus_PreschPhase.dao.deleteByIds(id, preid,cflag);
					if(!"0".equals(supid)){
						supid = "p_"+supid;
					}
				}
				if(success){
					msg = "删除成功！";
					map.put("idkey", "id");
					map.put("reloadid", supid);
				}
			}else{
				success = T_Bus_PlanItem.dao.deleteByIds(id);
			}
		}catch (Exception e) {
			errorCode="error";
			msg=e.getMessage();
			e.printStackTrace();
		}finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
	
	public void save(){
		String act = getPara("act");
		T_Bus_PlanItem p = getModel(T_Bus_PlanItem.class);
		try {
			if(act.endsWith("_organ")){
				String sup = p.get("pid")==null?"0":p.get("pid").toString();
				//机构/人员
				String orgid = getPara("organid");
				String orgname = getPara("organname");
				if(orgname==null || "".equals(orgname)){
					orgid = "";
				}
				p.set("itemid", orgid);
				if("add_organ".equals(act)){
					T_Bus_PlanItem.dao.insert(p);
				}else{
					p.update();
				}
				renderText("{\"success\":true,\"dialogid\":\"planMgDialog\",\"gridid\":\"preschOrgGrid"
						+"\",\"msg\":\"保存成功！\",\"treeObj\":\"preschOrgTree\",\"reloadid\":"+sup+",\"idkey\":\"id\"}");
				return;
			}else if(act.endsWith("_plevel")){
				//事件类型级别
				String itemname = "";
				if("1010".equals(p.getStr("planitemcode"))){
					itemname = StrappUtil.translate(p.getStr("itemid"),"EVTP");
				}else{
					itemname = StrappUtil.translate(p.getStr("itemid"),"EVLV");
				}
				p.set("itemname", itemname);
				if("add_plevel".equals(act)){
					T_Bus_PlanItem.dao.insert(p);
				}else{
					p.update();
				}
				toDwzText(true, "保存成功！", "", "planMgDialog", "preschLevelGrid", "closeCurrent");
			}else if(act.endsWith("_pinformation")){
				//通知单位
				String itemid = p.getStr("itemid");
				String itemname = T_Bus_Preschinfo.dao.getOrganName(itemid);
				p.set("itemname", itemname);
				if("add_pinformation".equals(act)){
					T_Bus_PlanItem.dao.insert(p);
				}else{
					p.update();
				}
				toDwzText(true, "保存成功！", "", "planMgDialog", "informationGrid", "closeCurrent");
			}else if(act.endsWith("_presource")){
				//应急资源
				String planresid = getPara("planresid");
				String planresname = getPara("planresname");
				String[] presid = planresid.split(",");
				String[] presname = planresname.split(",");
				String preschid = p.get("preschid").toString();
				String planitemcode = p.getStr("planitemcode");
				//删除冗余数据
				T_Bus_PlanItem.dao.deleteByCode(planresid, planitemcode, preschid);
				List<Record> reslist = T_Bus_PlanItem.dao.getListByIdCode(preschid, planitemcode);
				List<Record> rlist = T_Bus_PlanItem.dao.getListByRecid(planitemcode, planresid);
				String itemids = "";
				for(Record r : reslist){
					String itemid = r.getStr("itemid");
					itemids = itemids+ "_" + itemid+",";
				}
				for(int i=0;i<presid.length;i++){
					if(itemids.indexOf("_"+presid[i]+",")<0){
						p.set("itemname", presname[i]);
						p.set("itemid", presid[i]);
						if("3020".equals(planitemcode)){
							p.set("itemcontent", rlist.get(i).getStr("tcode"));
						}else if("2080".equals(planitemcode)){
							p.set("itemcontent", rlist.get(i).getStr("remark"));
						}else if("3010".equals(planitemcode)){
							p.set("itemcontent", rlist.get(i).getStr("teamjob"));
						}else if("3030".equals(planitemcode)){
							p.set("itemcontent", rlist.get(i).getStr("remark"));
						}
						T_Bus_PlanItem.dao.insert(p);
					}
				}
				toDwzText(true, "保存成功！", "", "planMgDialog", "preschResGrid", "closeCurrent");
			}else if(act.endsWith("pprocess")){
				String codeflag = getPara("codeflag");
				String sup = getPara("supid");
				if("3".equals(codeflag)){
					T_Bus_PreschActionDept a = getModel(T_Bus_PreschActionDept.class);
					String actdeptid = a.get("actdeptid").toString();
					String actdeptname = T_Bus_Preschinfo.dao.getOrganName(actdeptid);
					a.set("actdeptname", actdeptname);
					if("add_pprocess".equals(act)){
						T_Bus_PreschActionDept.dao.insert(a);
					}else{
						a.update();
					}
					toDwzText(true, "保存成功！", "", "planMgDialog", "preschProGrid", "closeCurrent");
				}else if("2".equals(codeflag)){
					T_Bus_PreschAction a = getModel(T_Bus_PreschAction.class);
					String actphase = a.get("actphase").toString();
					if(!sup.equals(actphase)){
						sup = null;
					}
					if("add_pprocess".equals(act)){
						T_Bus_PreschAction.dao.insert(a);
					}else{
						a.update();
					}
					if(sup!=null && !"0".equals(sup)){
						sup = "p_"+sup;
					}
					renderText("{\"success\":true,\"dialogid\":\"planMgDialog\",\"gridid\":\"preschProGrid"
							+"\",\"msg\":\"保存成功！\",\"treeObj\":\"preschProTree\",\"reloadid\":\""+sup+"\",\"idkey\":\"id\"}");
				}else{
					T_Bus_PreschPhase a = getModel(T_Bus_PreschPhase.class);
					String fatherid = a.get("fatherid").toString();
					if(!sup.equals(fatherid)){
						sup = null;
					}
					if("add_pprocess".equals(act)){
						T_Bus_PreschPhase.dao.insert(a);
					}else{
						a.update();
					}
					if(sup!=null && !"0".equals(sup)){
						sup = "p_"+sup;
					}
					renderText("{\"success\":true,\"dialogid\":\"planMgDialog\",\"gridid\":\"preschProGrid"
							+"\",\"msg\":\"保存成功！\",\"treeObj\":\"preschProTree\",\"reloadid\":\""+sup+"\",\"idkey\":\"id\"}");
				}
				
			}
		} catch (Exception e) {
			toDwzText(false, "保存异常，请检查！", "", "", "", "");
			e.printStackTrace();
		}
	}
	public void getmodel(){
		//预案分类
		List<Record> plist = T_Sys_Parameter.dao.getParamByCode("YAFL",false);
		setAttr("plist",plist);
		render("model.jsp");
	}
	public void impmodel(){
		String mid=getPara("mid");
		String pid=getPara("pid");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		try {
			T_Bus_Preschinfo.dao.impByIds(pid,mid);
			T_Bus_PreschLaw.dao.impByIds(pid,mid);
			T_Bus_PlanItem.dao.impByIds(pid,mid);
			Map<String,Object> map2=new HashMap<String,Object>();
			Map<String,Object> map3=new HashMap<String,Object>();
			T_Bus_PreschPhase.dao.impByIds(pid,mid,map2);
			T_Bus_PreschAction.dao.impByIds(pid,mid,map2,map3);
			T_Bus_PreschActionDept.dao.impByIds(pid,mid,map3);
		success=true;								
		} catch (Exception e) {
			log.error(e.getMessage());
			errorCode="error";
			msg=e.getMessage();
			e.printStackTrace();
		}finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}	
	}
}
