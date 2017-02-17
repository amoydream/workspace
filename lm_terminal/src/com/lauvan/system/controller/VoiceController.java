package com.lauvan.system.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.base.controller.BaseController;
import com.lauvan.dutymanage.entity.T_Fax_Receive;
import com.lauvan.dutymanage.entity.T_Fax_Send;
import com.lauvan.dutymanage.service.FaxReceiveService;
import com.lauvan.dutymanage.service.FaxSendService;
import com.lauvan.event.entity.E_EventNote;
import com.lauvan.event.service.EventNoteService;
import com.lauvan.organ.entity.C_Address_Book;
import com.lauvan.organ.service.AddressBookService;
import com.lauvan.system.entity.T_Voice_Record;
import com.lauvan.system.service.VoiceRecordService;
import com.lauvan.system.vo.VoiceRecordVo;
import com.lauvan.system.vo.VoiceVo;
import com.lauvan.util.FTPUtil;
import com.lauvan.util.Json;
import com.lauvan.util.SiteUrl;
import com.lauvan.util.ValidateUtil;

/**
 * 语音日志操作类
 *
 * @author 陈存登 钮炜炜
 * @version 1.0 10-10-2015
 */
@Controller
@RequestMapping("system/voice")
public class VoiceController extends BaseController {
	private final String		path	= "d:/voicelog.txt";
	@Autowired
	private VoiceRecordService	voiceRecordService;
	@Autowired
	private AddressBookService	addressBookService;
	@Autowired
	private FaxSendService		faxSendService;
	@Autowired
	private FaxReceiveService	faxReceiveService;
	@Autowired
	private EventNoteService	eventNoteService;

	/**
	 * 写入语音日志
	 *
	 * @param path
	 *            日志根路径
	 * @param text
	 *            日志内容
	 */
	@RequestMapping("/write")
	public void write(String text) {
		System.out.println(text);
		String filePath = createNewFile();
		FileWriter fileWriter = null;
		try {
			fileWriter = new FileWriter(filePath, true);
			fileWriter.write(text + "\r\n");
			fileWriter.close();
		} catch(IOException e) {
			e.printStackTrace();
		}
	}

	@ResponseBody
	@RequestMapping("/read")
	public VoiceVo read(VoiceVo voiceVo) {
		VoiceVo vo = voiceVo;
		return vo;
	}

