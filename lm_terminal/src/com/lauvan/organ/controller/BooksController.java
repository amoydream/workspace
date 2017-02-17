package com.lauvan.organ.controller;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Address_Book;
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.organ.entity.T_Contact_Group;
import com.lauvan.organ.entity.V_Contact;
import com.lauvan.organ.service.AddressBookService;
import com.lauvan.organ.service.ContactGroupService;
import com.lauvan.organ.service.ContactService;
import com.lauvan.organ.service.OrganPersonService;
import com.lauvan.organ.service.PositionService;
import com.lauvan.organ.vo.AddressBookVo;
import com.lauvan.organ.vo.ContactVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

/**
 * ClassName: BooksController
 *
 * @Description: 通讯录管理
 * @author 钮炜炜
 * @date 2015年12月2日 上午10:10:35
 */
@Controller
@RequestMapping("work/books")
public class BooksController extends BaseController {
	@Autowired
	private ContactService		contactService;
	@Autowired
	private ContactGroupService	contactGroupService;
	@Autowired
	private AddressBookService	addressBookService;
	@Autowired
	private OrganPersonService	organPersonService;
	@Autowired
	private PositionService		positionService;

	@MethodLog(description = "通讯录查询")
	@RequestMapping("/main")
	public String main() {
		return "jsp/work/books/books_list";
	}

	@RequestMapping("/mainSelect")
	public String mainSelect() {
		return "jsp/work/books/books_select";
	}

	@MethodLog(description = "通讯录添加")
	@Perm(privilegeValue = "booksAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(AddressBookVo aBookVo) {
		C_Address_Book ab = new C_Address_Book();
		BeanUtils.copyProperties(aBookVo, ab);
		String bo_type = ab.getBo_type();
		String bo_usertype = ab.getBo_usertype();
		String sql = " from C_Address_Book where 1=1";
		List<C_Address_Book> bos = null;
		C_Address_Book b = null;
		if(bo_type != null) {
			sql += " and bo_type='" + bo_type + "'";
		}
		if(bo_usertype != null) {
			sql += " and bo_usertype='" + bo_usertype + "'";
		}

		if(!ValidateUtil.isEmpty(aBookVo.getOrid())) {
			sql += " and or_id='" + aBookVo.getOrid() + "'";
		} else if(!ValidateUtil.isEmpty(aBookVo.getPid())) {
			sql += " and pe_id='" + aBookVo.getPid() + "'";
		}

		bos = addressBookService.getResultList(sql);
		if(bos != null && bos.size() > 0) {
			b = bos.get(0);
		}

		if(b != null) {
			try {
				b.setBo_index(ab.getBo_index());
				b.setBo_number(ab.getBo_number());
				b.setBo_state(ab.getBo_state());
				b.setBo_remark(ab.getBo_remark());
				addressBookService.update(b);
				return json(true, "通讯录修改成功");
			} catch(Exception e) {
				e.printStackTrace();
				return json("通讯录修改失败");
			}
		} else {
			try {
				if(!ValidateUtil.isEmpty(aBookVo.getOrid())) {// 单位
					ab.setOrgan(new C_Organ(aBookVo.getOrid()));
					ab.setBo_usertype("2");
				}
				if(!ValidateUtil.isEmpty(aBookVo.getPid())) {// 个人
					C_Organ_Person op = organPersonService.find(aBookVo.getPid());
					if(op != null) {
						ab.setPerson(op);
						ab.setBo_usertype("1");
					} else {
						return json("没有获取到机构人员的信息");
					}
				}
				addressBookService.save(ab);
				return json(true, "通讯录添加成功");
			} catch(Exception e) {
				e.printStackTrace();
				return json("通讯录添加失败");
			}
		}
	}

	@RequestMapping("/list")
	@ResponseBody
	public Json list(ContactVo vo) {
		try {
			if(vo == null) {
				vo = new ContactVo();
			}
			if(vo.getPage() == null || vo.getPage() < 1) {
				vo.setPage(1);
			}
			if(vo.getRows() < 1) {
				vo.setRows(12);
			}
			PageView<ContactVo> pageView = new PageView<>(vo.getRows(), vo.getPage());
			if(!StringUtils.isEmpty(vo.getGroup_id())) {
				T_Contact_Group g = contactGroupService.find(vo.getGroup_id());
				if(g != null) {
					vo.setContactIds(g.getContactIds());
				}
			}
			QueryResult<ContactVo> result = contactService.getContacts(vo);
			List<ContactVo> voList = result.getResultlist();
			for(ContactVo c : voList) {
				c.setP_names(positionService.getPositionNames(c.getPe_poids()));
			}

			pageView.setQueryResult(result);

			return json(true, "", pageView);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		}
	}

