package com.lauvan.dutymanage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.dutymanage.service.DutyScheduleService;
import com.lauvan.dutymanage.vo.DutyScheduleVo;
import com.lauvan.util.DateUtil;
import com.lauvan.util.Json;

@Controller
@RequestMapping("dutymanage/dutyschedule")
public class DutyScheduleController extends BaseController {
	@Autowired
	private DutyScheduleService dutyScheduleService;

	@RequestMapping("/calendar")
	public String calendar() {
		return "/jsp/dutymanage/dutyschedule/dutyschedule_calendar";
	}

	@MethodLog(description = "新增值班排班")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(@ModelAttribute DutyScheduleVo dutyScheduleVo) {
		try {
			dutyScheduleService.addDutySchedule(dutyScheduleVo);
			return json(true, "添加成功！");
		} catch(Exception e) {
			return json(false, "添加失败！");
		}
	}

	@MethodLog(description = "新增值班排班")
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Json delete(@PathVariable Integer id) {
		try {
			dutyScheduleService.deleteDutySchedule(id);
			return json(true, "删除成功！");
		} catch(Exception e) {
			return json(false, "删除失败！");
		}
	}

	@RequestMapping("/import")
	public ModelAndView importSchedule(HttpServletRequest request, @ModelAttribute DutyScheduleVo dutyScheduleVo) {
		ModelAndView mav = new ModelAndView("/jsp/dutymanage/dutyschedule/dutyschedule_main");

		return mav;
	}

	@RequestMapping("/retrieve")
	@ResponseBody
	public List<DutyScheduleVo> retrieve(@ModelAttribute DutyScheduleVo dutyScheduleVo) {
		if(dutyScheduleVo == null) {
			dutyScheduleVo = new DutyScheduleVo();
		}

		return dutyScheduleService.getCalendarSchedule(dutyScheduleVo);
	}

	@RequestMapping("/templates")
	@ResponseBody
	public List<DutyScheduleVo> templates() {
		return dutyScheduleService.getScheduleTemplates();
	}

	@RequestMapping("/addform/{dutyDate}")
	public ModelAndView addForm(@PathVariable String dutyDate) {
		DutyScheduleVo dutyScheduleVo = new DutyScheduleVo();
		dutyScheduleVo.setDuty_date(DateUtil.parse(dutyDate, "yyyy-MM-dd"));
		dutyScheduleVo.setDuty_prop("1");
		dutyScheduleVo.setDuty_type("1");

		ModelAndView mav = new ModelAndView("/jsp/dutymanage/dutyschedule/dutyschedule_form");
		mav.addObject("dutyScheduleVo", dutyScheduleVo);

		return mav;
	}

	@RequestMapping("/editform/{id}")
	public ModelAndView editForm(@PathVariable Integer id) {
		ModelAndView mav = new ModelAndView("/jsp/dutymanage/dutyschedule/dutyschedule_form");
		mav.addObject("dutyScheduleVo", dutyScheduleService.getDutyScheduleById(id));

		return mav;
	}

	@MethodLog(description = "保存值班排班")
	@RequestMapping("/save")
	@ResponseBody
	public Json save(@ModelAttribute DutyScheduleVo dutyScheduleVo) {
		try {
			if(dutyScheduleService.isOnDuty(dutyScheduleVo.getPe_id(), dutyScheduleVo.getDuty_date())) {
				return json(false, "该人员当日已排班！");
			}
			Integer id = dutyScheduleService.saveDutySchedule(dutyScheduleVo);
			if("Y".equals(dutyScheduleVo.getIs_tmpl())) {
				dutyScheduleService.saveScheduleTemplate(dutyScheduleVo);
			}
			return json(true, "添加成功！", id);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "添加失败！");
		}
	}

	@MethodLog(description = "保存值班排班")
	@RequestMapping("/update")
	@ResponseBody
	public Json update(@ModelAttribute DutyScheduleVo dutyScheduleVo) {
		try {
			dutyScheduleService.saveDutySchedule(dutyScheduleVo);
			if("Y".equals(dutyScheduleVo.getIs_tmpl())) {
				dutyScheduleService.saveScheduleTemplate(dutyScheduleVo);
			}
			return json(true, "修改成功！");
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "修改失败！");
		}
	}

	@MethodLog(description = "删除值班排班模板")
	@RequestMapping("/deletetmpl/{id}")
	@ResponseBody
	public Json deletetmpl(@PathVariable Integer id) {
		try {
			dutyScheduleService.deleteScheduleTemplate(id);
			return json(true, "删除成功！");
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "删除失败！");
		}
	}
}
