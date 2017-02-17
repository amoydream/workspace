package com.lauvan.emergencyplan.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.emergencyplan.entity.E_EmeOrganPerson;
import com.lauvan.emergencyplan.service.EmeOrganPersonService;
import com.lauvan.organ.entity.C_Address_Book;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.organ.service.AddressBookService;
/**
 * 
 * ClassName: EmeBooksController 
 * @Description: 应急通讯录管理
 * @author 钮炜炜
 * @date 2015年12月2日 上午10:10:35
 */
@Controller
@RequestMapping("emeplan/emeBooks")
public class EmeBooksController extends BaseController {
	@Autowired
	private AddressBookService addressBookService;
	@Autowired
	private EmeOrganPersonService emeOrganPersonService;
	@MethodLog(description="应急通讯录查询")
	@RequestMapping("/main")
	public String main() {
		return "jsp/emeplan/emebooks/emebooks_list";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public List<C_Address_Book> list(Integer eoId) {
		List<C_Address_Book> abs = new ArrayList<C_Address_Book>();
		List<C_Address_Book> abs1 = addressBookService.findByProperty("emeOrgan.eo_id", eoId,"bo_usertype","3");
		abs.addAll(abs1);
		List<E_EmeOrganPerson> eops = emeOrganPersonService.findByProperty("organ.eo_id", eoId);
		for (E_EmeOrganPerson eop : eops) {
			C_Organ_Person op = eop.getPerson();
			List<C_Address_Book> abs2 = addressBookService.findByProperty("person.pe_id", op.getPe_id());
			abs.addAll(abs2);
		}
		return abs;
	}
}
