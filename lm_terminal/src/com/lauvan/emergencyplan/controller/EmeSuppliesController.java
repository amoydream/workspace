package com.lauvan.emergencyplan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_Eme_Supplies;
import com.lauvan.emergencyplan.service.EmeSuppliesService;
import com.lauvan.interceptor.Perm;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

/**
 * 
 * ClassName: EmeSuppliesController
 * 
 * @Description: 预案应急物资关联管理
 * @author 钮炜炜
 * @date 2015年12月11日 下午2:40:24
 */
@Controller
@RequestMapping("emeplan/planSupplies")
public class EmeSuppliesController extends BaseController {
	@Autowired
	private EmeSuppliesService emeSuppliesService;

	@RequestMapping("/list")
	public String list(Integer pi_id, Model model) {
		if (!ValidateUtil.isEmpty(pi_id)) {
			List<E_Eme_Supplies> eSupplies = emeSuppliesService.findByProperty(
					"pi_id", pi_id);
			model.addAttribute("eSupplies", eSupplies);
		}
		model.addAttribute("pi_id", pi_id);
		return "jsp/emeplan/management/manage_resource_supplies";
	}
	@MethodLog(description = "预案物资添加")
	@Perm(privilegeValue = "planSuppliesAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(Integer pi_id, String su_Ids) {
		if (!ValidateUtil.isEmpty(pi_id) && !ValidateUtil.isEmpty(su_Ids)) {
			String[] ss = su_Ids.split(",");
			try {
				emeSuppliesService.addAll(pi_id, ss);
				return json(true, "预案应急物资关联添加成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("预案应急物资关联添加失败");
			}
		}
		return json("没做什么操作");
	}

	@RequestMapping("/checkList")
	@ResponseBody
	public List<E_Eme_Supplies> checkList(Integer piId) {
		if (!ValidateUtil.isEmpty(piId)){
			List<E_Eme_Supplies> emeSupplies = emeSuppliesService
					.findByProperty("pi_id", piId);
		return emeSupplies;
		}
		return null;
	}
	@MethodLog(description = "预案物资删除")
	@Perm(privilegeValue = "planSuppliesDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer pi_id,Integer id) {
		if (!ValidateUtil.isEmpty(id) && !ValidateUtil.isEmpty(pi_id)) {
			try {
				List<E_Eme_Supplies> supplies = emeSuppliesService.findByProperty("pi_id", pi_id, "suppliy.su_Id", id);
				for (E_Eme_Supplies e_Eme_Supplies : supplies) {
					emeSuppliesService.delete(e_Eme_Supplies.getEr_id());
				}
				return json(true, "预案-应急资源-应急物资删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "预案-应急资源-应急物资删除失败");
			}
		}
		return json("没做什么操作");
	}
}
