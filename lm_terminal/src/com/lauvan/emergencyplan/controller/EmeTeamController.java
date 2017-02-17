package com.lauvan.emergencyplan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_Eme_Team;
import com.lauvan.emergencyplan.service.EmeTeamService;
import com.lauvan.interceptor.Perm;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: EmeSuppliesController 
 * @Description: 预案应急队伍关联管理
 * @author 钮炜炜
 * @date 2015年12月11日 下午2:40:24
 */
@Controller
@RequestMapping("emeplan/planTeam")
public class EmeTeamController extends BaseController {
	@Autowired
	private EmeTeamService emeTeamService;
	@RequestMapping("/list")
	public String list(Integer pi_id,Model model){
		if (!ValidateUtil.isEmpty(pi_id)) {
			List<E_Eme_Team> etTeams = emeTeamService.findByProperty("pi_id", pi_id);
			model.addAttribute("etTeams", etTeams);
		}
		model.addAttribute("pi_id", pi_id);
		return "jsp/emeplan/management/manage_resource_team";
	}
	@MethodLog(description = "预案队伍添加")
	@Perm(privilegeValue = "planTeamAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(Integer pi_id,String te_Ids) {
		if (!ValidateUtil.isEmpty(pi_id) && !ValidateUtil.isEmpty(te_Ids)) {
			String[] ss = te_Ids.split(",");
			try {
				emeTeamService.addAll(pi_id, ss);
				return json(true, "预案应急队伍关联添加成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("预案应急队伍关联添加失败");
			}
		}
		return json("没做什么操作");
	}
	@MethodLog(description = "预案队伍删除")
	@Perm(privilegeValue = "planTeamdelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer pi_id,Integer id) {
		if (!ValidateUtil.isEmpty(id) && !ValidateUtil.isEmpty(pi_id)) {
			try {
				List<E_Eme_Team> teams = emeTeamService.findByProperty("pi_id", pi_id, "team.te_Id", id);
				for (E_Eme_Team team : teams) {
					emeTeamService.delete(team.getEt_id());
				}
				return json(true, "预案-应急资源-应急队伍删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "预案-应急资源-应急队伍删除失败");
			}
		}
		return json("没做什么操作");
	}
}
