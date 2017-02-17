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
import com.lauvan.emergencyplan.entity.E_Action_Department;
import com.lauvan.emergencyplan.entity.E_Action_List;
import com.lauvan.emergencyplan.entity.E_Disposal_Stage;
import com.lauvan.emergencyplan.service.ActionDepartmentService;
import com.lauvan.emergencyplan.service.ActionListService;
import com.lauvan.emergencyplan.service.DisposalStageService;
import com.lauvan.emergencyplan.vo.DisposalStageVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: DisposalStageController 
 * @Description: 预案应急处置-处置阶段流程
 * @author 钮炜炜
 * @date 2016年1月15日 下午2:09:52
 */
@Controller
@RequestMapping("emeplan/disposalStage")
public class DisposalStageController extends BaseController {

	@Autowired
	private DisposalStageService disposalStageService;
	@Autowired
	private ActionListService actionListService;
	@Autowired
	private ActionDepartmentService actionDepartmentService;
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo> tree(Integer pi_id) {
		//流程阶段1
		List<E_Disposal_Stage> dss = disposalStageService.getListIsNull("pi_id", pi_id, "dStage");
		List<TreeVo> treeVos = null;
		if (dss.size()>0) {
			treeVos = new ArrayList<TreeVo>();
			TreeVo treeVo = null;
			for (E_Disposal_Stage ds : dss) {
				treeVo = new TreeVo(ds.getEds_name(), ds.getEds_id().toString());
				//流程阶段2
				List<E_Disposal_Stage> dss2 = disposalStageService.findByProperty("dStage.eds_id", ds.getEds_id());
				if (dss2.size()>0) {
					List<TreeVo> treeVos2 = new ArrayList<TreeVo>();
					TreeVo treeVo2 = null;
					for (E_Disposal_Stage ds2 : dss2) {
						treeVo2 = new TreeVo(ds2.getEds_name(), ds2.getEds_id().toString());
						//行动清单
						List<E_Action_List> als = actionListService.findByProperty("dStage.eds_id", ds2.getEds_id());
						if (als.size()>0) {
							List<TreeVo> treeVos3 = new ArrayList<TreeVo>();
							TreeVo treeVo3 = null;
							for (E_Action_List al : als) {
								treeVo3 = new TreeVo(al.getEal_name(), al.getEal_id().toString());
								treeVos3.add(treeVo3);
							}
							treeVo2.setNodes(treeVos3);
						}
						treeVos2.add(treeVo2);
					}
					treeVo.setNodes(treeVos2);
				}
				treeVos.add(treeVo);
			}
		}
		return treeVos;
	}
	@RequestMapping("/tree2")
	@ResponseBody
	public List<Tree2Vo> tree2(Integer pi_id) {
		//流程阶段1
		List<E_Disposal_Stage> dss = disposalStageService.getListIsNull("pi_id", pi_id, "dStage");
		List<Tree2Vo> treeVos = new ArrayList<Tree2Vo>();
		treeVos.add(new Tree2Vo(null, 0, "应急处置"));
		if (dss.size()>0) {
			Tree2Vo treeVo = null;
			for (E_Disposal_Stage ds : dss) {
				treeVo = new Tree2Vo(ds.getEds_id(), null,ds.getEds_name());
				treeVos.add(treeVo);
				//流程阶段2
				List<E_Disposal_Stage> dss2 = disposalStageService.findByProperty("dStage.eds_id", ds.getEds_id());
				if (dss2.size()>0) {
					for (E_Disposal_Stage ds2 : dss2) {
						treeVo = new Tree2Vo(ds2.getEds_id(), ds.getEds_id(),ds2.getEds_name());
						treeVos.add(treeVo);
						//行动清单
						List<E_Action_List> als = actionListService.findByProperty("dStage.eds_id", ds2.getEds_id());
						if (als.size()>0) {
							for (E_Action_List al : als) {
								treeVo = new Tree2Vo(al.getEal_id(), ds2.getEds_id(),al.getEal_name());
								treeVos.add(treeVo);
							}
						}
					}
				}
			}
		}
		return treeVos;
	}
	@RequestMapping("/list")
	@ResponseBody
	public List<E_Disposal_Stage> list(Integer pi_id,Integer eds_id) {
		if (!ValidateUtil.isEmpty(pi_id)) {
			return disposalStageService.getListIsNull("pi_id", pi_id, "dStage");
		}else if (!ValidateUtil.isEmpty(eds_id)) {
			return disposalStageService.findByProperty("dStage.eds_id", eds_id);
		}
		return null;
	}
	@MethodLog(description = "处置流程添加")
	@Perm(privilegeValue = "disposalStageAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(DisposalStageVo disposalStageVo) {
		E_Disposal_Stage eds = new E_Disposal_Stage();
		BeanUtils.copyProperties(disposalStageVo, eds);
		eds.setEds_id(((Integer)disposalStageService.getMax("eds_id"))+1);
		if (!ValidateUtil.isEmpty(disposalStageVo.getPi_id())) {
			eds.setPi_id(disposalStageVo.getPi_id());
		}
		if (!ValidateUtil.isEmpty(disposalStageVo.getEds_pid())) {
			eds.setdStage(new E_Disposal_Stage(disposalStageVo.getEds_pid()));
		}
		try {
			disposalStageService.save(eds);
			return json(true, "预案应急处置阶段流程添加成功",eds);
		} catch (Exception e) {
			e.printStackTrace();
			return json(true, "预案应急处置阶段流程添加失败");
		}
	}
	@MethodLog(description = "处置流程修改UI")
	@Perm(privilegeValue = "disposalStageEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			E_Disposal_Stage disposal_Stage = disposalStageService.find(id);
			model.addAttribute("disposal_Stage", disposal_Stage);
			return "jsp/emeplan/disposalStage/disposalStage_edit";
		}
		return null;
	}
	@MethodLog(description = "处置流程修改")
	@Perm(privilegeValue = "disposalStageEdit")
	@ResponseBody
	@RequestMapping("/edit")
	public Json edit(DisposalStageVo disposalStageVo) {
		if (ValidateUtil.isEmpty(disposalStageVo.getEds_id())) {
			return json("预案应急处置阶段流程ID没有获取到");
		}
		E_Disposal_Stage ds = disposalStageService.find(disposalStageVo.getEds_id());
		ds.setEds_index(disposalStageVo.getEds_index());
		ds.setEds_name(disposalStageVo.getEds_name());
		ds.setEds_remark(disposalStageVo.getEds_remark());
		ds.setEds_task(disposalStageVo.getEds_task());
		try {
			disposalStageService.update(ds);
			return json(true, "预案应急处置阶段流程修改成功",ds);
		} catch (Exception e) {
			e.printStackTrace();
			return json("预案应急处置阶段流程修改失败");
		}
	}
	/**
	 * 删除流程，同时删除流程的所有关联
	 * @param id
	 * @param level
	 * @return
	 */
	@MethodLog(description = "处置流程删除")
	@Perm(privilegeValue = "disposalStageDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id,Integer level) {
		if (!ValidateUtil.isEmpty(id) && (level!=null && level>=0)) {
			List<E_Disposal_Stage> dss = null;
			List<E_Action_List> als = null;
			List<E_Action_List> action_Lists = null;
			List<E_Action_Department> action_Departments = null;
			//判断流程树的级别：0：有两层流程需要查询删除；1：表示有一层流程需要查询删除
			if (level==0) {
				dss = disposalStageService.findByProperty("dStage.eds_id", id);
				if (dss.size()>0) {
					als = new ArrayList<E_Action_List>();
					for (E_Disposal_Stage ds : dss) {
						als.addAll(actionListService.findByProperty("dStage.eds_id", ds.getEds_id()));
					}
				}
			}else if (level==1) {
				als = actionListService.findByProperty("dStage.eds_id", id);
			}
			//查询并删除流程下面的所有行动和行动人员
			if (als !=null && als.size()>0) {
				action_Lists = new ArrayList<E_Action_List>();
				action_Lists.addAll(als);
				for (E_Action_List al : als) {
					List<E_Action_Department> ads = actionDepartmentService.findByProperty("eal_id", al.getEal_id());
					if (ads.size()>0) {
						action_Departments = new ArrayList<E_Action_Department>();
						action_Departments.addAll(ads);
					}
				}
			}
			try {
				disposalStageService.deleteAll(id, dss, action_Lists, action_Departments);
				return json(true, "预案应急处置阶段流程删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("预案应急处置阶段流程删除失败");
			}
		}
		return json("没有做什么处理");
	}
}
