package com.lauvan.system.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.interceptor.Perm;
import com.lauvan.system.entity.T_Module_Info;
import com.lauvan.system.service.ModuleInfoService;
import com.lauvan.system.vo.ModuleInfoVo;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: ModuleInfoController 
 * @Description: 模块控制管理
 * @author 钮炜炜
 * @date 2015年9月11日 下午3:36:16
 */
@Controller
@RequestMapping("system/moduleinfo")
public class ModuleInfoController extends BaseController{

	@Autowired
	private ModuleInfoService moduleInfoService;
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo> tree() {
		return moduleInfoService.tree();
	}
	@RequestMapping("/tree2")
	@ResponseBody
	public List<Tree2Vo> tree2() {
		List<T_Module_Info> ms = moduleInfoService.getListEntitys();
		List<Tree2Vo> tree2Vos = new ArrayList<Tree2Vo>();
		for (T_Module_Info m : ms) {
			tree2Vos.add(new Tree2Vo(m.getMo_Id(), m.getMo_Pid(), m.getMo_Name()));
		}
		return tree2Vos;
	}
	@RequestMapping("/main")
	public String main(Model model) {
		List<T_Module_Info> ms = moduleInfoService.getListIsNull("mo_Pid");
		model.addAttribute("pid", ms.get(0).getMo_Id());
		return "jsp/system/moduleinfo/module_main";
	}
	@RequestMapping("/list")
	@ResponseBody
	public List<T_Module_Info> list(Integer id) {
		List<T_Module_Info> ms2 = null;
		if (id==null) {
			List<T_Module_Info> ms = moduleInfoService.getListIsNull("mo_Pid");
			ms2 = moduleInfoService.findByProperty("mo_Pid", ms.get(0).getMo_Id());
		}else {
			ms2 = moduleInfoService.findByProperty("mo_Pid", id);
		}
		return ms2;
	}
	@MethodLog(description="模块添加UI")
	@Perm(privilegeValue = "moduleAddip")
	@RequestMapping("/addip")
	public String addip(Integer id,Model model) {
		model.addAttribute("id", id);
		return "/system/moduleinfo/module_add";
	}
	@MethodLog(description="模块添加")
	@Perm(privilegeValue = "moduleAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(ModuleInfoVo moduleInfoVo) {
		T_Module_Info m = new T_Module_Info();
		//复制数据
		BeanUtils.copyProperties(moduleInfoVo, m);
		Integer id = (Integer) moduleInfoService.getMax("mo_Id");
		m.setMo_Id(id+1);
		try {
			moduleInfoService.save(m);
			return json(true, "模块添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("模块添加失败");
		}
	}
	@MethodLog(description="模块修改UI")
	@Perm(privilegeValue = "moduleEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			T_Module_Info m = moduleInfoService.find(id);
			model.addAttribute("module", m);
			return "jsp/system/moduleinfo/module_edit";
		}
		return "";
	}
	@MethodLog(description="模块修改")
	@Perm(privilegeValue = "moduleEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(ModuleInfoVo moduleInfoVo) {
		if (ValidateUtil.isEmpty(moduleInfoVo.getMo_Id())) {
			return json("模块ID没有获取到");
		}
		T_Module_Info m = moduleInfoService.find(moduleInfoVo.getMo_Id());
		
		BeanUtils.copyProperties(moduleInfoVo, m);
		
		try {
			moduleInfoService.update(m);
			return json(true, "模块修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("模块修改失败");
		}
	}
	@RequestMapping("/findmenu")
	@ResponseBody
	public List<T_Module_Info> findmenu(Integer pid) {
		return moduleInfoService.findByProperty("mo_Pid", pid);
	}
	@MethodLog(description="模块删除")
	@Perm(privilegeValue = "moduleDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			moduleInfoService.deleteAll(id);
			return json(true, "菜单删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("菜单删除失败");
		}
	}
}
