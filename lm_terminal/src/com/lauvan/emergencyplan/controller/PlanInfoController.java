package com.lauvan.emergencyplan.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_Eme_Classification;
import com.lauvan.emergencyplan.entity.E_PlanInfo;
import com.lauvan.emergencyplan.entity.E_Plan_Legal;
import com.lauvan.emergencyplan.entity.E_Plan_Legal_Id;
import com.lauvan.emergencyplan.entity.E_Plandoc;
import com.lauvan.emergencyplan.service.EmeClassificationService;
import com.lauvan.emergencyplan.service.PlanInfoService;
import com.lauvan.emergencyplan.service.PlanLegalService;
import com.lauvan.emergencyplan.service.PlandocService;
import com.lauvan.emergencyplan.vo.PlanInfoVo;
import com.lauvan.emergencyplan.vo.PlanLegalVo;
import com.lauvan.event.entity.T_Event_Type;
import com.lauvan.interceptor.Perm;
import com.lauvan.resource.entity.R_Legal;
import com.lauvan.resource.service.LegalService;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: PlanInfoController 
 * @Description: 预案基本信息管理
 * @author 钮炜炜
 * @date 2015年12月7日 下午4:58:34
 */
@Controller
@RequestMapping("emeplan/planinfo")
public class PlanInfoController extends BaseController {

	@Autowired
	private PlanInfoService planInfoService;
	@Autowired
	private PlanLegalService planLegalService;
	@Autowired
	private LegalService legalService;
	@Autowired
	private EmeClassificationService emeClassificationService;
	@Autowired
	private PlandocService plandocService;
	
	@RequestMapping("/main")
	public String main() {
		return "jsp/emeplan/planinfo/planinfo_list";
	}
	@RequestMapping("/list")
	@ResponseBody
	public List<E_PlanInfo> list(Integer etId) {
		if (!ValidateUtil.isEmpty(etId)) {
			return planInfoService.findByNotProperty("eventType.et_id", etId, "pi_del", "1");
		}
		return null;
	}
	@RequestMapping("/search")
	@ResponseBody
	public List<E_PlanInfo> search(String pi_name) {
		if (!ValidateUtil.isEmpty(pi_name)) {
			List<E_PlanInfo> planInfos = planInfoService.findByPropertyauto("pi_name", pi_name);
			return planInfos;
		}
		return null;
	}
	
	@MethodLog(description = "预案基本信息添加")
	@Perm(privilegeValue = "planAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(PlanInfoVo planInfoVo) {
		E_PlanInfo pi = new E_PlanInfo();
		BeanUtils.copyProperties(planInfoVo, pi);
		if (!ValidateUtil.isEmpty(planInfoVo.getEventTypeId())) {
			pi.setEventType(new T_Event_Type(planInfoVo.getEventTypeId()));
		}
		try {
			planInfoService.save(pi);
			return json(true, "预案基本信息添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案基本信息添加失败");
		}
	}
	
