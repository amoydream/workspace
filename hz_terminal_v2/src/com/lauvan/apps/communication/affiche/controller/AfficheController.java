package com.lauvan.apps.communication.affiche.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Clear;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.affiche.model.T_Bus_Affiche;
import com.lauvan.apps.event.utils.SendTask;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

@RouteBind(path="Main/affiche", viewPath = "/communication/affiche")
public class AfficheController extends BaseController {
	
	public void index(){
		String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_FORMAT);;
		setAttr("now",now);
		render("main.jsp");
	}
	
	public void getGridData(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String title = getPara("title");
		String username = getPara("username");
		String createtime = getPara("createtime");
        StringBuffer sqlWhere = new StringBuffer();
        if(StringUtils.isNotBlank(title)){
        	sqlWhere.append(" and t.title like '%")
        	.append(title)
        	.append("%'");
        }
        if(StringUtils.isNotBlank(username)){
        	sqlWhere.append(" and t.username like '%")
        	.append(username)
        	.append("%'");
        }
        if(StringUtils.isNotBlank(createtime)){
        	sqlWhere.append(" and t.createtime like '")
        	.append(createtime)
        	.append("%'");
        }
		Page<Record> page = T_Bus_Affiche.dao.getGridPage(pageNumber, pageSize,sqlWhere.toString());
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);	
	}
	
	public void add(){
		render("add.jsp");
	}
	
	public void update(){
		String id = getPara(0);
		T_Bus_Affiche a = T_Bus_Affiche.dao.findById(id);
		setAttr("affiche", a);
		render("update.jsp");
	}
	
	public void save(){
		String act = getPara("act");
		T_Bus_Affiche model = getModel(T_Bus_Affiche.class);
		String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		LoginModel loginModel=getSessionAttr("loginModel");
		Number userid=loginModel.getUserId();
		String username = loginModel.getUserName();
		boolean success = false;		
		String msg="";
	try{
		if("add".equals(act)){
			model.set("createtime", now);
			model.set("username", username);
			model.set("userid", userid);
			model.set("status","0");
			model.set("id", AutoId.nextval(model));
			success = model.save();
			msg = "添加成功！";
		}else{
			success = model.update();
			msg = "更新成功！";
		}
		toDwzText(success, msg, "", "afficheDialog", "afficheGrid", "closeCurrent");	
	} catch (Exception e) {
		e.printStackTrace();
		toDwzText(false, "保存异常！", "", "", "", "");
	}
  }
	
	public void del(){
		String ids = getPara("ids");
		String[] idsArr = StringUtils.split(ids, ",");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		LoginModel login = getSessionAttr("loginModel");
		String uid = login.getUserId().toString();
		try {
			if(login.getIsAdmin()||T_Bus_Affiche.dao.isStatus(ids, uid)){				
				success = T_Bus_Affiche.dao.delete(idsArr);
			}else{
				errorCode="error";
				msg = "只能删除自己添加或发布的公告！";
			}
		} catch (Exception e) {
			e.printStackTrace();
			errorCode = "error";
			msg = e.getMessage();
		} finally {
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}	
	}
	//群发公告到终端用户
	@Clear
	public void send(){
		String act = getPara("act");
		T_Bus_Affiche model = getModel(T_Bus_Affiche.class);
		String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		LoginModel loginModel=getSessionAttr("loginModel");
		Number userid=loginModel.getUserId();
		String username = loginModel.getUserName();
		String title = model.getStr("title");
		String content = model.getStr("content");
		boolean success = false;		
		String msg="";
		String sendstatus = "1";
	try{
		if("add".equals(act)){
			model.set("createtime", now);
			model.set("sendtime", now);
			model.set("username", username);
			model.set("userid", userid);
			model.set("status","1");
			model.set("id", AutoId.nextval(model));
			success = model.save();
			if(success){
			JSONObject notification = new JSONObject();
			notification.put("TITLE", title);
			notification.put("CONTENT", content);
			notification.put("USERNAME", username);
			notification.put("FLAG", 3);
			sendstatus = SendTask.pushAll(notification);
			if("1".equals(sendstatus)){
				msg = "添加与发送成功！";
			  }else{
				  msg = "添加成功，发送异常！";
			  }
			}else{				
				msg = "保存与发送失败！";
			}
		}else{
			model.set("sendtime", now);
			model.set("status","1");
			success = model.update();
			if(success){
				JSONObject notification = new JSONObject();
				notification.put("TITLE", model.getStr("title"));
				notification.put("CONTENT", model.getStr("content"));
				notification.put("USERNAME", model.getStr("username"));
				sendstatus = SendTask.pushAll(notification);
				if("1".equals(sendstatus)){
					msg = "更新与发送成功！";
				  }else{
					  msg = "更新成功，发送异常！";
				  }
				}else{					
					msg = "更新与发送失败！";
				}
		}
		toDwzText(success, msg, "", "afficheDialog", "afficheGrid", "closeCurrent");	
	} catch (Exception e) {
		e.printStackTrace();
		toDwzText(false, "保存异常！", "", "", "", "");
	}
  }
	
	public void getView(){
		String aid = getPara(0);
		T_Bus_Affiche aff = T_Bus_Affiche.dao.findById(aid);
		setAttr("model", aff);
		render("view.jsp");
	}
}
