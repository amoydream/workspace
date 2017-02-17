package com.lauvan.emergencyplan.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_Plan_Organ;
import com.lauvan.emergencyplan.entity.E_Plan_Organ_Id;
import com.lauvan.emergencyplan.entity.E_Plan_Person;
import com.lauvan.emergencyplan.service.PlanOrganService;
import com.lauvan.emergencyplan.service.PlanPersonService;
import com.lauvan.emergencyplan.vo.ManageOrganPersonVo;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.organ.service.OrganService;
import com.lauvan.organ.service.PositionService;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: PlanOrganController 
 * @Description: 应急预案机构人员管理
 * @author 钮炜炜
 * @date 2015年12月10日 下午5:45:49
 */
@Controller
@RequestMapping("emeplan/planOrgan")
public class PlanOrganController extends BaseController {

	@Autowired
	private PlanOrganService planOrganService;
	@Autowired
	private PlanPersonService planPersonService;
	@Autowired
	private OrganService organService;
	@Autowired
	private PositionService positionService;
	
	@RequestMapping("/tree2")
	@ResponseBody
	public List<Tree2Vo> tree2(Integer pi_id) {
		List<E_Plan_Organ> pos = planOrganService.findByProperty("id.pi_id", pi_id);
		List<Tree2Vo> treeVos = new ArrayList<Tree2Vo>();
		treeVos.add(new Tree2Vo(null, 0, "应急机构"));
		
		Tree2Vo treeVo = null;
		for (E_Plan_Organ po : pos) {
			treeVo = new Tree2Vo();
			C_Organ organ = organService.find(po.getId().getOr_id());
			
			treeVo.setId(po.getId().getOr_id());
			treeVo.setName(organ.getOr_name());
			treeVo.setpId(po.getPor_id());
			
			treeVos.add(treeVo);
		}
		return treeVos;
	}
	

	@RequestMapping("/list")
	@ResponseBody
	public List<ManageOrganPersonVo> list(Integer pi_id,Integer or_id) {
		if (!ValidateUtil.isEmpty(pi_id)) {
			List<ManageOrganPersonVo> mops = null;
			List<E_Plan_Organ> pos = null;
			if (or_id==null) {
				pos = planOrganService.getListIsNull("id.pi_id", pi_id, "por_id");
			}else {
				pos = planOrganService.findByProperty("id.pi_id",pi_id,"por_id", or_id);
			}
			
			if (pos!=null) {
				mops = new ArrayList<ManageOrganPersonVo>();
				ManageOrganPersonVo mop = null;
				for (E_Plan_Organ po2 : pos) {
					mop = new ManageOrganPersonVo();
					C_Organ organ = organService.find(po2.getId().getOr_id());
					mop.setEoId(organ.getOr_id());
					mop.setName(organ.getOr_name());
					mops.add(mop);
				}
			}
			
			List<E_Plan_Person> pps = planPersonService.findByProperty("pi_id", pi_id, "or_id", or_id);
			if (pps.size()>0) {
				mops = new ArrayList<ManageOrganPersonVo>();
				ManageOrganPersonVo mop = null;
				for (E_Plan_Person pp : pps) {
					mop = new ManageOrganPersonVo();
					mop.setEppId(pp.getOrganPerson().getPe_id());
					mop.setName(pp.getOrganPerson().getPe_name());
//					mop.setJob(pp.getOrganPerson().getPosition()!=null ? pp.getOrganPerson().getPosition().getP_name():null);
					if (!ValidateUtil.isEmpty(pp.getOrganPerson().getPe_poids())) {
						mop.setJob(positionService.getPositionNames(pp.getOrganPerson().getPe_poids()));
					}
					mop.setEoId(pp.getOr_id());
					mop.setPp_id(pp.getPp_id());
					mops.add(mop);
				}
			}
			
			return mops;
		}
		return null;
	}
	/**
	 * 添加机构
	 * @param pi_id
	 * @param or_Ids
	 * @param pid
	 * @return
	 */
	@MethodLog(description = "预案机构添加")
	@Perm(privilegeValue = "planOrganAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(Integer pi_id,String or_Ids,Integer pid) {
		if (ValidateUtil.isEmpty(pi_id)) {
			return json("预案ID没有获取到");
		}
		if (!ValidateUtil.isEmpty(or_Ids)) {
			String[] eoIds = or_Ids.split(",");
			List<E_Plan_Organ> pos = new ArrayList<E_Plan_Organ>();
			E_Plan_Organ po = null;
			for (String s : eoIds) {
				po = new E_Plan_Organ();
				po.setId(new E_Plan_Organ_Id(pi_id, Integer.valueOf(s)));
				if (!ValidateUtil.isEmpty(pid)) {
					po.setPor_id(pid);
				}
				pos.add(po);
			}
			try {
				planOrganService.add(pos);
				return json(true, "应急机构添加成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("应急机构添加失败");
			}
		}
		return json("没做什么处理");
	}
	/**
	 * 添加机构人员
	 * @param pi_id
	 * @param pe_Ids
	 * @param pid
	 * @return
	 */
	@MethodLog(description = "预案机构人员添加")
	@Perm(privilegeValue = "planOrganPersonAdd")
	@RequestMapping("/addPerson")
	@ResponseBody
	public Json addPerson(Integer pi_id,String pe_Ids,Integer pid) {
		if (ValidateUtil.isEmpty(pi_id)) {
			return json("预案ID没有获取到");
		}
		if (ValidateUtil.isEmpty(pid)) {
			return json("机构ID没有获取到");
		}
		if (!ValidateUtil.isEmpty(pe_Ids)) {
			String[] peIds = pe_Ids.split(",");
			List<E_Plan_Person> pos = new ArrayList<E_Plan_Person>();
			E_Plan_Person po = null;
			for (String s : peIds) {
				po = new E_Plan_Person();
				po.setOr_id(pid);
				po.setOrganPerson(new C_Organ_Person(Integer.valueOf(s)));
				po.setPi_id(pi_id);
				pos.add(po);
			}
			try {
				planPersonService.addAll(pos);
				return json(true, "应急机构人员添加成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("应急机构人员添加失败");
			}
		}
		return json("没做什么处理");
	}
	@MethodLog(description = "预案机构删除")
	@Perm(privilegeValue = "planOrganDelete")
	@RequestMapping("/deleteOrgan")
	@ResponseBody
	public Json deleteOrgan(Integer pi_id,Integer or_Id) {
		if (!ValidateUtil.isEmpty(pi_id) && !ValidateUtil.isEmpty(or_Id)) {
			try {
				planOrganService.deleteAll(pi_id,or_Id);
				return json(true, "应急机构删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("应急机构删除失败");
			}
		}
		return json("没有做任何操作");
	}
	@MethodLog(description = "预案机构人员删除")
	@Perm(privilegeValue = "planOrganPersonDelete")
	@RequestMapping("/deletePerson")
	@ResponseBody
	public Json deletePerson(Integer pp_id) {
		if(!ValidateUtil.isEmpty(pp_id)){
			try {
				planPersonService.delete(pp_id);
				return json(true, "应急机构人员删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("应急机构人员删除失败");
			}
		}
		return json("没有做任何操作");
	}
}
