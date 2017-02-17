package com.lauvan.apps.communication.mobileuser.controller;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;











import com.baidu.yun.core.log.YunLogEvent;
import com.baidu.yun.core.log.YunLogHandler;
import com.baidu.yun.push.auth.PushKeyPair;
import com.baidu.yun.push.client.BaiduPushClient;
import com.baidu.yun.push.constants.BaiduPushConstants;
import com.baidu.yun.push.exception.PushClientException;
import com.baidu.yun.push.exception.PushServerException;
import com.baidu.yun.push.model.PushMsgToSingleDeviceRequest;
import com.baidu.yun.push.model.PushMsgToSingleDeviceResponse;
import com.jfinal.aop.Clear;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.communication.mobileuser.model.S_Bas_SendTask;
import com.lauvan.apps.communication.mobileuser.model.S_Bas_TaskBack;
import com.lauvan.apps.communication.mobileuser.model.T_MobileUser;
import com.lauvan.apps.event.utils.SendTask;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

@RouteBind(path = "Main/mobileuser", viewPath = "/communication/mobileuser")
public class MobileUserMgController extends BaseController {
	private static final Logger log = Logger.getLogger(MobileUserMgController.class);
	public void index() {
		render("main.jsp");
	}
	public void getGridData() {
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String mobileusername = getPara("mobileusername");
		String mobileuserrealname = getPara("mobileuserrealname");
		Page<Record> page;
		page = T_MobileUser.dao.getGridPage(pageNumber, pageSize,mobileusername,mobileuserrealname);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void useradd(){
	render("add.jsp");
	}
	public void userupd(){
	String id=getPara(0);
	T_MobileUser mu=T_MobileUser.dao.findById(id);
	setAttr("mu",mu);
	render("update.jsp");
	}
    public void getUserView(){
	String id=getPara(0);
	T_MobileUser mu=T_MobileUser.dao.findById(id);
	setAttr("mu",mu);
	render("view.jsp");	
	}
    
    public void ifExistUsername(){
		String username=getPara("username");
		Integer uid=getParaToInt("uid");
		boolean flag=T_MobileUser.dao.ifExsitAccount(username, uid);		
		renderJson("{\"success\":"+flag+"}");
	}
    
	public void save(){
		try {
    		boolean success=false;
    		LoginModel loginModel=getSessionAttr("loginModel");
    		Number userid=loginModel.getUserId();
    		String methodname="add";
			String act = getPara("act");
			T_MobileUser mu = getModel(T_MobileUser.class);
			String alt="";
					if(act.equals("upd")){
						mu.update();
						success=true;
						methodname="update";
						alt="修改成功！";
					}else{
						mu.set("id", AutoId.nextval(mu));
						mu.save();
						success=true;
						alt="保存成功！";
						T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mobileuser", methodname,mu,getRequest());
					}
		toDwzText(success, alt, "", "mobileuserDialog", "mobileuserGrid", "closeCurrent");	
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}
	public void userdel(){
		String ids=getPara("ids");
		String[] id=ids.split(",");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="";
		String errorCode="info";
		LoginModel loginModel=getSessionAttr("loginModel");
		Number userid=loginModel.getUserId();
		try {
			for(String i:id){
		T_MobileUser mu=T_MobileUser.dao.findById(i);
		mu.delete();
		T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mobileuser/userdel", "delete",mu,getRequest());
			}
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
	public void sendtask(){
		String ids = getPara("ids");
		//String id=getPara("id");
		setAttr("ids",ids);
		render("sendtask.jsp");	
	}
	/**
	 * 获取所有终端用户详细信息
	 * */
	public void getContent(){
		List<Record> list = T_MobileUser.dao.getAllusers();
		String jsonlist = JsonKit.toJson(list);
		renderJson(jsonlist);
	}
	
	//发送任务到手机终端
		public void taskSave(){
			//发送内容
			S_Bas_SendTask st  = getModel(S_Bas_SendTask.class);
			String title   = st.getStr("title");
			String content = st.getStr("content");
			String x_point = st.getStr("pointx");
			String y_point = st.getStr("pointy");
			//发送人
			LoginModel loginModel=getSessionAttr("loginModel");
			Number sender=loginModel.getUserId();
			//接收人
			String ids = getPara("ids");
			String[] idsArr = StringUtils.split(ids,",");
			//发送时间
			String now = DateTimeUtil.formatDate(new Date(),
					DateTimeUtil.Y_M_D_HMS_FORMAT);
			String msg="推送成功的用户是：";
			String sendmsg="推送中的用户是：";
			String error="推送失败的用户：";
	        try {
				for(int i=0;i<idsArr.length;i++){
					T_MobileUser user = T_MobileUser.dao.findById(idsArr[i]);
					if(user!=null){	 	     	
				    String token = user.getStr("token");
					S_Bas_SendTask t = new S_Bas_SendTask();
					String id = AutoId.nextval(t).toString();
					t.set("id", id);
					t.set("pointx", x_point);
					t.set("pointy", y_point);
					t.set("title", title);
					t.set("content", content);
					t.set("sender", sender);
					t.set("status", "0");
					t.set("time", now);
					String sendstatus = "1";
					//推送
					if(token!=null && !"".equals(token)){
						//String njson = JsonKit.toJson(t);
						JSONObject notification = new JSONObject();
						notification.put("ID", id);
						notification.put("POINTX", x_point);
						notification.put("POINTY",y_point);
						notification.put("TITLE",title);
						notification.put("CONTENT",content);
						notification.put("SENDER", sender);
						notification.put("TIME", now);
						notification.put("FLAG", 1); 
						notification.put("STATUS", 0); 
						notification.put("ISNEWS", 0);
						sendstatus = SendTask.send(notification, token);
						if("1".equals(sendstatus.trim())){
						msg+=user.getStr("username")+" ";
						}else{
							error+=user.getStr("username")+" ";
						}
					}else{
						sendstatus = "0";
						sendmsg+=user.getStr("username")+" ";
					}
					t.set("sendstatus", sendstatus);
					t.set("arriver", user.getBigDecimal("id"));
					t.save();						   
				  }					
				}
				 msg+=sendmsg;
				 msg+=error;
				 toDwzText(true, msg, "", "sendtasktomDialog", "mobileuserGrid", "closeCurrent");	
			} catch (Exception e) {
				e.printStackTrace();
				toDwzText(false, "发送异常："+e.getMessage(), "", "", "", "");
			}
	       
		}
	
	public void getTaskView(){
		String userid = getPara(0);
		setAttr("userid", userid);
		render("tasklist.jsp");
	}
	
	public void getTaskList(){
		String userid = getPara("userid");
		String sendtime = getPara("sendtime");
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		 Page<Record> page = S_Bas_SendTask.dao.getGridPage(pageNumber, pageSize, userid, sendtime);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
			// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void getTaskBack(){
		String taskid = getPara(0);
		Record task = S_Bas_SendTask.dao.getTaskInfo(taskid);
		//获取反馈信息
		List<Record> flist = S_Bas_TaskBack.dao.getListByTask(taskid);
		//获取反馈信息的附件列表
		if(flist!=null && flist.size()>0){
			for(Record r : flist){
				String fjid = r.getStr("attid");
				if(fjid!=null && !"".equals(fjid)){
					List<T_Attachment> fjlist = T_Attachment.dao.getListByIds(fjid);
					r.set("fjlist", fjlist);
				}
			}
		}
		setAttr("task", task);
		setAttr("flist",flist);
		render("taskview.jsp");
	}
	
	
	public void getTaskFj(){
		String id = getPara(0);
		T_Attachment fj = T_Attachment.dao.findById(id);
		setAttr("fjid",id);
		String ftype = "media";
		if("jpg".equals(fj.getStr("m_type")) || "png".equals(fj.getStr("m_type")) || "gif".equals(fj.getStr("m_type"))){
			ftype = "tupian";
			String url = fj.getStr("url");
			T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("MOBILEFILE", "UPDZ");
			String savepath = p.getStr("p_acode"); 
			if(url.startsWith("/") || url.indexOf(":")==1){
				url = url.replace(savepath, "/yj/fjdoc");
			}else{
				String path = getRequest().getContextPath();
				String basePath = getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort()+path+"/";
				url=basePath+url;
			}
			setAttr("furl",url);
		}
		setAttr("ftype",ftype);
		
		render("taskFj.jsp");
	}
	
	public void getTaskFjView(){
		String id = getPara(0);
		T_Attachment fj = T_Attachment.dao.findById(id);
		//视频文件输出
		String url = fj.getStr("url");
		
		if(!url.startsWith("/") && url.indexOf(":")!=1){
			url = PathKit.getWebRootPath() + "/" + url;
		}
		
		File file = new File(url);
		if(file.exists()){
			try{
				String fname = fj.getStr("name");
				HttpServletResponse res = getResponse();
				res.setContentType("text/html; charset=UTF-8");
				res.setContentType("application/x-msdownload");
				res.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode(fname, "UTF-8"));
				OutputStream out = res.getOutputStream();
				
				FileInputStream fis=new FileInputStream(file);
			    BufferedInputStream buff=new BufferedInputStream(fis);
			    byte [] b=new byte[1024];//相当于我们的缓存
			    long k=0;//该值用于计算当前实际下载了多少字节
			    while(k<file.length()){
			        int j=buff.read(b,0,1024);
			        k+=j;
			        //将b中的数据写到客户端的内存
			         out.write(b,0,j);
			      }
			    fis.close();
		        //将写入到客户端的内存的数据,刷新到磁盘
		        out.flush();
		        out.close();
		        
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				renderNull();
			}	
		}else{
			renderText("该文件不存在！");
		}
	}
		
}
