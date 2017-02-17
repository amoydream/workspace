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
import com.lauvan.resource.entity.R_Danger_Type;
import com.lauvan.resource.service.DangerTypeService;
import com.lauvan.resource.vo.DangerTypeVo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/dangertype")
public class DangerTypeController extends BaseController{
	
	@Autowired
	private DangerTypeService dangerTypeService;
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo>tree(){
		return dangerTypeService.tree();
	}
	
	@MethodLog(description="类型查询")
	@RequestMapping("/main")
	public String main(Model model) {
		List<R_Danger_Type> ts = dangerTypeService.getListIsNull("dt_Pid");
		if (ts.size()>0) {
			model.addAttribute("pid", ts.get(0).getDt_Id());
		}
		return "jsp/resource/dangertype/dangertype_main";
	}
	
	@MethodLog(description="类型查询")
	@RequestMapping("/list")
	@ResponseBody
	public List<R_Danger_Type> list(Integer id,DangerTypeVo dangerTypeVo,String query) {
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(dangerTypeVo.getDt_Code())) {
				System.out.println(dangerTypeVo.getDt_Code());
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.dt_Code = ?").append((params.size()+1));
				params.add(dangerTypeVo.getDt_Code());
			}
			if (!ValidateUtil.isEmpty(dangerTypeVo.getDt_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.dt_Name like ?").append((params.size()+1));
				params.add("%"+dangerTypeVo.getDt_Name().trim()+"%");
			}
			return dangerTypeService.getListEntitys(jpql.toString(), params.toArray());
		}
		
		List<R_Danger_Type> ts2 = null;
		if (id==null) {
			List<R_Danger_Type> ts = dangerTypeService.getListIsNull("dt_Pid");
			if (ts.size()>0) {
				ts2 = dangerTypeService.findByProperty("dt_Pid", ts.get(0).getDt_Id());
			}
		}else {
			ts2 = dangerTypeService.findByProperty("dt_Pid", id);
		}
		return ts2;
	}
	
	@MethodLog(description="类型添加")
	@Perm(privilegeValue = "dangerTypeAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(DangerTypeVo dangerTypeVo) {
		R_Danger_Type type = new R_Danger_Type();
		//复制数据
		BeanUtils.copyProperties(dangerTypeVo, type);
		try {
			dangerTypeService.save(type);
			return json(true, "类型添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型添加失败");
		}
	}
	@MethodLog(description="类型修改UI")
	@Perm(privilegeValue = "dangerTypeEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			R_Danger_Type type = dangerTypeService.find(id);
			model.addAttribute("type", type);
			return "jsp/resource/dangertype/dangertype_edit";
		}
		return "";
	}
	@MethodLog(description="类型修改")
	@Perm(privilegeValue = "dangerTypeEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(DangerTypeVo dangerTypeVo) {
		if (ValidateUtil.isEmpty(dangerTypeVo.getDt_Id())) {
			return json("类型ID没有获取到");
		}
		R_Danger_Type type = dangerTypeService.find(dangerTypeVo.getDt_Id());
		
		BeanUtils.copyProperties(dangerTypeVo, type);
		
		try {
			dangerTypeService.update(type);
			return json(true, "类型修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型修改失败");
		}
	}
	
	@RequestMapping("/findmenu")
	@ResponseBody
	public List<R_Danger_Type> findmenu(Integer pid) {
		return dangerTypeService.findByProperty("dt_Pid", pid);
	}
	
	@MethodLog(description="类型删除")
	@Perm(privilegeValue = "dangerTypeDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			dangerTypeService.deleteAll(id);
			return json(true, "类型删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("类型删除失败");
		}
	}
}
