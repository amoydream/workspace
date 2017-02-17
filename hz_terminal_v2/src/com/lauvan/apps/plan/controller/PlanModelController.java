package com.lauvan.apps.plan.controller;
/**
 * 应急预案模板控制类
 * @author 郭广欢
 * */
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.comdecivemanagement.controller.ComDeciveMgController;
import com.lauvan.apps.communication.comdecivemanagement.model.T_DeviceInfo;
import com.lauvan.apps.plan.model.T_Bus_PlanItem;
import com.lauvan.apps.plan.model.T_Bus_PreschLaw;
import com.lauvan.apps.plan.model.T_Bus_Preschinfo;
import com.lauvan.apps.resource.assets.model.T_Bus_Equipname;
import com.lauvan.apps.resource.assets.model.T_Bus_Equipstore;
import com.lauvan.apps.resource.assets.model.T_Bus_Expert;
import com.lauvan.apps.resource.assets.model.T_Bus_Team;
import com.lauvan.apps.resource.material.model.T_Bus_Materialname;
import com.lauvan.apps.resource.material.model.T_Bus_Repertory;
import com.lauvan.apps.resource.material.model.T_Bus_Store;
import com.lauvan.apps.workcontact.model.T_Bus_Organ;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/planmodel",viewPath="/plan/management")
public class PlanModelController extends BaseController {
	private static final Logger log = Logger.getLogger(ComDeciveMgController.class);
	public void index(){
		//预案分类
		List<Record> plist = T_Sys_Parameter.dao.getParamByCode("YAFL",false);
		setAttr("plist",plist);
		render("modelmain.jsp");
	}
	public void getGridDate(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String planname = getPara("planname");
		String plantype = getPara("plantype");
		Integer deptid = getParaToInt(0);
		StringBuffer str = new StringBuffer();
		String type=getPara("type");
		if(type.equals("m")){
		str.append(" and p.type=1");
		}else{
		str.append(" and p.type=0");
		}
		if(planname!=null && !"".equals(planname)){
			str.append(" and p.preschname like '%").append(planname).append("%' ");
		}
		if(plantype!=null && !"".equals(plantype)){
 			str.append(" and p.preschtype = '").append(plantype).append("' ");
 		}   
		if(deptid != null && deptid !=0 ){
			str.append(" and p.organid ='").append("od_").append(deptid).append("' ");
		}
		Page<Record> page = T_Bus_Preschinfo.dao.getPageList(pageSize, pageNumber, str.toString());
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void getView(){
		String id = getPara(0);
		String type=getPara(1);
		T_Bus_Preschinfo p = T_Bus_Preschinfo.dao.findById(id);
		setAttr("p",p);
		//法律法规列表
		List<Record> laws = T_Bus_PreschLaw.dao.getLawsByPid(id);
		setAttr("laws",laws);
		if(laws!=null && laws.size()>0){
			StringBuffer str = new StringBuffer();
			StringBuffer str2 = new StringBuffer();
			for(Record r : laws){
				if(str.length()>0){
					str.append(",");
					str2.append(",");
				}
				str.append(r.get("lr_id").toString());
				str2.append(r.getStr("lr_title"));
			}
			setAttr("lawids",str.toString());
			setAttr("lawnames",str2.toString());
		}
		//转换字符
		String preschscale = p.getStr("preschscale");
		if(preschscale!=null && !"".equals(preschscale)){
			preschscale = preschscale.replace("/r/n", "</br>");
			preschscale = preschscale.replace(" ", "&nbsp;&nbsp;&nbsp;");
		}
		setAttr("preschscale",preschscale);
		
		String incidenttypenote = p.getStr("incidenttypenote");
		if(incidenttypenote!=null && !"".equals(incidenttypenote)){
			incidenttypenote = incidenttypenote.replace("/r/n", "</br>");
			incidenttypenote = incidenttypenote.replace(" ", "&nbsp;&nbsp;&nbsp;");
		}
		setAttr("incidenttypenote",incidenttypenote);
		
		String preschdetail = p.getStr("preschdetail");
		if(preschdetail!=null && !"".equals(preschdetail)){
			preschdetail = preschdetail.replace("/r/n", "</br>");
			preschdetail = preschdetail.replace(" ", "&nbsp;&nbsp;&nbsp;");
		}
		setAttr("preschdetail",preschdetail);
		
		String note = p.getStr("note");
		if(note!=null && !"".equals(note)){
			note = note.replace("/r/n", "</br>");
			note = note.replace(" ", "&nbsp;&nbsp;&nbsp;");
		}
		setAttr("note",note);
		setAttr("type",type);
		render("planview.jsp");
	}
	public void save(){
		try{
		T_Bus_Preschinfo t = getModel(T_Bus_Preschinfo.class);
		String lawids = getPara("mlawid");
		String lawname = getPara("mlawname");
		if(lawname==null || "".equals(lawname)){
			lawids = "";//清空操作
		}
		String preshid = t.get("id").toString();
		T_Bus_PreschLaw.dao.updateLaw(lawids, preshid);
		t.update();
		toDwzText(true, "修改成功！", "", "", "", "");
		} catch (Exception e) {
			toDwzText(false, "保存异常，请检查！", "", "", "", "");
			e.printStackTrace();
		}
	}
	public void getfocuslist(){
		String id=getPara(0);
		String type=getPara(1);
		T_Bus_PlanItem pi=T_Bus_PlanItem.dao.findById(id);
		int itemid=Integer.valueOf(pi.get("itemid").toString());
		String path = getRequest().getContextPath();
		String basePath = getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort()+path+"/";
		List<Record> datalist=new ArrayList<Record>();
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
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("datalist", datalist);
		renderJson(map);
	}
	public void getresourceview(){
		String id=getPara(0);
		String type=getPara(1);
		T_Bus_PlanItem pi=T_Bus_PlanItem.dao.findById(id);
		int itemid=Integer.valueOf(pi.get("itemid").toString());
		if(type.equals("3020")){
			getview(itemid);
		}else if(type.equals("2080")){
			getview2(itemid);	
		}else if(type.equals("3010")){
			getview3(itemid);
		}else if(type.equals("3030")){
			getview4(itemid);
		}		
	}
	public void getview(int itemid){
		T_Bus_Materialname model=T_Bus_Materialname.dao.findById(itemid);
		//物资类型
		T_Sys_Parameter type = T_Sys_Parameter.dao.findById(model.get("type"));
		setAttr("itemid",itemid);
		setAttr("typename", type.get("p_name"));
		setAttr("model", model);
		render("findData/yjwzview.jsp");
	}
	public void getdatabymatid(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String itemid=getPara("itemid");
		Page<Record> page=T_Bus_Store.dao.getPagebymatid(pageNumber,pageSize,Integer.valueOf(itemid));
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void getContent(){
		Integer id=getParaToInt("id");
		T_Bus_Store model=T_Bus_Store.dao.findById(id);
		
		String repertoryname = "";
		BigDecimal repertoryid = model.getBigDecimal("repertoryid");
		if(repertoryid!=null){
			T_Bus_Repertory repertory= T_Bus_Repertory.dao.getRepertoryByRepid(model.getBigDecimal("repertoryid"));
			repertoryname= repertory.getStr("name");
		}
		setAttr("repertoryname",repertoryname);
		
		String materialname = "";
		BigDecimal meterialid = model.getBigDecimal("materialid");
		if(meterialid!=null){
			T_Bus_Materialname material= T_Bus_Materialname.dao.getMaterialByMaterialid(model.getBigDecimal("materialid"));
			materialname= material.getStr("mn_name");
		}
		setAttr("materialname",materialname);
		
		//所属单位
				String dept = model.get("organid")==null?null:model.get("organid").toString();
				if(dept!=null){
					T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
					if(d!=null){
					setAttr("organ",d.getStr("or_name"));
					}
				}
		
		setAttr("model", model);
		render("findData/wzview.jsp");
	}
	public void getview2(int itemid){
		T_Bus_Expert model=T_Bus_Expert.dao.findById(itemid);
		//所在单位
		String dept = model.get("organid")==null?null:model.get("organid").toString();
		if(dept!=null){
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			if(d!=null){
			setAttr("organ",d.getStr("or_name"));
			}
		}
		//专家类型
		T_Sys_Parameter type = T_Sys_Parameter.dao.findById(model.get("typeid"));
		setAttr("typename", type.get("p_name"));
		
		setAttr("model", model);
		render("findData/yjzjview.jsp");
	}
	public void getview3(int itemid){
		T_Bus_Team team = T_Bus_Team.dao.getById(itemid);
		//所属单位
				String dept = team.get("organid")==null?null:team.get("organid").toString();
				if(dept!=null){
					T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
					if(d!=null){
					setAttr("organ",d.getStr("or_name"));
					}
				}
		setAttr("team", team);
		renderJsp("findData/yjdwview.jsp");
	}
	public void getview4(int itemid){
		T_Bus_Equipname model=T_Bus_Equipname.dao.findById(itemid);
		T_Sys_Parameter type = T_Sys_Parameter.dao.findById(model.get("type"));
		setAttr("typename", type.get("p_name"));
		setAttr("model", model);
		setAttr("itemid",itemid);
		render("findData/yjzbview.jsp");
	}
	public void getdatabymatid2(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String itemid=getPara("itemid");
		Page<Record> page=T_Bus_Equipstore.dao.getPagebymatid(pageNumber,pageSize,Integer.valueOf(itemid));
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void getContent2(){
		Integer id=getParaToInt("id");
		T_Bus_Equipstore model=T_Bus_Equipstore.dao.findById(id);
		
		String equipname = "";
		BigDecimal equipnameid = model.getBigDecimal("equipnameid");
		if(equipnameid!=null){
			T_Bus_Equipname equip= T_Bus_Equipname.dao.getEquipnameByEquipnameid(model.getBigDecimal("equipnameid"));
			equipname= equip.getStr("eqn_name");
		}
		setAttr("equipname",equipname);
		
		//主管单位
		String dept = model.get("organid")==null?null:model.get("organid").toString();
		if(dept!=null){
			T_Bus_Organ d = T_Bus_Organ.dao.findById(dept);
			if(d!=null){
			setAttr("organ",d.getStr("or_name"));
			}
		}
		
		//数据来源单位
		String sourcedept = model.get("sourcedept")==null?null:model.get("sourcedept").toString();
		if(sourcedept!=null){
			T_Bus_Organ d = T_Bus_Organ.dao.findById(sourcedept);
			if(d!=null){
			setAttr("sourcedept",d.getStr("or_name"));
			}
		}
		
		setAttr("model", model);
		render("findData/zbview.jsp");
	}
}
