package com.lauvan.apps.communication.mail.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.apps.communication.mail.model.T_Bus_Mail_Cg;
import com.lauvan.apps.communication.mail.model.T_Bus_Mail_Fq;
import com.lauvan.apps.communication.mail.model.T_Bus_Mail_Rece;
import com.lauvan.apps.communication.mail.model.T_Bus_Mail_To;
import com.lauvan.apps.communication.mail.utils.EmailUtil;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.core.util.AutoId;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.JsonUtil;
/***
 * 邮件管理控制类
 * */
@RouteBind(path="Main/mail",viewPath="/communication/mail")
public class MailController extends BaseController {
	//发件箱
	public void sendMain(){
		render("sendMain.jsp");
	}
	
	public void getSendGrid(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String rname = getPara("rname");
		String subject = getPara("subject");
		String sendtime = getPara("sendtime");
		StringBuffer swhere  = new StringBuffer();
		if(rname!=null && !"".equals(rname)){
			swhere.append(" and t.address_to like '%").append(rname).append("%'");
		}
		if(subject!=null && !"".equals(subject)){
			swhere.append(" and t.subject like '%").append(subject).append("%'");
		}
		if(sendtime!=null && !"".equals(sendtime)){
			swhere.append(" and substr(t.send_time,0,10) ='").append(sendtime).append("'");
		}
		Page<Record> page = T_Bus_Mail_To.dao.getSendPage(pageSize, pageNumber, swhere.toString());
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	//收件箱
	public void receMain(){
		render("receMain.jsp");
	}
	
	public void getReceGrid(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String sname = getPara("sname");
		String subject = getPara("subject");
		String sendtime = getPara("sendtime");
		StringBuffer swhere  = new StringBuffer();
		if(sname!=null && !"".equals(sname)){
			swhere.append(" and t.sender like '%").append(sname).append("%'");
		}
		if(subject!=null && !"".equals(subject)){
			swhere.append(" and t.subject like '%").append(subject).append("%'");
		}
		if(sendtime!=null && !"".equals(sendtime)){
			swhere.append(" and substr(t.send_time,0,10) ='").append(sendtime).append("'");
		}
		Page<Record> page = T_Bus_Mail_Rece.dao.getRecePage(pageSize, pageNumber, swhere.toString());
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	//草稿箱
	public void editMain(){
		render("editMain.jsp");
	}
	
	public void getEditGrid(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String rname = getPara("ename");
		String subject = getPara("subject");
		String marktime = getPara("marktime");
		StringBuffer swhere  = new StringBuffer();
		if(rname!=null && !"".equals(rname)){
			swhere.append(" and t.address_to like '%").append(rname).append("%'");
		}
		if(subject!=null && !"".equals(subject)){
			swhere.append(" and t.subject like '%").append(subject).append("%'");
		}
		if(marktime!=null && !"".equals(marktime)){
			swhere.append(" and substr(t.marktime,0,10) ='").append(marktime).append("'");
		}
		Page<Record> page = T_Bus_Mail_Cg.dao.getCaogaoPage(pageSize, pageNumber, swhere.toString());
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	//垃圾箱
	public void delMain(){
		render("delMain.jsp");
	}
	
	public void getDelGrid(){
		Integer pageSize = getParaToInt("rows");
		Integer pageNumber = getParaToInt("page");
		String rname = getPara("name");
		String subject = getPara("subject");
		String marktime = getPara("marktime");
		StringBuffer swhere  = new StringBuffer();
		if(rname!=null && !"".equals(rname)){
			swhere.append(" and t.address_to like '%").append(rname).append("%'");
		}
		if(subject!=null && !"".equals(subject)){
			swhere.append(" and t.subject like '%").append(subject).append("%'");
		}
		if(marktime!=null && !"".equals(marktime)){
			swhere.append(" and substr(t.marktime,0,10) ='").append(marktime).append("'");
		}
		Page<Record> page = T_Bus_Mail_Fq.dao.getDelPage(pageSize, pageNumber, swhere.toString());
		List<Record> list = page.getList();
		int totalCount = page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr = JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	//新建邮件
	public void add(){
		String flag = getPara(0);
		String id = getPara(1);
		Record mail = new Record();
		String fjids = "";
		if("zfsend".equals(flag)){
			//转发发件箱邮件
			mail = T_Bus_Mail_To.dao.getById(id);
			setAttr("mail",mail);
			fjids = mail.getStr("fjids");
			if(fjids!=null && !"".equals(fjids)){
				List<T_Attachment> fjlist = T_Attachment.dao.getListByIds(fjids);
				setAttr("fjlist",fjlist);
			}
			render("add_zf.jsp");
		}else if("zfrece".equals(flag)){
			//转发收件箱邮件
			mail = T_Bus_Mail_Rece.dao.getById(id);
			setAttr("mail",mail);
			fjids = mail.getStr("fjids");
			if(fjids!=null && !"".equals(fjids)){
				List<T_Attachment> fjlist = T_Attachment.dao.getListByIds(fjids);
				setAttr("fjlist",fjlist);
			}
			render("add_zf.jsp");
		}else if("zfedit".equals(flag)){
			//转发收件箱邮件
			mail = T_Bus_Mail_Cg.dao.getById(id);
			setAttr("mail",mail);
			fjids = mail.getStr("fjids");
			if(fjids!=null && !"".equals(fjids)){
				List<T_Attachment> fjlist = T_Attachment.dao.getListByIds(fjids);
				setAttr("fjlist",fjlist);
			}
			render("add_zf.jsp");
		}else if("reply".equals(flag)){
			//回复邮件
			mail = T_Bus_Mail_Rece.dao.getById(id);
			setAttr("mail",mail);
			fjids = mail.getStr("fjids");
			if(fjids!=null && !"".equals(fjids)){
				List<T_Attachment> fjlist = T_Attachment.dao.getListByIds(fjids);
				setAttr("fjlist",fjlist);
			}
			render("add_reply.jsp");
		}else if("resend".equals(flag)){
			//重新发送邮件
			mail = T_Bus_Mail_To.dao.getById(id);
			setAttr("mail",mail);
			fjids = mail.getStr("fjids");
			if(fjids!=null && !"".equals(fjids)){
				List<T_Attachment> fjlist = T_Attachment.dao.getListByIds(fjids);
				setAttr("fjlist",fjlist);
			}
			render("add_edit.jsp");
		}else if("upd".equals(flag)){
			//编辑草稿邮件
			mail = T_Bus_Mail_Cg.dao.getById(id);
			setAttr("mail",mail);
			fjids = mail.getStr("fjids");
			if(fjids!=null && !"".equals(fjids)){
				List<T_Attachment> fjlist = T_Attachment.dao.getListByIds(fjids);
				setAttr("fjlist",fjlist);
			}
			render("add_edit.jsp");
		}else{
			//新建邮件
			render("add.jsp");
		}
	}
		
	public void save(){
		try {
			String act = getPara("act");
			T_Bus_Mail_To to = getModel(T_Bus_Mail_To.class);
			//获取附件
			String[] fjids = getParaValues("emfjid");
			if(fjids!=null && fjids.length>0){
				fjids = ArrayUtils.removeDuplicate(fjids);
			}
			String fjid = ArrayUtils.ArrayToString(fjids);
			List<String> filepath = new ArrayList<String>();
			//获取附件实际路径
			if(fjid!=null && !"".equals(fjid)){
				List<T_Attachment> alist = T_Attachment.dao.getListByIds(fjid);
				if(alist!=null && alist.size()>0){
					for(T_Attachment a: alist){
						String url = a.getStr("url");
						if(!url.startsWith("/") && url.indexOf(":") != 1) {
							url = PathKit.getWebRootPath() + "/" + url;
						}
						filepath.add(url);
					}
				}
			}
			//获取收件人
			String rece = getPara("mailto");
			String recename = getPara("mailtoname");
			StringBuffer address_to = new StringBuffer();
			if(rece!=null && !"".equals(rece)){
				String[] r = rece.split(",");
				String[] rname = recename.split(",");
				for(int i=0;i<r.length;i++){
					if(i>0){
						address_to.append(",");
					}
					String rn = rname[i];
					if(rn.indexOf("@")>0){
						rn = rn.substring(0, rn.indexOf("@"));
					}
					address_to.append(rn).append("<").append(r[i]).append(">");
				}
			}
			
			//获取抄送人
			String cc = getPara("mailcc");
			String ccname = getPara("mailccname");
			StringBuffer address_cc = new StringBuffer();
			if(cc!=null && !"".equals(cc)){
				String[] c = cc.split(",");
				String[] cname = ccname.split(",");
				for(int i=0;i<c.length;i++){
					if(i>0){
						address_cc.append(",");
					}
					String cn = cname[i];
					if(cn.indexOf("@")>0){
						cn = cn.substring(0, cn.indexOf("@"));
					}
					address_cc.append(cn).append("<").append(c[i]).append(">");
				}
			}
			to.set("fjids", fjid);
			to.set("address_to", address_to.toString());
			to.set("address_cc", address_cc.toString());
			
			LoginModel login = getSessionAttr("loginModel");
			to.set("user_id", login.getUserId());
			to.set("user_name", login.getUserName());
			
			String subject = to.getStr("subject");
			String conhtml = to.getStr("content");
			boolean sendflag = true;
			boolean cgflag = true;
			
			if("cg".equals(act)){
				T_Bus_Mail_Cg cg = new T_Bus_Mail_Cg();
				cg.set("subject", to.get("subject"));
				cg.set("address_to", address_to.toString());
				cg.set("address_cc", address_cc.toString());
				cg.set("content", to.get("content"));
				cg.set("eventid", to.get("eventid"));
				cg.set("emseq", to.get("emseq"));
				cg.set("fjids", fjid);
				cg.set("user_name", to.get("user_name"));
				cg.set("user_id", to.get("user_id"));
				if(cgflag){
					T_Bus_Mail_Cg.dao.insert(cg);
				}
				if(cgflag){
					toDwzText(true, "保存草稿成功！", "", "", "", "closeCurrent");
				}else{
					toDwzText(false, "保存草稿失败！", "", "", "", "");
				}
			}
			
			//草稿存为草稿，则直接update
			if("cgcg".equals(act)){
				T_Bus_Mail_Cg cg = T_Bus_Mail_Cg.dao.findById(to.get("id"));
				System.out.println("22222"+to.get("id"));
				cg.set("subject", subject);
				cg.set("address_to", address_to.toString());
				cg.set("address_cc", address_cc.toString());
				cg.set("content", to.get("content"));
				cg.set("eventid", to.get("eventid"));
				cg.set("emseq", to.get("emseq"));
				cg.set("fjids", fjid);
				cg.set("user_name", to.get("user_name"));
				cg.set("user_id", to.get("user_id"));
				if(cgflag){
					cg.update();
				}
				if(cgflag){
					toDwzText(true, "编辑成功！", "", "", "", "closeCurrent");
				}else{
					toDwzText(false, "编辑失败！", "", "", "", "");
				}
			}
			
			if("add".equals(act)){
				//调用邮件发送接口
				sendflag = EmailUtil.send(address_to.toString(), address_cc.toString(), subject, conhtml, filepath);
				//T_Bus_Mail_To.dao.insert(to);
				if(sendflag){
					//新增邮件
					T_Bus_Mail_To.dao.insert(to);
				}
				if(sendflag){
					toDwzText(true, "发送完成！", "", "", "", "closeCurrent");
				}else{
					toDwzText(false, "发送失败！", "", "", "", "");
				}
			}
		} catch (Exception e) {
			toDwzText(false, "操作异常，请检查！", "", "", "", "");
			e.printStackTrace();
		}
	}
	//查看详情
	public void getView(){
		String id = getPara(0);
		String flag = getPara(1);
		Record mail = new Record();
		String fjids = "";
		if("send".equals(flag)){
			//发件箱
			mail = T_Bus_Mail_To.dao.getById(id);
		}if("rece".equals(flag)){
			//收件箱
			mail = T_Bus_Mail_Rece.dao.getById(id);
	    }if("edit".equals(flag)){
		    //草稿箱
		    mail = T_Bus_Mail_Cg.dao.getById(id);
	    }if("del".equals(flag)){
		    //垃圾箱
		    mail = T_Bus_Mail_Fq.dao.getById(id);
	    }
		setAttr("flag",flag);
		setAttr("mail",mail);
		fjids = mail.getStr("fjids");
		if(fjids!=null && !"".equals(fjids)){
			List<T_Attachment> fjlist = T_Attachment.dao.getListByIds(fjids);
			setAttr("fjlist",fjlist);
		}
		render("view.jsp");
	}
	
	//事件关联页面
	public void getMailEvent() {
		render("mailEvent.jsp");
	}

	//邮件关联事件
	public void relaEvent() {
		String mid = getPara("mid");
		String eventid = getPara("eventid");
		String flag = getPara("flag");
		Map<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		String msg = "关联成功！";
		String errorCode = "info";
		try {
			if("to_unrela".equals(flag)){
				//取消关联事件
				msg = "取消关联事件成功！";
				success = T_Bus_Mail_To.dao.unrelaEventid(mid);
				//删除事件短信信息表中的关联短信
			}if("rece_unrela".equals(flag)){
				//取消关联事件
				msg = "取消关联事件成功！";
				success = T_Bus_Mail_Rece.dao.unrelaEventid(mid);
				//删除事件短信信息表中的关联短信
			}if("to_rela".equals(flag)){
				if(eventid == null || "".equals(eventid)) {
					errorCode = "error";
					msg = "请选择关联事件！";
				} else {
					success = T_Bus_Mail_To.dao.relaEventid(mid, eventid);}
				}
			if("rece_rela".equals(flag)){
				if(eventid == null || "".equals(eventid)) {
					errorCode = "error";
					msg = "请选择关联事件！";
				} else {
					success = T_Bus_Mail_Rece.dao.relaEventid(mid, eventid);
				}
					//往事件短信表添加记录
				/*	String ids = T_Bus_Moblie_To.dao.getIdsBySmid(smid);
					String[] id = ids.split(",");
					for(int i = 0; i < id.length; i++) {
						T_Bus_Moblie_To t = T_Bus_Moblie_To.dao.findById(id[i]);
						T_Bus_SmsSendRD s = new T_Bus_SmsSendRD();
						s.set("smsid", t.getStr("sm_id"));
						s.set("sendstate", t.getStr("send_state"));
						s.set("smsdata", t.getStr("content"));
						s.set("sendtime", t.getStr("send_time"));
						s.set("senduser", t.getStr("send_user"));
						s.set("eventid", eventid);
						String callno = t.getStr("mobile");
						String callname = t.getStr("mobname");
						if(callno.indexOf(",") > 0) {
							String[] mobile = callno.split(",");
							String[] mobname = callname.split(",");
							for(int j = 0; j < mobile.length; j++) {
								s.set("callno", mobile[j]);
								s.set("callname", j < mobname.length ? mobname[j] : mobile[j]);
								T_Bus_SmsSendRD.dao.insert(s);
							}
						} else {
							s.set("callno", callno);
							s.set("callname", callname);
							T_Bus_SmsSendRD.dao.insert(s);
						}

					}*/
			}
		} catch(Exception e) {
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
	
	//恢复垃圾箱邮件
	public void reback(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			for(int i = 0; i<ids.length; i++){
				T_Bus_Mail_Fq fq = T_Bus_Mail_Fq.dao.findById(ids[i]);
				if(fq.get("state").equals("001")){
					T_Bus_Mail_To t = new T_Bus_Mail_To();
					t.set("subject", fq.get("subject"));
					t.set("address_to", fq.get("address_to"));
					t.set("address_cc", fq.get("address_cc"));
					t.set("sender", fq.get("sender"));
					t.set("content", fq.get("content"));
					t.set("eventid", fq.get("eventid"));
					t.set("emseq", fq.get("emseq"));
					t.set("fjids", fq.get("fjids"));
					t.set("send_time", fq.get("send_time"));
					t.set("marktime", fq.get("marktime"));
					t.set("id", AutoId.nextval(t));
					t.save();
					fq.delete();
				}
				if(fq.get("state").equals("002")){
					T_Bus_Mail_Rece t = new T_Bus_Mail_Rece();
					t.set("subject", fq.get("subject"));
					t.set("address_to", fq.get("address_to"));
					t.set("address_cc", fq.get("address_cc"));
					t.set("sender", fq.get("sender"));
					t.set("content", fq.get("content"));
					t.set("eventid", fq.get("eventid"));
					t.set("emseq", fq.get("emseq"));
					t.set("fjids", fq.get("fjids"));
					t.set("msgid", fq.get("msgid"));
					t.set("send_time", fq.get("send_time"));
					t.set("marktime", fq.get("marktime"));
					t.set("id", AutoId.nextval(t));
					t.save();
					fq.delete();
				}
				if(fq.get("state").equals("003")){
					T_Bus_Mail_Cg t = new T_Bus_Mail_Cg();
					t.set("subject", fq.get("subject"));
					t.set("address_to", fq.get("address_to"));
					t.set("address_cc", fq.get("address_cc"));
					t.set("sender", fq.get("sender"));
					t.set("content", fq.get("content"));
					t.set("eventid", fq.get("eventid"));
					t.set("emseq", fq.get("emseq"));
					t.set("fjids", fq.get("fjids"));
					t.set("send_time", fq.get("send_time"));
					t.set("marktime", fq.get("marktime"));
					t.set("id", AutoId.nextval(t));
					t.save();
					fq.delete();
				}
				}
				success = true;
				errorCode = "info";
			} catch(Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
			} finally {
				tips.put("success", success);
				tips.put("errorCode", errorCode);
				tips.put("msg", msg);
				renderJson(tips);
			}
	}
	
	//删除发件
		public void toDel(){
			String[] ids = getParaValues("ids");
			Map<String, Object> tips = new HashMap<String, Object>();
			boolean success = false;
			String errorCode = "error";
			String msg = "";
			try {
				for(int i = 0; i<ids.length; i++){
					T_Bus_Mail_Fq m = new T_Bus_Mail_Fq();
					T_Bus_Mail_To c = T_Bus_Mail_To.dao.findById(ids[i]);
					m.set("subject", c.get("subject"));
					m.set("address_to", c.get("address_to"));
					m.set("address_cc", c.get("address_cc"));
					m.set("sender", c.get("sender"));
					m.set("content", c.get("content"));
					m.set("eventid", c.get("eventid"));
					m.set("emseq", c.get("emseq"));
					m.set("msgid", c.get("msgid"));
					m.set("fjids", c.get("fjids"));
					m.set("state", "001");
					m.set("send_time", c.get("send_time"));
					T_Bus_Mail_Fq.dao.insert(m);
					c.delete();
				}
				success = true;
				errorCode = "info";
			} catch(Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
			} finally {
				tips.put("success", success);
				tips.put("errorCode", errorCode);
				tips.put("msg", msg);
				renderJson(tips);
			}
		}	
	
	//删除收件
	public void receDel(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			for(int i = 0; i<ids.length; i++){
				T_Bus_Mail_Fq m = new T_Bus_Mail_Fq();
				T_Bus_Mail_Rece c = T_Bus_Mail_Rece.dao.findById(ids[i]);
				m.set("subject", c.get("subject"));
				m.set("address_to", c.get("address_to"));
				m.set("address_cc", c.get("address_cc"));
				m.set("sender", c.get("sender"));
				m.set("content", c.get("content"));
				m.set("eventid", c.get("eventid"));
				m.set("emseq", c.get("emseq"));
				m.set("msgid", c.get("msgid"));
				m.set("fjids", c.get("fjids"));
				m.set("send_time", c.get("send_time"));
				m.set("state", "002");
				T_Bus_Mail_Fq.dao.insert(m);
				c.delete();
			}
			success = true;
			errorCode = "info";
		} catch(Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally {
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			renderJson(tips);
		}
	}

	//删除草稿
	public void cgDel(){
		String[] ids = getParaValues("ids");
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			for(int i = 0; i<ids.length; i++){
				T_Bus_Mail_Fq m = new T_Bus_Mail_Fq();
				T_Bus_Mail_Cg c = T_Bus_Mail_Cg.dao.findById(ids[i]);
				m.set("subject", c.get("subject"));
				m.set("address_to", c.get("address_to"));
				m.set("address_cc", c.get("address_cc"));
				m.set("sender", c.get("sender"));
				m.set("content", c.get("content"));
				m.set("eventid", c.get("eventid"));
				m.set("emseq", c.get("emseq"));
				m.set("fjids", c.get("fjids"));
				m.set("send_time", c.get("send_time"));
				m.set("state", "003");
				T_Bus_Mail_Fq.dao.insert(m);
				c.delete();
			}
			success = true;
			errorCode = "info";
		} catch(Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally {
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			renderJson(tips);
		}
	}
	
	//彻底删除垃圾箱邮件
	public void realdelete(){
		String[] ids = getParaValues("ids");
		String msgids = "";
		for(int i=0;i<ids.length;i++){
			String msgid = T_Bus_Mail_Fq.dao.findById(ids[i]).getStr("msgid");
			if(msgids.equals("")){
				msgids = msgids + ",";
			}
			msgids = msgids + msgid; 
		}
		Map<String, Object> tips = new HashMap<String, Object>();
		boolean success = false;
		String errorCode = "error";
		String msg = "";
		try {
			String idStr = ArrayUtils.ArrayToString(ids);
			T_Bus_Mail_Fq.dao.deleteByIds(idStr);
			EmailUtil.deleteMail(msgids);
			success = true;
			errorCode = "info";
		} catch(Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		} finally {
			tips.put("success", success);
			tips.put("errorCode", errorCode);
			tips.put("msg", msg);
			renderJson(tips);
		}
	}
	
	
}
