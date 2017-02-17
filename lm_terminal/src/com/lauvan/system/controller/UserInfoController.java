package com.lauvan.system.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.service.AddressBookService;
import com.lauvan.organ.vo.OrganPersonVo;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.entity.T_User_Role;
import com.lauvan.system.service.UserInfoService;
import com.lauvan.system.service.UserRoleService;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.Json;
import com.lauvan.util.PwdUtil;
import com.lauvan.util.ValidateUtil;

/**
 * ClassName: UserInfoController
 * @Description: 用户管理
 * @author 钮炜炜
 * @date 2015年9月11日 下午3:43:12
 */
@Controller
@RequestMapping("system/userinfo")
@SessionAttributes(names = {"userVo"})
public class UserInfoController extends BaseController {

	@Autowired
	private UserInfoService		userInfoService;
	@Autowired
	private UserRoleService		UserRoleService;
	@Autowired
	private AddressBookService	addressBookService;

	@RequestMapping("/main")
	public String main() {
		return "/system/userinfo/userinfo_main";
	}

	@RequestMapping("/view")
	public String view() {
		return "/system/userinfo/userinfo_view";
	}

	@RequestMapping("/list")
	public String list(Integer page, String query, UserInfoVo userInfoVo, Model model) {
		userList(page, query, userInfoVo, model);
		return "jsp/system/userinfo/userinfo_list";
	}

