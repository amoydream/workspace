package com.lauvan.emergencyplan.controller;

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
import com.lauvan.emergencyplan.entity.E_Plandoc;
import com.lauvan.emergencyplan.service.PlandocService;
import com.lauvan.util.Json;
import com.lauvan.util.SiteUrl;
/**
 * 
 * ClassName: PlandocController 
 * @Description: 预案附件管理
 * @author 钮炜炜
 * @date 2016年4月24日 下午4:16:33
 */
@Controller
@RequestMapping("emeplan/plandoc")
public class PlandocController extends BaseController {

	@Autowired
	private PlandocService plandocService;
	
	@RequestMapping("/upload")
	@ResponseBody
	public Json upload(Integer piId,HttpServletRequest request) {
		ServletContext application = request.getSession().getServletContext();
		String savePath = application.getRealPath("/") + "upload/plan/";
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
					File file = new File(new File(SiteUrl.readUrl("planDoc")),fileName);
					if (!file.getParentFile().exists()) {
						file.getParentFile().mkdirs();
					}
					FileCopyUtils.copy(mf.getBytes(), file);
					
					E_Plandoc plandoc = new E_Plandoc();
					plandoc.setPdoc_name(fileName);
					plandoc.setPi_id(piId);
					plandocService.save(plandoc);
				}
			}
			return json(true, "预案附件上传成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案附件上传失败");
		}
	}
	
	public String list(Integer piId,Model model) {
		List<E_Plandoc> plandocs = plandocService.findByProperty("pi_id", piId);
		model.addAttribute("plandocs", plandocs);
		return "";
	}
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			plandocService.delete(id);
			return json(true, "预案附件删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案附件删除失败");
		}
	}
	@RequestMapping("/view")
	public String view(String docName,Model model) {
		model.addAttribute("docName", docName);
		return "jsp/emeplan/planinfo/planinfo_report";
	}
}
