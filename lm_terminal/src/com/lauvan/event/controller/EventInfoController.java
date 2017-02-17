package com.lauvan.event.controller;

import java.util.ArrayList;
import java.util.Date;
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
import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.event.entity.T_Event_Type;
import com.lauvan.event.service.BaseEventService;
import com.lauvan.event.service.EventInfoService;
import com.lauvan.event.service.EventNoteService;
import com.lauvan.event.vo.EventInfoVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Address_Book;
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.organ.service.AddressBookService;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.DateUtil;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
import com.zhuozhengsoft.pageoffice.wordwriter.WordDocument;


/**
 * ClassName: EventInfoController
 * 
 * @Description: 事件管理
 * @author 钮炜炜
 * @date 2015年12月3日 下午5:02:53
 */
@Controller
@RequestMapping("event/eventinfo")
public class EventInfoController extends BaseController {

	@Autowired
	private EventInfoService eventInfoService;
	@Autowired
	private BaseEventService baseEventService;
	@Autowired
	private AddressBookService addressBookService;
	@Autowired
	private EventNoteService eventNoteService;

	@RequestMapping("/list")
	public String list(Integer page, String query, EventInfoVo eventInfoVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("ev_createDate", "desc");
		PageView<T_EventInfo> pageView = new PageView<T_EventInfo>(15,
				((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		jpql.append(" o.ev_del <> ?").append((params.size() + 1));
		params.add("1"); 
		if ("true".equals(query)) {
			if (!ValidateUtil.isEmpty(eventInfoVo.getEv_name())) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.ev_name like ?").append((params.size() + 1));
				params.add("%" + eventInfoVo.getEv_name().trim() + "%");
			}
			if (!ValidateUtil.isEmpty(eventInfoVo.getEventTypeId())) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.eventType.et_id = ?").append(
						(params.size() + 1));
				params.add(eventInfoVo.getEventTypeId());
			}
			if (!ValidateUtil.isEmpty(eventInfoVo.getEv_level())) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.ev_level = ?").append((params.size() + 1));
				params.add(eventInfoVo.getEv_level());
			}
			if (!ValidateUtil.isEmpty(eventInfoVo.getEv_status())) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.ev_status = ?").append((params.size() + 1));
				params.add(eventInfoVo.getEv_status());
			}
			if (eventInfoVo.getEv_dateBegin() != null) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.ev_date >= ?").append((params.size() + 1));
				params.add(eventInfoVo.getEv_dateBegin());
			}
			if (eventInfoVo.getEv_dateEnd() != null) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.ev_date <= ?").append((params.size() + 1));
				params.add(eventInfoVo.getEv_dateEnd());
			}
			model.addAttribute("eventInfoVo", eventInfoVo);
			pageView.setQueryResult(eventInfoService.getScrollList(
					pageView.getFirstResult(), pageView.getMaxresult(),
					jpql.toString(), params.toArray(), orderby));
		} else {
			/*jpql.append(" and o.ev_status <> ?").append((params.size() + 1));
			params.add("4");*/
			pageView.setQueryResult(eventInfoService.getScrollList(
					pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(), params.toArray(), orderby));
		}
		model.addAttribute("pageView", pageView);
		return "jsp/event/eventinfo/eventinfo_list";
	}

	@RequestMapping("/selectList")
	public String selectList(Integer page, String query,
			EventInfoVo eventInfoVo, Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("ev_createDate", "desc");
		PageView<T_EventInfo> pageView = new PageView<T_EventInfo>(10,
				((page == null || page < 1) ? 1 : page));
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(eventInfoVo.getEv_name())) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.ev_name like ?").append((params.size() + 1));
				params.add("%" + eventInfoVo.getEv_name().trim() + "%");
			}
			if (!ValidateUtil.isEmpty(eventInfoVo.getEventTypeId())) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.eventType.et_id = ?").append(
						(params.size() + 1));
				params.add(eventInfoVo.getEventTypeId());
			}
			model.addAttribute("eventInfoVo", eventInfoVo);
			pageView.setQueryResult(eventInfoService.getScrollList(
					pageView.getFirstResult(), pageView.getMaxresult(),
					jpql.toString(), params.toArray(), orderby));
		} else {
			pageView.setQueryResult(eventInfoService.getScrollList(
					pageView.getFirstResult(), pageView.getMaxresult(), orderby));
		}
		model.addAttribute("pageView", pageView);
		return "jsp/event/eventinfo/eventinfo_select";
	}

	/**
	 * 查询接听电话的事件集合
	 * 
	 * @param ev_reportPhone
	 * @param model
	 * @return
	 */
	@RequestMapping("/list2")
	public String list2(String ev_reportPhone,String CallID, Model model) {
		List<T_BaseEvent> baseEvents = baseEventService.findStatus("4");
		List<T_EventInfo> eventInfos = eventInfoService.findStatus("4");
		List<C_Address_Book> aBooks = addressBookService.findByProperty("bo_number", CallID);
		if (aBooks.size()>0) {
			for (C_Address_Book ab : aBooks) {
				if (ab.getBo_index()==1) {
					if (ab.getBo_usertype().equals("1")) {
						model.addAttribute("name", ab.getPerson().getPe_name());
						model.addAttribute("dep", ab.getPerson().getOrgan().getOr_name());
					}else if (ab.getBo_usertype().equals("2")) {
						model.addAttribute("dep", ab.getOrgan().getOr_name());
					}
				}
			}
		}
		model.addAttribute("CallID", CallID);
		model.addAttribute("baseEvents", baseEvents);
		model.addAttribute("eventInfos", eventInfos);
		model.addAttribute("ev_reportPhone", ev_reportPhone);
		model.addAttribute("ev_reportDate",
				ValidateUtil.parseDateToStringss(new Date()));
		return "jsp/event/eventinfo/eventinfo_list2";
	}

	@MethodLog(description = "突发事件添加")
	@Perm(privilegeValue = "eventAdd")
	@ResponseBody
	@RequestMapping("/add")
	public Json add(EventInfoVo eventInfoVo, HttpSession session) {
		UserInfoVo uv = (UserInfoVo) session.getAttribute("userVo");

		T_EventInfo e = new T_EventInfo();
		BeanUtils.copyProperties(eventInfoVo, e);
		if (!ValidateUtil.isEmpty(eventInfoVo.getEventTypeId())) {
			e.setEventType(new T_Event_Type(eventInfoVo.getEventTypeId()));
		}
		if (!ValidateUtil.isEmpty(eventInfoVo.getOrganId())) {
			e.setOrgan(new C_Organ(eventInfoVo.getOrganId()));
		}
		e.setUser(new T_User_Info(uv.getUs_Id()));
		
		Integer id = (Integer) eventInfoService.getMax("ev_id");
		e.setEv_id(id+1);
		
		try {
			eventInfoService.save(e);
			if (!ValidateUtil.isEmpty(eventInfoVo.getCallID())) {
				E_EventNote en = new E_EventNote();
				en.setEn_wid(eventInfoVo.getCallID());
				en.setEv_id(e.getEv_id());
				try {
					eventNoteService.save(en);
					return json(true, "备忘录添加成功");
				} catch (Exception e1) {
					e1.printStackTrace();
					return json("备忘录添加失败");
				}
			}
			return json(true, "事件添加成功");
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("事件添加失败");
		}
	}

	@MethodLog(description = "突发事件编辑UI")
	@Perm(privilegeValue = "eventEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Integer CallID, Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			T_EventInfo e = eventInfoService.find(id);
			model.addAttribute("eventInfo", e);
			model.addAttribute("CallID", CallID);
			return "jsp/event/eventinfo/eventinfo_edit";
		}
		return "";
	}

	
	@RequestMapping("/tomap")
	public String tomap(Integer id, Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			T_EventInfo e = eventInfoService.find(id);
			model.addAttribute("eventInfo", e);
			return "jsp/event/eventinfo/eventinfo_map";
		}
		return "";
	}

	@MethodLog(description = "突发事件处置")
	@Perm(privilegeValue = "eventViewip")
	@RequestMapping("/view")
	public String view(Integer id, Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			T_EventInfo e = eventInfoService.find(id);
			model.addAttribute("eventInfo", e);
			return "jsp/event/eventinfo/eventinfo_view";
		}
		return "";
	}

	@MethodLog(description = "突发事件编辑")
	@Perm(privilegeValue = "eventEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(EventInfoVo eventInfoVo) {
		if (ValidateUtil.isEmpty(eventInfoVo.getEv_id())) {
			return json("事件ID没有获取到");
		}
		T_EventInfo e = eventInfoService.find(eventInfoVo.getEv_id());
		BeanUtils.copyProperties(eventInfoVo, e);
		if (!ValidateUtil.isEmpty(eventInfoVo.getEventTypeId())) {
			e.setEventType(new T_Event_Type(eventInfoVo.getEventTypeId()));
		}
		if (!ValidateUtil.isEmpty(eventInfoVo.getOrganId())) {
			e.setOrgan(new C_Organ(eventInfoVo.getOrganId()));
		}
		
		try {
			eventInfoService.update(e);
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("事件修改失败");
		}
		if (!ValidateUtil.isEmpty(eventInfoVo.getCallID())) {
			E_EventNote en = new E_EventNote();
			en.setEn_wid(eventInfoVo.getCallID());
			en.setEv_id(e.getEv_id());
			try {
				eventNoteService.save(en);
				return json(true, "备忘录添加成功");
			} catch (Exception e1) {
				e1.printStackTrace();
				return json("备忘录添加失败");
			}
		}
		return json(true, "事件修改成功");
	}

	@MethodLog(description = "突发事件彻底删除")
	@Perm(privilegeValue = "eventDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			try {
				eventInfoService.delete(id);
				return json(true, "事件彻底删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("事件彻底删除失败");
			}
		}
		return json("没有做任何操作");
	}
	
	@MethodLog(description="突发事件删除")
	@Perm(privilegeValue="eventDelup")
	@RequestMapping("/delup")
	@ResponseBody
	public Json delup(Integer id) {
		if(!ValidateUtil.isEmpty(id)) {
			T_EventInfo ev = eventInfoService.find(id);
			ev.setEv_del("1");
			try {
				eventInfoService.update(ev);
				return json(true, "突发事件删除成功");
			} catch(Exception e) {
				e.printStackTrace();
				return json("突发事件删除失败");
			}
		}
		return json("没有做任何操作");
	}

	@RequestMapping("/map")
	public String map(Double longitude, Double latitude,Integer eventTypeId, Model model) {
		model.addAttribute("eventTypeId", eventTypeId);
		model.addAttribute("longitude", longitude);
		model.addAttribute("latitude", latitude);
		return "jsp/event/eventinfo/eventinfo_map";
	}
	/**
	 * 处置过程
	 * @param id
	 * @return
	 */
	@RequestMapping("/disposal")
	public String disposal(Integer id) {
		return "jsp/event/disposal/disposal_main";
	}
	/**
	 * 事件完结
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/finish")
	public Json finish(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			T_EventInfo ei = eventInfoService.find(id);
			ei.setEv_status("4");
			try {
				eventInfoService.update(ei);
				return json(true, "事件完结提交成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "事件完结提交失败");
			}
		}
		return json("事件ID没有获取到");
	}
	@ResponseBody
	@RequestMapping("/backinfo")
	public Json backinfo(Integer eventId,String content) {
		if (!ValidateUtil.isEmpty(eventId) && !ValidateUtil.isEmpty(content)) {
			E_EventNote eventNote = new E_EventNote();
			eventNote.setEn_content(content.trim());
			eventNote.setEn_type("5");
			eventNote.setEv_id(eventId);
			try {
				eventNoteService.save(eventNote);
				return json(true, "事件反馈提交成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "事件反馈提交失败");
			}
		}
		return json("没有做任何操作");
	}
	
	
	@RequestMapping("/infoshow")
	public String infoshow(Integer ev_id,Model model){
		if(ValidateUtil.isEmpty(ev_id)){			
			return null;
		}
		
		T_EventInfo eveninfo = eventInfoService.find(ev_id);
		WordDocument doc = new WordDocument();
		doc.openDataTag("{PO_ev_name}").setValue(eveninfo.getEv_name());
		doc.openDataTag("{PO_ev_address}").setValue(eveninfo.getEv_address());
		if(eveninfo.getEv_date()==null){
		doc.openDataTag("{PO_ev_date}").setValue("");
		}else{
		doc.openDataTag("{PO_ev_date}").setValue(DateUtil.getDate(eveninfo.getEv_date()));
		}
		if(eveninfo.getEv_reportDate()==null){
		doc.openDataTag("{PO_ev_reportDate}").setValue("");	
		}else{
		doc.openDataTag("{PO_ev_reportDate}").setValue(DateUtil.getDate(eveninfo.getEv_reportDate()));
		}
		if(eveninfo.getOrgan()==null){
			doc.openDataTag("{PO_or_name}").setValue("");
		}else{			
			doc.openDataTag("{PO_or_name}").setValue(eveninfo.getOrgan().getOr_name());
		}
		if(eveninfo.getEv_reportMode()=="1"){
		doc.openDataTag("{PO_ev_reportMode}").setValue("电话");
		}else if(eveninfo.getEv_reportMode()=="2"){
			doc.openDataTag("{PO_ev_reportMode}").setValue("传真");
		}else if(eveninfo.getEv_reportMode()=="3"){
			doc.openDataTag("{PO_ev_reportMode}").setValue("邮件");
		}else if(eveninfo.getEv_reportMode()=="4"){
			doc.openDataTag("{PO_ev_reportMode}").setValue("网络");
		}else if(eveninfo.getEv_reportMode()=="5"){
			doc.openDataTag("{PO_ev_reportMode}").setValue("视频");
		}else{
			doc.openDataTag("{PO_ev_reportMode}").setValue("其他");
		}
		if(eveninfo.getEventType()==null){
			doc.openDataTag("{PO_eventType}").setValue("");	
		}else{
		    doc.openDataTag("{PO_eventType}").setValue(eveninfo.getEventType().getEt_name());
		}
		if(eveninfo.getEv_level()=="1"){
			doc.openDataTag("{PO_ev_level}").setValue("Ⅰ级事件(特别重大)");
		}else if(eveninfo.getEv_level()=="2"){
			doc.openDataTag("{PO_ev_level}").setValue("Ⅱ级事件(重大)");
		}else if(eveninfo.getEv_level()=="3"){
			doc.openDataTag("{PO_ev_level}").setValue("Ⅲ级事件(较大)");		
		}else if(eveninfo.getEv_level()=="4"){
			doc.openDataTag("{PO_ev_level}").setValue("Ⅳ级事件(一般)");
		}else{
			doc.openDataTag("{PO_ev_level}").setValue("Ⅳ级以下事件");
		}
		
		
		if(eveninfo.getEv_affectedArea()==null){
			doc.openDataTag("{PO_ev_Area}").setValue("");	
		}else{
		doc.openDataTag("{PO_ev_Area}").setValue(String.valueOf(eveninfo.getEv_affectedArea()));
		}
		if(eveninfo.getEv_participationNumber()==null){
			doc.openDataTag("{PO_ev_Number}").setValue("");
		}else{
		doc.openDataTag("{PO_ev_Number}").setValue(String.valueOf(eveninfo.getEv_participationNumber()));
		}
		if(ValidateUtil.isEmpty(eveninfo.getEv_injuredPeople())){
			doc.openDataTag("{PO_ev_injuredP}").setValue("");
		}else{
		doc.openDataTag("{PO_ev_injuredP}").setValue(String.valueOf(eveninfo.getEv_injuredPeople()));
		}
		if(ValidateUtil.isEmpty(eveninfo.getEv_deathToll())){
			doc.openDataTag("{PO_ev_deathToll}").setValue("");
		}else{
		doc.openDataTag("{PO_ev_deathToll}").setValue(String.valueOf(eveninfo.getEv_deathToll()));
		}
		if(eveninfo.getEv_longitude()==null){
			doc.openDataTag("{PO_ev_longitude}").setValue("");
		}else{
		doc.openDataTag("{PO_ev_longitude}").setValue(String.valueOf(eveninfo.getEv_longitude()));
		}
		if(eveninfo.getEv_latitude()==null){
			doc.openDataTag("{PO_ev_latitude}").setValue("");
		}else{
		doc.openDataTag("{PO_ev_latitude}").setValue(String.valueOf(eveninfo.getEv_latitude()));
		}
		if(eveninfo.getEv_economicLoss()==null){
			doc.openDataTag("{PO_ev_economicLoss}").setValue("");
		}else{
		doc.openDataTag("{PO_ev_economicLoss}").setValue(String.valueOf(eveninfo.getEv_economicLoss()));
		}
		doc.openDataTag("{PO_ev_reportName}").setValue(eveninfo.getEv_reportName());
		doc.openDataTag("{PO_ev_reportPost}").setValue(eveninfo.getEv_reportPost());
		doc.openDataTag("{PO_ev_reportUnit}").setValue(eveninfo.getEv_reportUnit());
		doc.openDataTag("{PO_ev_reportPhone}").setValue(eveninfo.getEv_reportPhone());
		doc.openDataTag("{PO_ev_reportAddress}").setValue(eveninfo.getEv_reportAddress());
		doc.openDataTag("{PO_ev_relatedP}").setValue(eveninfo.getEv_relatedPersonnel());
		
		if(eveninfo.getEv_endDate()==null){
		doc.openDataTag("{PO_ev_endDate}").setValue("");
		}else{
			doc.openDataTag("{PO_ev_endDate}").setValue(DateUtil.getDate(eveninfo.getEv_endDate()));
		}
		
		doc.openDataTag("{PO_ev_cause}").setValue(eveninfo.getEv_cause());
		doc.openDataTag("{PO_ev_influenceScope}").setValue(eveninfo.getEv_influenceScope());
		doc.openDataTag("{PO_ev_advancedDisposal}").setValue(eveninfo.getEv_advancedDisposal());
		doc.openDataTag("{PO_ev_basicSituation}").setValue(eveninfo.getEv_basicSituation());
		doc.openDataTag("{PO_ev_nextStep}").setValue(eveninfo.getEv_nextStep());
		
		model.addAttribute("doc", doc);		
		return "jsp/poffice/eventinfoprint";
		
	}
}
