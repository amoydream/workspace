package com.lauvan.emergencyplan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_Eme_Classification;
import com.lauvan.emergencyplan.service.EmeClassificationService;
import com.lauvan.interceptor.Perm;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: EmeClassificationController 
 * @Description: 预案事件分级管理
 * @author 钮炜炜
 * @date 2016年3月2日 下午4:51:51
 */
@Controller
@RequestMapping("emeplan/classification")
public class EmeClassificationController extends BaseController {
	@Autowired
	private EmeClassificationService emeClassificationService;
	@RequestMapping("/list")
	public String list(Integer pi_id,Model model){
		if (!ValidateUtil.isEmpty(pi_id)) {
			List<E_Eme_Classification> classifications = emeClassificationService.findByProperty("pi_id", pi_id);
			model.addAttribute("classifications", classifications);
		}
		model.addAttribute("pi_id", pi_id);
		return "jsp/emeplan/management/manage_event_classification";
	}
	
	@MethodLog(description = "事件分级添加")
	@Perm(privilegeValue = "classificationAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(E_Eme_Classification classification) {
		Integer id = (Integer) emeClassificationService.getMax("eec_id");
		classification.setEec_id(id+1);
		try {
			emeClassificationService.save(classification);
			return json(true, "预案事件分级添加成功",classification);
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案事件分级添加失败");
		}
	}
	@MethodLog(description = "事件分级修改UI")
	@Perm(privilegeValue = "classificationEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		E_Eme_Classification classification = emeClassificationService.find(id);
		model.addAttribute("classification", classification);
		return "jsp/emeplan/emeClassification/emeClassification_edit";
	}
	@MethodLog(description = "事件分级修改")
	@Perm(privilegeValue = "classificationEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(E_Eme_Classification classification) {
		try {
			emeClassificationService.update(classification);
			return json(true, "预案事件分级修改成功",classification);
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案事件分级修改失败");
		}
	}
	@MethodLog(description = "事件分级删除")
	@Perm(privilegeValue = "classificationDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			try {
				emeClassificationService.delete(id);
				return json(true, "预案-事件分类分级-事件分级删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "预案-事件分类分级-事件分级删除失败");
			}
		}
		return json("没做什么操作");
	}
}
