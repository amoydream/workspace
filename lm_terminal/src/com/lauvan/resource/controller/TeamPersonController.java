package com.lauvan.resource.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.resource.entity.R_Team;
import com.lauvan.resource.entity.R_Team_Person;
import com.lauvan.resource.entity.R_Team_Person_Id;
import com.lauvan.resource.service.TeamPersonService;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/teamperson")
public class TeamPersonController extends BaseController{
	
	@Autowired
	private TeamPersonService teamPersonService;
	
	@RequestMapping("/main")
	public String main(Integer teId,Integer page, Model model) {
		StringBuilder jpql = new StringBuilder();
		List<Object> params = new ArrayList<Object>();
		if (!ValidateUtil.isEmpty(teId)) {
			if (params.size()>0) {
				jpql.append(" and ");
			}
			jpql.append(" o.id.te_Id.te_Id=?").append(params.size()+1);
			params.add(teId);
		}
		PageView<R_Team_Person> pageView = new PageView<R_Team_Person>(2, ((page==null || page<1) ? 1:page));
		pageView.setQueryResult(teamPersonService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(), jpql.toString(), params.toArray()));
		model.addAttribute("pageView", pageView);
		model.addAttribute("teId", teId);
		return "jsp/resource/teamperson/teamperson_main";
	}
	
	
	@RequestMapping("/selectip")
	public String selectip(Integer teId, Model model) {
		model.addAttribute("teId", teId);
		return "jsp/resource/teamperson/teamperson_select";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public Json add(Integer teId,Integer peId,R_Team_Person member) {
		member.setId(new R_Team_Person_Id(new R_Team(teId),new C_Organ_Person(peId)));
		try {
			teamPersonService.save(member);
			return json(true, "成员添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("成员添加失败");
		}
	}
	
	@RequestMapping("/baseinfo")
	public String baseinfo(Integer id,Model model) {
		R_Team_Person member = teamPersonService.find(id);
		model.addAttribute("member", member);
		return "jsp/resource/teamperson/teamperson_baseinfo";
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer peId, Integer teId) {
		try {
			teamPersonService.delete(new R_Team_Person_Id(new R_Team(teId), new C_Organ_Person(peId)));
			return json(true, "成员信息删除成功");
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("成员信息删除失败");
		}
	}
	
	
	
	

}
