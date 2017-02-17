package com.lauvan.dutymanage.controller;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.dutymanage.entity.SMS_Template;
import com.lauvan.dutymanage.service.SMSTemplateService;
import com.lauvan.dutymanage.vo.SMSVo;
import com.lauvan.meip.client.DfsdlItem;
import com.lauvan.meip.client.DfsdlResult;
import com.lauvan.meip.client.Jsdl2Item;
import com.lauvan.meip.client.Jsdl2Result;
import com.lauvan.meip.client.JsdlItem;
import com.lauvan.meip.client.JsdlResult;
import com.lauvan.meip.client.MeipService;
import com.lauvan.meip.client.MsgItem;
import com.lauvan.meip.client.MsgResult;
import com.lauvan.meip.client.YfsdlItem;
import com.lauvan.meip.client.YfsdlResult;
import com.lauvan.organ.service.ContactService;
import com.lauvan.organ.vo.ContactVo;
import com.lauvan.util.Json;

@Controller
@RequestMapping("dutymanage/smsdisp")
public class SMSDispatchController extends BaseController {
	@Autowired
	private SMSTemplateService	smsTemplateService;

	@Autowired
	private ContactService		contactService;

	@Autowired
	private MeipService			meipService;

	@RequestMapping("/main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView("jsp/dutymanage/smsdisp/smsdisp_main");
		mav.addObject("activePage", "msgroup");
		try {
			JsdlResult result = meipService.getLatestJsdl();
			if(result.isSuccess() && result.getItem() != null) {
				JsdlItem item = result.getItem();
				if(item.getId() != 0) {
					mav.addObject("activePage", "unread");
				}
			}
		} catch(RemoteException e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping("/msgroupane")
	public String msgroupane() {
		return "jsp/dutymanage/smsdisp/smsdisp_msgroup";
	}

	@RequestMapping("/unreadpane")
	public String unreadpane() {
		return "jsp/dutymanage/smsdisp/smsdisp_unread";
	}

	@RequestMapping("/readpane")
	public String readpane() {
		return "jsp/dutymanage/smsdisp/smsdisp_read";
	}

	@RequestMapping("/sentpane")
	public String sentpane() {
		return "jsp/dutymanage/smsdisp/smsdisp_sent";
	}

	@RequestMapping("/failedpane")
	public String failedpane() {
		return "jsp/dutymanage/smsdisp/smsdisp_failed";
	}

	@RequestMapping("/tmplpane")
	public String tmplpane() {
		return "jsp/dutymanage/smsdisp/smsdisp_template";
	}

	@RequestMapping("/sendpane")
	public ModelAndView sendpane(SMSVo smsVo) {
		if(smsVo == null) {
			smsVo = new SMSVo();
		}

		ModelAndView mav = new ModelAndView("jsp/dutymanage/smsdisp/smsdisp_sendform");
		mav.addObject("smsVo", smsVo);

		return mav;
	}

	@RequestMapping("/send")
	@ResponseBody
	public Json send(SMSVo smsVo) {
		String[] mobiles = null;
		if(smsVo.getTel_mobile() != null) {
			mobiles = new String[]{smsVo.getTel_mobile()};
		} else {
			mobiles = smsVo.getTel_mobile_arr();
		}
		DfsdlItem item = new DfsdlItem();
		item.setContent(smsVo.getContent());
		item.setMobiles(mobiles);
		try {
			DfsdlResult result = meipService.send(item);
			return json(result.isSuccess(), result.getMsg());
		} catch(RemoteException e) {
			e.printStackTrace();
			return json(false, "发送失败: " + e.getMessage());
		}
	}

	@RequestMapping("/resend/{id}")
	@ResponseBody
	public Json resend(@PathVariable Integer id) {
		try {
			DfsdlResult result = meipService.resend(new int[]{id});
			return json(result.isSuccess(), result.getMsg());
		} catch(RemoteException e) {
			e.printStackTrace();
			return json(false, "发送失败: " + e.getMessage());
		}
	}

	@RequestMapping("/latest")
	@ResponseBody
	public Json latest() {
		SMSVo smsVo = new SMSVo();
		try {
			JsdlResult result = meipService.getLatestJsdl();
			if(result.isSuccess() && result.getItem() != null) {
				JsdlItem item = result.getItem();
				if(item.getId() != 0) {
					ContactVo vo = contactService.getContactByMobile(item.getMobile());
					if(vo != null) {
						BeanUtils.copyProperties(vo, smsVo);
					} else {
						smsVo.setPe_name("未入编");
						smsVo.setOr_name("未知");
					}
					smsVo.setTel_mobile(item.getMobile());
					smsVo.setContent(item.getContent());
					if(item.getRecetime() != null) {
						smsVo.setRecetime(item.getRecetime().getTime());
					}
					smsVo.setRece_id(item.getId());
				} else {
					smsVo.setRece_id(0);
				}
			}
			return json(result.isSuccess(), result.getMsg(), smsVo);
		} catch(RemoteException e) {
			e.printStackTrace();
			return json(false, "系统异常: " + e.getMessage());
		}
	}

	@RequestMapping("/msgroup")
	@ResponseBody
	public Json msgroup(SMSVo vo) {
		try {
			if(vo == null) {
				vo = new SMSVo();
			}
			if(vo.getPage() < 1) {
				vo.setPage(1);
			}
			vo.setRows(15);
			Integer total = 0;
			List<SMSVo> voList = new ArrayList<>();
			if(!StringUtils.isEmpty(vo.getPe_name())) {
				ContactVo cVo = new ContactVo();
				BeanUtils.copyProperties(vo, cVo);
				List<ContactVo> cvList = contactService.getMobileContactPage(cVo);
				Map<String, ContactVo> map = new HashMap<>();
				if(cvList != null && cvList.size() > 0) {
					String[] mobiles = new String[cvList.size()];
					for(int i = 0; i < cvList.size(); i++) {
						String mobile = cvList.get(i).getTel_mobile();
						mobiles[i] = mobile;
						map.put(mobile, cvList.get(i));
					}
					MsgItem item = new MsgItem();
					item.setFirstResult((vo.getPage() - 1) * vo.getRows());
					item.setCurrentPage(vo.getPage());
					item.setMaxResults(vo.getRows());
					item.setMobiles(mobiles);
					MsgResult result = meipService.getMsgGroupPage(item);
					if(result != null && result.getItems() != null && result.getItems().length > 0) {
						total = result.getTotal();
						MsgItem[] items = result.getItems();
						for(MsgItem i : items) {
							ContactVo v = map.get(i.getMobile());
							SMSVo sv = new SMSVo();
							BeanUtils.copyProperties(v, sv);
							sv.setMsgtime(i.getMsgtime().getTime());
							sv.setRece_id(i.getId());
							sv.setContent(i.getContent());
						}
					}
				}
			} else {
				MsgItem item = new MsgItem();
				item.setMobile(vo.getTel_mobile());
				item.setMobiles(vo.getTel_mobile_arr());
				item.setFirstResult((vo.getPage() - 1) * vo.getRows());
				item.setCurrentPage(vo.getPage());
				item.setMaxResults(vo.getRows());
				MsgResult result = meipService.getMsgGroupPage(item);
				if(result != null && result.isSuccess() && result.getItems() != null && result.getItems().length > 0) {
					total = result.getTotal();
					MsgItem[] items = result.getItems();
					Set<String> mobiles = new HashSet<>();
					for(int i = 0; i < items.length; i++) {
						mobiles.add(items[i].getMobile());
					}
					List<ContactVo> cvList = contactService.getContactByMobiles(mobiles.toArray(new String[mobiles.size()]));
					Map<String, ContactVo> cvMap = new HashMap<>();

					if(cvList != null && cvList.size() > 0) {
						for(ContactVo cv : cvList) {
							cvMap.put(cv.getTel_mobile(), cv);
						}
					}
					for(MsgItem i : items) {
						SMSVo sv = new SMSVo();
						String mobile = i.getMobile();
						ContactVo cv = cvMap.get(mobile);
						if(cv != null) {
							BeanUtils.copyProperties(cv, sv);
						} else {
							sv.setPe_name("未入编");
							sv.setOr_name("未知");
						}
						sv.setTel_mobile(i.getMobile());
						sv.setContent(i.getContent());
						sv.setRece_id(i.getId());
						sv.setMsgtime(i.getMsgtime().getTime());
						sv.setMsgtype(i.getMsgtype());
						sv.setCount(i.getCount());
						voList.add(sv);
					}
				} else {
					return json(true, result.getMsg());
				}
			}

			if(voList.size() > 0) {
				PageView<SMSVo> pageView = new PageView<>(vo.getRows(), vo.getPage());
				pageView.setTotalrecord(total);
				pageView.setRecords(voList);
				return new Json(true, "", pageView);
			} else {
				return json(true, "无数据" + "");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "搜索失败");
		}
	}

	@RequestMapping("/searchMsg/{bo_number}/{currentPage}")
	@ResponseBody
	public Json searchMsg(@PathVariable String bo_number, @PathVariable Integer currentPage) {
		try {
			Integer maxResults = 12;
			Integer total = 0;
			List<SMSVo> voList = new ArrayList<>();

			MsgItem item = new MsgItem();
			item.setFirstResult((currentPage - 1) * maxResults);
			item.setCurrentPage(currentPage);
			item.setMaxResults(maxResults);
			item.setMobile(bo_number);
			MsgResult result = meipService.getMsgPage(item);
			if(result != null && result.isSuccess() && result.getItems() != null && result.getItems().length > 0) {
				total = result.getTotal();
				MsgItem[] items = result.getItems();
				Set<String> mobiles = new HashSet<>();
				for(int i = 0; i < items.length; i++) {
					mobiles.add(items[i].getMobile());
				}
				List<ContactVo> cvList = contactService.getContactByMobiles(mobiles.toArray(new String[mobiles.size()]));
				Map<String, ContactVo> cvMap = new HashMap<>();

				if(cvList != null && cvList.size() > 0) {
					for(ContactVo cv : cvList) {
						cvMap.put(cv.getTel_mobile(), cv);
					}
				}
				for(MsgItem i : items) {
					SMSVo sv = new SMSVo();
					String mobile = i.getMobile();
					ContactVo cv = cvMap.get(mobile);
					if(cv != null) {
						BeanUtils.copyProperties(cv, sv);
					} else {
						sv.setPe_name("未入编");
						sv.setOr_name("未知");
					}
					sv.setTel_mobile(i.getMobile());
					sv.setMsg_id(i.getId());
					sv.setContent(i.getContent());
					sv.setRece_id(i.getId());
					sv.setMsgtime(i.getMsgtime().getTime());
					sv.setMsgtype(i.getMsgtype());
					voList.add(sv);
				}
			} else {
				return json(true, result.getMsg());
			}

			if(voList.size() > 0) {
				PageView<SMSVo> pageView = new PageView<>(maxResults, currentPage);
				pageView.setTotalrecord(total);
				pageView.setRecords(voList);
				return new Json(true, "", pageView);
			} else {
				return json(true, "无数据" + "");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "搜索失败");
		}
	}

	@RequestMapping("/unread")
	@ResponseBody
	public Json unread(SMSVo vo) {
		try {
			if(vo == null) {
				vo = new SMSVo();
			}
			if(vo.getPage() < 1) {
				vo.setPage(1);
			}
			vo.setRows(15);
			Integer total = 0;
			List<SMSVo> voList = new ArrayList<>();
			if(!StringUtils.isEmpty(vo.getPe_name())) {
				ContactVo cVo = new ContactVo();
				BeanUtils.copyProperties(vo, cVo);
				List<ContactVo> cvList = contactService.getMobileContactPage(cVo);
				Map<String, ContactVo> map = new HashMap<>();
				if(cvList != null && cvList.size() > 0) {
					String[] mobiles = new String[cvList.size()];
					for(int i = 0; i < cvList.size(); i++) {
						String mobile = cvList.get(i).getTel_mobile();
						mobiles[i] = mobile;
						map.put(mobile, cvList.get(i));
					}
					JsdlItem item = new JsdlItem();
					item.setFirstResult((vo.getPage() - 1) * vo.getRows());
					item.setCurrentPage(vo.getPage());
					item.setMaxResults(vo.getRows());
					item.setMobiles(mobiles);
					JsdlResult result = meipService.getJsdlPage(item);
					if(result != null && result.getItems() != null && result.getItems().length > 0) {
						total = result.getTotal();
						JsdlItem[] items = result.getItems();
						for(JsdlItem i : items) {
							ContactVo v = map.get(i.getMobile());
							SMSVo sv = new SMSVo();
							BeanUtils.copyProperties(v, sv);
							sv.setRecetime(i.getRecetime().getTime());
							sv.setRece_id(i.getId());
							sv.setContent(i.getContent());
						}
					}
				}
			} else {
				JsdlItem item = new JsdlItem();
				item.setMobile(vo.getTel_mobile());
				item.setMobiles(vo.getTel_mobile_arr());
				item.setFirstResult((vo.getPage() - 1) * vo.getRows());
				item.setCurrentPage(vo.getPage());
				item.setMaxResults(vo.getRows());
				JsdlResult result = meipService.getJsdlPage(item);
				if(result != null && result.isSuccess() && result.getItems() != null && result.getItems().length > 0) {
					total = result.getTotal();
					JsdlItem[] items = result.getItems();
					Set<String> mobiles = new HashSet<>();
					for(int i = 0; i < items.length; i++) {
						mobiles.add(items[i].getMobile());
					}
					List<ContactVo> cvList = contactService.getContactByMobiles(mobiles.toArray(new String[mobiles.size()]));
					Map<String, ContactVo> cvMap = new HashMap<>();

					if(cvList != null && cvList.size() > 0) {
						for(ContactVo cv : cvList) {
							cvMap.put(cv.getTel_mobile(), cv);
						}
					}
					for(JsdlItem i : items) {
						SMSVo sv = new SMSVo();
						String mobile = i.getMobile();
						ContactVo cv = cvMap.get(mobile);
						if(cv != null) {
							BeanUtils.copyProperties(cv, sv);
						} else {
							sv.setPe_name("未入编");
							sv.setOr_name("未知");
						}
						sv.setTel_mobile(i.getMobile());
						sv.setContent(i.getContent());
						sv.setRece_id(i.getId());
						sv.setRecetime(i.getRecetime().getTime());
						voList.add(sv);
					}
				} else {
					return json(true, result.getMsg());
				}
			}

			if(voList.size() > 0) {
				PageView<SMSVo> pageView = new PageView<>(vo.getRows(), vo.getPage());
				pageView.setTotalrecord(total);
				pageView.setRecords(voList);
				return new Json(true, "", pageView);
			} else {
				return json(true, "无数据" + "");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "搜索失败");
		}
	}

	@RequestMapping("/read")
	@ResponseBody
	public Json read(SMSVo vo) {
		try {
			if(vo == null) {
				vo = new SMSVo();
			}
			if(vo.getPage() < 1) {
				vo.setPage(1);
			}
			vo.setRows(15);
			Integer total = 0;
			List<SMSVo> voList = new ArrayList<>();
			if(!StringUtils.isEmpty(vo.getPe_name())) {
				ContactVo cVo = new ContactVo();
				BeanUtils.copyProperties(vo, cVo);
				List<ContactVo> cvList = contactService.getMobileContactPage(cVo);
				Map<String, ContactVo> map = new HashMap<>();
				if(cvList != null && cvList.size() > 0) {
					String[] mobiles = new String[cvList.size()];
					for(int i = 0; i < cvList.size(); i++) {
						String mobile = cvList.get(i).getTel_mobile();
						mobiles[i] = mobile;
						map.put(mobile, cvList.get(i));
					}
					Jsdl2Item item = new Jsdl2Item();
					item.setFirstResult((vo.getPage() - 1) * vo.getRows());
					item.setCurrentPage(vo.getPage());
					item.setMaxResults(vo.getRows());
					item.setMobiles(mobiles);
					Jsdl2Result result = meipService.getJsdl2Page(item);
					if(result != null && result.getItems() != null && result.getItems().length > 0) {
						total = result.getTotal();
						Jsdl2Item[] items = result.getItems();
						for(Jsdl2Item i : items) {
							ContactVo v = map.get(i.getMobile());
							SMSVo sv = new SMSVo();
							if(v != null) {
								BeanUtils.copyProperties(v, sv);
							}
							sv.setRecetime(i.getRecetime().getTime());
							sv.setRece_id(i.getId());
							sv.setContent(i.getContent());
						}
					}
				}
			} else {
				Jsdl2Item item = new Jsdl2Item();
				item.setMobile(vo.getTel_mobile());
				item.setMobiles(vo.getTel_mobile_arr());
				item.setFirstResult((vo.getPage() - 1) * vo.getRows());
				item.setCurrentPage(vo.getPage());
				item.setMaxResults(vo.getRows());
				Jsdl2Result result = meipService.getJsdl2Page(item);
				if(result != null && result.isSuccess() && result.getItems() != null && result.getItems().length > 0) {
					total = result.getTotal();
					Jsdl2Item[] items = result.getItems();
					Set<String> mobiles = new HashSet<>();
					for(int i = 0; i < items.length; i++) {
						mobiles.add(items[i].getMobile());
					}
					List<ContactVo> cvList = contactService.getContactByMobiles(mobiles.toArray(new String[mobiles.size()]));
					Map<String, ContactVo> cvMap = new HashMap<>();

					if(cvList != null && cvList.size() > 0) {
						for(ContactVo cv : cvList) {
							cvMap.put(cv.getTel_mobile(), cv);
						}
					}
					for(Jsdl2Item i : items) {
						SMSVo sv = new SMSVo();
						String mobile = i.getMobile();
						ContactVo cv = cvMap.get(mobile);
						if(cv != null) {
							BeanUtils.copyProperties(cv, sv);
						} else {
							sv.setPe_name("未入编");
							sv.setOr_name("未知");
						}
						sv.setTel_mobile(i.getMobile());
						sv.setContent(i.getContent());
						sv.setRece_id(i.getId());
						sv.setRecetime(i.getRecetime().getTime());
						voList.add(sv);
					}
				} else {
					return json(true, result.getMsg());
				}
			}

			if(voList.size() > 0) {
				PageView<SMSVo> pageView = new PageView<>(vo.getRows(), vo.getPage());
				pageView.setTotalrecord(total);
				pageView.setRecords(voList);
				return new Json(true, "", pageView);
			} else {
				return json(true, "无数据" + "");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "搜索失败");
		}
	}

	@RequestMapping("/sent")
	@ResponseBody
	public Json sent(SMSVo vo) {
		try {
			if(vo == null) {
				vo = new SMSVo();
			}
			if(vo.getPage() < 1) {
				vo.setPage(1);
			}
			vo.setRows(15);
			Integer total = 0;
			List<SMSVo> voList = new ArrayList<>();
			if(!StringUtils.isEmpty(vo.getPe_name())) {
				ContactVo cVo = new ContactVo();
				BeanUtils.copyProperties(vo, cVo);
				List<ContactVo> cvList = contactService.getMobileContactPage(cVo);
				Map<String, ContactVo> map = new HashMap<>();
				if(cvList != null && cvList.size() > 0) {
					String[] mobiles = new String[cvList.size()];
					for(int i = 0; i < cvList.size(); i++) {
						String mobile = cvList.get(i).getTel_mobile();
						mobiles[i] = mobile;
						map.put(mobile, cvList.get(i));
					}
					YfsdlItem item = new YfsdlItem();
					item.setFirstResult((vo.getPage() - 1) * vo.getRows());
					item.setCurrentPage(vo.getPage());
					item.setMaxResults(vo.getRows());
					item.setMobiles(mobiles);
					YfsdlResult result = meipService.getYfsdlPage(item);
					if(result != null && result.getItems() != null && result.getItems().length > 0) {
						total = result.getTotal();
						YfsdlItem[] items = result.getItems();
						for(YfsdlItem i : items) {
							ContactVo v = map.get(i.getMobile());
							SMSVo sv = new SMSVo();
							BeanUtils.copyProperties(v, sv);
							sv.setSendtime(i.getDeadtime().getTime());
							sv.setSend_id(i.getId());
							sv.setContent(i.getContent());
						}
					}
				}
			} else {
				YfsdlItem item = new YfsdlItem();
				item.setMobile(vo.getTel_mobile());
				item.setMobiles(vo.getTel_mobile_arr());
				item.setFirstResult((vo.getPage() - 1) * vo.getRows());
				item.setCurrentPage(vo.getPage());
				item.setMaxResults(vo.getRows());
				YfsdlResult result = meipService.getYfsdlPage(item);
				if(result != null && result.isSuccess() && result.getItems() != null && result.getItems().length > 0) {
					total = result.getTotal();
					YfsdlItem[] items = result.getItems();
					Set<String> mobiles = new HashSet<>();
					for(int i = 0; i < items.length; i++) {
						mobiles.add(items[i].getMobile());
					}
					List<ContactVo> cvList = contactService.getContactByMobiles(mobiles.toArray(new String[mobiles.size()]));
					Map<String, ContactVo> cvMap = new HashMap<>();

					if(cvList != null && cvList.size() > 0) {
						for(ContactVo cv : cvList) {
							cvMap.put(cv.getTel_mobile(), cv);
						}
					}
					for(YfsdlItem i : items) {
						SMSVo sv = new SMSVo();
						String mobile = i.getMobile();
						ContactVo cv = cvMap.get(mobile);
						if(cv != null) {
							BeanUtils.copyProperties(cv, sv);
						} else {
							sv.setPe_name("未入编");
							sv.setOr_name("未知");
						}
						sv.setTel_mobile(i.getMobile());
						sv.setContent(i.getContent());
						sv.setSend_id(i.getId());
						sv.setSendtime(i.getDeadtime().getTime());
						voList.add(sv);
					}
				} else {
					return json(true, result.getMsg());
				}
			}

			if(voList.size() > 0) {
				PageView<SMSVo> pageView = new PageView<>(vo.getRows(), vo.getPage());
				pageView.setTotalrecord(total);
				pageView.setRecords(voList);
				return new Json(true, "", pageView);
			} else {
				return json(true, "无数据" + "");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "搜索失败");
		}
	}

	@RequestMapping("/failed")
	@ResponseBody
	public Json failed(SMSVo vo) {
		try {
			if(vo == null) {
				vo = new SMSVo();
			}
			if(vo.getPage() < 1) {
				vo.setPage(1);
			}
			vo.setRows(15);
			Integer total = 0;
			List<SMSVo> voList = new ArrayList<>();
			if(!StringUtils.isEmpty(vo.getPe_name())) {
				ContactVo cVo = new ContactVo();
				BeanUtils.copyProperties(vo, cVo);
				List<ContactVo> cvList = contactService.getMobileContactPage(cVo);
				Map<String, ContactVo> map = new HashMap<>();
				if(cvList != null && cvList.size() > 0) {
					String[] mobiles = new String[cvList.size()];
					for(int i = 0; i < cvList.size(); i++) {
						String mobile = cvList.get(i).getTel_mobile();
						mobiles[i] = mobile;
						map.put(mobile, cvList.get(i));
					}
					DfsdlItem item = new DfsdlItem();
					item.setFirstResult((vo.getPage() - 1) * vo.getRows());
					item.setCurrentPage(vo.getPage());
					item.setMaxResults(vo.getRows());
					item.setMobiles(mobiles);
					item.setStatus(2);
					DfsdlResult result = meipService.getDfsdlPage(item);
					if(result != null && result.getItems() != null && result.getItems().length > 0) {
						total = result.getTotal();
						DfsdlItem[] items = result.getItems();
						for(DfsdlItem i : items) {
							ContactVo v = map.get(i.getMobile());
							SMSVo sv = new SMSVo();
							BeanUtils.copyProperties(v, sv);
							sv.setSend_id(i.getId());
							sv.setContent(i.getContent());
						}
					}
				}
			} else {
				DfsdlItem item = new DfsdlItem();
				item.setMobile(vo.getTel_mobile());
				item.setMobiles(vo.getTel_mobile_arr());
				item.setFirstResult((vo.getPage() - 1) * vo.getRows());
				item.setCurrentPage(vo.getPage());
				item.setMaxResults(vo.getRows());
				item.setStatus(2);
				DfsdlResult result = meipService.getDfsdlPage(item);
				if(result != null && result.isSuccess() && result.getItems() != null && result.getItems().length > 0) {
					total = result.getTotal();
					DfsdlItem[] items = result.getItems();
					Set<String> mobiles = new HashSet<>();
					for(int i = 0; i < items.length; i++) {
						mobiles.add(items[i].getMobile());
					}
					List<ContactVo> cvList = contactService.getContactByMobiles(mobiles.toArray(new String[mobiles.size()]));
					Map<String, ContactVo> cvMap = new HashMap<>();

					if(cvList != null && cvList.size() > 0) {
						for(ContactVo cv : cvList) {
							cvMap.put(cv.getTel_mobile(), cv);
						}
					}
					for(DfsdlItem i : items) {
						SMSVo sv = new SMSVo();
						String mobile = i.getMobile();
						ContactVo cv = cvMap.get(mobile);
						if(cv != null) {
							BeanUtils.copyProperties(cv, sv);
						} else {
							sv.setPe_name("未入编");
							sv.setOr_name("未知");
						}
						sv.setTel_mobile(i.getMobile());
						sv.setContent(i.getContent());
						sv.setSend_id(i.getId());
						voList.add(sv);
					}
				} else {
					return json(true, result.getMsg());
				}
			}

			if(voList.size() > 0) {
				PageView<SMSVo> pageView = new PageView<>(vo.getRows(), vo.getPage());
				pageView.setTotalrecord(total);
				pageView.setRecords(voList);
				return new Json(true, "", pageView);
			} else {
				return json(true, "无数据" + "");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "搜索失败");
		}
	}

	@RequestMapping("/template/{page}")
	@ResponseBody
	public Json searchTemplate(@PathVariable Integer page) {
		try {
			if(page < 1) {
				page = 1;
			}
			int maxResults = 15;
			PageView<SMS_Template> pageView = new PageView<>(maxResults, page);
			pageView.setQueryResult(smsTemplateService.getTemplates((page - 1) * maxResults, maxResults));
			return json(true, "", pageView);
		} catch(Exception e) {
			return json(false, "搜索失败");
		}
	}

	@RequestMapping("/template/save")
	@ResponseBody
	public Json saveTemplate(SMSVo vo) {
		try {
			SMS_Template template = smsTemplateService.saveTemplate(vo.getTmpl_id(), vo.getContent());
			if(template != null) {
				return json(true, "保存成功");
			} else {
				return json(false, "保存失败");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, e.getMessage());
		}
	}

	@RequestMapping("/template/delete/{tmpl_id}")
	@ResponseBody
	public Json saveTemplate(@PathVariable Integer tmpl_id) {
		try {
			SMS_Template template = smsTemplateService.findById(tmpl_id);
			if(template != null) {
				smsTemplateService.delete(template);
				return json(true, "删除成功");
			} else {
				return json(false, "模板不存在");
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, e.getMessage());
		}
	}

	@RequestMapping("/viewunread/{rece_id}")
	public ModelAndView viewunread(@PathVariable Integer rece_id) {
		ModelAndView mav = new ModelAndView("jsp/dutymanage/smsdisp/smsdisp_unreadform");
		SMSVo smsVo = new SMSVo();
		try {
			JsdlResult result = meipService.getJsdlById(rece_id);
			JsdlItem item = result.getItem();
			if(item != null) {
				ContactVo vo = contactService.getContactByMobile(item.getMobile());
				if(vo != null) {
					BeanUtils.copyProperties(vo, smsVo);
				} else {
					smsVo.setPe_name("未入编");
					smsVo.setOr_name("未知");
				}
				smsVo.setTel_mobile(item.getMobile());
				smsVo.setContent(item.getContent());
				smsVo.setRecetime(item.getRecetime().getTime());
				smsVo.setRece_id(rece_id);
				meipService.updateJsdlStatus(rece_id);
			}
		} catch(RemoteException e) {
			e.printStackTrace();
			smsVo.setSuccess(false);
			smsVo.setMsg("系统异常: " + e.getMessage());
		}
		mav.addObject("smsVo", smsVo);
		return mav;
	}

	@RequestMapping("/viewread/{rece_id}")
	public ModelAndView viewread(@PathVariable Integer rece_id) {
		ModelAndView mav = new ModelAndView("jsp/dutymanage/smsdisp/smsdisp_readform");
		SMSVo smsVo = new SMSVo();
		try {
			Jsdl2Result result = meipService.getJsdl2ById(rece_id);
			if(result != null) {
				Jsdl2Item item = result.getItem();
				ContactVo vo = contactService.getContactByMobile(item.getMobile());
				if(vo != null) {
					BeanUtils.copyProperties(vo, smsVo);
				} else {
					smsVo.setPe_name("未入编");
					smsVo.setOr_name("未知");
				}
				smsVo.setTel_mobile(item.getMobile());
				smsVo.setContent(item.getContent());
				smsVo.setRecetime(item.getRecetime().getTime());
				smsVo.setRece_id(rece_id);
			}
		} catch(RemoteException e) {
			e.printStackTrace();
			smsVo.setSuccess(false);
			smsVo.setMsg("系统异常: " + e.getMessage());
		}
		mav.addObject("smsVo", smsVo);
		return mav;
	}

	@RequestMapping("/viewsent/{send_id}")
	public ModelAndView viewsent(@PathVariable Integer send_id) {
		ModelAndView mav = new ModelAndView("jsp/dutymanage/smsdisp/smsdisp_sentform");
		SMSVo smsVo = new SMSVo();
		try {
			YfsdlResult result = meipService.getYfsdlById(send_id);
			if(result != null) {
				YfsdlItem item = result.getItem();
				ContactVo vo = contactService.getContactByMobile(item.getMobile());
				if(vo != null) {
					BeanUtils.copyProperties(vo, smsVo);
				} else {
					smsVo.setPe_name("未入编");
					smsVo.setOr_name("未知");
				}
				smsVo.setTel_mobile(item.getMobile());
				smsVo.setContent(item.getContent());
				smsVo.setSendtime(item.getDeadtime().getTime());
				smsVo.setSend_id(send_id);
			}
		} catch(RemoteException e) {
			e.printStackTrace();
			smsVo.setSuccess(false);
			smsVo.setMsg("系统异常: " + e.getMessage());
		}
		mav.addObject("smsVo", smsVo);
		return mav;
	}

	@RequestMapping("/viewfailed/{send_id}")
	public ModelAndView viewfailed(@PathVariable Integer send_id) {
		ModelAndView mav = new ModelAndView("jsp/dutymanage/smsdisp/smsdisp_failedform");
		SMSVo smsVo = new SMSVo();
		try {
			DfsdlResult result = meipService.getDfsdlById(send_id);
			if(result != null) {
				DfsdlItem item = result.getItem();
				ContactVo vo = contactService.getContactByMobile(item.getMobile());
				if(vo != null) {
					BeanUtils.copyProperties(vo, smsVo);
				} else {
					smsVo.setPe_name("未入编");
					smsVo.setOr_name("未知");
				}
				smsVo.setTel_mobile(item.getMobile());
				smsVo.setContent(item.getContent());
				smsVo.setSend_id(send_id);
			}
		} catch(RemoteException e) {
			e.printStackTrace();
			smsVo.setSuccess(false);
			smsVo.setMsg("系统异常: " + e.getMessage());
		}
		mav.addObject("smsVo", smsVo);
		return mav;
	}
}
