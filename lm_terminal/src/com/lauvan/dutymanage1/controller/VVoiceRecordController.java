package com.lauvan.dutymanage1.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.dutymanage.vo.FaxSendVo;
import com.lauvan.dutymanage1.entity.VVoiceRecord;
import com.lauvan.dutymanage1.service.VVoiceRecordService;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.Json;
import com.lauvan.util.SiteUrl;
import com.lauvan.util.ValidateUtil;
@Controller
@RequestMapping("dutymanage/vVoiceRecord")
public class VVoiceRecordController extends BaseController {

	@Autowired
	private VVoiceRecordService vVoiceRecordService;
	
	@RequestMapping("/main")
	public String main() {
		return "jsp/dutymanage1/voiceRecord/voiceRecord_main";
	}
	
	@RequestMapping("/list")
	public String list(Integer page, String query,VVoiceRecord voiceRecord,String voiceType, Model model,HttpSession session) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("voiceType", voiceType);
		UserInfoVo userInfoVo = (UserInfoVo) session.getAttribute("userVo");
		String[] voices = null;
		if (!ValidateUtil.isEmpty(userInfoVo.getVoice())) {
			voices = userInfoVo.getVoice().split(",");
		}
		String telCode = SiteUrl.readUrl("telCode");
		PageView<VVoiceRecord> pageView = new PageView<VVoiceRecord>(15, page == null || page < 1 ? 1 : page);
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("voTime", "desc");
		if("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (voices != null) {
				if (!ValidateUtil.isEmpty(voiceType) && voiceType.equals("1")) {// 接通电话
					for (int i = 0, h = voices.length; i < h; i++) {
						if (h == 2) {
							if (i == 1) {
								if (!ValidateUtil.isEmpty(telCode)) {
									if (params.size() > 0) {
										jpql.append(" or ");
									}
									jpql.append(" o.voCeid = ?").append(params.size() + 1);
									params.add(voices[i]);
									jpql.append(" or o.voCeid = ?").append(params.size() + 1).append(")");
									params.add(telCode.trim());
								}else {
									if (params.size() > 0) {
										jpql.append(" or ");
									}
									jpql.append(" o.voCeid = ?").append(params.size() + 1).append(")");
									params.add(voices[i]);
								}
							} else {
								if (params.size() > 0) {
									jpql.append(" and ");
								}
								jpql.append(" (o.voCeid = ?").append(
										params.size() + 1);
								params.add(voices[i]);
							}
						} else {
							if (!ValidateUtil.isEmpty(telCode)) {
								if (params.size() > 0) {
									jpql.append(" and ");
								}
								jpql.append(" (o.voCeid = ?").append(params.size() + 1);
								params.add(voices[i]);
								jpql.append(" or o.voCeid = ?").append(params.size() + 1).append(")");
								params.add(telCode.trim());
							}else{
								if (params.size() > 0) {
									jpql.append(" and ");
								}
								jpql.append(" o.voCeid = ?").append(params.size() + 1);
								params.add(voices[i]);
							}
						}
					}
				} else if (!ValidateUtil.isEmpty(voiceType) && voiceType.equals("2")) {// 拨打电话
					for (int i = 0, h = voices.length; i < h; i++) {
						if (h == 2) {
							if (i == 1) {
								if (!ValidateUtil.isEmpty(telCode)) {
									if (params.size() > 0) {
										jpql.append(" or ");
									}
									jpql.append(" o.voCcid = ?").append(params.size() + 1);
									params.add(voices[i]);
									jpql.append(" or o.voCcid = ?").append(params.size() + 1).append(")");
									params.add(telCode.trim());
								}else {
									if (params.size() > 0) {
										jpql.append(" or ");
									}
									jpql.append(" o.voCcid = ?").append(params.size() + 1).append(")");
									params.add(voices[i]);
								}
							} else {
								if (params.size() > 0) {
									jpql.append(" and ");
								}
								jpql.append(" (o.voCcid = ?").append(
										params.size() + 1);
								params.add(voices[i]);
							}
						} else {
							if (!ValidateUtil.isEmpty(telCode)) {
								if (params.size() > 0) {
									jpql.append(" and ");
								}
								jpql.append(" (o.voCcid = ?").append(params.size() + 1);
								params.add(voices[i]);
								jpql.append(" or o.voCcid = ?").append(params.size() + 1).append(")");
								params.add(telCode.trim());
							}else{
								if (params.size() > 0) {
									jpql.append(" and ");
								}
								jpql.append(" o.voCcid = ?").append(params.size() + 1);
								params.add(voices[i]);
							}
						}
					}
				}
			}else{
				if (!ValidateUtil.isEmpty(telCode)) {
					if (!ValidateUtil.isEmpty(voiceType) && voiceType.equals("1")) {// 接通电话
						if (params.size() > 0) {
							jpql.append(" and ");
						}
						jpql.append(" o.voCeid = ?").append(params.size() + 1);
						params.add(telCode.trim());
					} else if (!ValidateUtil.isEmpty(voiceType) && voiceType.equals("2")) {// 拨打电话
						if (params.size() > 0) {
							jpql.append(" and ");
						}
						jpql.append(" o.voCcid = ?").append(params.size() + 1);
						params.add(telCode.trim());
					}
				}
			}
			
			if(!ValidateUtil.isEmpty(voiceRecord.getPeName())) {
				if(params.size() > 0) {
					jpql.append(" and ");
				}
				jpql.append(" o.peName like ?").append(params.size() + 1);
				params.add("%" + voiceRecord.getPeName().trim() + "%");
			}
			if(!ValidateUtil.isEmpty(voiceRecord.getBoNumber())) {
				if(params.size() > 0) {
					jpql.append(" and ");
				}
				jpql.append(" o.boNumber like ?").append(params.size() + 1);
				params.add("%" + voiceRecord.getBoNumber().trim() + "%");
			}
			model.addAttribute("voiceRecord", voiceRecord);
			pageView.setQueryResult(vVoiceRecordService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(), jpql.toString(), params.toArray(),orderby));
		} else {
			pageView.setQueryResult(vVoiceRecordService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(),orderby));
		}
		model.addAttribute("pageView", pageView);
		return "jsp/dutymanage1/voiceRecord/voiceRecord_list";
	}
	
	@RequestMapping("/music")
	@ResponseBody
	public Json music(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "file", required = false) MultipartFile file,
			FaxSendVo faxSendVo) throws IOException {

		String path = request.getSession().getServletContext()
				.getRealPath("/upload");
		String fileName = "telRing.mp3";
		File uploadFile = new File(path, fileName);

		System.out.println("创建");
		uploadFile.mkdirs();

		try {
			file.transferTo(uploadFile);
		} catch (Exception e) {
			e.printStackTrace();
			return json(false, "上传失败");
		}
		return json(true, "上传成功,已设置为来电铃声");
	}
	
}
