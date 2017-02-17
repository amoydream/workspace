package com.lauvan.system.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.base.controller.BaseController;
import com.lauvan.dutymanage.entity.T_Fax_Receive;
import com.lauvan.dutymanage.entity.T_Fax_Send;
import com.lauvan.dutymanage.service.FaxReceiveService;
import com.lauvan.dutymanage.service.FaxSendService;
import com.lauvan.system.entity.T_Ccms_Record;
import com.lauvan.system.entity.T_Module_Info;
import com.lauvan.system.entity.T_Role_Module;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.entity.T_User_Role;
import com.lauvan.system.entity.T_Voice_Record;
import com.lauvan.system.service.CcmsRecordService;
import com.lauvan.system.service.ModuleInfoService;
import com.lauvan.system.service.RoleModuleService;
import com.lauvan.system.service.UserInfoService;
import com.lauvan.system.service.UserLimitService;
import com.lauvan.system.service.UserRoleService;
import com.lauvan.system.service.VoiceRecordService;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.FTPUtil;
import com.lauvan.util.Json;
import com.lauvan.util.Messenger;
import com.lauvan.util.PwdUtil;
import com.lauvan.util.SiteUrl;

/**
 *
 * ClassName: LoginController
 * @Description: 登陆控制类
 * @author 钮炜炜
 * @date 2015年9月11日 下午3:34:53
 */
@Controller
public class LoginController extends BaseController {

	@Autowired
	private UserInfoService		userInfoService;
	@Autowired
	private UserLimitService	userLimitService;
	@Autowired
	private UserRoleService		userRoleService;
	@Autowired
	private RoleModuleService	roleModuleService;
	@Autowired
	private ModuleInfoService	moduleInfoService;
	@Autowired
	private CcmsRecordService	ccmsRecordService;
	@Autowired
	private FaxReceiveService	faxReceiveService;
	@Autowired
	private VoiceRecordService	voiceRecordService;
	@Autowired
	private FaxSendService		faxSendService;

