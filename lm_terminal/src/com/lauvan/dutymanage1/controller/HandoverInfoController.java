package com.lauvan.dutymanage1.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.dutymanage1.entity.D_Handover_Info;
import com.lauvan.dutymanage1.service.HandoverInfoService;
import com.lauvan.dutymanage1.vo.HandoverInfoVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.service.UserInfoService;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: HandoverInfoController 
 * @Description: 交接事宜管理
 * @author 钮炜炜
 * @date 2016年3月7日 上午9:20:25
 */
@Controller
@RequestMapping("dutymanage/handoverInfo")
public class HandoverInfoController extends BaseController {

	@Autowired
	private HandoverInfoService handoverInfoService;
	@Autowired
	private UserInfoService userInfoService;
	
	@RequestMapping("/main")
	public String main() {
		return "jsp/dutymanage1/handoverInfo/handoverInfo_main";
	}
	@RequestMapping("/list")
	public String list(Integer page, String query,HandoverInfoVo handoverInfoVo,Model model,HttpSession session) {
		UserInfoVo u = (UserInfoVo) session.getAttribute("userVo");
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("ha_Date", "desc");
		PageView<D_Handover_Info> pageView = new PageView<D_Handover_Info>(15,((page == null || page < 1) ? 1 : page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
        if ("true".equals(query)) {
			
			/*if (!ValidateUtil.isEmpty(eventInfoVo.getEv_name())) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.ev_name like ?").append((params.size() + 1));
				params.add("%" + eventInfoVo.getEv_name().trim() + "%");
			}*/
        	if (!ValidateUtil.isEmpty(handoverInfoVo.getHoType()) && "1".equals(handoverInfoVo.getHoType())) {//交班
        		if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.us_Hander.us_Id = ?").append((params.size() + 1));
				params.add(u.getUs_Id());
				if (!ValidateUtil.isEmpty(handoverInfoVo.getUs_name())) {
					if (params.size() > 0)
						jpql.append(" and ");
					jpql.append(" o.us_Overer.us_Name like ?").append((params.size() + 1));
					params.add("%" + handoverInfoVo.getUs_name().trim() + "%");
				}
			}else if (!ValidateUtil.isEmpty(handoverInfoVo.getHoType()) && "2".equals(handoverInfoVo.getHoType())) {//接班
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.us_Overer.us_Id = ?").append((params.size() + 1));
				params.add(u.getUs_Id());
				if (!ValidateUtil.isEmpty(handoverInfoVo.getUs_name())) {
					if (params.size() > 0)
						jpql.append(" and ");
					jpql.append(" o.us_Hander.us_Name like ?").append((params.size() + 1));
					params.add("%" + handoverInfoVo.getUs_name().trim() + "%");
				}
			}
        	model.addAttribute("handoverInfoVo", handoverInfoVo);
			pageView.setQueryResult(handoverInfoService.getScrollList(
					pageView.getFirstResult(), pageView.getMaxresult(),
					jpql.toString(), params.toArray(), orderby));
        }else {
        	pageView.setQueryResult(handoverInfoService.getScrollList(
					pageView.getFirstResult(), pageView.getMaxresult(),orderby));
		}
        model.addAttribute("pageView", pageView);
        return "jsp/dutymanage1/handoverInfo/handoverInfo_list";
	}
	
	@MethodLog(description = "交接班添加")
	@Perm(privilegeValue = "handoverAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(HandoverInfoVo handoverInfoVo,HttpSession session) {
        if (ValidateUtil.isEmpty(handoverInfoVo.getUs_Overid())) {
			return json("接班人信息没有获取到");
		}
		UserInfoVo u = (UserInfoVo) session.getAttribute("userVo");
		D_Handover_Info h = new D_Handover_Info();
		Integer id = (Integer) handoverInfoService.getMax("ha_Id");
		h.setHa_Id(id+1);
		h.setHa_Content(handoverInfoVo.getHa_Content());
		h.setHa_Date(new Date());
		h.setUs_Hander(new T_User_Info(u.getUs_Id()));
		T_User_Info user_Info = userInfoService.find(handoverInfoVo.getUs_Overid());
		user_Info.setCallif("1");
		h.setUs_Overer(user_Info);
		
		T_User_Info user_Info2 = userInfoService.find(u.getUs_Id());
		user_Info2.setCallif("0");
		try {
//			handoverInfoService.save(h);
			handoverInfoService.addAll(h, user_Info, user_Info2);
			return json(true, "交接事宜添加成功",h);
		} catch (Exception e) {
			e.printStackTrace();
			return json("交接事宜添加失败");
		}
	}
	
	@MethodLog(description = "交接班编辑UI")
	@Perm(privilegeValue = "handoverEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			D_Handover_Info h = handoverInfoService.find(id);
			model.addAttribute("handover", h);
			return "jsp/dutymanage1/handoverInfo/handoverInfo_edit";
		}
		return null;
	}
	
	@MethodLog(description = "交接班编辑")
	@Perm(privilegeValue = "handoverEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(HandoverInfoVo handoverInfoVo) {
		if (ValidateUtil.isEmpty(handoverInfoVo.getHa_Id())) {
			return json("交接事宜ID没有获取到");
		}
		if (ValidateUtil.isEmpty(handoverInfoVo.getUs_Overid())) {
			return json("接班人信息没有获取到");
		}
		D_Handover_Info h = handoverInfoService.find(handoverInfoVo.getHa_Id());
		h.setHa_Content(handoverInfoVo.getHa_Content());
		
		if (!h.getUs_Overer().getUs_Id().equals(handoverInfoVo.getUs_Overid())) {
			T_User_Info user_Info = userInfoService.find(handoverInfoVo.getUs_Overid());
			user_Info.setCallif("1");
			h.setUs_Overer(user_Info);
			
			T_User_Info user_Info2 = h.getUs_Overer();
			user_Info2.setCallif("0");
			
			try {
				handoverInfoService.addAll(h, user_Info, user_Info2);
				return json(true, "交接事宜修改成功",h);
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "交接事宜修改失败");
			}
		}
		
		try {
			handoverInfoService.update(h);
			return json(true, "交接事宜修改成功",h);
		} catch (Exception e) {
			e.printStackTrace();
			return json(true, "交接事宜修改失败");
		}
	}
	@MethodLog(description = "交接班完成")
	@Perm(privilegeValue = "handoverFinish")
	@RequestMapping("/finish")
	@ResponseBody
	public Json finish(Integer id,String ha_state) {
		if (!ValidateUtil.isEmpty(id)) {
			D_Handover_Info h = handoverInfoService.find(id);
			h.setHa_state(ha_state);
			try {
				handoverInfoService.update(h);
				return json(true, "该事宜设置成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("该事宜设置失败");
			}
		}
		return json("事宜ID没有获取到");
	}
}