	private void userList(Integer page, String query, UserInfoVo userInfoVo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<T_User_Info> pageView = new PageView<T_User_Info>(15, page == null || page < 1 ? 1 : page);
		if("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if(!ValidateUtil.isEmpty(userInfoVo.getUs_Name())) {
				if(params.size() > 0) {
					jpql.append(" and ");
				}
				jpql.append(" o.us_Name like ?").append(params.size() + 1);
				params.add("%" + userInfoVo.getUs_Name().trim() + "%");
			}
			if(!ValidateUtil.isEmpty(userInfoVo.getUs_Mophone())) {
				if(params.size() > 0) {
					jpql.append(" and ");
				}
				jpql.append(" o.us_Mophone like ?").append(params.size() + 1);
				params.add("%" + userInfoVo.getUs_Mophone().trim() + "%");
			}
			model.addAttribute("userInfoVo", userInfoVo);
			pageView.setQueryResult(userInfoService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(), jpql.toString(), params.toArray()));
		} else {
			pageView.setQueryResult(userInfoService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult()));
		}
		model.addAttribute("pageView", pageView);
	}
	@RequestMapping("/handoverList")
	public String handoverList(Integer page, String query, UserInfoVo userInfoVo, Model model) {
		userList(page, query, userInfoVo, model);
		return "jsp/system/userinfo/userinfo_handover_select";
	}

	@RequestMapping("/search")
	@ResponseBody
	public Json search(UserInfoVo userInfoVo) {
		try {
			if(userInfoVo == null) {
				userInfoVo = new UserInfoVo();
			}
			if(userInfoVo.getPage() < 1) {
				userInfoVo.setPage(1);
			}
			userInfoVo.setRows(8);
			PageView<T_User_Info> pageView = new PageView<T_User_Info>(userInfoVo.getRows(), userInfoVo.getPage());
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if(!ValidateUtil.isEmpty(userInfoVo.getUs_Name())) {
				if(params.size() > 0) {
					jpql.append(" and ");
				}
				jpql.append(" o.us_Name like ?").append(params.size() + 1);
				params.add("%" + userInfoVo.getUs_Name().trim() + "%");
			}
			if(!ValidateUtil.isEmpty(userInfoVo.getUs_Mophone())) {
				if(params.size() > 0) {
					jpql.append(" and ");
				}
				jpql.append(" o.us_Mophone like ?").append(params.size() + 1);
				params.add("%" + userInfoVo.getUs_Mophone().trim() + "%");
			}
			pageView.setQueryResult(userInfoService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(), jpql.toString(), params.toArray()));
			return json(true, "", pageView);
		} catch(Exception e) {
			return json(false, "");
		}
	}

	@RequestMapping("/contactfavorites/{page}")
	@ResponseBody
	public Json getFavorites(@ModelAttribute("userVo") UserInfoVo userVo, @PathVariable Integer page) {
		try {
			T_User_Info userInfo = userInfoService.find(userVo.getUs_Id());
			PageView<OrganPersonVo> pageView = new PageView<>(8, page);
			List<OrganPersonVo> opVos = new ArrayList<OrganPersonVo>();
			if(userInfo != null) {
				/*Set<C_Organ_Person> contactFavorites = userInfo.getContactFavorites();
				List<C_Organ_Person> persons = new ArrayList<C_Organ_Person>();
				persons.addAll(contactFavorites);

				for(int i = pageView.getFirstResult(); i < persons.size() && i < pageView.getFirstResult() + pageView.getMaxresult(); i++) {
					C_Organ_Person op = persons.get(i);
					OrganPersonVo opVo = new OrganPersonVo();
					BeanUtils.copyProperties(op, opVo);
					List<C_Address_Book> abs = addressBookService.findByProperty("person.pe_id", op.getPe_id());
					for(C_Address_Book ab : abs) {
						if("1".equals(ab.getBo_type())) {
							opVo.setOfficephone(ab.getBo_number());
						} else if("2".equals(ab.getBo_type())) {
							opVo.setMobilephone(ab.getBo_number());
						} else if("5".equals(ab.getBo_type())) {
							opVo.setHomephone(ab.getBo_number());
						} else if("4".equals(ab.getBo_type())) {
							opVo.setEmail(ab.getBo_number());
						}
					}
					opVo.setFavorite(true);
					opVos.add(opVo);
				}

				pageView.setRecords(opVos);
				pageView.setTotalrecord(contactFavorites.size());*/
			}
			return json(true, "", pageView);
		} catch(Exception e) {
			return json(false, "获取常用联系人失败");
		}
	}

	@RequestMapping("/setfavorite/{pe_id}/{favorite}")
	@ResponseBody
	public Json setFavorite(@ModelAttribute("userVo") UserInfoVo userVo, @PathVariable Integer pe_id, @PathVariable boolean favorite) {
		try {
			T_User_Info userInfo = userInfoService.find(userVo.getUs_Id());
			if(userInfo != null) {
				/*C_Organ_Person person = new C_Organ_Person();
				person.setPe_id(pe_id);
				Set<C_Organ_Person> contactFavorites = userInfo.getContactFavorites();
				if(contactFavorites == null) {
					contactFavorites = new HashSet<C_Organ_Person>();
				}

				int size = contactFavorites.size();

				if(favorite) {
					if(!contactFavorites.contains(person)) {
						contactFavorites.add(person);
					}
				} else {
					if(size != 0) {
						contactFavorites.remove(person);
					}
				}

				if(contactFavorites.size() != size) {
					userInfo.setContactFavorites(contactFavorites);
					userInfoService.update(userInfo);
					if(contactFavorites.size() > size) {
						return json(true, "已收藏");
					} else {
						return json(true, "已取消收藏");
					}
				}*/
			}
			return json(false, "无操作");
		} catch(Exception e) {
			return json(false, "收藏失败");
		}
	}

	@RequestMapping("/select/{us_Id}")
	@ResponseBody
	public T_User_Info select(@PathVariable Integer us_Id) {
		T_User_Info userInfo = null;

		if(!ValidateUtil.isEmpty(us_Id)) {
			userInfo = userInfoService.find(us_Id);
		}

		if(userInfo == null) {
			userInfo = new T_User_Info();
		}

		return userInfo;
	}

	@MethodLog(description = "用户添加UI")
	@Perm(privilegeValue = "userAddip")
	@RequestMapping("/addip")
	public String addip() {
		return "jsp/system/userinfo/userinfo_add";
	}

	@MethodLog(description = "用户添加")
	@Perm(privilegeValue = "userAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(UserInfoVo userInfoVo) {
		if(ValidateUtil.isEmpty(userInfoVo.getUs_Code())) {
			return json("用户名不能为空");
		}
		if(ValidateUtil.isEmpty(userInfoVo.getUs_Pass())) {
			return json("密码不能为空");
		}
		T_User_Info u = userInfoService.findEntity("us_Code", userInfoVo.getUs_Code());
		if(u != null) {
			return json("已有该用户名，请更换");
		}

		u = new T_User_Info();
		BeanUtils.copyProperties(userInfoVo, u);
		Integer id = (Integer) userInfoService.getMax("us_Id");
		u.setUs_Id(id+1);
		u.setUs_Pass(PwdUtil.encrypt(userInfoVo.getUs_Pass()));
		try {
			userInfoService.save(u);
			return json(true, "用户信息添加成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("用户信息添加成功");
		}
	}

	@MethodLog(description = "用户修改UI")
	@Perm(privilegeValue = "userEditip")
	@RequestMapping("/editip")
	public String editip(Integer id, Model model) {
		if(!ValidateUtil.isEmpty(id)) {
			T_User_Info u = userInfoService.find(id);
			model.addAttribute("user", u);
			return "jsp/system/userinfo/userinfo_edit";
		}
		return null;
	}

	@MethodLog(description = "用户修改")
	@Perm(privilegeValue = "userEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(UserInfoVo userInfoVo) {
		if(ValidateUtil.isEmpty(userInfoVo.getUs_Id())) {
			return json("用户ID没有获取到");
		}

		T_User_Info u = userInfoService.find(userInfoVo.getUs_Id());
		BeanUtils.copyProperties(userInfoVo, u);
		try {
			userInfoService.update(u);
			return json(true, "用户信息修改成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("用户信息修改失败");
		}
	}

	/**
	 * 启用或禁用
	 * @param id
	 * @param state
	 * @return
	 */
	@MethodLog(description = "用户启用禁用")
	@Perm(privilegeValue = "userEnable")
	@RequestMapping("/enable")
	@ResponseBody
	public Json enable(Integer id, String state) {
		if(ValidateUtil.isEmpty(id)) {
			return json("用户ID没有获取到");
		}
		if(ValidateUtil.isEmpty(state)) {
			return json("用户状态没有获取到");
		}
		T_User_Info u = userInfoService.find(id);
		u.setUs_State(state);
		try {
			userInfoService.update(u);
			return json(true, "用户状态设置成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("用户状态设置失败");
		}
	}

	@MethodLog(description = "用户删除")
	@Perm(privilegeValue = "userDelete")
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Json delete(Integer id) {
		if(!ValidateUtil.isEmpty(id)) {
			List<T_User_Role> urs = UserRoleService.findByProperty("id.usId", id);
			try {
				userInfoService.deleteAll(id, urs);
				return json(true, "用户删除设置成功");
			} catch(Exception e) {
				e.printStackTrace();
				return json(true, "用户删除设置失败");
			}
		}
		return json(true, "没有做任何操作");
	}

	@MethodLog(description = "用户授权UI")
	@Perm(privilegeValue = "userRoleip")
	@RequestMapping("/roleip")
	@ResponseBody
	public List<T_User_Role> roleip(Integer id, Model model) {
		if(!ValidateUtil.isEmpty(id)) {
			List<T_User_Role> urs = UserRoleService.findByProperty("id.usId", id);
			return urs;
		}
		return null;
	}

	/**
	 * 角色添加
	 * @param id
	 * @param roleids
	 * @return
	 */
	@MethodLog(description = "用户授权")
	@Perm(privilegeValue = "userRole")
	@RequestMapping("/role")
	@ResponseBody
	public Json role(Integer id, String roleids) {
		if(ValidateUtil.isEmpty(id)) {
			return json("用户ID没有获取到哦");
		}
		if(ValidateUtil.isEmpty(roleids)) {
			return json("角色没有获取到哦");
		}
		String[] roids = roleids.split(",");
		try {
			UserRoleService.saveRole(id, roids);
			return json(true, "角色设置成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("角色设置失败");
		}
	}

	@MethodLog(description = "用户修改密码")
	@Perm(privilegeValue = "userEditpwd")
	@RequestMapping("/editpwd")
	@ResponseBody
	public Json editpwd(Integer id,String pwd) {
		if(ValidateUtil.isEmpty(id) || ValidateUtil.isEmpty(pwd)) {
			return json("用户ID或新密码不能为空！");
		}
		T_User_Info u = userInfoService.find(id);
		u.setUs_Pass(PwdUtil.encrypt(pwd.trim()));
		try {
			userInfoService.update(u);
			return json(true, "密码更改成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("密码更改失败");
		}
	}
}
