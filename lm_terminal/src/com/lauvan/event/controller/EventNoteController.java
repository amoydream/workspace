package com.lauvan.event.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lauvan.base.controller.BaseController;
import com.lauvan.dutymanage.entity.T_Fax_Send;
import com.lauvan.dutymanage.service.FaxSendService;
import com.lauvan.event.entity.E_EventNote;
import com.lauvan.event.entity.T_EventInfo;
import com.lauvan.event.service.EventInfoService;
import com.lauvan.event.service.EventNoteService;
import com.lauvan.event.vo.EventNoteVo;
import com.lauvan.system.entity.T_Voice_Record;
import com.lauvan.system.service.VoiceRecordService;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("event/eventNote")
public class EventNoteController extends BaseController {

	@Autowired
	private EventNoteService eventNoteService;
	@Autowired
	private VoiceRecordService voiceRecordService;
	@Autowired
	private FaxSendService faxService;
	@Autowired
	private EventInfoService eventInfoService;
	
	@RequestMapping("/list")
	public String list(Integer ev_id,Model model) {
		if (ValidateUtil.isEmpty(ev_id)) {
			return "jsp/event/disposal/disposal_back";
		}
		T_EventInfo eventInfo = eventInfoService.find(ev_id);
		model.addAttribute("eventInfo", eventInfo);
		List<EventNoteVo> eventNoteVos = new ArrayList<EventNoteVo>();
		EventNoteVo eventNoteVo = null;
		List<E_EventNote> eventNotes = eventNoteService.findByProperty("ev_id", ev_id);
		for (E_EventNote eventNote : eventNotes) {
			eventNoteVo = new EventNoteVo();
			
			BeanUtils.copyProperties(eventNote, eventNoteVo);
			
			if (eventNote.getEn_type().equals("1")) {
				T_Voice_Record voice_Record = voiceRecordService.find(eventNote.getEn_wid());
				if (voice_Record!=null) {
					eventNoteVo.setWo(voice_Record);
				}
			}else if (eventNote.getEn_type().equals("2")) {
				
			}else if (eventNote.getEn_type().equals("3")) {
				T_Fax_Send fax = faxService.find(eventNote.getEn_wid());
				if (fax!=null) {
					eventNoteVo.setWo(fax);
				}
			}else if (eventNote.getEn_type().equals("4")) {
				
			}
			eventNoteVos.add(eventNoteVo);
		}
		model.addAttribute("eventNoteVos", eventNoteVos);
		return "jsp/event/disposal/disposal_back";
	}
}
