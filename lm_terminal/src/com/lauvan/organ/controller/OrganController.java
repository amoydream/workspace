package com.lauvan.organ.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.base.vo.PageView;
import com.lauvan.base.vo.QueryResult;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Address_Book;
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.organ.service.AddressBookService;
import com.lauvan.organ.service.OrganPersonService;
import com.lauvan.organ.service.OrganService;
import com.lauvan.organ.vo.OrganVo;
import com.lauvan.resource.entity.R_Expert;
import com.lauvan.resource.entity.R_Expert_Type;
import com.lauvan.system.vo.Tree2Vo;
import com.lauvan.system.vo.TreeVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
import com.sun.javafx.collections.MappingChange.Map;

/**
 * ClassName: OrganController
 * 
 * @Description: 组织机构管理
 * @author 钮炜炜
 * @date 2015年12月1日 上午10:20:21
 */
@Controller
@RequestMapping("work/organ")
public class OrganController extends BaseController {

	@Autowired
	private OrganService		organService;
	@Autowired
	private OrganPersonService	organPersonService;
	@Autowired
	private AddressBookService	addressBookService;

	@RequestMapping("/main")
	public String main(Model model) {
		List<C_Organ> ms = organService.getListNullParent();
		if(ms.size() > 0) {
			model.addAttribute("pid", ms.get(0).getOr_id());
		}
		return "jsp/work/organ/organ_list";
	}

	@RequestMapping("/ememain")
	public String ememain(Model model) {
		List<C_Organ> ms = organService.getListNullParent();
		if(ms.size() > 0) {
			model.addAttribute("pid", ms.get(0).getOr_id());
		}
		return "jsp/work/organ/organ_emelist";
	}

	@RequestMapping("/list")
	@ResponseBody
	public List<OrganVo> list(Integer id) {
		List<C_Organ> ms2 = null;
		if(id == null) {
			List<C_Organ> ms = organService.getListNullParent();
			if(ms.size() > 0) {
				ms2 = organService.findByPid(id);
			}
		} else {
			ms2 = organService.findByPid(id);
		}
		List<OrganVo> organVos = null;
		if(ms2 != null) {
			organVos = new ArrayList<OrganVo>();
			OrganVo oVo = null;
			for(C_Organ o : ms2) {
				oVo = new OrganVo();
				oVo.setOr_id(o.getOr_id());
				oVo.setOr_name(o.getOr_name());
				oVo.setOr_address(o.getOr_address());
				oVo.setOr_type(o.getOr_type());
				oVo.setOr_sort(o.getOr_sort());
				oVo.setOr_sort_old(o.getOr_sort());
				//List<C_Address_Book> abs = addressBookService.findByProperty("organ.or_id", o.getOr_id());
				List<C_Address_Book> abs = addressBookService.getResultList(" from C_Address_Book where bo_usertype='2' and or_id=" + o.getOr_id());
				for(C_Address_Book ab : abs) {
					if("1".equals(ab.getBo_type())) {// 办公电话
						oVo.setOfficephone(ab.getBo_number());
					} else if("3".equals(ab.getBo_type())) {// 传真
						oVo.setFax(ab.getBo_number());
					} else if("4".equals(ab.getBo_type())) {// 邮箱
						oVo.setEmail(ab.getBo_number());
					}
				}
				organVos.add(oVo);
			}

		}
		return organVos;
	}

	@RequestMapping("/search")
	@ResponseBody
	public Json search(OrganVo vo) {
		try {
			if(vo == null) {
				vo = new OrganVo();
			}
			if(vo.getPage() == null || vo.getPage() < 1) {
				vo.setPage(1);
			}
			if(vo.getRows() < 1) {
				vo.setRows(12);
			}

			PageView<OrganVo> pageView = new PageView<OrganVo>(vo.getRows(), vo.getPage());
			QueryResult<C_Organ> result = organService.getOrganPage(vo);
			List<C_Organ> vList = result.getResultlist();
			List<OrganVo> voList = new ArrayList<OrganVo>();
			if(result != null) {
				OrganVo oVo = null;
				for(C_Organ o : vList) {
					oVo = new OrganVo();
					oVo.setOr_id(o.getOr_id());
					oVo.setOr_name(o.getOr_name());
					oVo.setOr_address(o.getOr_address());
					oVo.setOr_type(o.getOr_type());
					oVo.setOr_sort(o.getOr_sort());
					oVo.setOr_sort_old(o.getOr_sort());
					//List<C_Address_Book> abs = addressBookService.findByProperty("organ.or_id", o.getOr_id());
					List<C_Address_Book> abs = addressBookService.getResultList(" from C_Address_Book where bo_usertype='2' and or_id=" + o.getOr_id());
					for(C_Address_Book ab : abs) {
						if("1".equals(ab.getBo_type())) {// 办公电话
							oVo.setOfficephone(ab.getBo_number());
						} else if("3".equals(ab.getBo_type())) {// 传真
							oVo.setFax(ab.getBo_number());
						} else if("4".equals(ab.getBo_type())) {// 邮箱
							oVo.setEmail(ab.getBo_number());
						}
					}
					voList.add(oVo);
				}
			}
			QueryResult<OrganVo> qr = new QueryResult<>();
			qr.setResultlist(voList);
			qr.setTotalrecord(result.getTotalrecord());
			pageView.setQueryResult(qr);

			return json(true, "", pageView);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		}
	}

