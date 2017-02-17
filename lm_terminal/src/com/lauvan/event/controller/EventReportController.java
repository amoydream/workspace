package com.lauvan.event.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.base.controller.BaseController;
import com.lauvan.event.entity.E_EventReport;
import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.event.service.EventInfoService;
import com.lauvan.event.service.EventReportService;
import com.lauvan.event.vo.EventReportVo;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.BaseUtil;
import com.lauvan.util.Json;
import com.lauvan.util.SiteUrl;
import com.lauvan.util.ValidateUtil;

/**
 *
 * ClassName: EventReportController
 * @Description: 专报管理
 * @author 钮炜炜
 * @date 2016年4月12日 上午10:01:48
 */
@Controller
@RequestMapping("event/eventReport")
public class EventReportController extends BaseController {

	@Autowired
	private EventReportService	eventReportService;
	@Autowired
	private EventInfoService	eventInfoService;

	@RequestMapping("/list")
	public String list(Integer evId, Model model) {
		List<E_EventReport> eventReports = eventReportService.findByProperty("ev_id", evId);
		model.addAttribute("eventReports", eventReports);
		model.addAttribute("evId", evId);
		return "jsp/event/eventreport/eventreport_list";
	}

	/**
	 * 打开报表
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/report")
	public String report(Integer id, HttpServletRequest request, Model model) {
		model.addAttribute("id", id.toString());
		/*String path = request.getSession().getServletContext().getRealPath("/jsp/poffice/file/") + id + ".doc";
		File file = new File(path);
		if(file.exists()) {
			model.addAttribute("newPath", "jsp/poffice/file/" + id + ".doc");
			return "jsp/event/eventreport/eventreport_report";
		} else {
			File file2 = new File(new File(SiteUrl.readUrl("eventReport")), id + ".doc");
			if(file2.exists()) {
				try {
					FileUtils.copyFile(file2, new File(path));
					model.addAttribute("newPath", "jsp/poffice/file/" + id + ".doc");
					return "jsp/event/eventreport/eventreport_report";
				} catch(IOException e) {
					e.printStackTrace();
				}
			}
		}*/

