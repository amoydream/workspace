package com.lauvan.system.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.interceptor.Perm;
import com.lauvan.system.entity.T_Module_Info;
import com.lauvan.system.entity.T_Role_Info;
import com.lauvan.system.entity.T_Role_Module;
import com.lauvan.system.entity.T_Role_Module_Id;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.entity.T_User_Role;
import com.lauvan.system.entity.T_User_Role_Id;
import com.lauvan.system.service.ModuleInfoService;
import com.lauvan.system.service.RoleInfoService;
import com.lauvan.system.service.RoleModuleService;
import com.lauvan.system.service.UserInfoService;
import com.lauvan.system.service.UserRoleService;
import com.lauvan.util.PwdUtil;
import com.lauvan.util.ValidateUtil;

/**
 * 
 * ClassName: IndexController
 * 
 * @Description: 首页数据展示管理
 * @author 钮炜炜 陈存登
 * @version 1.1 30-11-2015
 */
@Controller
public class IndexController extends BaseController {

	@Autowired
	private ModuleInfoService				moduleInfoService;
	@Autowired
	private RoleInfoService					roleInfoService;
	@Autowired
	private UserInfoService					userInfoService;
	@Autowired
	private RoleModuleService				roleModuleService;
	@Autowired
	private UserRoleService					userRoleService;
	@Autowired
	private RequestMappingHandlerMapping	rmhm;