	@MethodLog(description = "预案基本信息编辑UI")
	@Perm(privilegeValue = "planEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			E_PlanInfo pi = planInfoService.find(id);
			List<E_Plan_Legal> plan_Legals = planLegalService.findByProperty("id.pi_id", id);
			List<PlanLegalVo> planLegalVos = null;
			if (plan_Legals.size()>0) {
				planLegalVos = new ArrayList<PlanLegalVo>();
				for (E_Plan_Legal pl : plan_Legals) {
					R_Legal legal = legalService.find(pl.getId().getLe_id());
					if (legal!=null) {
						planLegalVos.add(new PlanLegalVo(id, pl.getId().getLe_id(), legal.getLe_Name()));
					}
				}
			}
			
			model.addAttribute("planInfo", pi);
			model.addAttribute("planLegalVos", planLegalVos);
			List<E_Plandoc> plandocs = plandocService.findByProperty("pi_id", id);
			model.addAttribute("plandocs", plandocs);
			
			return "jsp/emeplan/planinfo/planinfo_edit";
		}
		return "";
	}
	
	@MethodLog(description = "预案基本信息编辑")
	@Perm(privilegeValue = "planEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(PlanInfoVo planInfoVo) {
		if (ValidateUtil.isEmpty(planInfoVo.getPi_id())) {
			return json("预案基本信息ID没有获取到");
		}
		E_PlanInfo pi = planInfoService.find(planInfoVo.getPi_id());
		BeanUtils.copyProperties(planInfoVo, pi);
		if (!ValidateUtil.isEmpty(planInfoVo.getEventTypeId())) {
			pi.setEventType(new T_Event_Type(planInfoVo.getEventTypeId()));
		}
		try {
			planInfoService.update(pi);
			return json(true, "预案基本信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案基本信息修改失败");
		}
	}
	
	@MethodLog(description = "预案基本信息彻底删除")
	@Perm(privilegeValue = "planDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			try {
				planInfoService.delete(id);
				return json(true, "预案基本信息彻底删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("预案基本信息彻底删除失败");
			}
		}
		return json("没有做任何操作");
	}
	
	@MethodLog(description="预案基本信息删除")
	@Perm(privilegeValue="planDelup")
	@RequestMapping("/delup")
	@ResponseBody
	public Json delup(Integer id) {
		if(!ValidateUtil.isEmpty(id)) {
			E_PlanInfo pi = planInfoService.find(id);
			pi.setPi_del("1");
			try {
				planInfoService.update(pi);
				return json(true, "预案基本信息删除成功");
			} catch(Exception e) {
				e.printStackTrace();
				return json("预案基本信息删除失败");
			}
		}
		return json("没有做任何操作");
	}
	
	@RequestMapping("/view")
	public String view(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			E_PlanInfo pi = planInfoService.find(id);
			List<E_Plan_Legal> plan_Legals = planLegalService.findByProperty("id.pi_id", id);
			List<PlanLegalVo> planLegalVos = null;
			if (plan_Legals.size()>0) {
				planLegalVos = new ArrayList<PlanLegalVo>();
				for (E_Plan_Legal pl : plan_Legals) {
					R_Legal legal = legalService.find(pl.getId().getLe_id());
					if (legal!=null) {
						planLegalVos.add(new PlanLegalVo(id, pl.getId().getLe_id(), legal.getLe_Name()));
					}
				}
			}
			List<E_Plandoc> plandocs = plandocService.findByProperty("pi_id", id);
			model.addAttribute("plandocs", plandocs);
			model.addAttribute("planLegalVos", planLegalVos);
			model.addAttribute("planInfo", pi);
			return "jsp/emeplan/planinfo/planinfo_view";
		}
		return "";
	}
	@RequestMapping("/addLegal")
	@ResponseBody
	public Json addLegal(Integer pi_id,String le_Ids) {
		if (ValidateUtil.isEmpty(pi_id) && ValidateUtil.isEmpty(le_Ids)) {
			return json("数据获取不完整");
		}
		String[] ids = le_Ids.split(",");
		List<E_Plan_Legal> plan_Legals = new ArrayList<E_Plan_Legal>();
		for (int i = 0; i < ids.length; i++) {
			plan_Legals.add(new E_Plan_Legal(new E_Plan_Legal_Id(pi_id, Integer.valueOf(ids[i]))));
		}
		
		try {
			planLegalService.addAll(plan_Legals);
			return json(true, "预案法律法规添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案法律法规添加失败");
		}
	}
	@RequestMapping("/deleteLegal")
	@ResponseBody
	public Json deleteLegal(Integer pi_id,Integer id) {
		if (!ValidateUtil.isEmpty(pi_id) && !ValidateUtil.isEmpty(id)) {
			try {
				planLegalService.delete(new E_Plan_Legal_Id(pi_id, id));
				return json(true, "预案法律法规删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "预案法律法规删除失败");
			}
		}
		return json("没有做任何操作");
	}
	/**
	 * 事件匹配预案
	 * @param eventTypeId
	 * @param ev_level
	 * @return
	 */
	@RequestMapping("/getplanByEvent")
	@ResponseBody
	public List<E_PlanInfo> getplanByEvent(Integer eventTypeId,String ev_level) {
		if (ValidateUtil.isEmpty(eventTypeId) || ValidateUtil.isEmpty(ev_level)) {
			return null;
		}
		List<E_PlanInfo> planInfos = planInfoService.findByProperty("eventType.et_id", eventTypeId);//匹配事件类型
		List<E_PlanInfo> planInfos2 = new ArrayList<E_PlanInfo>();
		for (E_PlanInfo planInfo : planInfos) {
			List<E_Eme_Classification> classifications = emeClassificationService.findByProperty("pi_id", planInfo.getPi_id());//查询事件分级
			for (E_Eme_Classification classification : classifications) {
				if (!ValidateUtil.isEmpty(classification.getEec_type()) && ev_level.equals(classification.getEec_type())) {//匹配时间分级
					planInfos2.add(planInfo);
				}
			}
		}
		return planInfos2;
	}
}