	/**
	 * 用户登录
	 * @param username
	 * @param pass
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public Json login(String username, String pass, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Messenger.sendCount = 0;
		T_User_Info u = userInfoService.findEntity("us_Code", username);
		if(u == null) {
			return json("该用户不存在！");
		}
		if(u.getUs_State().equals("0")) {
			return json("该用户已停用！");
		}
		if(!u.getUs_Pass().equals(PwdUtil.encrypt(pass.trim()))) {
			return json("该用户密码不正确！");
		}
		//获取用户的权限   需要优化
		UserInfoVo uVo = new UserInfoVo();
		BeanUtils.copyProperties(u, uVo);
		List<String> permissions = new ArrayList<>();
		List<Integer> moMenus = new ArrayList<>();
		List<T_User_Role> urs = userRoleService.findByProperty("id.usId", u.getUs_Id());
		for(T_User_Role ur : urs) {
			List<T_Role_Module> rms = roleModuleService.findByProperty("id.ro_Id", ur.getId().getRoId());
			for(T_Role_Module rm : rms) {
				T_Module_Info m = moduleInfoService.find(rm.getId().getMo_Id());
				if(m != null) {
					if(m.getMo_Step() != null && m.getMo_Step().equals("1")) {
						moMenus.add(m.getMo_Id());
					} else if(m.getMo_Step() != null && m.getMo_Step().equals("2")) {
						permissions.add(m.getMo_Code());
					}
				}
			}
		}
		uVo.setMomenus(moMenus);
		uVo.setPermissions(permissions);
		uVo.setVoice(u.getVoice());

		uVo.setVoiceip(SiteUrl.readUrl("VOICE_PATH"));
		session.setAttribute("userVo", uVo);
		dataUpdate();
		return json(true, "登陆成功");
	}

	@ResponseBody
	@RequestMapping("/logout")
	public Json logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		session.removeAttribute("userVo");
		return json(true, "已注销！");
	}

	public void dataUpdate() {
		List<T_Ccms_Record> list = ccmsRecordService.getListEntitys();
		if(list != null) {
			for(T_Ccms_Record rec : list) {
				Integer FAXST = rec.getFAXST();
				Integer CALLID = rec.getCALLID();
				String fileName = CALLID.toString() + ".TIF";
				if(FAXST.intValue() == 0) {
					if(voiceRecordService.findByProperty("vo_callid", CALLID) != null) {
						ccmsRecordService.delete(CALLID);
						continue;
					}
				} else {
					if(faxReceiveService.findEntity("fr_Filename", fileName) != null) {
						ccmsRecordService.delete(CALLID);
						continue;
					} else if(faxSendService.findEntity("fs_Filename", fileName) != null) {
						ccmsRecordService.delete(CALLID);
						continue;
					}
				}

				String ACTS = StringUtils.trim(rec.getACTS());
				String CCID = StringUtils.trim(rec.getCCID());
				String CEID = StringUtils.trim(rec.getCEID());
				Integer CALLVOCNO = rec.getCALLVOCNO();
				Integer CHANNELNO = rec.getCHANNELNO();
				String DATETIME = StringUtils.trim(rec.getDATETIME());
				Integer OUTCTIME = rec.getOUTCTIME();
				Integer TALKTIME = rec.getTALKTIME();
				Integer TOTALTIME = rec.getTOTALTIME();
				Integer WAITTIME = rec.getWAITTIME();
				String VOCRECDFILE = StringUtils.trim(rec.getVOCRECDFILE());
				//直接用中间件生成的文件名
				if(VOCRECDFILE != null) {
					File f = new File(VOCRECDFILE);
					if(f.exists()) {
						fileName = f.getName();
					}
				}
				//保存录音文件的2级目录名
				String exfileString = "00000000" + CALLVOCNO;
				String exfileString2 = exfileString.substring(exfileString.length() - 8, exfileString.length() - 1);
				String exfileString3 = exfileString2.substring(0, 5);

				if(FAXST.intValue() == 0) {
					T_Voice_Record vr = new T_Voice_Record();
					vr.setVo_actAs(ACTS);
					vr.setVo_callid(CALLID);
					vr.setVo_ccid(CCID);
					vr.setVo_ceid(CEID);
					vr.setVo_channelno(CHANNELNO);
					vr.setVo_outCallTime(OUTCTIME);
					//vr.setVo_seadid(vo_seadid);
					//vr.setVo_state(vo_state);
					vr.setVo_talkTime(TALKTIME);
					//vr.setVo_time(vo_time);
					vr.setVo_totalTime(TOTALTIME);
					vr.setVo_voicepath(VOCRECDFILE);
					vr.setVo_waitTime(WAITTIME);
					try {
						voiceRecordService.save(vr);
						//同步备份到FTP服务器
						if(CALLVOCNO != 0) {
							FTPUtil.upload_vocrecd(exfileString3, CALLVOCNO + ".WAV");
						}
					} catch(Exception e) {
						e.printStackTrace();
					}
				} else if(FAXST.intValue() == 9999) {
					File source = new File(SiteUrl.readUrl("FAX") + "//" + CALLID + ".tif");
					File target = new File(SiteUrl.readUrl("FAX_R") + "//" + CALLID + ".tif");

					T_Fax_Receive fr = new T_Fax_Receive();
					Integer id = faxReceiveService.getMax("fr_Id");
					fr.setFr_Id(id + 1);
					fr.setFr_Filename(fileName);
					fr.setFr_Faxnum(CCID);
					fr.setFr_Status("1");
					java.text.SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					try {
						copyFaxFile(source, target);
					} catch(Exception e) {
						e.printStackTrace();
					}
					fr.setFr_Path(SiteUrl.readUrl("FAX_R") + "\\" + CALLID + ".tif");
					try {
						fr.setFr_Time(formatter.parse(DATETIME));
						faxReceiveService.save(fr);
						//同步备份到FTP服务器
						if(source.exists()) {
							FTPUtil.upload_faxrecv(fileName);
						}
					} catch(Exception e) {
						e.printStackTrace();
					}
				} else if(FAXST.intValue() == 8888 || FAXST.intValue() == -8888) {
					File source = new File(SiteUrl.readUrl("FAX") + "//" + CALLID + ".tif");
					File target = new File(SiteUrl.readUrl("FAX_S") + "//" + CALLID + ".tif");

					T_Fax_Send fs = new T_Fax_Send();
					Integer id = faxSendService.getMax("fs_Id");
					fs.setFs_Id(id + 1);
					fs.setFs_Channelno(CHANNELNO);
					fs.setFs_Faxnum(CCID);
					fs.setFs_Filename(fileName);
					String status = "1";
					//fs.setFs_Path(fs_Path);
					if(FAXST.intValue() == -8888) {
						status = "2";
					}
					fs.setFs_Status(status);
					java.text.SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					try {
						copyFaxFile(source, target);
					} catch(Exception e) {
						e.printStackTrace();
					}
					fs.setFs_Path(SiteUrl.readUrl("FAX_S") + "\\" + CALLID + ".tif");
					try {
						fs.setFs_Time(formatter.parse(DATETIME));
						faxSendService.save(fs);
						//同步备份到FTP服务器
						if(source.exists()) {
							FTPUtil.upload_faxsend(fileName);
						}
					} catch(Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	public static void copyFaxFile(File source, File target) throws IOException {
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
		} catch(IOException e) {
			e.printStackTrace();
		} finally {
			inStream.close();
			in.close();
			outStream.close();
			out.close();
		}
	}

}
