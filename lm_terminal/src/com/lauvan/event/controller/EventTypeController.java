package com.lauvan.event.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.event.entity.T_Event_Type;
import com.lauvan.event.service.EventTypeService;
import com.lauvan.event.vo.EventTypeVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: EventTypeController 
 * @Description: 事件类型管理
 * @author 钮炜炜
 * @date 2015年12月3日 上午10:28:16
 */
@Controller
@RequestMapping("event/eventtype")
public class EventTypeController extends BaseController {

	@Autowired
	private EventTypeService eventTypeService;
	
	@MethodLog(description="事件类型查询")
	@RequestMapping("/main")
	public String main(Model model) {
		List<T_Event_Type> ms = eventTypeService.getListIsNull("eventType");
		if (ms.size()>0) {
			model.addAttribute("pid", ms.get(0).getEt_id());
		}
		return "jsp/event/eventtype/eventtype_list";
	}
	
	@MethodLog(description="事件类型查询")
	@RequestMapping("/list")
	@ResponseBody
	public List<EventTypeVo> list(Integer id) {
		List<T_Event_Type> ms2 = null;
		if (id==null) {
			List<T_Event_Type> ms = eventTypeService.getListIsNull("eventType");
			if (ms.size()>0) {
				ms2 = eventTypeService.findByProperty("eventType.et_id", ms.get(0).getEt_id());
			}
		}else {
			ms2 = eventTypeService.findByProperty("eventType.et_id", id);
		}
		List<EventTypeVo> etVos = null;
		if (ms2!=null) {
			etVos = new ArrayList<EventTypeVo>();
			EventTypeVo etVo = null;
			for (T_Event_Type et : ms2) {
				etVo = new EventTypeVo();
				BeanUtils.copyProperties(et, etVo);
				etVos.add(etVo);
			}
		}
		return etVos;
	}
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo> tree() {
		return eventTypeService.tree();
	}
	
	@MethodLog(description = "事件类型添加")
	@Perm(privilegeValue = "eventTypeAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(EventTypeVo eTypeVo) {
		T_Event_Type et = new T_Event_Type();
		BeanUtils.copyProperties(eTypeVo, et);
		if (!ValidateUtil.isEmpty(eTypeVo.getPid())) {
			et.setEventType(new T_Event_Type(eTypeVo.getPid()));
		}
		
		try {
			eventTypeService.save(et);
			return json(true, "事件类型添加成功",et);
		} catch (Exception e) {
			e.printStackTrace();
			return json("事件类型添加失败");
		}
	}
	
	@MethodLog(description = "事件类型编辑UI")
	@Perm(privilegeValue = "eventTypeEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			T_Event_Type et = eventTypeService.find(id);
			model.addAttribute("eventtype", et);
			return "jsp/event/eventtype/eventtype_edit";
		}
		return "";
	}
	
	@MethodLog(description = "事件类型编辑")
	@Perm(privilegeValue = "eventTypeEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(EventTypeVo eTypeVo) {
		if (ValidateUtil.isEmpty(eTypeVo.getEt_id())) {
			return json("事件类型ID没有获取到");
		}
		T_Event_Type et = eventTypeService.find(eTypeVo.getEt_id());
		BeanUtils.copyProperties(eTypeVo, et);
		try {
			eventTypeService.update(et);
			return json(true, "事件类型修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("事件类型修改失败");
		}
	}
	
	@MethodLog(description = "事件类型删除")
	@Perm(privilegeValue = "eventTypeDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			eventTypeService.deleteAll(id);
			return json(true, "事件类型删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json(true, "事件类型删除失败");
		}
	}
	
	@RequestMapping("/tree2")
	@ResponseBody
	public List<Tree2Vo> tree2() {
		List<T_Event_Type> ms = eventTypeService.getListEntitys();
		List<Tree2Vo> tree2Vos = new ArrayList<Tree2Vo>();
		for (T_Event_Type m : ms) {
			tree2Vos.add(new Tree2Vo(m.getEt_id(), m.getEventType()!=null ? m.getEventType().getEt_id():null, m.getEt_name()));
		}
		return tree2Vos;
	}
	
	@RequestMapping("/drop")
	@ResponseBody
	public Json drop(String ids,Integer id) {
		if (!ValidateUtil.isEmpty(ids) && !ValidateUtil.isEmpty(id)) {
			String[] oids = ids.split(",");
			try {
				for (String s : oids) {
					T_Event_Type event_Type = eventTypeService.find(Integer.valueOf(s));
					event_Type.setEventType(new T_Event_Type(id));
					eventTypeService.update(event_Type);
				}
				return json(true, "数据更新成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("数据更新发生错误");
			}
			
		}
		return json("节点ID没有获取到，没有做任何操作");
	}
}
