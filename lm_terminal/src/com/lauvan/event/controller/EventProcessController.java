package com.lauvan.event.controller;

import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.service.PlanInfoService;
import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.event.entity.T_Event_Process;
import com.lauvan.event.service.EventInfoService;
import com.lauvan.event.service.EventProcessService;
import com.lauvan.event.vo.EventInfoVo;
import com.lauvan.event.vo.EventProcessVo;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.organ.service.OrganPersonService;
import com.lauvan.util.Json;

/**
 * ClassName: EventProcessController
 * 
 * @Description: 事务处理过程信息
 * @author Tao
 * @date 14/12/2015
 */
@Controller
@RequestMapping("event/eventproc")
public class EventProcessController extends BaseController {
	@Autowired
	private EventProcessService	eventProcessService;
	@Autowired
	private EventInfoService	eventInfoService;
	@Autowired
	private PlanInfoService		planInfoService;
	@Autowired
	private OrganPersonService	organPersonService;

	@RequestMapping("/procedure/{ev_id}")
	public ModelAndView handleproc(HttpServletRequest request, @PathVariable Integer ev_id) {
		return needrptto(request, ev_id);
	}

	@RequestMapping("/needrptto/{ev_id}")
	public ModelAndView needrptto(HttpServletRequest request, @PathVariable Integer ev_id) {
		T_EventInfo eventInfo = eventInfoService.find(ev_id);
		EventInfoVo eventInfoVo = new EventInfoVo();
		BeanUtils.copyProperties(eventInfo, eventInfoVo);
		eventInfoVo.setEt_name(eventInfo.getEventType().getEt_name());

		ModelAndView mav = new ModelAndView("jsp/event/eventproc/eventproc_procedure");
		mav.addObject("eventInfoVo", eventInfoVo);
		request.setAttribute("dispatch", "needrptto");

		return mav;
	}

	@RequestMapping("/advise/{ev_id}")
	public ModelAndView advise(HttpServletRequest request, @PathVariable Integer ev_id) {
		T_EventInfo eventInfo = eventInfoService.find(ev_id);
		EventInfoVo eventInfoVo = new EventInfoVo();
		BeanUtils.copyProperties(eventInfo, eventInfoVo);
		eventInfoVo.setEt_name(eventInfo.getEventType().getEt_name());

		ModelAndView mav = new ModelAndView("jsp/event/eventproc/eventproc_procedure");
		mav.addObject("eventInfoVo", eventInfoVo);
		request.setAttribute("dispatch", "advise");

		return mav;
	}

	@RequestMapping("/notify/{ev_id}")
	public ModelAndView notify(HttpServletRequest request, @PathVariable Integer ev_id) {
		T_EventInfo eventInfo = eventInfoService.find(ev_id);
		EventInfoVo eventInfoVo = new EventInfoVo();
		BeanUtils.copyProperties(eventInfo, eventInfoVo);
		eventInfoVo.setEt_name(eventInfo.getEventType().getEt_name());

		ModelAndView mav = new ModelAndView("jsp/event/eventproc/eventproc_procedure");
		mav.addObject("eventInfoVo", eventInfoVo);
		request.setAttribute("dispatch", "notify");

		return mav;
	}

	/*@RequestMapping("/preplan/{ev_id}")
	public ModelAndView preplan(HttpServletRequest request, @PathVariable Integer ev_id, PlanInfoVo planInfoVo) {
		T_EventInfo eventInfo = eventInfoService.find(ev_id);

		if(planInfoVo == null) {
			planInfoVo = new PlanInfoVo();
		}
		if(planInfoVo.getPage() < 1) {
			planInfoVo.setPage(1);
		}
		planInfoVo.setRows(8);

		PageView<E_PlanInfo> pageView = new PageView<E_PlanInfo>(planInfoVo.getRows(), planInfoVo.getPage());

		ModelAndView mav = new ModelAndView("jsp/event/eventproc/eventproc_procedure");

		QueryResult<E_PlanInfo> planInfoList = planInfoService.getPlanInfoListByEvId(ev_id);
		if(planInfoList == null) {
			planInfoList = new QueryResult<E_PlanInfo>();
		}
		pageView.setQueryResult(planInfoList);
		mav.addObject("pageView", pageView);
		mav.addObject("eventInfo", eventInfo);
		mav.addObject("eventInfoVo", eventInfo);
		mav.addObject("planInfoVo", planInfoVo);
		request.setAttribute("dispatch", "preplan");

		return mav;
	}*/

