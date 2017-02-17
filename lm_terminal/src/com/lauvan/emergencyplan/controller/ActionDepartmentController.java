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
import com.lauvan.emergencyplan.service.ActionDepartmentService;
import com.lauvan.emergencyplan.vo.ActionDepartmentVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Address_Book;
import com.lauvan.organ.service.AddressBookService;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: ActionDepartmentController 
 * @Description: 预案应急处置阶段流程-行动清单-执行人员管理
 * @author 钮炜炜
 * @date 2015年12月15日 上午10:00:35
 */
@Controller
@RequestMapping("emeplan/actionDepartment")
public class ActionDepartmentController extends BaseController {

	@Autowired
	private ActionDepartmentService actionDepartmentService;
	@Autowired
	private AddressBookService addressBookService;
	
	@RequestMapping("/list")
	@ResponseBody
	public List<E_Action_Department> list(Integer eal_id) {
		if (!ValidateUtil.isEmpty(eal_id)) {
			return actionDepartmentService.findByProperty("eal_id", eal_id);
		}
		return null;
	}
	
	@MethodLog(description = "执行人员添加")
	@Perm(privilegeValue = "actionDepartmentAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(ActionDepartmentVo actionDepartmentVo) {
		if (ValidateUtil.isEmpty(actionDepartmentVo.getPi_id())) {
			return json("预案ID都没有拿到");
		}
		if (ValidateUtil.isEmpty(actionDepartmentVo.getEal_id())) {
			return json("执行清单ID都没有拿到");
		}
		E_Action_Department ad = new E_Action_Department();
		BeanUtils.copyProperties(actionDepartmentVo, ad);
		ad.setEad_id(((Integer)actionDepartmentService.getMax("ead_id"))+1);
		if (!ValidateUtil.isEmpty(actionDepartmentVo.getaBooksId())) {
			C_Address_Book address_Book = addressBookService.find(actionDepartmentVo.getaBooksId());
			ad.setaBooks(address_Book);
		}else {
			return json("行动人员没有获取到");
		}
		try {
			actionDepartmentService.save(ad);
			return json(true, "执行人员名单添加成功",ad);
		} catch (Exception e) {
			e.printStackTrace();
			return json("执行人员名单添加失败");
		}
	}
	@MethodLog(description = "执行人员修改UI")
	@Perm(privilegeValue = "actionDepartmentEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			E_Action_Department action_Department = actionDepartmentService.find(id);
			model.addAttribute("action_Department", action_Department);
			return "jsp/emeplan/actiondepartment/actiondepartment_edit";
		}
		return null;
	}
	@MethodLog(description = "执行人员修改")
	@Perm(privilegeValue = "actionDepartmentEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(ActionDepartmentVo actionDepartmentVo) {
		if (ValidateUtil.isEmpty(actionDepartmentVo.getEad_id())) {
			return json("执行人员名单ID没有获取到");
		}
		E_Action_Department ad = actionDepartmentService.find(actionDepartmentVo.getEad_id());
		if (!ValidateUtil.isEmpty(actionDepartmentVo.getaBooksId())) {
			if (ad.getaBooks().getBo_id() != actionDepartmentVo.getaBooksId()) {
				C_Address_Book address_Book = addressBookService.find(actionDepartmentVo.getaBooksId());
				ad.setaBooks(address_Book);
			}
		}
		ad.setEad_remark(actionDepartmentVo.getEad_remark());
		try {
			actionDepartmentService.update(ad);
			return json(true, "执行人员名单修改成功",ad);
		} catch (Exception e) {
			e.printStackTrace();
			return json("执行人员名单修改失败");
		}
	}
	@MethodLog(description = "执行人员删除")
	@Perm(privilegeValue = "actionDepartmentDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			try {
				actionDepartmentService.delete(id);
				return json(true, "执行人员名单删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("执行人员名单删除失败");
			}
		}
		return json("没有做什么处理");
	}
}
