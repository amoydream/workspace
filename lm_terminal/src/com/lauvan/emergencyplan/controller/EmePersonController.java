package com.lauvan.emergencyplan.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_EmeOrgan;
import com.lauvan.emergencyplan.entity.E_EmeOrganPerson;
import com.lauvan.emergencyplan.service.EmeOrganPersonService;
import com.lauvan.organ.entity.C_Address_Book;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.organ.service.AddressBookService;
import com.lauvan.organ.vo.OrganPersonVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

/**
 * 
 * ClassName: EmePersonController
 * 
 * @Description: 应急机构人员管理
 * @author 钮炜炜
 * @date 2015年12月1日 下午4:17:31
 */
@Controller
@RequestMapping("emeplan/emePerson")
public class EmePersonController extends BaseController {

	@Autowired
	private EmeOrganPersonService emeOrganPersonService;
	@Autowired
	private AddressBookService	addressBookService;
	
	@MethodLog(description = "应急机构人员查询")
	@RequestMapping("/main")
	public String main() {
		return "jsp/emeplan/emeperson/emeperson_list";
	}
	@RequestMapping("/list")
	@ResponseBody
	public List<OrganPersonVo> list(Integer eoId) {
		List<E_EmeOrganPerson> eops = emeOrganPersonService.findByProperty("organ.eo_id", eoId);
		
		List<OrganPersonVo> opVos = null;
		OrganPersonVo opVo = null;
		opVos = new ArrayList<OrganPersonVo>();
		for (E_EmeOrganPerson op : eops) {
			opVo = new OrganPersonVo();
			BeanUtils.copyProperties(op.getPerson(), opVo);
			List<C_Address_Book> abs = addressBookService.findByProperty(
					"person.pe_id", op.getPerson().getPe_id());
			for (C_Address_Book ab : abs) {
				if ("1".equals(ab.getBo_type())) {// 办公电话
					opVo.setOfficephone(ab.getBo_number());
				} else if ("2".equals(ab.getBo_type())) {// 手机
					opVo.setMobilephone(ab.getBo_number());
				} else if ("5".equals(ab.getBo_type())) {// 住宅电话
					opVo.setHomephone(ab.getBo_number());
				} else if ("4".equals(ab.getBo_type())) {// 邮箱
					opVo.setEmail(ab.getBo_number());
				}
			}
			opVos.add(opVo);
		}
		return opVos;
	}

	@RequestMapping("/add")
	@ResponseBody
	public Json add(Integer eoId, String su_Ids) {
		if (!ValidateUtil.isEmpty(eoId) && !ValidateUtil.isEmpty(su_Ids)) {
			String[] ss = su_Ids.split(",");
			List<E_EmeOrganPerson> eops = new ArrayList<E_EmeOrganPerson>();
			E_EmeOrganPerson eop = null;
			for (int i = 0; i < ss.length; i++) {
				eop = new E_EmeOrganPerson();
				eop.setOrgan(new E_EmeOrgan(eoId));
				eop.setPerson(new C_Organ_Person(Integer.valueOf(ss[i])));
				eops.add(eop);
			}
			try {
				emeOrganPersonService.addAll(eops);
				return json(true, "应急机构人员添加成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json(true, "应急机构人员添加失败");
			}
		}
		return json("没做什么操作");
	}
}
