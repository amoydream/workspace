package com.lauvan.dutymanage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lauvan.base.controller.BaseController;

@Controller
@RequestMapping("dutymanage/dutylog")
public class DutyLogController extends BaseController {/*
	@Autowired
	private DutyLogService			dutyLogService;

	@Autowired
	private PhoneDispatchService	phoneDispatchService;

	@Autowired
	private SMSDispatchService		smsDispatchService;

	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest request) {
		return curmatter(request, null);
	}

	@RequestMapping("/curmatter")
	public ModelAndView curmatter(HttpServletRequest request, DutyLogVo vo) {
		if(vo == null) {
			vo = new DutyLogVo();
		}
		if(vo.getPage() < 1) {
			vo.setPage(1);
		}
		vo.setRows(8);

		Calendar duty_date_start = Calendar.getInstance();
		Calendar duty_date_end = Calendar.getInstance();
		duty_date_start.set(duty_date_start.get(Calendar.YEAR), duty_date_start.get(Calendar.MONTH), duty_date_start.get(Calendar.DATE), 0, 0, 0);
		duty_date_end.set(duty_date_end.get(Calendar.YEAR), duty_date_end.get(Calendar.MONTH), duty_date_end.get(Calendar.DATE), 23, 59, 59);

		vo.setDuty_date_start(duty_date_start.getTime());
		vo.setDuty_date_end(duty_date_end.getTime());

		PageView<DutyLogVo> pageView = new PageView<DutyLogVo>(vo.getRows(), vo.getPage());

		pageView.setQueryResult(dutyLogService.getCurrentMatterList(vo));

		ModelAndView mav = new ModelAndView("/jsp/dutymanage/dutylog/dutylog_main");
		mav.addObject("pageView", pageView);
		mav.addObject("dutyLogVo", vo);
		request.setAttribute("dispatch", "curmatter");

		return mav;
	}

	@RequestMapping("/genlog")
	public ModelAndView genlog(HttpServletRequest request, DutyLogVo vo) {
		if(vo == null) {
			vo = new DutyLogVo();
		}
		if(vo.getPage() < 1) {
			vo.setPage(1);
		}
		vo.setRows(8);
		if(vo.getDuty_month() == null) {
			vo.setDuty_month(Calendar.getInstance().getTime());
		}

		Calendar duty_date_start = Calendar.getInstance();
		Calendar duty_date_end = Calendar.getInstance();
		duty_date_start.setTime(vo.getDuty_month());
		duty_date_start.set(duty_date_start.get(Calendar.YEAR), duty_date_start.get(Calendar.MONTH), 1, 0, 0, 0);
		duty_date_end.setTime(vo.getDuty_month());
		duty_date_end.set(duty_date_end.get(Calendar.YEAR), duty_date_end.get(Calendar.MONTH), 1, 23, 59, 59);
		duty_date_end.set(Calendar.DATE, duty_date_end.getMaximum(Calendar.DATE));

		vo.setDuty_date_start(duty_date_start.getTime());
		vo.setDuty_date_end(duty_date_end.getTime());

		PageView<DutyLogVo> pageView = new PageView<DutyLogVo>(vo.getRows(), vo.getPage());

		pageView.setQueryResult(dutyLogService.getCurrentMatterList(vo));

		ModelAndView mav = new ModelAndView("/jsp/dutymanage/dutylog/dutylog_main");
		mav.addObject("pageView", pageView);
		mav.addObject("dutyLogVo", vo);
		request.setAttribute("dispatch", "genlog");

		return mav;
	}

	@RequestMapping("/monthlog")
	public ModelAndView monthlog(HttpServletRequest request, DutyLogVo vo) {
		if(vo == null) {
			vo = new DutyLogVo();
		}
		if(vo.getPage() < 1) {
			vo.setPage(1);
		}
		vo.setRows(8);
		if(vo.getDuty_month() == null) {
			vo.setDuty_month(Calendar.getInstance().getTime());
		}

		Calendar duty_date_start = Calendar.getInstance();
		Calendar duty_date_end = Calendar.getInstance();
		duty_date_start.setTime(vo.getDuty_month());
		duty_date_start.set(duty_date_start.get(Calendar.YEAR), duty_date_start.get(Calendar.MONTH), 1, 0, 0, 0);
		duty_date_end.setTime(vo.getDuty_month());
		duty_date_end.set(duty_date_end.get(Calendar.YEAR), duty_date_end.get(Calendar.MONTH), 1, 23, 59, 59);
		duty_date_end.set(Calendar.DATE, duty_date_end.getMaximum(Calendar.DATE));

		vo.setDuty_date_start(duty_date_start.getTime());
		vo.setDuty_date_end(duty_date_end.getTime());

		PageView<DutyLogVo> pageView = new PageView<DutyLogVo>(vo.getRows(), vo.getPage());

		pageView.setQueryResult(dutyLogService.getCurrentMatterList(vo));

		ModelAndView mav = new ModelAndView("/jsp/dutymanage/dutylog/dutylog_main");
		mav.addObject("pageView", pageView);
		mav.addObject("dutyLogVo", vo);
		request.setAttribute("dispatch", "monthlog");

		return mav;
	}

	@RequestMapping("/daylog")
	public ModelAndView daylog(HttpServletRequest request, DutyLogVo vo) {
		if(vo == null) {
			vo = new DutyLogVo();
		}
		if(vo.getPage() < 1) {
			vo.setPage(1);
		}
		vo.setRows(8);
		if(vo.getDuty_date() == null) {
			vo.setDuty_date(Calendar.getInstance().getTime());
		}

		Calendar duty_date_start = Calendar.getInstance();
		Calendar duty_date_end = Calendar.getInstance();
		duty_date_start.setTime(vo.getDuty_date());
		duty_date_end.setTime(vo.getDuty_date());
		duty_date_start.set(duty_date_start.get(Calendar.YEAR), duty_date_start.get(Calendar.MONTH), duty_date_start.get(Calendar.DATE), 0, 0, 0);
		duty_date_end.set(duty_date_end.get(Calendar.YEAR), duty_date_end.get(Calendar.MONTH), duty_date_end.get(Calendar.DATE), 23, 59, 59);

		vo.setDuty_date(duty_date_start.getTime());
		vo.setDuty_date_start(duty_date_start.getTime());
		vo.setDuty_date_end(duty_date_end.getTime());

		PageView<DutyLogVo> pageView = new PageView<DutyLogVo>(vo.getRows(), vo.getPage());

		pageView.setQueryResult(dutyLogService.getCurrentMatterList(vo));

		ModelAndView mav = new ModelAndView("/jsp/dutymanage/dutylog/dutylog_main");
		mav.addObject("pageView", pageView);
		mav.addObject("dutyLogVo", vo);
		request.setAttribute("dispatch", "daylog");

		return mav;
	}

	@RequestMapping("/callview/{pe_id}/{ev_id}/{call_date_str}/{page}")
	public ModelAndView callview(@PathVariable Integer pe_id, @PathVariable Integer ev_id, @PathVariable String call_date_str, @PathVariable Integer page) {
		CallHistoryVo callHistoryVo = new CallHistoryVo();
		callHistoryVo.setPage(page < 1 ? 1 : page);
		callHistoryVo.setRows(8);
		callHistoryVo.setPe_id(pe_id);
		callHistoryVo.setEv_id(ev_id);

		String[] ss = call_date_str.split("-");
		Calendar vo_time_start = Calendar.getInstance();
		vo_time_start.set(Integer.parseInt(ss[0]), Integer.parseInt(ss[1]) - 1, Integer.parseInt(ss[2]), 0, 0, 0);

		callHistoryVo.setVo_time_start(vo_time_start.getTime());
		callHistoryVo.setVo_time(vo_time_start.getTime());

		PageView<CallHistoryVo> pageView = new PageView<CallHistoryVo>(callHistoryVo.getRows(), callHistoryVo.getPage());

		QueryResult<CallHistoryVo> queryResult = phoneDispatchService.getCallHistoryList(callHistoryVo);
		pageView.setQueryResult(queryResult);

		ModelAndView mav = new ModelAndView("/jsp/dutymanage/dutylog/dutylog_callview");
		mav.addObject("pageView", pageView);
		mav.addObject("callHistoryVo", callHistoryVo);

		return mav;
	}

	@RequestMapping("/smsview/{pe_id}/{ev_id}/{sms_date_str}/{page}")
	public ModelAndView smsview(@PathVariable Integer pe_id, @PathVariable Integer ev_id, @PathVariable String sms_date_str, @PathVariable Integer page) {
		SMSVo smsVo = new SMSVo();
		smsVo.setPage(page < 1 ? 1 : page);
		smsVo.setRows(8);
		smsVo.setPe_id(pe_id);
		smsVo.setEv_id(ev_id);

		String[] ss = sms_date_str.split("-");
		Calendar sms_date_start = Calendar.getInstance();
		sms_date_start.set(Integer.parseInt(ss[0]), Integer.parseInt(ss[1]) - 1, Integer.parseInt(ss[2]), 0, 0, 0);

		smsVo.setSms_date_start(sms_date_start.getTime());
		smsVo.setSms_date(sms_date_start.getTime());

		PageView<SMSVo> pageView = new PageView<SMSVo>(smsVo.getRows(), smsVo.getPage());

		QueryResult<SMSVo> queryResult = smsDispatchService.getPersonalSMSList(smsVo);
		pageView.setQueryResult(queryResult);

		ModelAndView mav = new ModelAndView("/jsp/dutymanage/dutylog/dutylog_smsview");
		mav.addObject("pageView", pageView);
		mav.addObject("smsVo", smsVo);

		return mav;
	}
*/}
