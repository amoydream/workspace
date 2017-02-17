package com.lauvan.resource.controller;

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
import com.lauvan.resource.entity.R_Legal_Type;
import com.lauvan.resource.service.LegalTypeService;
import com.lauvan.resource.vo.LegalTypeVo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/legaltype")
public class LegalTypeController extends BaseController{
	
	@Autowired
	private LegalTypeService legalTypeService;
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo>tree(){
		return legalTypeService.tree();
	}
	
	@MethodLog(description="类型查询")
	@RequestMapping("/main")
	public String main(Model model) {
		List<R_Legal_Type> ts = legalTypeService.getListIsNull("lt_Pid");
		if (ts.size()>0) {
			model.addAttribute("pid", ts.get(0).getLt_Id());
		}
		return "jsp/resource/legaltype/legaltype_main";
	}
	
	@MethodLog(description="类型查询")
	@RequestMapping("/list")
	@ResponseBody
	public List<R_Legal_Type> list(Integer id,LegalTypeVo legalTypeVo,String query) {
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(legalTypeVo.getLt_Code())) {
				System.out.println(legalTypeVo.getLt_Code());
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.dt_Code = ?").append((params.size()+1));
				params.add(legalTypeVo.getLt_Code());
			}
			if (!ValidateUtil.isEmpty(legalTypeVo.getLt_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.dt_Name like ?").append((params.size()+1));
				params.add("%"+legalTypeVo.getLt_Name().trim()+"%");
			}
			return legalTypeService.getListEntitys(jpql.toString(), params.toArray());
		}
		
		List<R_Legal_Type> ts2 = null;
		if (id==null) {
			List<R_Legal_Type> ts = legalTypeService.getListIsNull("lt_Pid");
			if (ts.size()>0) {
				ts2 = legalTypeService.findByProperty("lt_Pid", ts.get(0).getLt_Id());
			}
		}else {
			ts2 = legalTypeService.findByProperty("lt_Pid", id);
		}
		return ts2;
	}
	
	@MethodLog(description="类型添加")
	@Perm(privilegeValue = "legalTypeAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(LegalTypeVo legalTypeVo) {
		R_Legal_Type type = new R_Legal_Type();
		//复制数据
		BeanUtils.copyProperties(legalTypeVo, type);
		try {
			legalTypeService.save(type);
			return json(true, "类型添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型添加失败");
		}
	}
	@MethodLog(description="类型修改UI")
	@Perm(privilegeValue = "legalTypeEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			R_Legal_Type type = legalTypeService.find(id);
			model.addAttribute("type", type);
			return "jsp/resource/legaltype/legaltype_edit";
		}
		return "";
	}
	@MethodLog(description="类型修改")
	@Perm(privilegeValue = "legalTypeEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(LegalTypeVo legalTypeVo) {
		if (ValidateUtil.isEmpty(legalTypeVo.getLt_Id())) {
			return json("类型ID没有获取到");
		}
		R_Legal_Type type = legalTypeService.find(legalTypeVo.getLt_Id());
		
		BeanUtils.copyProperties(legalTypeVo, type);
		
		try {
			legalTypeService.update(type);
			return json(true, "类型修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型修改失败");
		}
	}
	
	@RequestMapping("/findmenu")
	@ResponseBody
	public List<R_Legal_Type> findmenu(Integer pid) {
		return legalTypeService.findByProperty("lt_Pid", pid);
	}
	
	@MethodLog(description="类型删除")
	@Perm(privilegeValue = "legalTypeDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			legalTypeService.deleteAll(id);
			return json(true, "类型删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型删除失败");
		}
	}
}
