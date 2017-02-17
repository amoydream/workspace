package com.lauvan.apps.communication.mobileuser.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.mobileuser.model.S_Bas_SendTask;
import com.lauvan.apps.communication.mobileuser.model.T_MobileUser;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Operation_Log;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.DateTimeUtil;
import com.lauvan.util.JsonUtil;

import net.sf.json.JSONObject;

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
		page = T_MobileUser.dao.getGridPage(pageNumber, pageSize, mobileusername, mobileuserrealname);
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		// 调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}

	public void useradd() {
		render("add.jsp");
	}

	public void userupd() {
		String id = getPara(0);
		T_MobileUser mu = T_MobileUser.dao.findById(id);
		setAttr("mu", mu);
		render("update.jsp");
	}

	public void userview() {
		String id = getPara(0);
		T_MobileUser mu = T_MobileUser.dao.findById(id);
		setAttr("mu", mu);
		render("view.jsp");
	}

	public void save() {
		try {
			boolean success = false;
			LoginModel loginModel = getSessionAttr("loginModel");
			Number userid = loginModel.getUserId();
			String methodname = "add";
			String act = getPara("act");
			T_MobileUser mu = getModel(T_MobileUser.class);
			String alt = "";
			if(act.equals("upd")) {
				mu.update();
				success = true;
				methodname = "update";
				alt = "修改成功！";
			} else {
				mu.set("id", AutoId.nextval(mu));
				mu.save();
				success = true;
				alt = "保存成功！";
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mobileuser", methodname, mu, getRequest());
			}
			toDwzText(success, alt, "", "mobileuserDialog", "mobileuserGrid", "closeCurrent");
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}
	}

	public void userdel() {
		String ids = getPara("ids");
		String[] id = ids.split(",");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "";
		String errorCode = "info";
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		try {
			for(String i : id) {
				T_MobileUser mu = T_MobileUser.dao.findById(i);
				mu.delete();
				T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mobileuser/userdel", "delete", mu, getRequest());
			}
			success = true;
		} catch(Exception e) {
			log.error(e.getMessage());
			errorCode = "error";
			msg = e.getMessage();
			e.printStackTrace();
		} finally {
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}

	public void sendtask() {
		String id = getPara("id");
		setAttr("id", id);
		render("sendtask.jsp");
	}

	/**
	 * 获取所有终端用户详细信息
	 * */
	public void getContent() {
		List<Record> list = T_MobileUser.dao.getAllusers();
		String jsonlist = JsonKit.toJson(list);
		renderJson(jsonlist);
	}

	//发送任务到手机终端
	public void taskSave() throws PushClientException,
		PushServerException {
		LoginModel loginModel = getSessionAttr("loginModel");
		Number userid = loginModel.getUserId();
		String now = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_HMS_FORMAT);
		S_Bas_SendTask st = getModel(S_Bas_SendTask.class);
		st.set("time", now);
		st.set("id", AutoId.nextval(st));
		st.set("sender", userid);
		String alt = "保存失败！";
		boolean success = false;
		T_MobileUser user = T_MobileUser.dao.findById(st.getBigDecimal("ARRIVER").toString());
		String apiKey = "dAcgOSGA22toup3jCf09kFlOaiQ4R12c";
		String secretKey = "HfNYgwoya0bxUyAKX2S5KOHPxXSuAnzK";
		PushKeyPair pair = new PushKeyPair(apiKey, secretKey);

		// 2. 创建BaiduPushClient，访问SDK接口
		BaiduPushClient pushClient = new BaiduPushClient(pair, BaiduPushConstants.CHANNEL_REST_URL);

		// 3. 注册YunLogHandler，获取本次请求的交互信息
		pushClient.setChannelLogHandler(new YunLogHandler() {
			@Override
			public void onHandle(YunLogEvent event) {
				System.out.println(event.getMessage());
			}
		});
		if(user != null) {
			if(StringUtils.isNotBlank(user.getStr("TOKEN"))) {
				st.set("SENDSTATUS", 1);
				try {
					//发送的数据必须是json格式
					JSONObject notification = new JSONObject();
					notification.put("ID", st.getBigDecimal("ID").toString());
					notification.put("POINTX", st.getStr("POINTX"));
					notification.put("POINTY", st.getStr("POINTY"));
					notification.put("TITLE", st.getStr("TITLE"));
					notification.put("CONTENT", st.getStr("CONTENT"));
					notification.put("SENDER", st.getBigDecimal("SENDER").toString());
					notification.put("TIME", st.getStr("TIME"));
					notification.put("STATUS", 0);
					// 4. 设置请求参数，创建请求实例
					PushMsgToSingleDeviceRequest request = new PushMsgToSingleDeviceRequest().addChannelId(user.getStr("TOKEN")).addMsgExpires(new Integer(3600 * 5)). //设置消息的有效时间,单位秒,默认3600*5.
						addMessageType(0). //设置消息类型,0表示透传消息,1表示通知,默认为0.
						addMessage(notification.toString()).addDeviceType(3); //设置设备类型，deviceType => 1 for web, 2 for pc, 
																				//3 for android, 4 for ios, 5 for wp.
																				// 5. 执行Http请求
					PushMsgToSingleDeviceResponse response = pushClient.pushMsgToSingleDevice(request);
					// 6. Http请求返回值解析
					System.out.println("msgId: " + response.getMsgId() + ",sendTime: " + response.getSendTime());

				} catch(PushClientException e) {
					//ERROROPTTYPE 用于设置异常的处理方式 -- 抛出异常和捕获异常,
					//'true' 表示抛出, 'false' 表示捕获。
					if(BaiduPushConstants.ERROROPTTYPE) {
						throw e;
					} else {
						e.printStackTrace();
					}
				} catch(PushServerException e) {
					if(BaiduPushConstants.ERROROPTTYPE) {
						throw e;
					} else {
						System.out.println(String.format("requestId: %d, errorCode: %d, errorMsg: %s", e.getRequestId(), e.getErrorCode(), e.getErrorMsg()));
					}
				}

			}
		}

		try {
			String methodname = "add";
			success = st.save();
			if(success) {
				if(StringUtils.isNotBlank(user.getStr("TOKEN"))) {
					alt = "推送与保存成功！";
				} else {
					alt = "推送失败，已保存！用户登录后自动重新发送！";
				}
			}
			T_Sys_Operation_Log.dao.insert(success, userid.toString(), "Main/mobileuser/sendtask", methodname, st, getRequest());
			toDwzText(success, alt, "", "sendtasktomDialog", "mobileuserGrid", "closeCurrent");
		} catch(Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			toDwzText(false, "保存异常！", "", "", "", "");
		}

	}

	public void getTaskView() {
		String userid = getPara(0);
		setAttr("userid", userid);
		render("tasklist.jsp");
	}

	public void getTaskList() {
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

}