	@RequestMapping("/tree")
	@ResponseBody
	public List<TreeVo> tree() {
		return organService.tree();
	}

	@MethodLog(description = "组织机构添加")
	@Perm(privilegeValue = "organAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(OrganVo organVo) {
		C_Organ o = new C_Organ();
		if(organVo.getOr_sort() == 0) {
			organVo.setOr_sort(100);
		}
		BeanUtils.copyProperties(organVo, o);
		if(!ValidateUtil.isEmpty(organVo.getPid())) {
			o.setOrgan(new C_Organ(organVo.getPid()));
		}

		try {
			organService.save(o);
			return json(true, "组织机构添加成功", o);
		} catch(Exception e) {
			e.printStackTrace();
			return json("组织机构添加失败");
		}
	}

	@MethodLog(description = "组织机构修改UI")
	@Perm(privilegeValue = "organEditip")
	@RequestMapping("/editip")
	public String editip(Integer id, Model model) {
		if(!ValidateUtil.isEmpty(id)) {
			C_Organ o = organService.find(id);
			OrganVo organVo = new OrganVo();
			organVo.setOr_sort_old(o.getOr_sort());
			BeanUtils.copyProperties(o, organVo);
			model.addAttribute("organ", organVo);
			return "jsp/work/organ/organ_edit";
		}
		return "";
	}