	/*@RequestMapping("/searchplan/{ev_id}")
	public ModelAndView searchplan(HttpServletRequest request, @PathVariable Integer ev_id, PlanInfoVo planInfoVo) {
		T_EventInfo eventInfo = eventInfoService.find(ev_id);

		if(planInfoVo == null) {
			planInfoVo = new PlanInfoVo();
		}
		if(planInfoVo.getPage() < 1) {
			planInfoVo.setPage(1);
		}
		planInfoVo.setRows(8);

		PageView<E_PlanInfo> pageView = new PageView<E_PlanInfo>(planInfoVo.getRows(), planInfoVo.getPage());

		ModelAndView mav = new ModelAndView("jsp/event/eventproc/eventproc_procedure");
		pageView.setQueryResult(planInfoService.getPlanInfoList(planInfoVo));
		mav.addObject("pageView", pageView);
		mav.addObject("eventInfo", eventInfo);
		mav.addObject("eventInfoVo", eventInfo);
		mav.addObject("planInfoVo", planInfoVo);
		request.setAttribute("dispatch", "preplan");

		return mav;
	}*/

	@RequestMapping("/procinfo/{ev_id}")
	public ModelAndView procinfo(@PathVariable Integer ev_id) {
		EventProcessVo eventProcessVo = new EventProcessVo();
		eventProcessVo.setEv_id(ev_id);

		List<EventProcessVo> eventProcessList = eventProcessService.getEventProcessList(eventProcessVo).getResultlist();

		ModelAndView mav = new ModelAndView("jsp/event/eventproc/eventproc_procinfo");
		mav.addObject("eventProcessList", eventProcessList);
		mav.addObject("eventProcessVo", eventProcessVo);

		return mav;
	}

	@RequestMapping("/viewproc/{pr_id}")
	public ModelAndView viewproc(@PathVariable Integer pr_id) {
		EventProcessVo eventProcessVo = new EventProcessVo();
		eventProcessVo.setEv_id(pr_id);

		T_Event_Process eventProcess = eventProcessService.getEventProcessById(pr_id);

		ModelAndView mav = new ModelAndView("jsp/event/eventproc/eventproc_viewproc");
		mav.addObject("eventProcess", eventProcess);

		return mav;
	}

	@RequestMapping("/review/{ev_id}")
	public ModelAndView review(@PathVariable Integer ev_id) {
		EventProcessVo eventProcessVo = new EventProcessVo();
		eventProcessVo.setEv_id(ev_id);

		T_EventInfo eventInfo = eventInfoService.find(ev_id);
		EventInfoVo eventInfoVo = new EventInfoVo();

		List<EventProcessVo> eventProcessList = eventProcessService.getEventProcessList(eventProcessVo).getResultlist();
		if(eventInfo != null) {
			BeanUtils.copyProperties(eventInfo, eventInfoVo);
		}
		ModelAndView mav = new ModelAndView("jsp/event/eventproc/eventproc_procreview");
		mav.addObject("eventProcessList", eventProcessList);
		mav.addObject("eventInfoVo", eventInfoVo);

		return mav;
	}

	@RequestMapping("/viewsms/{pr_id}")
	public ModelAndView viewsms(@PathVariable Integer pr_id) {
		T_Event_Process eventProcess = eventProcessService.getEventProcessById(pr_id);
		ModelAndView mav = new ModelAndView("jsp/event/eventproc/eventproc_viewsms");
		mav.addObject("eventProcess", eventProcess);

		return mav;
	}

	@RequestMapping("/save")
	@ResponseBody
	public Json save(HttpServletRequest request, EventProcessVo eventProcessVo) {
		try {
			eventProcessVo.setPr_date(Calendar.getInstance().getTime());
			eventProcessService.save(eventProcessVo);
			return json(false, "保存成功");
		} catch(Exception e) {
			return json(false, "保存失败");
		}
	}

	@RequestMapping("/smsform")
	@ResponseBody
	public Json smsform(HttpServletRequest request, EventProcessVo eventProcessVo) {
		try {
			Set<Integer> idSet = new HashSet<Integer>();
			idSet.add(eventProcessVo.getPe_id());
			if(eventProcessVo.getPe_id_arr() != null) {
				for(Integer pe_id : eventProcessVo.getPe_id_arr()) {
					idSet.add(pe_id);
				}
			}
			Integer[] pe_id_arr = idSet.toArray(new Integer[idSet.size()]);
			List<C_Organ_Person> smsReceiverList = organPersonService.getPersonsByIds(pe_id_arr);
			request.getSession().setAttribute("smsReceiverList", smsReceiverList);
			request.getSession().setAttribute("rp_content", eventProcessVo.getRp_content());
			return json(true, "");
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "");
		}
	}
}
