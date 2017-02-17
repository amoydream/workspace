package com.lauvan.emergencyplan.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_PlanInfo;
import com.lauvan.emergencyplan.service.PlanInfoService;
import com.lauvan.event.service.EventTypeService;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: ManageController 
 * @Description: 预案综合管理
 * @author 钮炜炜
 * @date 2015年12月10日 下午3:08:41
 */
@Controller
@RequestMapping("emeplan/manage")
public class ManageController extends BaseController {

	@Autowired
	private PlanInfoService planInfoService;
	@Autowired
	private EventTypeService eventTypeService;

	@RequestMapping("/main")
	public String main(Integer pi_id,Model model) {
		if (ValidateUtil.isEmpty(pi_id)) {
			pi_id = 1;
		}
		model.addAttribute("pi_id", pi_id);
		return "jsp/emeplan/management/manage_main";
	}
	
	@RequestMapping("/tree2")
	@ResponseBody
	public List<Tree2Vo> tree2() {
		List<Tree2Vo> tree2Vos = eventTypeService.tree2();
		
		for (Tree2Vo tree2Vo : tree2Vos) {
			if (tree2Vo.getChildren()!=null) {
				getTress2(tree2Vo.getChildren());
			}
			
			List<E_PlanInfo> pis = planInfoService.findByProperty("eventType.et_id", tree2Vo.getId());
			List<Tree2Vo> tree2Vos2 = null;
			Tree2Vo tree2Vo2 = null;
			if (pis!=null && pis.size()>0) {
				tree2Vos2 = new ArrayList<Tree2Vo>();
				for (E_PlanInfo pi : pis) {
					tree2Vo2 = new Tree2Vo(pi.getPi_id(),pi.getPi_name());
					tree2Vos2.add(tree2Vo2);
				}
				tree2Vo.setChildren(tree2Vos2);
				
			}
		}
		return tree2Vos;
	}
	private void getTress2(List<Tree2Vo> tree2Vos) {
		for (Tree2Vo tree2Vo : tree2Vos) {
			if (tree2Vo.getChildren()!=null) {
				getTress2(tree2Vo.getChildren());
			}
			
			List<E_PlanInfo> pis = planInfoService.findByProperty("eventType.et_id", tree2Vo.getId());
			List<Tree2Vo> tree2Vos2 = null;
			Tree2Vo tree2Vo2 = null;
			if (pis!=null && pis.size()>0) {
				tree2Vos2 = new ArrayList<Tree2Vo>();
				for (E_PlanInfo pi : pis) {
					tree2Vo2 = new Tree2Vo(pi.getPi_id(),pi.getPi_name());
					tree2Vos2.add(tree2Vo2);
				}
				tree2Vo.setChildren(tree2Vos2);
				
			}
		}
	}
}