		if(!ValidateUtil.isEmpty(id)) {
			E_EventReport eventReport = eventReportService.find(id);
			T_EventInfo eventInfo = eventInfoService.find(eventReport.getEv_id());
			com.zhuozhengsoft.pageoffice.wordwriter.WordDocument doc = new com.zhuozhengsoft.pageoffice.wordwriter.WordDocument();
			doc.openDataTag("{PO_num}").setValue(eventReport.getEr_no());
			doc.openDataTag("{PO_bsdw}").setValue(eventReport.getEr_reportUnit());
			String evdate = "";
			String repdate = "";
			try {
				String now = BaseUtil.parseDateToString(new Date());
				now = now.replaceFirst("-", "年");
				now = now.replaceFirst("-", "月");
				now = now + "日";
				doc.openDataTag("{PO_date}").setValue(now);
				evdate = BaseUtil.parseDateToStringss(eventInfo.getEv_date());
				repdate = BaseUtil.parseDateToStringss(eventInfo.getEv_reportDate());
			} catch(Exception e) {
				doc.openDataTag("{PO_date}").setValue("");
				e.printStackTrace();
			}
			doc.openDataTag("{PO_zsdw}").setValue(eventReport.getEr_mainSupply());
			doc.openDataTag("{PO_csdw}").setValue(eventReport.getEr_copySupply());
			doc.openDataTag("{PO_bj}").setValue(eventReport.getEr_contact());
			doc.openDataTag("{PO_tel}").setValue(eventReport.getEr_contactPhone());
			doc.openDataTag("{PO_issuser}").setValue(eventReport.getEr_issuer());
			//内容
			doc.openDataTag("{PO_name}").setValue(eventInfo.getEv_name());
			doc.openDataTag("{PO_address}").setValue(eventInfo.getEv_address());
			doc.openDataTag("{PO_next}").setValue(eventInfo.getEv_nextStep());
			doc.openDataTag("{PO_repunit}").setValue(eventReport.getEr_reportUnit());
			doc.openDataTag("{PO_etname}").setValue(eventInfo.getEventType().getEt_name());
			String PO_level = eventInfo.getEv_level();
			if("1".equals(PO_level)) {
				PO_level = "Ⅰ级事件(特别重大)";
			} else if("2".equals(PO_level)) {
				PO_level = "Ⅱ级事件(重大)";
			} else if("3".equals(PO_level)) {
				PO_level = "Ⅲ级事件(较大)";
			} else if("4".equals(PO_level)) {
				PO_level = "Ⅳ级事件(一般)";
			} else if("5".equals(PO_level)) {
				PO_level = "Ⅳ级以下事件";
			}

			doc.openDataTag("{PO_level}").setValue(PO_level);
			doc.openDataTag("{PO_evdate}").setValue(evdate);
			doc.openDataTag("{PO_repdate}").setValue(repdate);
			doc.openDataTag("{PO_othUser}").setValue(eventInfo.getEv_relatedPersonnel());
			doc.openDataTag("{PO_repuser}").setValue(eventInfo.getEv_reportName());

			doc.openDataTag("{PO_reppost}").setValue(eventInfo.getEv_reportPost());
			doc.openDataTag("{PO_evrepunit}").setValue(eventInfo.getEv_reportUnit());
			doc.openDataTag("{PO_repphone}").setValue(eventInfo.getEv_reportPhone());

			doc.openDataTag("{PO_repaddress}").setValue(eventInfo.getEv_reportAddress());
			doc.openDataTag("{PO_cause}").setValue(eventInfo.getEv_cause());
			doc.openDataTag("{PO_parnum}").setValue(eventInfo.getEv_participationNumber() == null ? "0" : eventInfo.getEv_participationNumber().toString());
			doc.openDataTag("{PO_affArea}").setValue(eventInfo.getEv_affectedArea() == null ? "0" : eventInfo.getEv_affectedArea().toString());
			doc.openDataTag("{PO_deanum}").setValue(eventInfo.getEv_deathToll() == null ? "0" : eventInfo.getEv_deathToll().toString());
			doc.openDataTag("{PO_injnum}").setValue(eventInfo.getEv_injuredPeople() == null ? "0" : eventInfo.getEv_injuredPeople().toString());
			doc.openDataTag("{PO_ecoloss}").setValue(eventInfo.getEv_economicLoss() == null ? "0" : eventInfo.getEv_economicLoss().toString());
			doc.openDataTag("{PO_advdis}").setValue(eventInfo.getEv_advancedDisposal());

			model.addAttribute("newPath", "jsp/poffice/tfsj.doc");
			model.addAttribute("doc", doc);
			return "jsp/event/eventreport/eventreport_report";
		}
		return null;
	}

	/**
	 * 保存修改报表
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/reportSave")
	public String reportSave(Integer id, HttpServletRequest request, HttpServletResponse response) {
		com.zhuozhengsoft.pageoffice.FileSaver fs = new com.zhuozhengsoft.pageoffice.FileSaver(request, response);
		String path = request.getSession().getServletContext().getRealPath("/jsp/poffice/file/") + id + ".doc";
		fs.saveToFile(path);
		File file = new File(new File(SiteUrl.readUrl("eventReport")), id + ".doc");
		if(!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		try {
			FileUtils.copyFile(new File(path), file);
		} catch(IOException e) {
			e.printStackTrace();
		}
		fs.close();
		return null;
	}

	@RequestMapping("/addip")
	public String addip(Integer evId, Model model) {
		T_EventInfo eventInfo = eventInfoService.find(evId);
		model.addAttribute("eventInfo", eventInfo);
		return "jsp/event/eventreport/eventreport_add";
	}

	@ResponseBody
	@RequestMapping("/add")
	public Json add(EventReportVo eventReportVo, HttpSession session) {
		UserInfoVo uv = (UserInfoVo)session.getAttribute("userVo");
		E_EventReport eventReport = new E_EventReport();
		BeanUtils.copyProperties(eventReportVo, eventReport);
		eventReport.setEr_createDate(new Date());
		eventReport.setUser(new T_User_Info(uv.getUs_Id()));
		try {
			eventReportService.save(eventReport);
			return json(true, "上报添加成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("上报添加失败");
		}
	}

	@RequestMapping("/editip")
	public String editip(Integer id, Model model) {
		E_EventReport eventReport = eventReportService.find(id);
		model.addAttribute("eventReport", eventReport);
		return "jsp/event/eventreport/eventreport_edit";
	}

	@ResponseBody
	@RequestMapping("/edit")
	public Json edit(EventReportVo eventReportVo) {
		if(ValidateUtil.isEmpty(eventReportVo.getEr_id())) {
			return json("专报ID没有获取到");
		}
		E_EventReport eventReport = eventReportService.find(eventReportVo.getEr_id());

		BeanUtils.copyProperties(eventReportVo, eventReport);
		try {
			eventReportService.update(eventReport);
			return json(true, "上报修改成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("上报修改失败");
		}
	}

	@ResponseBody
	@RequestMapping("/delete")
	public Json delete(Integer id) {
		try {
			eventReportService.delete(id);
			return json(true, "上报删除成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json(true, "上报删除失败");
		}
	}
}
