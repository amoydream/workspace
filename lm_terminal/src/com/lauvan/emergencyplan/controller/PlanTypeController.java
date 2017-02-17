package com.lauvan.emergencyplan.controller;

import java.util.ArrayList;
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
import com.lauvan.emergencyplan.entity.E_PlanType;
import com.lauvan.emergencyplan.service.PlanTypeService;
import com.lauvan.emergencyplan.vo.PlanTypeVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: PlanTypeController 
 * @Description: 预案分类管理
 * @author 钮炜炜
 * @date 2015年12月7日 上午11:08:25
 */
@Controller
@RequestMapping("emeplan/plantype")
public class PlanTypeController extends BaseController {

	@Autowired
	private PlanTypeService planTypeService;
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo> tree() {
		return planTypeService.tree();
	}
	@RequestMapping("/tree2")
	@ResponseBody
	public List<Tree2Vo> tree2() {
		List<E_PlanType> ms = planTypeService.getListEntitys();
		List<Tree2Vo> tree2Vos = new ArrayList<Tree2Vo>();
		for (E_PlanType m : ms) {
			tree2Vos.add(new Tree2Vo(m.getPt_id(), m.getPlanType()!=null ? m.getPlanType().getPt_id():null, m.getPt_name()));
		}
		return tree2Vos;
	}
	@MethodLog(description="预案分类查询")
	@RequestMapping("/main")
	public String main(Model model) {
		List<E_PlanType> ms = planTypeService.getListIsNull("planType");
		if (ms.size()>0) {
			model.addAttribute("pid", ms.get(0).getPt_id());
		}
		return "jsp/emeplan/plantype/plantype_list";
	}
	@MethodLog(description="预案分类查询")
	@RequestMapping("/list")
	@ResponseBody
	public List<E_PlanType> list(Integer id) {
		List<E_PlanType> ms2 = null;
		if (id==null) {
			List<E_PlanType> ms = planTypeService.getListIsNull("planType");
			if (ms.size()>0) {
				ms2 = planTypeService.findByProperty("planType.pt_id", ms.get(0).getPt_id());
			}
		}else {
			ms2 = planTypeService.findByProperty("planType.pt_id", id);
		}
		return ms2;
	}
	
	@MethodLog(description = "预案分类添加")
	@Perm(privilegeValue = "planTypeAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(PlanTypeVo planTypeVo,HttpSession session) {
		UserInfoVo uv = (UserInfoVo) session.getAttribute("userVo");
		E_PlanType pt = new E_PlanType();
		BeanUtils.copyProperties(planTypeVo, pt);
		if (!ValidateUtil.isEmpty(planTypeVo.getPid())) {
			pt.setPlanType(new E_PlanType(planTypeVo.getPid()));
		}
		pt.setUser(new T_User_Info(uv.getUs_Id()));
		try {
			planTypeService.save(pt);
			return json(true, "预案分类添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案分类添加成功");
		}
	}
	
	@MethodLog(description = "预案分类编辑UI")
	@Perm(privilegeValue = "planTypeEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			E_PlanType pt = planTypeService.find(id);
			model.addAttribute("planType", pt);
			return "jsp/emeplan/plantype/plantype_edit";
		}
		return "";
	}
	
	@MethodLog(description = "预案分类编辑")
	@Perm(privilegeValue = "planTypeEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(PlanTypeVo planTypeVo) {
		if (ValidateUtil.isEmpty(planTypeVo.getPt_id())) {
			return json("预案分类ID没有获取到");
		}
		E_PlanType pt = planTypeService.find(planTypeVo.getPt_id());
		BeanUtils.copyProperties(planTypeVo, pt);
		try {
			planTypeService.update(pt);
			return json(true, "预案分类修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案分类修改失败");
		}
	}
	
	@MethodLog(description = "预案分类删除")
	@Perm(privilegeValue = "planTypeDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			try {
				planTypeService.deleteAll(id);
				return json(true, "预案分类删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("预案分类删除失败");
			}
		}
		return json("没有做任何操作");
	}
}