	/**
	 * 加载系统登录首页
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/index")
	public String index(Model model) {
		List<T_Module_Info> pms = moduleInfoService.getListIsNull("mo_Pid");
		if(pms.size() > 0) {
			List<T_Module_Info> moduleInfo = moduleInfoService.findByProperty("mo_Pid", pms.get(0).getMo_Id()); // 查找一级菜单
			model.addAttribute("moduleInfo", moduleInfo);
		}
		return "/main";
	}

	@RequestMapping("/geturl")
	public void geturl() {
		Map<RequestMappingInfo, HandlerMethod> map = rmhm.getHandlerMethods();
		for(Map.Entry<RequestMappingInfo, HandlerMethod> m : map.entrySet()) {
			RequestMappingInfo info = m.getKey();
			HandlerMethod method = m.getValue();
			String url = info.getPatternsCondition().toString();
			url = url.replace("[", "");
			url = url.replace("]", "");
			String[] urls = url.split("/");
			MethodLog ml = method.getMethodAnnotation(MethodLog.class);

			Perm p = method.getMethodAnnotation(Perm.class);

			if(urls.length > 3 && ml != null) {
				String methoddesc = ml.description();
				if(!ValidateUtil.isEmpty(methoddesc) && p != null) {
					String perm = p.privilegeValue();
					if(!ValidateUtil.isEmpty(perm)) {
						System.out.println("------------------begin----------------------");
						System.out.println(url);
						System.out.println(urls[2]);
						System.out.println("日志拦截：----" + ml.description());
						System.out.println("权限拦截：----" + p.privilegeValue());
						System.out.println("-------------------end---------------------");

						if(moduleInfoService.getCount("mo_Code", perm) == 0) {
							List<T_Module_Info> ms = moduleInfoService.findByProperty("mo_Code", urls[2]);
							if(ms.size() > 0) {
								T_Module_Info module_Info = new T_Module_Info();
								Integer id = moduleInfoService.getMax("mo_Id");
								module_Info.setMo_Id(id);
								module_Info.setMo_Code(perm);
								module_Info.setMo_Name(methoddesc);
								module_Info.setMo_Pid(ms.get(0).getMo_Id());
								module_Info.setMo_Url(url.substring(1));
								module_Info.setMo_Step("2");
								moduleInfoService.save(module_Info);
								roleModuleService.save(new T_Role_Module(new T_Role_Module_Id(module_Info.getMo_Id(), 1)));
								System.out.println("ok");
							}
						}

					}
				}
			}
		}
	}

	@RequestMapping("/initdata")
	private void initData() {
		if(moduleInfoService.getCount() == 0) {
			List<T_Module_Info> module = new ArrayList<T_Module_Info>();

			T_Module_Info m0 = new T_Module_Info();
			Integer id = moduleInfoService.getMax("mo_Id");

			m0.setMo_Id(id);
			m0.setMo_Name("系统模块管理");
			m0.setMo_Code("");
			m0.setMo_State("1");
			m0.setMo_Step("0");
			m0.setMo_Url("");
			m0.setMo_Class("module1");
			moduleInfoService.save(m0);
			module.add(m0);

			T_Module_Info m1 = new T_Module_Info();
			Integer id1 = moduleInfoService.getMax("mo_Id");
			m1.setMo_Id(id1);
			m1.setMo_Pid(id);
			m1.setMo_Name("系统管理");
			m1.setMo_Code("system");
			m1.setMo_State("1");
			m1.setMo_Step("1");
			m1.setMo_Url("");
			m1.setMo_Class("module1");
			moduleInfoService.save(m1);
			module.add(m1);

			T_Module_Info m2 = new T_Module_Info();
			Integer id2 = moduleInfoService.getMax("mo_Id");
			m2.setMo_Id(id2);
			m2.setMo_Pid(id);
			m2.setMo_Name("值守管理");
			m2.setMo_Code("dutymanage");
			m2.setMo_State("1");
			m2.setMo_Step("1");
			m2.setMo_Url("");
			m2.setMo_Class("module1");
			module.add(m2);
			moduleInfoService.save(m2);

			T_Module_Info m3 = new T_Module_Info();
			Integer id3 = moduleInfoService.getMax("mo_Id");
			m3.setMo_Id(id3);
			m3.setMo_Pid(id);
			m3.setMo_Name("应急资源");
			m3.setMo_Code("resource");
			m3.setMo_State("1");
			m3.setMo_Step("1");
			m3.setMo_Url("");
			m3.setMo_Class("module1");
			module.add(m3);
			moduleInfoService.save(m3);

			T_Module_Info m4 = new T_Module_Info();
			Integer id4 = moduleInfoService.getMax("mo_Id");
			m4.setMo_Id(id4);
			m4.setMo_Pid(id);
			m4.setMo_Name("工作联络网");
			m4.setMo_Code("work");
			m4.setMo_State("1");
			m4.setMo_Step("1");
			m4.setMo_Url("");
			m4.setMo_Class("module1");
			module.add(m4);
			moduleInfoService.save(m4);

			T_Module_Info m5 = new T_Module_Info();
			Integer id5 = moduleInfoService.getMax("mo_Id");
			m5.setMo_Id(id5);
			m5.setMo_Pid(id);
			m5.setMo_Name("事件管理");
			m5.setMo_Code("event");
			m5.setMo_State("1");
			m5.setMo_Step("1");
			m5.setMo_Url("");
			m5.setMo_Class("module1");
			module.add(m5);
			moduleInfoService.save(m5);

			T_Module_Info m6 = new T_Module_Info();
			Integer id6 = moduleInfoService.getMax("mo_Id");
			m6.setMo_Id(id6);
			m6.setMo_Pid(id);
			m6.setMo_Name("应急预案管理");
			m6.setMo_Code("emergency");
			m6.setMo_State("1");
			m6.setMo_Step("1");
			m6.setMo_Url("");
			m6.setMo_Class("module1");
			module.add(m6);
			moduleInfoService.save(m6);

			T_Module_Info m7 = new T_Module_Info();
			Integer id7 = moduleInfoService.getMax("mo_Id");
			m7.setMo_Id(id7);
			m7.setMo_Pid(id);
			m7.setMo_Name("统计分析");
			m7.setMo_Code("analysis");
			m7.setMo_State("1");
			m7.setMo_Step("1");
			m7.setMo_Url("");
			m7.setMo_Class("module1");
			module.add(m7);
			moduleInfoService.save(m7);

			//2级模块

			T_Module_Info m8 = new T_Module_Info();
			Integer id8 = moduleInfoService.getMax("mo_Id");
			m8.setMo_Id(id8);
			m8.setMo_Pid(id1);
			m8.setMo_Name("用户管理");
			m8.setMo_Code("userinfo");
			m8.setMo_State("1");
			m8.setMo_Step("2");
			m8.setMo_Url("system/userinfo/list");
			m8.setMo_Class("module1");
			m8.setMo_Icon("fa-user");
			module.add(m8);
			moduleInfoService.save(m8);

			T_Module_Info m9 = new T_Module_Info();
			Integer id9 = moduleInfoService.getMax("mo_Id");
			m9.setMo_Id(id9);
			m9.setMo_Pid(id1);
			m9.setMo_Name("角色管理");
			m9.setMo_Code("roleinfo");
			m9.setMo_State("1");
			m9.setMo_Step("2");
			m9.setMo_Url("system/roleinfo/main");
			m9.setMo_Class("module2");
			m9.setMo_Icon("fa-users");
			module.add(m9);
			moduleInfoService.save(m9);

			T_Module_Info m11 = new T_Module_Info();
			Integer id11 = moduleInfoService.getMax("mo_Id");
			m11.setMo_Id(id11);
			m11.setMo_Pid(id1);
			m11.setMo_Name("模块管理");
			m11.setMo_Code("moduleinfo");
			m11.setMo_State("1");
			m11.setMo_Step("2");
			m11.setMo_Url("system/moduleinfo/main");
			m11.setMo_Class("module3");
			m11.setMo_Icon("fa-book");
			module.add(m11);
			moduleInfoService.save(m11);

			T_Module_Info m12 = new T_Module_Info();
			Integer id12 = moduleInfoService.getMax("mo_Id");
			m12.setMo_Id(id12);
			m12.setMo_Pid(id1);
			m12.setMo_Name("系统日志");
			m12.setMo_Code("sysloginfo");
			m12.setMo_State("1");
			m12.setMo_Step("2");
			m12.setMo_Url("system/sysloginfo/list");
			m12.setMo_Class("module4");
			m12.setMo_Icon("fa-file");
			module.add(m12);
			moduleInfoService.save(m12);

			T_Module_Info m13 = new T_Module_Info();
			Integer id13 = moduleInfoService.getMax("mo_Id");
			m13.setMo_Id(id13);
			m13.setMo_Pid(id2);
			m13.setMo_Name("电话调度");
			m13.setMo_Code("vVoiceRecord");
			m13.setMo_State("1");
			m13.setMo_Step("2");
			m13.setMo_Url("dutymanage/vVoiceRecord/main");
			m13.setMo_Class("module2");
			m13.setMo_Icon("fa-phone");
			module.add(m13);
			moduleInfoService.save(m13);

			T_Module_Info m14 = new T_Module_Info();
			Integer id14 = moduleInfoService.getMax("mo_Id");
			m14.setMo_Id(id14);
			m14.setMo_Pid(id2);
			m14.setMo_Name("短信调度");
			m14.setMo_Code("smsdisp");
			m14.setMo_State("1");
			m14.setMo_Step("2");
			m14.setMo_Url("dutymanage/smsdisp/main/unread");
			m14.setMo_Class("module1");
			m14.setMo_Icon("fa-envelope");
			module.add(m14);
			moduleInfoService.save(m14);

			T_Module_Info m15 = new T_Module_Info();
			Integer id15 = moduleInfoService.getMax("mo_Id");
			m15.setMo_Id(id15);
			m15.setMo_Pid(id2);
			m15.setMo_Name("传真调度");
			m15.setMo_Code("fax");
			m15.setMo_State("1");
			m15.setMo_Step("2");
			m15.setMo_Url("dutymanage/fax/main");
			m15.setMo_Class("module3");
			m15.setMo_Icon("fa-fax");
			module.add(m15);
			moduleInfoService.save(m15);

			T_Module_Info m16 = new T_Module_Info();
			Integer id16 = moduleInfoService.getMax("mo_Id");
			m16.setMo_Id(id16);
			m16.setMo_Pid(id2);
			m16.setMo_Name("值班交接");
			m16.setMo_Code("handoverInfo");
			m16.setMo_State("1");
			m16.setMo_Step("2");
			m16.setMo_Url("dutymanage/handoverInfo/main");
			m16.setMo_Class("module4");
			m16.setMo_Icon("fa-book");
			module.add(m16);
			moduleInfoService.save(m16);

			T_Module_Info m17 = new T_Module_Info();
			Integer id17 = moduleInfoService.getMax("mo_Id");
			m17.setMo_Id(id17);
			m17.setMo_Pid(id2);
			m17.setMo_Name("值班排班");
			m17.setMo_Code("dutyschedule1");
			m17.setMo_State("1");
			m17.setMo_Step("2");
			m17.setMo_Url("dutymanage/dutyschedule1/main");
			m17.setMo_Class("module5");
			m17.setMo_Icon("fa-book");
			module.add(m17);
			moduleInfoService.save(m17);

			T_Module_Info m18 = new T_Module_Info();
			Integer id18 = moduleInfoService.getMax("mo_Id");
			m18.setMo_Id(id18);
			m18.setMo_Pid(id3);
			m18.setMo_Name("物资分类");
			m18.setMo_Code("suppliestype");
			m18.setMo_State("1");
			m18.setMo_Step("2");
			m18.setMo_Url("resource/suppliestype/main");
			m18.setMo_Class("module3");
			m18.setMo_Icon("fa-book");
			module.add(m18);
			moduleInfoService.save(m18);

			T_Module_Info m19 = new T_Module_Info();
			Integer id19 = moduleInfoService.getMax("mo_Id");
			m19.setMo_Id(id19);
			m19.setMo_Pid(id3);
			m19.setMo_Name("物资信息");
			m19.setMo_Code("supplies");
			m19.setMo_State("1");
			m19.setMo_Step("2");
			m19.setMo_Url("resource/supplies/main");
			m19.setMo_Class("module2");
			m19.setMo_Icon("fa-book");
			module.add(m19);
			moduleInfoService.save(m19);

			T_Module_Info m20 = new T_Module_Info();
			Integer id20 = moduleInfoService.getMax("mo_Id");
			m20.setMo_Id(id20);
			m20.setMo_Pid(id3);
			m20.setMo_Name("物资存储");
			m20.setMo_Code("suppliesstore");
			m20.setMo_State("1");
			m20.setMo_Step("2");
			m20.setMo_Url("resource/suppliesstore/main");
			m20.setMo_Class("module1");
			m20.setMo_Icon("fa-book");
			module.add(m20);
			moduleInfoService.save(m20);

			T_Module_Info m21 = new T_Module_Info();
			Integer id21 = moduleInfoService.getMax("mo_Id");
			m21.setMo_Id(id21);
			m21.setMo_Pid(id3);
			m21.setMo_Name("应急资源");
			m21.setMo_Code("assets");
			m21.setMo_State("1");
			m21.setMo_Step("2");
			m21.setMo_Url("resource/assets/main");
			m21.setMo_Class("module1");
			m21.setMo_Icon("fa-book");
			module.add(m21);
			moduleInfoService.save(m21);

			T_Module_Info m22 = new T_Module_Info();
			Integer id22 = moduleInfoService.getMax("mo_Id");
			m22.setMo_Id(id22);
			m22.setMo_Pid(id3);
			m22.setMo_Name("危险隐患");
			m22.setMo_Code("expert");
			m22.setMo_State("1");
			m22.setMo_Step("2");
			m22.setMo_Url("resource/danger/main");
			m22.setMo_Class("module4");
			m22.setMo_Icon("fa-exclamation-triangle");
			module.add(m22);
			moduleInfoService.save(m22);

			T_Module_Info m23 = new T_Module_Info();
			Integer id23 = moduleInfoService.getMax("mo_Id");
			m23.setMo_Id(id23);
			m23.setMo_Pid(id3);
			m23.setMo_Name("应急队伍");
			m23.setMo_Code("team");
			m23.setMo_State("1");
			m23.setMo_Step("2");
			m23.setMo_Url("resource/team/main");
			m23.setMo_Class("module5");
			m23.setMo_Icon("fa-users");
			module.add(m23);
			moduleInfoService.save(m23);

			T_Module_Info m24 = new T_Module_Info();
			Integer id24 = moduleInfoService.getMax("mo_Id");
			m24.setMo_Id(id24);
			m24.setMo_Pid(id3);
			m24.setMo_Name("法律法规");
			m24.setMo_Code("legal");
			m24.setMo_State("1");
			m24.setMo_Step("2");
			m24.setMo_Url("resource/legal/main");
			m24.setMo_Class("module2");
			m24.setMo_Icon("fa-book");
			module.add(m24);
			moduleInfoService.save(m24);

			T_Module_Info m25 = new T_Module_Info();
			Integer id25 = moduleInfoService.getMax("mo_Id");
			m25.setMo_Id(id25);
			m25.setMo_Pid(id3);
			m25.setMo_Name("专家分类");
			m25.setMo_Code("experttype");
			m25.setMo_State("1");
			m25.setMo_Step("2");
			m25.setMo_Url("resource/experttype/main");
			m25.setMo_Class("module3");
			m25.setMo_Icon("fa-book");
			module.add(m25);
			moduleInfoService.save(m25);

			T_Module_Info m26 = new T_Module_Info();
			Integer id26 = moduleInfoService.getMax("mo_Id");
			m26.setMo_Id(id26);
			m26.setMo_Pid(id3);
			m26.setMo_Name("专家信息");
			m26.setMo_Code("resource");
			m26.setMo_State("1");
			m26.setMo_Step("2");
			m26.setMo_Url("resource/expert/main");
			m26.setMo_Class("module1");
			m26.setMo_Icon("fa-book");
			module.add(m26);
			moduleInfoService.save(m26);

			T_Module_Info m27 = new T_Module_Info();
			Integer id27 = moduleInfoService.getMax("mo_Id");
			m27.setMo_Id(id27);
			m27.setMo_Pid(id4);
			m27.setMo_Name("组织机构");
			m27.setMo_Code("organ");
			m27.setMo_State("1");
			m27.setMo_Step("2");
			m27.setMo_Url("work/organ/main");
			m27.setMo_Class("module3");
			m27.setMo_Icon("fa-sitemap");
			module.add(m27);
			moduleInfoService.save(m27);

			T_Module_Info m28 = new T_Module_Info();
			Integer id28 = moduleInfoService.getMax("mo_Id");
			m28.setMo_Id(id28);
			m28.setMo_Pid(id4);
			m28.setMo_Name("机构人员");
			m28.setMo_Code("person");
			m28.setMo_State("1");
			m28.setMo_Step("2");
			m28.setMo_Url("work/person/main");
			m28.setMo_Class("module4");
			m28.setMo_Icon("fa-users");
			module.add(m28);
			moduleInfoService.save(m28);

			T_Module_Info m29 = new T_Module_Info();
			Integer id29 = moduleInfoService.getMax("mo_Id");
			m29.setMo_Id(id29);
			m29.setMo_Pid(id4);
			m29.setMo_Name("通讯录管理");
			m29.setMo_Code("books");
			m29.setMo_State("1");
			m29.setMo_Step("2");
			m29.setMo_Url("work/books/main");
			m29.setMo_Class("module5");
			m29.setMo_Icon("fa-book");
			module.add(m29);
			moduleInfoService.save(m29);

			T_Module_Info m30 = new T_Module_Info();
			Integer id30 = moduleInfoService.getMax("mo_Id");
			m30.setMo_Id(id30);
			m30.setMo_Pid(id4);
			m30.setMo_Name("岗位分类");
			m30.setMo_Code("position");
			m30.setMo_State("1");
			m30.setMo_Step("2");
			m30.setMo_Url("work/positionclassification/main");
			m30.setMo_Class("module1");
			m30.setMo_Icon("fa-book");
			module.add(m30);
			moduleInfoService.save(m30);
			/*T_Module_Info m301= new T_Module_Info();
			Integer id301 = moduleInfoService.getMax("mo_Id");
			m301.setMo_Id(id301);
			m301.setMo_Pid(id4);
			m301.setMo_Name("岗位分类");
			m301.setMo_Code("position");
			m301.setMo_State("1");
			m301.setMo_Step("2");
			m301.setMo_Url("work/positionclassification/main");
			m301.setMo_Class("module1");
			m301.setMo_Icon("fa-book");
			module.add(m301);
			moduleInfoService.save(m301);*/

