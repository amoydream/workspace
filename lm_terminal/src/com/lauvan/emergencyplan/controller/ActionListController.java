package com.lauvan.emergencyplan.controller;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_Action_Department;
import com.lauvan.emergencyplan.entity.E_Action_List;
import com.lauvan.emergencyplan.entity.E_Disposal_Stage;
import com.lauvan.emergencyplan.service.ActionDepartmentService;
import com.lauvan.emergencyplan.service.ActionListService;
import com.lauvan.emergencyplan.vo.ActionListVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: ActionListController 
 * @Description: 行动清单
 * @author 钮炜炜
 * @date 2016年3月23日 下午2:57:26
 */
@Controller
@RequestMapping("emeplan/actionList")
public class ActionListController extends BaseController {

	@Autowired
	private ActionListService actionListService;
	@Autowired
	private ActionDepartmentService actionDepartmentService;
	
	@RequestMapping("/list")
	@ResponseBody
	public List<E_Action_List> list(Integer eds_id) {
		if (!ValidateUtil.isEmpty(eds_id)) {
			return actionListService.findByProperty("dStage.eds_id", eds_id);
		}
		return null;
	}
	
	@MethodLog(description = "行动清单添加")
	@Perm(privilegeValue = "actionListAdd")
	@ResponseBody
	@RequestMapping("/add")
	public Json add(ActionListVo actionListVo) {
		E_Action_List al = new E_Action_List();
		BeanUtils.copyProperties(actionListVo, al);
		al.setEal_id(((Integer)actionListService.getMax("eal_id"))+1);
		if (!ValidateUtil.isEmpty(actionListVo.getdStageId())) {
			al.setdStage(new E_Disposal_Stage(actionListVo.getdStageId()));
		}else {
			return json("没有获取到上级流程ID");
		}
		try {
			actionListService.save(al);
			return json(true, "行动清单添加成功",al);
		} catch (Exception e) {
			e.printStackTrace();
			return json(true, "行动清单添加失败");
		}
	}
	@MethodLog(description = "行动清单修改UI")
	@Perm(privilegeValue = "actionListEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			E_Action_List action_List = actionListService.find(id);
			model.addAttribute("action_List", action_List);
			return "jsp/emeplan/actionlist/actionlist_edit";
		}
		return null;
	}
	@MethodLog(description = "行动清单修改")
	@Perm(privilegeValue = "actionListEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(ActionListVo actionListVo) {
		if (ValidateUtil.isEmpty(actionListVo.getEal_id())) {
			return json("行动清单ID没有获取到");
		}
		E_Action_List al = actionListService.find(actionListVo.getEal_id());
		BeanUtils.copyProperties(actionListVo, al);
		try {
			actionListService.update(al);
			return json(true, "行动清单修改成功",al);
		} catch (Exception e) {
			e.printStackTrace();
			return json(true, "行动清单修改失败");
		}
	}
	@MethodLog(description = "行动清单删除")
	@Perm(privilegeValue = "actionListDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			List<E_Action_Department> ads = actionDepartmentService.findByProperty("eal_id", id);
			try {
				actionListService.deleteAll(id, ads);
				return json(true, "行动清单删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "行动清单删除失败");
			}
		}
		return json("没有做什么操作");
	}
}