	/**
	 * 根据组织查询通讯录
	 */
	@RequestMapping("/list3")
	@ResponseBody
	public List<ContactVo> list3(Integer orId, Integer page) {
		if(!ValidateUtil.isEmpty(orId)) {
			ContactVo cv = new ContactVo();
			cv.setOr_id(orId);
			cv.setPage(page);
			cv.setRows(15);
			List<ContactVo> voList = contactService.getContactPage(cv);
			for(ContactVo vo : voList) {
				vo.setP_names(positionService.getPositionNames(vo.getPe_poids()));
			}
			return voList;
		}
		return null;
	}

	@MethodLog(description = "通讯录修改UI")
	@Perm(privilegeValue = "booksEditip")
	@RequestMapping("/editip")
	public String editip(Integer id, Model model) {
		if(!ValidateUtil.isEmpty(id)) {
			C_Address_Book ab = addressBookService.find(id);
			model.addAttribute("books", ab);
			return "jsp/work/books/books_edit";
		}
		return "";
	}

	@MethodLog(description = "通讯录修改")
	@Perm(privilegeValue = "booksEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(AddressBookVo abVo) {
		if(ValidateUtil.isEmpty(abVo.getBo_id())) {
			return json("通讯录ID没有获取到");
		}
		C_Address_Book ab = addressBookService.find(abVo.getBo_id());
		BeanUtils.copyProperties(abVo, ab);
		try {
			addressBookService.update(ab);
			return json(true, "通讯录修改成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("通讯录修改失败");
		}
	}

	@MethodLog(description = "通讯录删除")
	@Perm(privilegeValue = "booksDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(String contact_id) {
		if(!ValidateUtil.isEmpty(contact_id)) {
			try {
				V_Contact c = contactService.getContactById(contact_id);
				if(c != null) {
					Integer bo_id_1 = c.getBo_id_1();
					if(bo_id_1 != null) {
						addressBookService.delete(bo_id_1);
					}
					Integer bo_id_2 = c.getBo_id_2();
					if(bo_id_2 != null) {
						addressBookService.delete(bo_id_2);
					}
					Integer bo_id_3 = c.getBo_id_3();
					if(bo_id_3 != null) {
						addressBookService.delete(bo_id_3);
					}
					Integer bo_id_4 = c.getBo_id_4();
					if(bo_id_4 != null) {
						addressBookService.delete(bo_id_4);
					}
					Integer bo_id_5 = c.getBo_id_5();
					if(bo_id_5 != null) {
						addressBookService.delete(bo_id_5);
					}

					return json(true, "通讯录删除成功");
				}
			} catch(Exception e) {
				e.printStackTrace();
				return json("通讯录删除失败");
			}
		}
		return json("没有做任何处理");
	}

	@RequestMapping("/saveGroup")
	@ResponseBody
	public Json saveGroup(Integer id, String name) {
		try {
			T_Contact_Group group = null;
			if(id != null) {
				group = contactGroupService.find(id);
			}
			if(group == null) {
				group = new T_Contact_Group();
			}
			group.setName(name);
			if(StringUtils.isEmpty(name)) {
				return json(false, "分组名不能为空");
			}
			contactGroupService.save(group);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, e.getMessage());
		}
		return json(true, "");
	}

	@RequestMapping("/get")
	@ResponseBody
	public Json get(Integer pe_id, Integer or_id, String bo_type, String bo_usertype) {
		C_Address_Book b = null;
		try {
			String sql = " from C_Address_Book where 1=1";

			if(or_id != null) {
				sql += " and or_id=" + or_id;
			}

			if(bo_type != null) {
				sql += " and bo_type='" + bo_type + "'";
			}

			if(bo_usertype != null) {
				if(bo_usertype.equals("1")) {
					if(pe_id != null) {
						sql += " and pe_id=" + pe_id;
					}
				}

				sql += " and bo_usertype='" + bo_usertype + "'";
			}

			List<C_Address_Book> list = addressBookService.getResultList(sql);
			if(list != null && list.size() > 0) {
				b = list.get(0);
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, e.getMessage());
		}

		return json(b == null ? false : true, "", b);
	}
}