			T_Module_Info m31 = new T_Module_Info();
			Integer id31 = moduleInfoService.getMax("mo_Id");
			m31.setMo_Id(id31);
			m31.setMo_Pid(id5);
			m31.setMo_Name("事件类型管理");
			m31.setMo_Code("eventtype");
			m31.setMo_State("1");
			m31.setMo_Step("2");
			m31.setMo_Url("event/eventtype/main");
			m31.setMo_Class("module4");
			m31.setMo_Icon("fa-book");
			module.add(m31);
			moduleInfoService.save(m31);

			T_Module_Info m32 = new T_Module_Info();
			Integer id32 = moduleInfoService.getMax("mo_Id");
			m32.setMo_Id(id32);
			m32.setMo_Pid(id5);
			m32.setMo_Name("突发事件管理");
			m32.setMo_Code("eventinfo");
			m32.setMo_State("1");
			m32.setMo_Step("2");
			m32.setMo_Url("event/eventinfo/list");
			m32.setMo_Class("module5");
			module.add(m32);
			moduleInfoService.save(m32);

			T_Module_Info m33 = new T_Module_Info();
			Integer id33 = moduleInfoService.getMax("mo_Id");
			m33.setMo_Id(id33);
			m33.setMo_Pid(id5);
			m33.setMo_Name("日常事件管理");
			m33.setMo_Code("baseevent");
			m33.setMo_State("1");
			m33.setMo_Step("2");
			m33.setMo_Url("event/baseevent/list");
			m33.setMo_Class("module2");
			module.add(m33);
			moduleInfoService.save(m33);

