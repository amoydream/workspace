package com.lauvan.dutymanage.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.dutymanage.entity.T_Fax_Receive;
import com.lauvan.dutymanage.entity.T_Fax_Send;
import com.lauvan.dutymanage.service.FaxReceiveService;
import com.lauvan.dutymanage.service.FaxSendService;
import com.lauvan.dutymanage.vo.FaxReceiveVo;
import com.lauvan.dutymanage.vo.FaxSendVo;
import com.lauvan.dutymanage.vo.SMSVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.tifconvert.Result;
import com.lauvan.tifconvert.TifConvertor;
import com.lauvan.util.Json;
import com.lauvan.util.SiteUrl;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("dutymanage/fax")
public class FaxController extends BaseController {

	@Autowired
	private FaxSendService faxSendService;
	
	@Autowired
	private TifConvertor tifConvertor;

	@Autowired
	private FaxReceiveService faxReceiveService;

	@RequestMapping("/main")
	public String main() {
			return "jsp/dutymanage/fax/fax_main";
	}

	@RequestMapping("/sendlist")
	public String sendlist(Integer page, String query, FaxSendVo faxSendVo, Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("fs_Id", "desc");
		PageView<T_Fax_Send> pageView = new PageView<T_Fax_Send>(10, ((page == null || page < 1) ? 1 : page));
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(faxSendVo.getFs_Faxnum())) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.fs_Faxnum like ?").append((params.size() + 1));
				params.add("%" + faxSendVo.getFs_Faxnum().trim() + "%");
			}
			pageView.setQueryResult(faxSendService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(), jpql.toString(), params.toArray(), orderby));
			model.addAttribute("pageView", pageView);
		} else {
			pageView.setQueryResult(faxSendService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(),orderby) );
			model.addAttribute("pageView", pageView);
		}
		return "jsp/dutymanage/fax/fax_sendlist";
	}
	
	@RequestMapping("/receivelist")
	public String receivelist(Integer page, String query, FaxReceiveVo faxReceiveVo, Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("fr_Id", "desc");
		PageView<T_Fax_Receive> pageView = new PageView<T_Fax_Receive>(10, ((page == null || page < 1) ? 1 : page));
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(faxReceiveVo.getFr_Faxnum())) {
				if (params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.fr_Faxnum like ?").append((params.size() + 1));
				params.add("%" + faxReceiveVo.getFr_Faxnum().trim() + "%");
			}
			pageView.setQueryResult(faxReceiveService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(), jpql.toString(), params.toArray(),orderby));
			model.addAttribute("pageView", pageView);
		} else {
			pageView.setQueryResult(faxReceiveService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(),orderby));
			model.addAttribute("pageView", pageView);
		}
		return "jsp/dutymanage/fax/fax_receivelist";
	}

	@RequestMapping("/sendgroup")
	public ModelAndView sendgroup(SMSVo smsVo) {
		if(smsVo == null) {
			smsVo = new SMSVo();
		}

		ModelAndView mav = new ModelAndView("jsp/dutymanage/fax/fax_sendgroup");
		mav.addObject("smsVo", smsVo);

		return mav;
	}
	
	@MethodLog(description = "传真添加")
	@Perm(privilegeValue = "sFaxAdd")
	@RequestMapping("/sendadd")
	@ResponseBody
	public Json sendadd(T_Fax_Send fax) {
		fax.setFs_Status("0");
		Integer id = (Integer) faxSendService.getMax("fs_Id");
		fax.setFs_Id(id+1);
		try {
			faxSendService.save(fax);
			return json(true, "传真信息添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("传真信息添加失败");
		}
	}
	
	/**
	 * 直发传真保存通道号以便后续在voice.js电话结束流程中根据通道号找到数据库中对应的发送传真记录，改变其发送状态
	 * @param fsId
	 * @param channelNo
	 * @return
	 */
	@RequestMapping("/sendstatus")
	@ResponseBody
	public Json sendstatus(Integer fsId, Integer channelNo) {
		T_Fax_Send fax = faxSendService.find(fsId);
		fax.setFs_Channelno(channelNo);
		try {
			faxSendService.update(fax);
			return json(true, "传真发送操作保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("传真发送操作保存失败");
		}
	}
	
	/**
	 * 呼叫转传真，再发出动作后直接改变发送状态
	 * @param fsId
	 * @return
	 */
	@RequestMapping("/sendstatus2")
	@ResponseBody
	public Json sendstatus2(Integer fsId) {
		T_Fax_Send fax = faxSendService.find(fsId);
		fax.setFs_Status("1");
		try {
			faxSendService.update(fax);
			return json(true, "传真发送操作保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("传真发送操作保存失败");
		}
	}

	@MethodLog(description = "发送传真编辑UI")
	@Perm(privilegeValue = "sFaxEditip")
	@RequestMapping("/seditip")
	public String seditip(Integer fsId, Model model) {
		if (!ValidateUtil.isEmpty(fsId)) {
			T_Fax_Send fax = faxSendService.find(fsId);
			model.addAttribute("fax", fax);
			return "jsp/dutymanage/fax/fax_sendedit";
		}
		return null;
	}
	
	@MethodLog(description = "接收传真编辑UI")
	@Perm(privilegeValue = "rFaxEditip")
	@RequestMapping("/reditip")
	public String reditip(Integer frId, Model model) {
		if (!ValidateUtil.isEmpty(frId)) {
			T_Fax_Receive fax = faxReceiveService.find(frId);
			model.addAttribute("fax", fax);
			return "jsp/dutymanage/fax/fax_receiveedit";
		}
		return null;
	}
	
	@MethodLog(description="发送传真编辑")
	@Perm(privilegeValue = "sFaxEdit")
	@RequestMapping("/sedit")
	@ResponseBody
	public Json sedit(FaxSendVo faxSendVo) {
		T_Fax_Send fax = faxSendService.find(faxSendVo.getFs_Id());
		BeanUtils.copyProperties(faxSendVo, fax);
		try {
			faxSendService.update(fax);
			return json(true,"传真信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("传真信息修改失败");
		}
	}
	
	@MethodLog(description="接收传真编辑")
	@Perm(privilegeValue = "rFaxEdit")
	@RequestMapping("/redit")
	@ResponseBody
	public Json redit(FaxReceiveVo faxReceiveVo) {
		T_Fax_Receive fax = faxReceiveService.find(faxReceiveVo.getFr_Id());
		BeanUtils.copyProperties(faxReceiveVo, fax);
		try {
			faxReceiveService.update(fax);
			return json(true,"传真信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("传真信息修改失败");
		}
	}

	
	@RequestMapping("/fileUpload")
	public String fileUpload(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "file", required = false) MultipartFile file,
			FaxSendVo faxSendVo) throws IOException {
        
		response.setContentType("text/plain;charset=UTF-8");
		
		System.out.println("开始");
		String path = request.getSession().getServletContext()
				.getRealPath("/faximg");
		String fileName = file.getOriginalFilename();
		System.out.println(path);
		File uploadFile = new File(path, fileName);
		if (!uploadFile.exists()) {
			System.out.println("创建");
			uploadFile.mkdirs();
			
			try {
				file.transferTo(uploadFile);
			} catch (Exception e) {
				e.printStackTrace();
				response.getWriter().write("1");
			}
		}
		System.out.println(uploadFile);
		
		File target = new File(SiteUrl.readUrl("tifconvert.sourceFolder")+ "//" + fileName);
		String targetFileName = fileName.substring(0, fileName.lastIndexOf("."));
		copyFaxFile(uploadFile,target);
		try {
			Result s = tifConvertor.convertFile(fileName);
			response.getWriter().write(targetFileName + "," + SiteUrl.readUrl("tifconvert.targetFolder"));
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("3");
		}
		
		//转换后的tif再上传至语音服务器传真文件目录
		File tifTarget = new File(SiteUrl.readUrl("tifconvert.targetFolder")+"//"+targetFileName+".tif");
		File serverTarget = new File(SiteUrl.readUrl("FAX")+"//"+targetFileName+".tif");
		copyFaxFile(tifTarget,serverTarget);

		return null;
	}
	
	//复制文件
	public static void copyFaxFile(File source, File target) throws IOException{
		FileChannel in = null;  
	    FileChannel out = null;
	    FileInputStream inStream = null;  
	    FileOutputStream outStream = null;
	    try {  
	        inStream = new FileInputStream(source);  
	        outStream = new FileOutputStream(target); 
	        in = inStream.getChannel();  
	        out = outStream.getChannel();  
	        in.transferTo(0, in.size(), out);
	    } catch (IOException e) {  
	        e.printStackTrace();  
	    } finally {  
	    	inStream.close();  
	    	in.close();  
	    	outStream.close();  
	    	out.close();  
	    }
	}

}