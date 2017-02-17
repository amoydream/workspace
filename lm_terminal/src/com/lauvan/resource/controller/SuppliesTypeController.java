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
import com.lauvan.resource.entity.R_Supplies_Type;
import com.lauvan.resource.service.SuppliesTypeService;
import com.lauvan.resource.vo.SuppliesTypeVo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/suppliestype")
public class SuppliesTypeController extends BaseController{
	
	@Autowired
	private SuppliesTypeService suppliesTypeService;
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo>tree(){
		return suppliesTypeService.tree();
	}
	
	@MethodLog(description="类型查询")
	@RequestMapping("/main")
	public String main(Model model) {
		List<R_Supplies_Type> ts = suppliesTypeService.getListIsNull("ty_Pid");
		if (ts.size()>0) {
			model.addAttribute("pid", ts.get(0).getTy_Id());
		}
		return "jsp/resource/suppliestype/suppliestype_main";
	}
	
	@MethodLog(description="类型查询")
	@RequestMapping("/list")
	@ResponseBody
	public List<R_Supplies_Type> list(Integer id,SuppliesTypeVo suppliesTypeVo,String query) {
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(suppliesTypeVo.getTy_Code())) {
				System.out.println(suppliesTypeVo.getTy_Code());
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.ty_Code = ?").append((params.size()+1));
				params.add(suppliesTypeVo.getTy_Code());
			}
			if (!ValidateUtil.isEmpty(suppliesTypeVo.getTy_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.ty_Name like ?").append((params.size()+1));
				params.add("%"+suppliesTypeVo.getTy_Name().trim()+"%");
			}
			return suppliesTypeService.getListEntitys(jpql.toString(), params.toArray());
		}
		
		List<R_Supplies_Type> ts2 = null;
		if (id==null) {
			List<R_Supplies_Type> ts = suppliesTypeService.getListIsNull("ty_Pid");
			if (ts.size()>0) {
				ts2 = suppliesTypeService.findByProperty("ty_Pid", ts.get(0).getTy_Id());
			}
		}else {
			ts2 = suppliesTypeService.findByProperty("ty_Pid", id);
		}
		return ts2;
	}
	
	@MethodLog(description="类型添加")
	@Perm(privilegeValue = "suppliesTypeAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(SuppliesTypeVo suppliesTypeVo) {
		R_Supplies_Type type = new R_Supplies_Type();
		//复制数据
		BeanUtils.copyProperties(suppliesTypeVo, type);
		try {
			suppliesTypeService.save(type);
			return json(true, "类型添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型添加失败");
		}
	}
	@MethodLog(description="类型修改UI")
	@Perm(privilegeValue = "suppliesTypeEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			R_Supplies_Type type = suppliesTypeService.find(id);
			model.addAttribute("type", type);
			return "jsp/resource/suppliestype/suppliestype_edit";
		}
		return "";
	}
	@MethodLog(description="类型修改")
	@Perm(privilegeValue = "suppliesTypeEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(SuppliesTypeVo suppliesTypeVo) {
		if (ValidateUtil.isEmpty(suppliesTypeVo.getTy_Id())) {
			return json("类型ID没有获取到");
		}
		R_Supplies_Type type = suppliesTypeService.find(suppliesTypeVo.getTy_Id());
		
		BeanUtils.copyProperties(suppliesTypeVo, type);
		
		try {
			suppliesTypeService.update(type);
			return json(true, "类型修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型修改失败");
		}
	}
	
	@RequestMapping("/findmenu")
	@ResponseBody
	public List<R_Supplies_Type> findmenu(Integer pid) {
		return suppliesTypeService.findByProperty("ty_Pid", pid);
	}
	
	@MethodLog(description="类型删除")
	@Perm(privilegeValue = "suppliesTypeDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			suppliesTypeService.deleteAll(id);
			return json(true, "类型删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型删除失败");
		}
	}
}