	@MethodLog(description = "组织机构修改")
	@Perm(privilegeValue = "organEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(OrganVo organVo) {
		if(ValidateUtil.isEmpty(organVo.getOr_id())) {
			return json("组织机构ID没有获取到");
		}
		C_Organ o = organService.find(organVo.getOr_id());
		if(organVo.getOr_sort() == 0) {
			organVo.setOr_sort(organVo.getOr_sort_old());
		}
		BeanUtils.copyProperties(organVo, o);
		try {
			organService.update(o);
			return json(true, "组织机构修改成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("组织机构修改失败");
		}
	}

	@MethodLog(description = "组织机构删除")
	@Perm(privilegeValue = "organDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		try {
			//删除当前节点的bumen通讯录
			List<C_Address_Book> book = addressBookService.findByProperty("organ.or_id", id, "bo_usertype", "2");
			for(C_Address_Book b : book) {
				addressBookService.delete(b.getBo_id());
			}
			organService.deleteAll(id);
			return json(true, "组织机构删除成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json(true, "组织机构删除失败,请先删除下属部门和下属人员");
		}
	}

	@RequestMapping("/tree2")
	@ResponseBody
	public List<Tree2Vo> tree2() {
		List<C_Organ> ms = organService.listAll();
		List<Tree2Vo> tree2Vos = new ArrayList<Tree2Vo>();
		for(C_Organ m : ms) {
			tree2Vos.add(new Tree2Vo(m.getOr_id(), m.getOrgan() != null ? m.getOrgan().getOr_id() : null, m.getOr_name()));
		}
		return tree2Vos;
	}

	@RequestMapping("/drop")
	@ResponseBody
	public Json drop(String ids, Integer id) {
		if(!ValidateUtil.isEmpty(ids) && !ValidateUtil.isEmpty(id)) {
			String[] oids = ids.split(",");
			try {
				for(String s : oids) {
					C_Organ organ = organService.find(Integer.valueOf(s));
					organ.setOrgan(new C_Organ(id));
					organService.update(organ);
				}
				return json(true, "数据更新成功");
			} catch(Exception e) {
				e.printStackTrace();
				return json("数据更新发生错误");
			}

		}
		return json("节点ID没有获取到，没有做任何操作");
	}

	@RequestMapping("excelin")
	@ResponseBody
	public Json excelin(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "file",
		required = false) MultipartFile file)
		throws IOException {

		MultipartHttpServletRequest re = (MultipartHttpServletRequest)request;
		MultipartFile fileM = re.getFile("file");
		CommonsMultipartFile cf = (CommonsMultipartFile)fileM;
		InputStream inputStream = cf.getInputStream();

		FileInputStream fis = null;
		Workbook wookbook = null;
		try {
			// 2003版本的excel，用.xls结尾
			wookbook = new HSSFWorkbook(inputStream);// 得到工作簿
		} catch(Exception ex) {
			// ex.printStackTrace();
			try {
				// 2007版本的excel，用.xlsx结尾
				wookbook = new XSSFWorkbook(inputStream);// 得到工作簿
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
		// 得到一个工作表
		Sheet sheet = wookbook.getSheetAt(0);
		// 获得表头
		Row rowHead = sheet.getRow(0);
		// 判断表头是否正确
		if(rowHead.getPhysicalNumberOfCells() != 4) {
			response.getWriter().write("表头数量不对，请检查excel格式");
		}
		// 获得数据的总行数
		int totalRowNum = sheet.getLastRowNum();
		//要获得的属性
		String name = "";
		String address = "";
		String pname = "";
		Integer pid = 0;
		String officetel = "";
		String fax = "";
		// 获得所有数据
		ArrayList<C_Organ> list = new ArrayList<C_Organ>();
		for(int i = 1; i <= totalRowNum; i++) {
			C_Organ organ = new C_Organ();
			Row row = sheet.getRow(i);
			//List<C_Organ> organList = new ArrayList<C_Organ>();

			Cell or_name = row.getCell((short)0);
			if(or_name != null) {
				name = or_name.getStringCellValue().toString();
				List<C_Organ> organList = organService.findByProperty("or_name", name);
				if(organList.size() != 0) {
					response.getWriter().write("第 " + i + " 行错误,已存在的机构,无法插入");
				}
				organ.setOr_name(name);
			}

			Cell or_pname = row.getCell((short)1);
			if(or_pname != null) {
				pname = or_pname.getStringCellValue().toString();
				List<C_Organ> porganList = organService.findByProperty("or_name", pname);
				if(porganList.size() == 0) {
					response.getWriter().write("第 " + i + " 行错误,不存在的上级机构,请检查数据");
				}
				organ.setOrgan(porganList.get(0));
			}
			organ.setOr_sort(100);
			try {
				organService.save(organ);
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("第 " + i + " 行,机构插入发生错误,请检查数据");
			}

			Cell or_officetel = row.getCell((short)2);
			if(or_officetel != null) {
				or_officetel.setCellType(Cell.CELL_TYPE_STRING);
				officetel = or_officetel.getStringCellValue().toString();

				C_Address_Book ab1 = new C_Address_Book();
				ab1.setOrgan(organService.findByProperty("or_name", name).get(0)); //插入外键person
				ab1.setBo_type("1"); //插入号码类型
				ab1.setBo_number(officetel); //插入号码
				ab1.setBo_index(1);
				ab1.setBo_usertype("2");
				ab1.setBo_state("0");
				try {
					addressBookService.save(ab1);
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("第 " + i + " 行,办公电话插入失败 ,请检查数据");
				}
			}

			Cell or_fax = row.getCell((short)3);
			if(or_fax != null) {
				or_fax.setCellType(Cell.CELL_TYPE_STRING);
				fax = or_fax.getStringCellValue().toString();

				C_Address_Book ab2 = new C_Address_Book();
				ab2.setOrgan(organService.findByProperty("or_name", name).get(0)); //插入外键person
				ab2.setBo_type("3"); //插入号码类型
				ab2.setBo_number(fax); //插入号码
				ab2.setBo_index(1);
				ab2.setBo_usertype("2");
				ab2.setBo_state("0");
				try {
					addressBookService.save(ab2);
				} catch(Exception e) {
					e.printStackTrace();
					response.getWriter().write("第 " + i + " 行,传真插入失败 ,请检查数据");
				}
			}

		}
		return json(true, "导入成功");
	}

}
