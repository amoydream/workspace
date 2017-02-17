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
import com.lauvan.resource.entity.R_Expert_Type;
import com.lauvan.resource.service.ExpertTypeService;
import com.lauvan.resource.vo.ExpertTypeVo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/experttype")
public class ExpertTypeController extends BaseController{
	
	@Autowired
	private ExpertTypeService expertTypeService;
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo>tree(){
		return expertTypeService.tree();
	}
	
	@MethodLog(description="类型查询")
	@RequestMapping("/main")
	public String main(Model model) {
		List<R_Expert_Type> ts = expertTypeService.getListIsNull("ext_Pid");
		if (ts.size()>0) {
			model.addAttribute("pid", ts.get(0).getExt_Id());
		}
		return "jsp/resource/experttype/experttype_main";
	}
	
	@MethodLog(description="类型查询")
	@RequestMapping("/list")
	@ResponseBody
	public List<R_Expert_Type> list(Integer id,ExpertTypeVo expertTypeVo,String query) {
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(expertTypeVo.getExt_Code())) {
				System.out.println(expertTypeVo.getExt_Code());
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.ext_Code = ?").append((params.size()+1));
				params.add(expertTypeVo.getExt_Code());
			}
			if (!ValidateUtil.isEmpty(expertTypeVo.getExt_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.ext_Name like ?").append((params.size()+1));
				params.add("%"+expertTypeVo.getExt_Name().trim()+"%");
			}
			return expertTypeService.getListEntitys(jpql.toString(), params.toArray());
		}
		
		List<R_Expert_Type> ts2 = null;
		if (id==null) {
			List<R_Expert_Type> ts = expertTypeService.getListIsNull("ext_Pid");
			if (ts.size()>0) {
				ts2 = expertTypeService.findByProperty("ext_Pid", ts.get(0).getExt_Id());
			}
		}else {
			ts2 = expertTypeService.findByProperty("ext_Pid", id);
		}
		return ts2;
	}
	
	@MethodLog(description="专家类型添加")
	@Perm(privilegeValue = "expertTypeAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(ExpertTypeVo expertTypeVo) {
		R_Expert_Type type = new R_Expert_Type();
		//复制数据
		BeanUtils.copyProperties(expertTypeVo, type);
		try {
			expertTypeService.save(type);
			return json(true, "类型添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型添加失败");
		}
	}
	
	@MethodLog(description="专家类型修改UI")
	@Perm(privilegeValue = "expertTypeEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			R_Expert_Type type = expertTypeService.find(id);
			model.addAttribute("type", type);
			return "jsp/resource/experttype/experttype_edit";
		}
		return "";
	}
	
	@MethodLog(description="类型修改")
	@Perm(privilegeValue = "expertTypeEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(ExpertTypeVo expertTypeVo) {
		if (ValidateUtil.isEmpty(expertTypeVo.getExt_Id())) {
			return json("类型ID没有获取到");
		}
		R_Expert_Type type = expertTypeService.find(expertTypeVo.getExt_Id());
		
		BeanUtils.copyProperties(expertTypeVo, type);
		type.setExt_Pid(1);
		try {
			expertTypeService.update(type);
			return json(true, "类型修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型修改失败");
		}
	}
	
	@RequestMapping("/findmenu")
	@ResponseBody
	public List<R_Expert_Type> findmenu(Integer pid) {
		return expertTypeService.findByProperty("ext_Pid", pid);
	}
	
	@RequestMapping("/delete")
	@Perm(privilegeValue = "expertTypeDelete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			expertTypeService.delete(id);
			return json(true, "类型删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型删除失败");
		}
	}

}
