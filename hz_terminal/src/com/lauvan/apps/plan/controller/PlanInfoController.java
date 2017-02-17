package com.lauvan.apps.plan.controller;
/**
 * 应急预案基本信息控制类
 * @author 黄丽凯
 * */
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.plan.model.T_Bus_PlanItem;
import com.lauvan.apps.plan.model.T_Bus_PreschAction;
import com.lauvan.apps.plan.model.T_Bus_PreschActionDept;
import com.lauvan.apps.plan.model.T_Bus_PreschLaw;
import com.lauvan.apps.plan.model.T_Bus_PreschPhase;
import com.lauvan.apps.plan.model.T_Bus_Preschinfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Department;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.basemodel.model.T_Sys_User;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/plan",viewPath="/plan/info")
public class PlanInfoController extends BaseController {
	public void index(){
		//预案分类
		List<Record> plist = T_Sys_Parameter.dao.getParamByCode("YAFL",false);
		setAttr("plist",plist);
		render("main.jsp");
	}
	
	public void getGridDate(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String planname = getPara("planname");
		String plantype = getPara("plantype");
		Integer deptid = getParaToInt(0);
		StringBuffer str = new StringBuffer();
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
	
	public void add(){
		render("add.jsp");
	}
	
	public void edit(){
		String id = getPara(0);
		T_Bus_Preschinfo t = T_Bus_Preschinfo.dao.findById(id);
		if(t!=null){
			LoginModel login = getSessionAttr("loginModel");
			String userid = t.get("user_id").toString();
			T_Sys_Department dept=T_Sys_Department.dao.getuserDept(userid);
			String deptid=dept.get("d_id").toString();
			//if(!login.getIsAdmin() && !userid.equals(login.getUserId().toString())){
			if(!login.getIsAdmin() && !deptid.equals(login.getOrgId().toString())){
				//toDwzText(false, "只能修改自己创建的预案，请检查！", "", "", "planGrid", "closeCurrent");
				toDwzText(false, "只能修改本部门创建的预案，请检查！", "", "", "planGrid", "closeCurrent");
				return;
			}
			setAttr("p",t);
			List<Record> laws = T_Bus_PreschLaw.dao.getLawsByPid(id);
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
		}else{
			toDwzText(false, "该预案不存在，请检查！", "", "", "planGrid", "closeCurrent");
			return;
		}
		render("edit.jsp");
	}
	
	public void save(){
		String act = getPara("act");
		T_Bus_Preschinfo t = getModel(T_Bus_Preschinfo.class);
		//获取法律文件id
		String lawids = getPara("lawid");
		String lawname = getPara("lawname");
		if(lawname==null || "".equals(lawname)){
			lawids = "";//清空操作
		}
		//操作手册
		String docid = getPara("docid");
		if(docid!=null && !"".equals(docid)){
			T_Attachment fj = T_Attachment.dao.findById(docid);
			t.set("preschdocid", docid);
			t.set("preschdocname", fj.getStr("name"));
			t.set("preschdocpath", fj.getStr("url"));
		}else if(getPara("docedit")==null ){
			toDwzText(false, "请上传预案的电子文档！", "", "", "", "");
			return;
		}
		try {
			if("add".equals(act)){
				LoginModel login = getSessionAttr("loginModel");
				t.set("user_id", login.getUserId());
				t.set("recname", login.getUserName());
				String id = T_Bus_Preschinfo.dao.insert(t);
				//若法律文件非空，关联法律文件
				if(lawids!=null && !"".equals(lawids)){
					T_Bus_PreschLaw.dao.insert(lawids,id);
				}
			}else{
				//t.set("preschdeptname", T_Bus_Preschinfo.dao.getOrganName(t.getStr("organid")));
				//t.set("preschpubdept", T_Bus_Preschinfo.dao.getOrganName(t.getStr("organid_fb")));
				//t.set("preschworkdept", T_Bus_Preschinfo.dao.getOrganName(t.getStr("organid_bz")));
				//t.set("preschexamdept", T_Bus_Preschinfo.dao.getOrganName(t.getStr("organid_sp")));
				t.update();
				String preshid = t.get("id").toString();
				T_Bus_PreschLaw.dao.updateLaw(lawids, preshid);
			}
			toDwzText(true, "保存成功！", "", "planDialog", "planGrid", "closeCurrent");
		} catch (Exception e) {
			toDwzText(false, "保存异常，请检查！", "", "", "", "");
			e.printStackTrace();
		}
		
	}
	
	public void delete(){
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="删除成功！";
		String errorCode="info";
		try {
			LoginModel login = getSessionAttr("loginModel");
			//String user = login.getUserId().toString();
			String dept=login.getOrgId().toString();
			//if(!login.getIsAdmin() && !T_Bus_Preschinfo.dao.isCreater(ids, user)){
			if(!login.getIsAdmin() && !T_Bus_Preschinfo.dao.isCreatDept(ids, dept)){
				errorCode="error";
				//msg = "只能删除自己创建的预案，请检查！";
				msg = "只能删除本部门创建的预案，请检查！";
			}else{
				success = T_Bus_Preschinfo.dao.deleteByIds(ids);
				T_Bus_PreschLaw.dao.deleteBYprechid(ids);
				T_Bus_PlanItem.dao.deleteBYprechid(ids);
				T_Bus_PreschPhase.dao.deleteBYprechid(ids);
				T_Bus_PreschAction.dao.deleteBYprechid(ids);
				T_Bus_PreschActionDept.dao.deleteBYprechid(ids);
			}
		} catch (Exception e) {
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
	
	//获取机构树
	public void getDeptTree(){
		String jsonStr = "[]";
		String flag = getPara(0);
		try {
			List<Record> list = T_Bus_Preschinfo.dao.getOrganList(flag);
			Map<String,String> outputKey = new HashMap<String,String>();
			outputKey.put("id", "add_code");
			outputKey.put("text", "add_name");
			//树根部
			/*Record root = new Record();
			root.set("add_pid", "-1");
			root.set("add_name", "组织机构");
			root.set("add_code", "0");
			list.add(root);*/
			jsonStr=JsonUtil.getTreeData(null, false, list, "add_code", "add_pid", outputKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderText(jsonStr);
	}
	
	public void getLaw(){
		String id = getPara(0);
		List<Record> list = T_Bus_PreschLaw.dao.getLawsByPid(id);
		/*int totalCount=list!=null?list.size():0;
		String jsonStr=JsonUtil.getGridData(list, totalCount);*/
		setAttr("lawsel",list);
		setAttr("prid",id);
		render("findData/lawList.jsp");
	}
	
	public void getLawData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String lawname = getPara("lawname");
		String swhere="";
		if(lawname!=null && !"".equals(lawname)){
			swhere = swhere+" and t.lr_title like '%"+lawname+"%' ";
		}
		String pid = getPara(0);
		Page<Record> page = T_Bus_PreschLaw.dao.getLaws(pageSize, pageNumber, swhere,pid);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void getView(){
		String id = getPara(0);
		T_Bus_Preschinfo p = T_Bus_Preschinfo.dao.findById(id);
		setAttr("p",p);
		String flag = getPara(1);
		if("view".equals(flag)){
		//法律法规列表
		List<Record> laws = T_Bus_PreschLaw.dao.getLawsByPid(id);
		setAttr("laws",laws);
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
		setAttr("flag",flag);
		}
		render("view.jsp");
	}
	//打开电子文档
	public void getDoc(){
		//String docid = getPara(0);
		String id = getPara(0);
		T_Bus_Preschinfo p = T_Bus_Preschinfo.dao.findById(id);
		String url = p.getStr("preschdocpath");
		if(url!=null){
			if(!url.startsWith("/")&&url.indexOf(":")!=1){
				url =  PathKit.getWebRootPath() +"/"+ url;
			}
			setAttr("newPath",url);
		}
		LoginModel login = getSessionAttr("loginModel");
		setAttr("username",login.getUserName());
		setAttr("id",id);
		//setAttr("docid",docid);
		render("docView.jsp");
	}
	
	public void pageSave(){
		com.zhuozhengsoft.pageoffice.FileSaver fs = new com.zhuozhengsoft.pageoffice.FileSaver(getRequest(),getResponse());
		String id = getPara(0);
		//String pid = getPara(1);
		T_Bus_Preschinfo p = T_Bus_Preschinfo.dao.findById(id);
		String url = p.getStr("preschdocpath");
		if(url==null || "".equals(url)){
			T_Sys_Parameter t = T_Sys_Parameter.dao.getByCode("FJDZ", "UPDZ");
			String path = "upload/fjdoc";
			if(p!=null){
				path = t.getStr("p_acode");
			}
			path = path+"/planFile/"+id+".doc";
		}
		if(!url.startsWith("/") && url.indexOf(":")!=1){
			url  = PathKit.getWebRootPath() +"/"+ url;
		}
		fs.saveToFile(url);
		fs.close();
		renderNull();
	}
}
