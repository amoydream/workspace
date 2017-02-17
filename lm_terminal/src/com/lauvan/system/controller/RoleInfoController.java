package com.lauvan.system.controller;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.interceptor.Perm;
import com.lauvan.system.entity.T_Role_Info;
import com.lauvan.system.entity.T_Role_Module;
import com.lauvan.system.entity.T_User_Role;
import com.lauvan.system.service.RoleInfoService;
import com.lauvan.system.service.RoleModuleService;
import com.lauvan.system.service.UserRoleService;
import com.lauvan.system.vo.RoleInfoVo;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: RoleInfoController 
 * @Description: 角色管理
 * @author 钮炜炜
 * @date 2015年9月9日 上午11:31:26
 */
@Controller
@RequestMapping("system/roleinfo")
public class RoleInfoController extends BaseController {

	@Autowired
	private RoleInfoService roleInfoService;
	@Autowired
	private RoleModuleService roleModuleService;
	@Autowired
	private UserRoleService userRoleService;
	
	@RequestMapping("/main")
	public String main(Integer page,String query,UserInfoVo userInfoVo,Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<T_Role_Info> pageView = new PageView<T_Role_Info>(15, ((page==null || page<1) ? 1:page));
		pageView.setQueryResult(roleInfoService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult()));
		model.addAttribute("pageView", pageView);
		return "jsp/system/roleinfo/role_main";
	}
	@RequestMapping("/listAll")
	public String listAll(Integer userid,Model model) {
		List<T_Role_Info> role_Infos = roleInfoService.getListEntitys();
		model.addAttribute("roles", role_Infos);
		model.addAttribute("userid", userid);
		return "jsp/system/roleinfo/role_list";
	}
	@MethodLog(description="角色添加UI")
	@Perm(privilegeValue="roleAddip")
	@RequestMapping("/addip")
	public String addip() {
		return "/system/roleinfo/role_add";
	}
	@MethodLog(description="角色添加")
	@Perm(privilegeValue="roleAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(RoleInfoVo roleInfoVo) {
		T_Role_Info r = new T_Role_Info();
		BeanUtils.copyProperties(roleInfoVo, r);
		Object o = roleInfoService.getMax("ro_Id");
		if (o=="") {
			r.setRo_Id(1);
		}else {
			r.setRo_Id(1+Integer.valueOf(o.toString()));
		}
		//权限值从页面传过来是以逗号分隔的
		String[] moids = null;
		if (!ValidateUtil.isEmpty(roleInfoVo.getMoids())) {
			moids = roleInfoVo.getMoids().split(",");
		}
		
		try {
			roleInfoService.saveAll(r, moids);
			return json(true, "角色添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("角色添加失败");
		}
	}
	@MethodLog(description="角色修改UI")
	@Perm(privilegeValue="roleEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			T_Role_Info r = roleInfoService.find(id);
			model.addAttribute("role",r);
			List<T_Role_Module> rms = roleModuleService.findByProperty("id.ro_Id", id);
			//封装权限为1,3,5... 格式，以便页面接受处理
			StringBuilder sb = new StringBuilder();
			if (ValidateUtil.isEmpty(rms)) {
				for (int i = 0,h=rms.size(); i < h; i++) {
					if (i==h-1) {
						sb.append(rms.get(i).getId().getMo_Id());
					}else {
						sb.append(rms.get(i).getId().getMo_Id()).append(",");
					}
				}
			}else {
				sb = null;
			}
			if (sb!=null) {
				model.addAttribute("moduleids", sb.toString());
			}
			return "jsp/system/roleinfo/role_edit";
		}
		return "";
	}
	@MethodLog(description="角色修改")
	@Perm(privilegeValue="roleEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(RoleInfoVo roleInfoVo) {
		if (ValidateUtil.isEmpty(roleInfoVo.getRo_Id())) {
			return json("角色ID没有获取到！");
		}
		T_Role_Info r = roleInfoService.find(roleInfoVo.getRo_Id());
		r.setRo_Code(roleInfoVo.getRo_Code());
		r.setRo_Name(roleInfoVo.getRo_Name());
		r.setRo_Remark(roleInfoVo.getRo_Remark());
		
		String[] moids = null;
		if (!ValidateUtil.isEmpty(roleInfoVo.getMoids())) {
			moids = roleInfoVo.getMoids().split(",");
		}
		try {
			roleInfoService.saveAll(r, moids);
			return json(true, "角色修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("角色修改失败");
		}
	}
	@MethodLog(description="角色删除")
	@Perm(privilegeValue="roleDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			List<T_User_Role> urs = userRoleService.findByProperty("id.roId", id);
			List<T_Role_Module> rms = roleModuleService.findByProperty("id.ro_Id", id);
			try {
				roleInfoService.deleteAll(urs, id, rms);
				return json(true,"角色删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("角色删除失败");
			}
		}
		return json("没有做任何操作");
	}
}
