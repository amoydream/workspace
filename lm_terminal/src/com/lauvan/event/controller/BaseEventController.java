package com.lauvan.event.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.event.entity.E_EventNote;
import com.lauvan.event.entity.T_BaseEvent;
import com.lauvan.event.entity.T_Event_Type;
import com.lauvan.event.service.BaseEventService;
import com.lauvan.event.service.EventNoteService;
import com.lauvan.event.vo.BaseEventVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.DateUtil;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
import com.zhuozhengsoft.pageoffice.wordwriter.WordDocument;
/**
 * 
 * ClassName: BaseEventController 
 * @Description: 日常事件管理
 * @author 钮炜炜
 * @date 2015年12月3日 下午5:02:53
 */
@Controller
@RequestMapping("event/baseevent")
public class BaseEventController extends BaseController {

	@Autowired
	private BaseEventService baseEventService;
	@Autowired
	private EventNoteService eventNoteService;
	
	@RequestMapping("/list")
	public String list(Integer page,String query,BaseEventVo baseEventVo,Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("be_createDate", "desc");
		PageView<T_BaseEvent> pageView = new PageView<T_BaseEvent>(15, ((page==null || page<1) ? 1:page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		jpql.append(" o.be_del <> ?").append((params.size() + 1));
		params.add("1"); 
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(baseEventVo.getBe_name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.be_name like ?").append((params.size()+1));
				params.add("%"+baseEventVo.getBe_name().trim()+"%");
			}
			if (!ValidateUtil.isEmpty(baseEventVo.getEventTypeId())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.eventType.et_id = ?").append((params.size()+1));
				params.add(baseEventVo.getEventTypeId());
			}
			if (baseEventVo.getBe_dateBegin()!=null) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.be_date >= ?").append((params.size()+1));
				params.add(baseEventVo.getBe_dateBegin());
			}
			if (baseEventVo.getBe_dateEnd()!=null) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.be_date <= ?").append((params.size()+1));
				params.add(baseEventVo.getBe_dateEnd());
			}
			model.addAttribute("baseEventVo", baseEventVo);
			pageView.setQueryResult(baseEventService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(),params.toArray(),orderby));
		}else {
			
			pageView.setQueryResult(baseEventService.getScrollList(
					pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray(), orderby));
		}
		model.addAttribute("pageView", pageView);
		return "jsp/event/baseevent/baseevent_list";
	}
	/**
	 * 查询接听电话的事件集合
	 * @param be_reportPhone
	 * @param model
	 * @return
	 */
	@RequestMapping("/list2")
	public String list2(String be_reportPhone,Model model) {
		List<T_BaseEvent> baseEvents = baseEventService.findByProperty("be_reportPhone", be_reportPhone);
		if (baseEvents.size()>0) {
			model.addAttribute("baseEvents", baseEvents);
			model.addAttribute("be_reportPhone", be_reportPhone);
			return "jsp/event/baseevent/baseevent_list2";
		}else {
			model.addAttribute("be_reportPhone", be_reportPhone);
			return "jsp/event/baseevent/baseevent_add";
		}
	}
	
	@MethodLog(description = "日常事件添加")
	@Perm(privilegeValue = "baseEventAdd")
	@ResponseBody
	@RequestMapping("/add")
	public Json add(BaseEventVo baseEventVo,HttpSession session) {
		UserInfoVo uv = (UserInfoVo) session.getAttribute("userVo");
		
		T_BaseEvent e = new T_BaseEvent();
		BeanUtils.copyProperties(baseEventVo, e);
		if (!ValidateUtil.isEmpty(baseEventVo.getEventTypeId())) {
			e.setEventType(new T_Event_Type(baseEventVo.getEventTypeId()));
		}
		if (!ValidateUtil.isEmpty(baseEventVo.getOrganId())) {
			e.setOrgan(new C_Organ(baseEventVo.getOrganId()));
		}
		e.setUser(new T_User_Info(uv.getUs_Id()));
		Integer id = (Integer) baseEventService.getMax("be_id");
		e.setBe_id(id+1);
		e.setBe_status("1");
		
		try {
			baseEventService.save(e);
			
			if (!ValidateUtil.isEmpty(baseEventVo.getCallID())) {
				E_EventNote en = new E_EventNote();
				en.setEn_wid(baseEventVo.getCallID());
				en.setEv_id(id);
				try {
					eventNoteService.save(en);
					return json(true, "备忘录添加成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("备忘录添加失败");
				}
			}
			return json(true, "日常事件添加成功");
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("日常事件添加失败");
		}
		
	}
	
	@MethodLog(description = "日常事件编辑UI")
	@Perm(privilegeValue = "baseEventEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			T_BaseEvent e = baseEventService.find(id);
			model.addAttribute("baseEvent", e);
			return "jsp/event/baseevent/baseevent_edit";
		}
		return "";
	}
	
	@MethodLog(description = "日常事件编辑")
	@Perm(privilegeValue = "baseEventEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(BaseEventVo baseEventVo) {
		if (ValidateUtil.isEmpty(baseEventVo.getBe_id())) {
			return json("日常事件ID没有获取到");
		}
		T_BaseEvent e = baseEventService.find(baseEventVo.getBe_id());
		BeanUtils.copyProperties(baseEventVo, e);
		if (!ValidateUtil.isEmpty(baseEventVo.getEventTypeId())) {
			e.setEventType(new T_Event_Type(baseEventVo.getEventTypeId()));
		}
		if (!ValidateUtil.isEmpty(baseEventVo.getOrganId())) {
			e.setOrgan(new C_Organ(baseEventVo.getOrganId()));
		}
		try {
			baseEventService.update(e);
			
			if (!ValidateUtil.isEmpty(baseEventVo.getCallID())) {
				E_EventNote en = new E_EventNote();
				en.setEn_wid(baseEventVo.getCallID());
				en.setEv_id(e.getBe_id());
				try {
					eventNoteService.save(en);
					return json(true, "备忘录添加成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("备忘录添加失败");
				}
			}
			return json(true,"日常事件修改成功");
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("日常事件修改失败");
		}
		
	}
	
	@MethodLog(description = "日常事件彻底删除")
	@Perm(privilegeValue = "baseEventDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			try {
				baseEventService.delete(id);
				return json(true, "日常事件彻底删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("日常事件彻底删除失败");
			}
		}
		return json("没有做任何操作");
	}
	
	@MethodLog(description="日常事件删除")
	@Perm(privilegeValue="baseEventDelup")
	@RequestMapping("/delup")
	@ResponseBody
	public Json delup(Integer id) {
		if(!ValidateUtil.isEmpty(id)) {
			T_BaseEvent be = baseEventService.find(id);
			be.setBe_del("1");
			try {
				baseEventService.update(be);
				return json(true, "日常事件删除成功");
			} catch(Exception e) {
				e.printStackTrace();
				return json("日常事件删除失败");
			}
		}
		return json("没有做任何操作");
	}
 
	@RequestMapping("/infoshow")
	public String infoshow(Integer be_id,Model model){
		if(ValidateUtil.isEmpty(be_id)){
			return null;
		}
		T_BaseEvent baseEvent = baseEventService.find(be_id);
		WordDocument doc = new WordDocument();
		doc.openDataTag("{PO_be_name}").setValue(baseEvent.getBe_name());
		doc.openDataTag("{PO_be_address}").setValue(baseEvent.getBe_address());
		if(baseEvent.getBe_date()==null){
			doc.openDataTag("{PO_be_date}").setValue("");
		}else{
		    doc.openDataTag("{PO_be_date}").setValue(DateUtil.getDate(baseEvent.getBe_date()));
		}
		if(baseEvent.getBe_reportDate()==null){
			doc.openDataTag("{PO_be_reportDate}").setValue("");
		}else{
		    doc.openDataTag("{PO_be_reportDate}").setValue(DateUtil.getDate(baseEvent.getBe_reportDate()));
		}
		if(baseEvent.getOrgan()==null){
			doc.openDataTag("{PO_or_name}").setValue("");
		}else{
		    doc.openDataTag("{PO_or_name}").setValue(baseEvent.getOrgan().getOr_name());
		}
		if(baseEvent.getEventType()==null){
			doc.openDataTag("{PO_et_name}").setValue("");
		}else{
		doc.openDataTag("{PO_et_name}").setValue(baseEvent.getEventType().getEt_name());		
		}
		if(baseEvent.getEventType()==null){
		   doc.openDataTag("{PO_et_name}").setValue("");
		}else{
		   doc.openDataTag("{PO_et_name}").setValue(baseEvent.getEventType().getEt_name());
		}
		if(baseEvent.getBe_reportMode()=="1"){
			doc.openDataTag("{PO_be_reportMode}").setValue("电话");
			}else if(baseEvent.getBe_reportMode()=="2"){
				doc.openDataTag("{PO_be_reportMode}").setValue("传真");
			}else if(baseEvent.getBe_reportMode()=="3"){
				doc.openDataTag("{PO_be_reportMode}").setValue("邮件");
			}else if(baseEvent.getBe_reportMode()=="4"){
				doc.openDataTag("{PO_be_reportMode}").setValue("网络");
			}else if(baseEvent.getBe_reportMode()=="5"){
				doc.openDataTag("{PO_be_reportMode}").setValue("视频");
			}else{
				doc.openDataTag("{PO_be_reportMode}").setValue("其他");
			}
		  doc.openDataTag("{PO_be_reportName}").setValue(baseEvent.getBe_reportName());	
		  doc.openDataTag("{PO_be_reportPhone}").setValue(baseEvent.getBe_reportPhone());
		  doc.openDataTag("{PO_be_basicSituation}").setValue(baseEvent.getBe_basicSituation());
		
		model.addAttribute("doc", doc);
		return "jsp/poffice/baseeventprint";
		
	}
}
