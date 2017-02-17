package com.lauvan.emergencyplan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_Eme_Expert;
import com.lauvan.emergencyplan.service.EmeExpertService;
import com.lauvan.interceptor.Perm;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: EmeSuppliesController 
 * @Description: 预案-应急资源-专家管理
 * @author 钮炜炜
 * @date 2015年12月11日 下午2:40:24
 */
@Controller
@RequestMapping("emeplan/planExpert")
public class EmeExpertController extends BaseController {
	@Autowired
	private EmeExpertService emeExpertService;
	
	@RequestMapping("/list")
	public String list(Integer pi_id,Model model){
		if (!ValidateUtil.isEmpty(pi_id)) {
			List<E_Eme_Expert> eExperts = emeExpertService.findByProperty("pi_id", pi_id);
			model.addAttribute("eExperts", eExperts);
		}
		model.addAttribute("pi_id", pi_id);
		return "jsp/emeplan/management/manage_resource_expert";
	}
	
	@MethodLog(description = "预案专家添加")
	@Perm(privilegeValue = "planExpertAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(Integer pi_id,String su_Ids) {
		if (!ValidateUtil.isEmpty(pi_id) && !ValidateUtil.isEmpty(su_Ids)) {
			String[] ss = su_Ids.split(",");
			try {
				emeExpertService.addAll(pi_id, ss);
				return json(true, "预案-应急资源-专家添加成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("预案-应急资源-专家添加失败");
			}
		}
		return json("没做什么操作");
	}
	@MethodLog(description = "预案专家删除")
	@Perm(privilegeValue = "planExpertDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id,Integer pi_id) {
		if (!ValidateUtil.isEmpty(id) && !ValidateUtil.isEmpty(pi_id)) {
			try {
				List<E_Eme_Expert> experts = emeExpertService.findByProperty("pi_id", pi_id, "expert.ex_Id", id);
				for (E_Eme_Expert e_Eme_Expert : experts) {
					emeExpertService.delete(e_Eme_Expert.getEx_id());
				}
				return json(true, "预案-应急资源-专家删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "预案-应急资源-专家删除失败");
			}
		}
		return json("没做什么操作");
	}
}
