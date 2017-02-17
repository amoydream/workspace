package com.lauvan.dutymanage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lauvan.base.controller.BaseController;
import com.lauvan.dutymanage.entity.T_Handover;
import com.lauvan.dutymanage.service.HandoverService;
import com.lauvan.dutymanage.vo.HandoverVo;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("dutymanage/handover")
public class HandOverController extends BaseController {

	@Autowired
	private HandoverService handoverService;
	
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest request) {
		return takeover(request);
	}

	@RequestMapping("/handover")
	public ModelAndView handover(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/jsp/dutymanage/handover/handover_main");
		request.setAttribute("dispatch", "handover");

		return mav;
	}

	@RequestMapping("/takeover")
	public ModelAndView takeover(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/jsp/dutymanage/handover/handover_main");
		request.setAttribute("dispatch", "takeover");

		return mav;
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public List<T_Handover> list(HandoverVo handoverVo,String query, Integer type) {
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(handoverVo.getHa_Handman())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.ha_Giveman.pe_id like ?").append((params.size()+1));
				params.add("%"+handoverVo.getHa_Handman()+"%");
			}
			return handoverService.getListEntitys(jpql.toString(), params.toArray());
		}
		if (!ValidateUtil.isEmpty(type)) {
			List<T_Handover> legal = handoverService.findByProperty("ha_Giveman", type);
			return legal;
		}
		return null;
	}

	
}
