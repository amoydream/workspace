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
import com.lauvan.emergencyplan.entity.E_EmeOrgan;
import com.lauvan.emergencyplan.service.EmeOrganService;
import com.lauvan.emergencyplan.vo.EmeOrganVo;
import com.lauvan.organ.entity.C_Address_Book;
import com.lauvan.organ.service.AddressBookService;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: EmeOrganController 
 * @Description: 应急组织机构
 * @author 钮炜炜
 * @date 2015年12月10日 上午9:02:17
 */
@Controller
@RequestMapping("emeplan/emeOrgan")
public class EmeOrganController extends BaseController {

	@Autowired
	private EmeOrganService emeOrganService;
	@Autowired
	private AddressBookService addressBookService;
	
	@MethodLog(description="应急组织机构查询")
	@RequestMapping("/main")
	public String main(Model model) {
		List<E_EmeOrgan> ms = emeOrganService.getListIsNull("organ");
		if (ms.size()>0) {
			model.addAttribute("pid", ms.get(0).getEo_id());
		}
		return "jsp/emeplan/emeorgan/emeorgan_list";
	}
	
	@MethodLog(description="应急组织机构查询")
	@RequestMapping("/list")
	@ResponseBody
	public List<EmeOrganVo> list(Integer id) {
		List<E_EmeOrgan> ms2 = null;
		if (id==null) {
			List<E_EmeOrgan> ms = emeOrganService.getListIsNull("organ");
			if (ms.size()>0) {
				ms2 = emeOrganService.findByProperty("organ.eo_id", ms.get(0).getEo_id());
			}
		}else {
			ms2 = emeOrganService.findByProperty("organ.eo_id", id);
		}
		List<EmeOrganVo> organVos = null;
		if (ms2!=null) {
			organVos = new ArrayList<EmeOrganVo>();
			EmeOrganVo oVo = null;
			for (E_EmeOrgan o : ms2) {
				oVo = new EmeOrganVo();
				oVo.setEo_id(o.getEo_id());
				oVo.setEo_name(o.getEo_name());
				oVo.setEo_address(o.getEo_address());
				List<C_Address_Book> abs = addressBookService.findByProperty("emeOrgan.eo_id", o.getEo_id());
				for (C_Address_Book ab : abs) {
					if ("1".equals(ab.getBo_type())) {//办公电话
						oVo.setOfficephone(ab.getBo_number());
					}else if ("3".equals(ab.getBo_type())) {//传真
						oVo.setFax(ab.getBo_number());
					}else if ("4".equals(ab.getBo_type())) {//邮箱
						oVo.setEmail(ab.getBo_number());
					}
				}
				organVos.add(oVo);
			}
			
		}
		return organVos;
	}
	
	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo> tree() {
		return emeOrganService.tree();
	}
	
	@RequestMapping("/tree2")
	@ResponseBody
	public List<Tree2Vo> tree2() {
		List<E_EmeOrgan> ms = emeOrganService.getListEntitys();
		List<Tree2Vo> tree2Vos = new ArrayList<Tree2Vo>();
		for (E_EmeOrgan m : ms) {
			tree2Vos.add(new Tree2Vo(m.getEo_id(), m.getOrgan()!=null ? m.getOrgan().getEo_id():null, m.getEo_name()));
		}
		return tree2Vos;
	}
	@RequestMapping("/add")
	@ResponseBody
	public Json add(EmeOrganVo organVo) {
		E_EmeOrgan o = new E_EmeOrgan();
		BeanUtils.copyProperties(organVo, o);
		if (!ValidateUtil.isEmpty(organVo.getPid())) {
			o.setOrgan(new E_EmeOrgan(organVo.getPid()));
		}
		
		try {
			emeOrganService.save(o);
			return json(true, "应急组织机构添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("应急组织机构添加失败");
		}
	}
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			E_EmeOrgan o = emeOrganService.find(id);
			model.addAttribute("emeOrgan", o);
			return "jsp/emeplan/emeorgan/emeorgan_edit";
		}
		return "";
	}
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(EmeOrganVo organVo) {
		if (ValidateUtil.isEmpty(organVo.getEo_id())) {
			return json("应急组织机构ID没有获取到");
		}
		E_EmeOrgan o = emeOrganService.find(organVo.getEo_id());
		BeanUtils.copyProperties(organVo,o);
		try {
			emeOrganService.update(o);
			return json(true, "应急组织机构修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("应急组织机构修改失败");
		}
	}
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			emeOrganService.deleteAll(id);
			return json(true, "应急组织机构删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json(true, "应急组织机构删除失败");
		}
	}
}
