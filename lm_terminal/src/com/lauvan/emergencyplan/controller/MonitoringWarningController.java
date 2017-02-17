package com.lauvan.emergencyplan.controller;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_EmeOrgan;
import com.lauvan.emergencyplan.entity.E_Monitoring_Warning;
import com.lauvan.emergencyplan.service.MonitoringWarningService;
import com.lauvan.emergencyplan.vo.MonitoringWarningVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: MonitoringWarningController 
 * @Description: 监测预警信息管理
 * @author 钮炜炜
 * @date 2015年12月22日 下午2:40:08
 */
@Controller
@RequestMapping("emeplan/monitoringWarning")
public class MonitoringWarningController extends BaseController {

	@Autowired
	private MonitoringWarningService monitoringWarningService;
	@RequestMapping("/list")
	public String list(Integer pi_id,Model model) {
		List<E_Monitoring_Warning> mws = monitoringWarningService.findByProperty("pi_id", pi_id);
		model.addAttribute("monitoring_Warnings", mws);
		model.addAttribute("pi_id", pi_id);
		return "jsp/emeplan/monitor/monitor_list";
	}
	@RequestMapping("/add")
	@ResponseBody
	public Json add(MonitoringWarningVo mwVo) {
		E_Monitoring_Warning mw = new E_Monitoring_Warning();
		BeanUtils.copyProperties(mwVo, mw);
		if (!ValidateUtil.isEmpty(mwVo.getEmeOrganId())) {
			mw.setEmeOrgan(new E_EmeOrgan(mwVo.getEmeOrganId()));
		}
		try {
			monitoringWarningService.save(mw);
			return json(true, "监测预警信息添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("监测预警信息添加失败");
		}
	}
	
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			E_Monitoring_Warning mw = monitoringWarningService.find(id);
			model.addAttribute("monitoring_Warning", mw);
			return "jsp/emeplan/monitor/monitor_edit";
		}
		return null;
	}
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(MonitoringWarningVo mwVo) {
		if (ValidateUtil.isEmpty(mwVo.getEmw_id())) {
			return json("监测预警信息ID没有获取到");
		}
		E_Monitoring_Warning mw = monitoringWarningService.find(mwVo.getEmw_id());
		BeanUtils.copyProperties(mwVo, mw);
		if (!ValidateUtil.isEmpty(mwVo.getEmeOrganId())) {
			mw.setEmeOrgan(new E_EmeOrgan(mwVo.getEmeOrganId()));
		}
		try {
			monitoringWarningService.update(mw);
			return json(true, "监测预警信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("监测预警信息修改失败");
		}
	}
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			try {
				monitoringWarningService.delete(id);
				return json(true, "监测预警信息删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("监测预警信息删除失败");
			}
		}
		return json("没有做什么处理");
	}
}
