package com.lauvan.organ.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Position;
import com.lauvan.organ.entity.C_Position_Classification;
import com.lauvan.organ.service.PositionClassificationService;
import com.lauvan.organ.service.PositionService;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

/**
 * ClassName: PositionController
 * 
 * @Description: 岗位名称
 * @author bob
 *
 */

@Controller
@RequestMapping("work/position")
public class PositionController extends BaseController {
	@Autowired
	private PositionService positionService;
	@Autowired
	private PositionClassificationService positionClassificationService;

	@MethodLog(description = "岗位名称查询")
	@RequestMapping("/list")
	@ResponseBody
	public List<C_Position> list(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			List<C_Position> ms = positionService.findByProperty(
					"positionClassification.pc_id", id);
			return ms;

		}
		return null;
	}

	@MethodLog(description="岗位添加")
	@Perm(privilegeValue="positionAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(Integer id, C_Position position) {
		if (!ValidateUtil.isEmpty(id)) {
			position.setPositionClassification(new C_Position_Classification(id));
			positionService.save(position);
			return json(true, "岗位名称添加成功", position);
		}
		return json("岗位名称添加失败");
	}
	@MethodLog(description="岗位修改UI")
	@Perm(privilegeValue="positionEditip")
	@RequestMapping("/editip")
	public String editip(Integer id, Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			C_Position position = positionService.find(id);
			model.addAttribute("posiclass", position.getPositionClassification());
			model.addAttribute("position", position);
			return "jsp/work/position/position_edit";
		}

		return "";
	}
	@MethodLog(description="岗位修改")
	@Perm(privilegeValue="positionEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(Integer p_id,Integer pc_id, String p_name) {

		if (ValidateUtil.isEmpty(p_id)) {
			return json("岗位ID没有获取到");
		}
		if (ValidateUtil.isEmpty(pc_id)) {
			return json("岗位分类ID没有获取到");
		}

		C_Position position = positionService.find(p_id);
		position.setP_name(p_name);
		position.setPositionClassification(new C_Position_Classification(pc_id));
		try {
			positionService.update(position);
			return json(true, "岗位名称修改成功", position);
		} catch (Exception e) {
			return json("岗位名称修改失败");
		}
	}
	@MethodLog(description="岗位删除")
	@Perm(privilegeValue="positionDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			positionService.delete(id);
			return json(true, "岗位名称删除成功");
		} catch (Exception e) {
			return json("岗位名称删除失败");
		}
	}

}