			/*T_Module_Info m34= new T_Module_Info();
			Integer id34 = moduleInfoService.getMax("mo_Id");
			m34.setMo_Id(id34);
			m34.setMo_Pid(id6);
			m34.setMo_Name("预案分类");
			m34.setMo_Code("plantype");
			m34.setMo_State("1");
			m34.setMo_Step("2");
			m34.setMo_Url("emeplan/plantype/main");
			m34.setMo_Class("module3");
			module.add(m34);
			moduleInfoService.save(m34);*/

			T_Module_Info m35 = new T_Module_Info();
			Integer id35 = moduleInfoService.getMax("mo_Id");
			m35.setMo_Id(id35);
			m35.setMo_Pid(id6);
			m35.setMo_Name("预案基本信息管理");
			m35.setMo_Code("planinfo");
			m35.setMo_State("1");
			m35.setMo_Step("2");
			m35.setMo_Url("emeplan/planinfo/main");
			m35.setMo_Class("module1");
			module.add(m35);
			moduleInfoService.save(m35);

			T_Module_Info m36 = new T_Module_Info();
			Integer id36 = moduleInfoService.getMax("mo_Id");
			m36.setMo_Id(id36);
			m36.setMo_Pid(id6);
			m36.setMo_Name("预案综合管理");
			m36.setMo_Code("manage");
			m36.setMo_State("1");
			m36.setMo_Step("2");
			m36.setMo_Url("emeplan/manage/main");
			m36.setMo_Class("module4");
			module.add(m36);
			moduleInfoService.save(m36);

