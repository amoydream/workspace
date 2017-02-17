package com.lauvan.emergencyplan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_Eme_ConditionType;
import com.lauvan.emergencyplan.entity.E_PlanInfo;
import com.lauvan.emergencyplan.service.EmeConditionTypeService;
import com.lauvan.emergencyplan.service.PlanInfoService;
import com.lauvan.interceptor.Perm;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: EmeEventTypeController 
 * @Description: 预案状况分类管理
 * @author 钮炜炜
 * @date 2015年12月11日 下午2:40:24
 */
@Controller
@RequestMapping("emeplan/conditionType")
public class EmeConditionTypeController extends BaseController {
	@Autowired
	private EmeConditionTypeService emeConditionTypeService;
	@Autowired
	private PlanInfoService planInfoService;
	
	@RequestMapping("/list")
	public String list(Integer pi_id,Model model){
		if (!ValidateUtil.isEmpty(pi_id)) {
			List<E_Eme_ConditionType> conditionTypes = emeConditionTypeService.findByProperty("pi_id", pi_id);
			model.addAttribute("conditionTypes", conditionTypes);
		}
		model.addAttribute("pi_id", pi_id);
		return "jsp/emeplan/management/manage_event_conditionType";
	}
	
	@MethodLog(description = "状况分类添加")
	@Perm(privilegeValue = "conditionTypeAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(E_Eme_ConditionType conditionType) {
		Integer id = (Integer) emeConditionTypeService.getMax("eec_id");
		conditionType.setEec_id(id+1);
		try {
			emeConditionTypeService.save(conditionType);
			return json(true, "预案状况分类添加成功",conditionType);
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案状况分类添加失败");
		}
	}
	@MethodLog(description = "状况分类修改UI")
	@Perm(privilegeValue = "conditionEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		E_Eme_ConditionType conditionType = emeConditionTypeService.find(id);
		model.addAttribute("conditionType", conditionType);
		return "jsp/emeplan/emeConditionType/emeConditionType_edit";
	}
	@MethodLog(description = "状况分类修改")
	@Perm(privilegeValue = "conditionEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(E_Eme_ConditionType conditionType) {
		try {
			emeConditionTypeService.update(conditionType);
			return json(true, "预案状况分类修改成功",conditionType);
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案状况分类修改失败");
		}
	}
	
	@RequestMapping("/select")
	@ResponseBody
	public List<E_PlanInfo> select(Integer eventTypeId, String piName) {
		/*if (!ValidateUtil.isEmpty(piName)) {
			List<E_PlanInfo> planList = planInfoService.findByPropertyauto("pi_name",piName);
			return planList;
		}
		if (!ValidateUtil.isEmpty(eventTypeId)) {
			List<E_Eme_EventType> list = emeEventTypeService.findByProperty("eventType.et_id", eventTypeId);
			List<E_PlanInfo> pIdsList = new ArrayList<E_PlanInfo>();
			List<E_PlanInfo> pIdList = new ArrayList<E_PlanInfo>();
			for (E_Eme_EventType pIds : list) {
				pIdList = planInfoService.findByProperty("pi_id", pIds.getPi_id());
				pIdsList.addAll(pIdList);
			}
			return pIdsList;
		}*/
		return null;
	}
	@MethodLog(description = "状况分类删除")
	@Perm(privilegeValue = "conditionDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			try {
				emeConditionTypeService.delete(id);
				return json(true, "预案-事件分类分级-状况分类删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "预案-事件分类分级-状况分类删除失败");
			}
		}
		return json("没做什么操作");
	}
}