	/**
	 * 保存录音
	 *
	 * @return
	 */
	@RequestMapping("/add")
	public void add(VoiceRecordVo vr) {
		if(vr.getVo_actions().contains("(F)")) { // 判断是否为传真
			if(vr.getVo_ceid().equals(SiteUrl.readUrl("faxCode"))) { // 判断是否为接收传真
				File source = new File(SiteUrl.readUrl("FAX") + "//" + vr.getVo_callid() + ".tif");
				File target = new File(SiteUrl.readUrl("FAX_R") + "//" + vr.getVo_callid() + ".tif");
				if(source.exists()) {
					T_Fax_Receive faxreceive = null;
					faxreceive = new T_Fax_Receive();
					Integer id = faxReceiveService.getMax("fr_Id");
					faxreceive.setFr_Id(id + 1);
					faxreceive.setFr_Faxnum(vr.getVo_ccid());
					faxreceive.setFr_Filename(vr.getVo_callid() + ".tif");
					faxreceive.setFr_Status("1"); // 设置状态1为接收成功

					try {
						copyFaxFile(source, target);
					} catch(Exception e) {
						e.printStackTrace();
					}
					faxreceive.setFr_Path(SiteUrl.readUrl("FAX_R") + "\\" + vr.getVo_callid() + ".tif");
					faxReceiveService.save(faxreceive);
					//同步备份到FTP服务器
					FTPUtil.upload_faxrecv(vr.getVo_callid() + ".TIF");
				} else {
					return;
				}
			} else {
				if(vr.getVo_CallFEER().equals("8888")) {
					T_Fax_Send faxsend = faxSendService.findEntity("fs_Channelno", vr.getVo_callid());
					faxsend.setFs_Status("1"); // 设置状态1为发送成功
					faxSendService.update(faxsend);
					//同步备份到FTP服务器
					FTPUtil.upload_faxsend(vr.getVo_callid() + ".TIF");
				} else {
					T_Fax_Send faxsend = faxSendService.findEntity("fs_Channelno", vr.getVo_callid());
					faxsend.setFs_Status("2"); // 设置状态2为发送失败
					faxSendService.update(faxsend);
				}
			}
			return;
		}

		if(vr.getVo_callid() > 0) {
			String exfileString3 = "";
			T_Voice_Record v = null;
			if(vr.getCallVocNO() == 0) {
				if(vr.getVo_actAs().equals("C")) {
					if(vr.getVo_totalTime() > 5) {// 总时长大于5秒
						if(voiceRecordService.count(vr.getVo_callid()) == 0) {
							v = new T_Voice_Record();
							BeanUtils.copyProperties(vr, v);
							v.setVo_state("0");
							//							Integer id = voiceRecordService.getMax("vo_id");
							Integer id = nextval("T_Voice_Record");
							v.setVo_id(id);
						}
					}
				}
			} else {
				/*if (vr.getVo_actAs().equals("C")) {
					return;
				}*/
				if(!vr.getVo_callid().equals(vr.getCallVocNO())) {
					return;
				}
				String exfileString = "00000000" + vr.getCallVocNO();
				String exfileString2 = exfileString.substring(exfileString.length() - 8, exfileString.length() - 1);
				exfileString3 = exfileString2.substring(0, 5);
				String path = SiteUrl.readUrl("voicePath") + exfileString3 + "\\" + vr.getCallVocNO() + ".WAV";
				String id = path.substring(path.lastIndexOf("\\") + 1, path.indexOf("."));
				if(id.equals(vr.getVo_callid().toString()) && voiceRecordService.count(vr.getCallVocNO()) == 0) {
					v = new T_Voice_Record();
					BeanUtils.copyProperties(vr, v);
					//v.setVo_callid(vr.getCallVocNO());
					if(vr.getVo_talkTime() > 0) {// 判断是否接通
						v.setVo_state("1");
						// vr.getVo_recdFile() D:\\CCMS\\MSEQ\\00012\\12638.WAV
						// 提取00012\\12638.WAV，并转换成00012/12638.WAV
						String p1 = path.substring(0, path.lastIndexOf("\\"));
						String p2 = path.substring(p1.lastIndexOf("\\") + 1);
						v.setVo_voicepath(p2.replace("\\", "/"));
					} else {
						v.setVo_state("0");
					}
					//					Integer id1 = voiceRecordService.getMax("vo_id");
					Integer id1 = nextval("T_Voice_Record");
					v.setVo_id(id1);
				}
			}
			try {
				if(v != null) {
					voiceRecordService.save(v);
					if(!"0".equals(vr.getCallVocNO())) {
						FTPUtil.upload_vocrecd(exfileString3, vr.getCallVocNO() + ".WAV");
					}
					if(vr.getEventId() > 0) {
						E_EventNote en = new E_EventNote();
						en.setEn_type("1");
						en.setEn_wid(v.getVo_id());
						en.setEv_id(vr.getEventId());
						eventNoteService.save(en);
						//同步备份到FTP服务器
					}
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

	public static void main(String[] args) {
		String path = "D:\\CCMS\\MSEQ\\00012\\12638.WAV";
		String p1 = path.substring(0, path.lastIndexOf("\\"));
		System.out.println(p1);
		String p2 = path.substring(p1.lastIndexOf("\\") + 1);
		System.out.println(p2.replace("\\", "/"));
		// String s = "12342";
		// Integer ii = 12342;
		// System.out.println(ii.toString().equals(s));
	}

	/**
	 * 创建语音日志
	 *
	 * @param path
	 *            系统根目录
	 */
	public String createNewFile() {

		File file = new File(path);
		if(!file.exists()) {
			try {
				file.createNewFile();
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
		return path;
	}

	/**
	 * 呼入
	 *
	 * @param CCID
	 * @param model
	 * @return
	 */
	@RequestMapping("/callIn")
	public String callIn(String CCID, Model model) {
		getPhone(CCID, model);
		model.addAttribute("CCID", CCID);
		return "jsp/voice/callIn";
	}

	/**
	 * 呼出
	 *
	 * @param CEID
	 * @param model
	 * @return
	 */
	@RequestMapping("/callOut")
	public String callOut(String CEID, Model model) {
		getPhone(CEID, model);
		model.addAttribute("CEID", CEID);
		return "jsp/voice/callOut";
	}

	private void getPhone(String CCID, Model model) {
		List<C_Address_Book> aBooks = addressBookService.findByProperty("bo_number", CCID);
		if(aBooks.size() > 0) {
			for(C_Address_Book ab : aBooks) {
				if(ab.getBo_index() == 1) {
					if(!ValidateUtil.isEmpty(ab.getBo_usertype())) {
						if(ab.getBo_usertype().equals("1")) {
							if(ab.getPerson() != null) {
								model.addAttribute("name", ab.getPerson().getPe_name());
								model.addAttribute("dep", ab.getPerson().getOrgan().getOr_name());
							}
						} else if(ab.getBo_usertype().equals("2")) {
							if(ab.getOrgan() != null) {
								model.addAttribute("dep", ab.getOrgan().getOr_name());
							}
						}
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

	@RequestMapping("/iffileexist")
	@ResponseBody
	public Json iffileexist(String callid) {
		File source = new File(SiteUrl.readUrl("FAX") + "//" + callid + ".tif");
		if(source.exists()) {
			return json(true, "文件存在接收成功");
		} else {
			return null;
		}

	}

}