			T_Module_Info m361 = new T_Module_Info();
			Integer id361 = moduleInfoService.getMax("mo_Id");
			m361.setMo_Id(id361);
			m361.setMo_Pid(id36);
			m361.setMo_Name("预案应急机构");
			m361.setMo_Code("planOrgan");
			m361.setMo_State("1");
			m361.setMo_Step("1");
			m361.setMo_Class("module4");
			module.add(m361);
			moduleInfoService.save(m361);

			T_Module_Info m362 = new T_Module_Info();
			Integer id362 = moduleInfoService.getMax("mo_Id");
			m362.setMo_Id(id362);
			m362.setMo_Pid(id36);
			m362.setMo_Name("应急资源配置");
			m362.setMo_Code("planResource");
			m362.setMo_State("1");
			m362.setMo_Step("1");
			m362.setMo_Class("module4");
			module.add(m362);
			moduleInfoService.save(m362);

			T_Module_Info m3621 = new T_Module_Info();
			Integer id3621 = moduleInfoService.getMax("mo_Id");
			m3621.setMo_Id(id3621);
			m3621.setMo_Pid(id362);
			m3621.setMo_Name("应急物资");
			m3621.setMo_Code("planSupplies");
			m3621.setMo_State("1");
			m3621.setMo_Step("1");
			m3621.setMo_Class("module4");
			module.add(m3621);
			moduleInfoService.save(m3621);

