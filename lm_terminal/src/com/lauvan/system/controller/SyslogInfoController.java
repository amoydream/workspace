package com.lauvan.system.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.system.entity.T_Syslog_Info;
import com.lauvan.system.service.SyslogInfoService;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: SyslogInfoController 
 * @Description: 系统日志管理
 * @author 钮炜炜
 * @date 2015年9月11日 下午3:41:49
 */
@Controller
@RequestMapping("/system/sysloginfo")
public class SyslogInfoController extends BaseController {

	@Autowired
	private SyslogInfoService syslogInfoService;
	
	@RequestMapping("/list")
	public String list(Integer page,String query,String lo_Type,Model model) {
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("lo_Uptime", "desc");
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<T_Syslog_Info> pageView = new PageView<T_Syslog_Info>(15, ((page==null || page<1) ? 1:page));
		StringBuffer jpql = new StringBuffer("");
		List<Object> params = new ArrayList<Object>();
		jpql.append(" o.lo_Type=?").append((params.size()+1));
		if (ValidateUtil.isEmpty(lo_Type)) {
			lo_Type = "0";
		}
		params.add(lo_Type.trim());
		model.addAttribute("lo_Type", lo_Type);
		pageView.setQueryResult(syslogInfoService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(),params.toArray(),orderby));
		model.addAttribute("pageView", pageView);
		return "jsp/system/sysloginfo/sysloginfo_list";
	}
}
