package com.lauvan.event.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.lauvan.base.controller.BaseController;
import com.lauvan.event.entity.E_Eventdoc;
import com.lauvan.event.service.EventdocService;
import com.lauvan.util.Json;
import com.lauvan.util.SiteUrl;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: EventdocController 
 * @Description: 事件附件管理
 * @author 钮炜炜
 * @date 2016年4月24日 上午11:44:15
 */
@Controller
@RequestMapping("event/eventdoc")
public class EventdocController extends BaseController {

	@Autowired
	private EventdocService eventdocService;
	
	@RequestMapping("/list")
	public String list(Integer evId,Model model) {
		List<E_Eventdoc> docs =  eventdocService.findByProperty("ev_id", evId);
		model.addAttribute("eventdocs", docs);
		return "jsp/event/eventdoc/eventdoc_list";
	}
	@RequestMapping("/upload")
	@ResponseBody
	public Json upload(Integer evid,HttpServletRequest request) {
		ServletContext application = request.getSession().getServletContext();
		String savePath = application.getRealPath("/") + "upload/event/";
		File uploadDir = new File(savePath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		try {
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(application);
			if (multipartResolver.isMultipart(request)) {
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
				Map<String, MultipartFile> fms = multipartRequest.getFileMap();
				for (Map.Entry<String, MultipartFile> entity : fms.entrySet()) {
					MultipartFile mf = entity.getValue();
					String fileName = mf.getOriginalFilename();
					FileCopyUtils.copy(mf.getBytes(), new File(savePath+fileName));
					File file = new File(new File(SiteUrl.readUrl("eventDoc")),fileName);
					if (!file.getParentFile().exists()) {
						file.getParentFile().mkdirs();
					}
					FileCopyUtils.copy(mf.getBytes(), file);
					
					E_Eventdoc doc = new E_Eventdoc();
					doc.setEdoc_name(fileName);
					doc.setEv_id(evid);
					eventdocService.save(doc);
				}
			}
			return json(true, "事件附件上传成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("事件附件上传失败");
		}
	}
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		E_Eventdoc doc = eventdocService.find(id);
		model.addAttribute("eventdoc", doc);
		return "jsp/event/eventdoc/eventdoc_edit";
	}
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(Integer edoc_id,String edoc_desc) {
		if (ValidateUtil.isEmpty(edoc_id)) {
			return json("附件ID没有获取到");
		}
		E_Eventdoc eventdoc = eventdocService.find(edoc_id);
		eventdoc.setEdoc_desc(edoc_desc);
		try {
			eventdocService.update(eventdoc);
			return json(true, "事件附件修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("事件附件修改失败");
		}
	}
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			eventdocService.delete(id);
			return json(true, "事件附件删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json(true, "事件附件删除失败");
		}
	}
	@RequestMapping("/view")
	public String view(String docName,Model model) {
		model.addAttribute("docName", docName);
		return "jsp/event/eventdoc/eventdoc_report";
	}
}
