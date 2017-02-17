package com.lauvan.organ.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.organ.entity.C_Position;
import com.lauvan.organ.entity.C_Position_Classification;
import com.lauvan.organ.service.PositionClassificationService;
import com.lauvan.organ.service.PositionService;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/** 
 * ClassName: PositionClassificationController 
 * @Description: 岗位分类
 * @author bob
 *
 */

@Controller
@RequestMapping("work/positionclassification")
public class PositionClassificationController extends BaseController{
	
    @Autowired
	private PositionService positionService;
    @Autowired
    private PositionClassificationService positionClassificationService;
	
	
	@RequestMapping("/main")
	public String main(Model model) {
		List<C_Position_Classification> ms = positionClassificationService.getListIsNull("pid");
		if (ms.size()>0) {
			model.addAttribute("pid", ms.get(0).getPc_id());
		}
		return "jsp/work/positionclassification/positionclassification_list";
	}
	

	@RequestMapping("/list")
	@ResponseBody
	public List<C_Position_Classification> list() {
	List<C_Position_Classification> ms = positionClassificationService.getListEntitys();
	ms.remove(0);
	return ms;
	}
		
	@RequestMapping("/add")
	@ResponseBody
	public Json add(Integer pid,String pc_name) {
		C_Position_Classification pc = new C_Position_Classification();
		if (!ValidateUtil.isEmpty(pid)) {
			pc.setPid(new C_Position_Classification(pid));
		} 
		try {
			pc.setPc_name(pc_name);
			positionClassificationService.save(pc);
			return json(true, "岗位分类添加成功",pc);
		} catch (Exception e) {
			e.printStackTrace();
			return json("岗位分类添加失败");
		}
	}
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			C_Position_Classification pc = positionClassificationService.find(id);
			model.addAttribute("pc", pc);
			return "jsp/work/positionclassification/positionclassification_edit";
		}
		
		return "";
	}
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(Integer pc_id,String pc_name) {
		try {
			C_Position_Classification pc = positionClassificationService.find(pc_id);
			pc.setPc_name(pc_name);
			positionClassificationService.update(pc);
			return json(true, "岗位分类修改成功");
		} catch (Exception e) {
			return json("岗位分类修改失败");
		}
	}
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		
		if (ValidateUtil.isEmpty(id)) {
			return json("岗位分类ID没有获取到");
		}
		try {
	
			C_Position_Classification pc = 
					positionClassificationService.find(id);
			
	       List<C_Position> position = positionService.findByProperty("positionClassification",pc);
	       if(position!=null){
	       for(C_Position p : position){
	    	   
	    	   positionService.delete(p.getP_id());
	       }
	       }
			positionClassificationService.delete(id);
			return json(true, "岗位分类删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json(true, "岗位分类删除失败");
		}
	}
	
	@RequestMapping("/tree2")
	@ResponseBody
	public List<Tree2Vo> tree2() {
		List<C_Position_Classification> ms = positionClassificationService.getListEntitys();
		List<Tree2Vo> tree2Vos = new ArrayList<Tree2Vo>();
		for (C_Position_Classification m : ms) {
			tree2Vos.add(new Tree2Vo(m.getPc_id(),m.getPid()!=null ? m.getPid().getPc_id():null,m.getPc_name()));
		}
		return tree2Vos;
	}
	
	@RequestMapping("/drop")
	@ResponseBody
	public Json drop(String ids,Integer id) {
		if (!ValidateUtil.isEmpty(ids) && !ValidateUtil.isEmpty(id)) {
			String[] oids = ids.split(",");
			try {
				for (String s : oids) {
					C_Position_Classification pc = positionClassificationService.find(Integer.valueOf(s));
					pc.setPid(new C_Position_Classification(id));
					positionClassificationService.update(pc);
				}
				return json(true, "数据更新成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("数据更新发生错误");
			}
			
		}
		return json("节点ID没有获取到，没有做任何操作");
	}
}