			T_Module_Info m3622 = new T_Module_Info();
			Integer id3622 = moduleInfoService.getMax("mo_Id");
			m3622.setMo_Id(id3622);
			m3622.setMo_Pid(id362);
			m3622.setMo_Name("应急专家");
			m3622.setMo_Code("planExpert");
			m3622.setMo_State("1");
			m3622.setMo_Step("1");
			m3622.setMo_Class("module4");
			module.add(m3622);
			moduleInfoService.save(m3622);

			T_Module_Info m3623 = new T_Module_Info();
			Integer id3623 = moduleInfoService.getMax("mo_Id");
			m3623.setMo_Id(id3623);
			m3623.setMo_Pid(id362);
			m3623.setMo_Name("应急队伍");
			m3623.setMo_Code("planTeam");
			m3623.setMo_State("1");
			m3623.setMo_Step("1");
			m3623.setMo_Class("module4");
			module.add(m3623);
			moduleInfoService.save(m3623);

			T_Module_Info m363 = new T_Module_Info();
			Integer id363 = moduleInfoService.getMax("mo_Id");
			m363.setMo_Id(id363);
			m363.setMo_Pid(id36);
			m363.setMo_Name("事件分类分级");
			m363.setMo_Code("planEvent");
			m363.setMo_State("1");
			m363.setMo_Step("1");
			m363.setMo_Class("module4");
			module.add(m363);
			moduleInfoService.save(m363);
			T_Module_Info m3631 = new T_Module_Info();
			Integer id3631 = moduleInfoService.getMax("mo_Id");
			m3631.setMo_Id(id3631);
			m3631.setMo_Pid(id363);
			m3631.setMo_Name("状况分类");
			m3631.setMo_Code("conditionType");
			m3631.setMo_State("1");
			m3631.setMo_Step("1");
			m3631.setMo_Class("module4");
			module.add(m3631);
			moduleInfoService.save(m3631);
			T_Module_Info m3632 = new T_Module_Info();
			Integer id3632 = moduleInfoService.getMax("mo_Id");
			m3632.setMo_Id(id3632);
			m3632.setMo_Pid(id363);
			m3632.setMo_Name("事件分级");
			m3632.setMo_Code("classification");
			m3632.setMo_State("1");
			m3632.setMo_Step("1");
			m3632.setMo_Class("module4");
			module.add(m3632);
			moduleInfoService.save(m3632);

