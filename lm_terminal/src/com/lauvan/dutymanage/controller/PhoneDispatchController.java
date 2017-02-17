package com.lauvan.dutymanage.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.dutymanage.service.PhoneDispatchService;
import com.lauvan.dutymanage.vo.CallHistoryVo;
import com.lauvan.util.Json;

@Controller
@RequestMapping("dutymanage/phonedisp")
public class PhoneDispatchController extends BaseController {
	@Autowired
	private PhoneDispatchService phoneDispatchService;

	@RequestMapping("/main/{dispatch}")
	public String main(HttpServletRequest request, @PathVariable String dispatch) {
		request.setAttribute("dispatch", dispatch);
		return "/jsp/dutymanage/phonedisp/phonedisp_main";
	}

	@RequestMapping("/contacts")
	public String contacts() {
		return "/jsp/dutymanage/phonedisp/phonedisp_contacts";
	}

	@RequestMapping("/unanswered")
	@ResponseBody
	public Json unanswered(CallHistoryVo callHistoryVO) {
		try {
			if(callHistoryVO == null) {
				callHistoryVO = new CallHistoryVo();
			}
			if(callHistoryVO.getPage() < 1) {
				callHistoryVO.setPage(1);
			}
			callHistoryVO.setRows(8);
			callHistoryVO.setVo_callerFlag("1");
			callHistoryVO.setVo_state("0");

			PageView<CallHistoryVo> pageView = new PageView<CallHistoryVo>(callHistoryVO.getRows(), callHistoryVO.getPage());

			pageView.setQueryResult(phoneDispatchService.getCallHistoryGroupList(callHistoryVO));

			return json(true, "", pageView);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		}
	}

	@RequestMapping("/answered")
	@ResponseBody
	public Json answered(CallHistoryVo callHistoryVO) {
		try {
			if(callHistoryVO == null) {
				callHistoryVO = new CallHistoryVo();
			}
			if(callHistoryVO.getPage() < 1) {
				callHistoryVO.setPage(1);
			}
			callHistoryVO.setRows(8);
			callHistoryVO.setVo_callerFlag("1");
			callHistoryVO.setVo_state("1");

			PageView<CallHistoryVo> pageView = new PageView<CallHistoryVo>(callHistoryVO.getRows(), callHistoryVO.getPage());

			pageView.setQueryResult(phoneDispatchService.getCallHistoryGroupList(callHistoryVO));

			return json(true, "", pageView);
		} catch(Exception e) {
			return json(false, "查询失败");
		}
	}

	@RequestMapping("/called")
	@ResponseBody
	public Json called(CallHistoryVo callHistoryVO) {
		try {
			if(callHistoryVO == null) {
				callHistoryVO = new CallHistoryVo();
			}
			if(callHistoryVO.getPage() < 1) {
				callHistoryVO.setPage(1);
			}
			callHistoryVO.setRows(8);
			callHistoryVO.setVo_callerFlag("0");

			PageView<CallHistoryVo> pageView = new PageView<CallHistoryVo>(callHistoryVO.getRows(), callHistoryVO.getPage());

			pageView.setQueryResult(phoneDispatchService.getCallHistoryGroupList(callHistoryVO));

			return json(true, "", pageView);
		} catch(Exception e) {
			return json(false, "查询失败");
		}
	}

	@RequestMapping("/recent")
	@ResponseBody
	public Json recent(CallHistoryVo callHistoryVO) {
		try {
			if(callHistoryVO == null) {
				callHistoryVO = new CallHistoryVo();
			}
			if(callHistoryVO.getPage() < 1) {
				callHistoryVO.setPage(1);
			}
			callHistoryVO.setRows(8);

			PageView<CallHistoryVo> pageView = new PageView<CallHistoryVo>(callHistoryVO.getRows(), callHistoryVO.getPage());

			pageView.setQueryResult(phoneDispatchService.getCallHistoryGroupList(callHistoryVO));

			return json(true, "", pageView);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		}
	}

	@RequestMapping("/history")
	@ResponseBody
	public Json history(CallHistoryVo callHistoryVO) {
		try {
			if(callHistoryVO == null) {
				callHistoryVO = new CallHistoryVo();
			}
			if(callHistoryVO.getPage() < 1) {
				callHistoryVO.setPage(1);
			}
			callHistoryVO.setRows(8);

			PageView<CallHistoryVo> pageView = new PageView<CallHistoryVo>(callHistoryVO.getRows(), callHistoryVO.getPage());

			pageView.setQueryResult(phoneDispatchService.getPersonalCallHistoryList(callHistoryVO));

			return json(true, "", pageView);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		}
	}
}