			T_Module_Info m364 = new T_Module_Info();
			Integer id364 = moduleInfoService.getMax("mo_Id");
			m364.setMo_Id(id364);
			m364.setMo_Pid(id36);
			m364.setMo_Name("预案应急处置");
			m364.setMo_Code("planHandle");
			m364.setMo_State("1");
			m364.setMo_Step("1");
			m364.setMo_Class("module4");
			module.add(m364);
			moduleInfoService.save(m364);
			T_Module_Info m3641 = new T_Module_Info();
			Integer id3641 = moduleInfoService.getMax("mo_Id");
			m3641.setMo_Id(id3641);
			m3641.setMo_Pid(id364);
			m3641.setMo_Name("处置流程");
			m3641.setMo_Code("disposalStage");
			m3641.setMo_State("1");
			m3641.setMo_Step("1");
			m3641.setMo_Class("module4");
			module.add(m3641);
			moduleInfoService.save(m3641);
			T_Module_Info m3642 = new T_Module_Info();
			Integer id3642 = moduleInfoService.getMax("mo_Id");
			m3642.setMo_Id(id3642);
			m3642.setMo_Pid(id364);
			m3642.setMo_Name("行动清单");
			m3642.setMo_Code("actionList");
			m3642.setMo_State("1");
			m3642.setMo_Step("1");
			m3642.setMo_Class("module4");
			module.add(m3642);
			moduleInfoService.save(m3642);
			T_Module_Info m3643 = new T_Module_Info();
			Integer id3643 = moduleInfoService.getMax("mo_Id");
			m3643.setMo_Id(id3643);
			m3643.setMo_Pid(id364);
			m3643.setMo_Name("执行人员");
			m3643.setMo_Code("actionDepartment");
			m3643.setMo_State("1");
			m3643.setMo_Step("1");
			m3643.setMo_Class("module4");
			module.add(m3643);
			moduleInfoService.save(m3643);

			/*T_Module_Info m37= new T_Module_Info();
			Integer id37 = moduleInfoService.getMax("mo_Id");
			m37.setMo_Id(id37);
			m37.setMo_Pid(id7);
			m37.setMo_Name("事件统计");
			m37.setMo_Code("analysis");
			m37.setMo_State("1");
			m37.setMo_Step("2");
			m37.setMo_Url("analysis/eventAnalysis/main");
			m37.setMo_Class("module5");
			m37.setMo_Icon("fa-bar-chart");
			module.add(m37);
			moduleInfoService.save(m37);*/
			T_Module_Info m38 = new T_Module_Info();
			Integer id38 = moduleInfoService.getMax("mo_Id");
			m38.setMo_Id(id38);
			m38.setMo_Pid(id7);
			m38.setMo_Name("按年统计事件数");
			m38.setMo_Code("eventyear");
			m38.setMo_State("1");
			m38.setMo_Step("2");
			m38.setMo_Url("analysis/eventAnalysis/year");
			m38.setMo_Class("module5");
			m38.setMo_Icon("fa-bar-chart");
			module.add(m38);
			moduleInfoService.save(m38);
			T_Module_Info m39 = new T_Module_Info();
			Integer id39 = moduleInfoService.getMax("mo_Id");
			m39.setMo_Id(id39);
			m39.setMo_Pid(id7);
			m39.setMo_Name("按月统计事件数");
			m39.setMo_Code("eventmonth");
			m39.setMo_State("1");
			m39.setMo_Step("2");
			m39.setMo_Url("analysis/eventAnalysis/month");
			m39.setMo_Class("module5");
			m39.setMo_Icon("fa-bar-chart");
			module.add(m39);
			moduleInfoService.save(m39);
			T_Module_Info m40 = new T_Module_Info();
			Integer id40 = moduleInfoService.getMax("mo_Id");
			m40.setMo_Id(id40);
			m40.setMo_Pid(id7);
			m40.setMo_Name("按事件级别统计事件数");
			m40.setMo_Code("eventlevel");
			m40.setMo_State("1");
			m40.setMo_Step("2");
			m40.setMo_Url("analysis/eventAnalysis/level");
			m40.setMo_Class("module5");
			m40.setMo_Icon("fa-bar-chart");
			module.add(m40);
			moduleInfoService.save(m40);

			T_Role_Info role = new T_Role_Info();
			Integer rid = roleInfoService.getMax("ro_Id");
			role.setRo_Id(rid);
			role.setRo_Code("001");
			role.setRo_Name("管理员");
			roleInfoService.save(role);

			for(T_Module_Info m : module) {
				roleModuleService.save(new T_Role_Module(new T_Role_Module_Id(m.getMo_Id(), role.getRo_Id())));
			}

			T_User_Info user = new T_User_Info();
			Integer uid = userInfoService.getMax("us_Id");
			user.setUs_Id(uid);
			user.setUs_Code("admin");
			user.setUs_Name("系统管理员");
			user.setUs_Pass(PwdUtil.encrypt("admin"));
			userInfoService.save(user);

			userRoleService.save(new T_User_Role(new T_User_Role_Id(user.getUs_Id(), role.getRo_Id())));

			geturl();
			System.out.println("初始后台数据完成");
		}
	}
}
