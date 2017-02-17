package com.lauvan.organ.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
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
import com.lauvan.organ.entity.C_Position;
import com.lauvan.organ.entity.V_Person;
import com.lauvan.organ.service.AddressBookService;
import com.lauvan.organ.service.OrganPersonService;
import com.lauvan.organ.service.OrganService;
import com.lauvan.organ.service.PersonService;
import com.lauvan.organ.service.PositionService;
import com.lauvan.organ.vo.OrganPersonVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

/**
 * ClassName: PersonController
 *
 * @Description: 机构人员管理
 * @author 钮炜炜
 * @date 2015年12月1日 下午4:17:31
 */
@Controller
@RequestMapping("work/person")
@SessionAttributes(names = {"userVo"})
public class PersonController extends BaseController {
	@Autowired
	private PersonService		personService;
	@Autowired
	private OrganPersonService	organPersonService;
	@Autowired
	private PositionService		positionService;
	@Autowired
	private OrganService		organService;

	@Autowired
	private AddressBookService	addressBookService;

	@Autowired
	private Properties			config;

	@RequestMapping("/main")
	public String main() {
		return "jsp/work/person/person_list";
	}

	@RequestMapping("/list")
	@ResponseBody
	public Json list(OrganPersonVo vo) {
		try {
			if(vo == null) {
				vo = new OrganPersonVo();
			}
			if(vo.getPage() == null || vo.getPage() < 1) {
				vo.setPage(1);
			}
			if(vo.getRows() < 1) {
				vo.setRows(12);
			}
			PageView<OrganPersonVo> pageView = new PageView<>(vo.getRows(), vo.getPage());
			QueryResult<V_Person> result = personService.getPersonPage(vo);
			List<V_Person> vList = result.getResultlist();
			List<OrganPersonVo> voList = personinfo(vList);
			QueryResult<OrganPersonVo> qr = new QueryResult<>();
			qr.setResultlist(voList);
			qr.setTotalrecord(result.getTotalrecord());
			pageView.setQueryResult(qr);

			return json(true, "", pageView);
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		}
	}

	private List<OrganPersonVo> personinfo(List<V_Person> ms) {
		List<OrganPersonVo> opVos = null;
		OrganPersonVo opVo = null;
		if(ms != null) {
			opVos = new ArrayList<>();
			for(V_Person op : ms) {
				opVo = new OrganPersonVo();
				opVo.setPe_sort_old(op.getPe_sort());
				BeanUtils.copyProperties(op, opVo);
				if(!ValidateUtil.isEmpty(op.getPe_poids())) {
					opVo.setPe_jobs(positionService.getPositionNames(op.getPe_poids()));
				}
				List<C_Address_Book> abs = addressBookService.findByProperty("person.pe_id", op.getPe_id());
				for(C_Address_Book ab : abs) {
					if("1".equals(ab.getBo_type())) {// 办公电话
						opVo.setOfficephone(ab.getBo_number());
					} else if("2".equals(ab.getBo_type())) {// 手机
						opVo.setMobilephone(ab.getBo_number());
					} else if("3".equals(ab.getBo_type())) {// 传真
						opVo.setFax(ab.getBo_number());
					} else if("4".equals(ab.getBo_type())) {// 邮箱
						opVo.setEmail(ab.getBo_number());
					} else if("5".equals(ab.getBo_type())) {// 住宅电话
						opVo.setHomephone(ab.getBo_number());
					}
				}
				opVos.add(opVo);
			}
		}

		return opVos;
	}

	/*
	 * @MethodLog(description = "机构人员查询")
	 * @RequestMapping("/search")
	 * @ResponseBody
	 * public Json search(OrganPersonVo vo, @ModelAttribute("userVo") UserInfoVo
	 * userVo) {
	 * if(vo == null) {
	 * vo = new OrganPersonVo();
	 * }
	 * if(vo.getPage() < 1) {
	 * vo.setPage(1);
	 * }
	 * if(vo.getRows() < 1) {
	 * vo.setRows(8);
	 * }
	 * PageView<OrganPersonVo> pageView = new PageView<>(vo.getRows(),
	 * vo.getPage());
	 * List<OrganPersonVo> opVos = new ArrayList<OrganPersonVo>();
	 * try {
	 * QueryResult<C_Organ_Person> queryResult =
	 * organPersonService.pagingQuery(vo);
	 * if(queryResult != null && queryResult.getResultlist() != null) {
	 * Set<C_Organ_Person> contactFavorites = new HashSet<C_Organ_Person>();
	 * if(userVo != null) {
	 * T_User_Info userInfo = userInfoService.find(userVo.getUs_Id());
	 * if(userInfo != null) {
	 * // contactFavorites = userInfo.getContactFavorites();
	 * }
	 * }
	 * for(C_Organ_Person op : queryResult.getResultlist()) {
	 * OrganPersonVo opVo = new OrganPersonVo();
	 * BeanUtils.copyProperties(op, opVo);
	 * List<C_Address_Book> abs =
	 * addressBookService.findByProperty("person.pe_id", op.getPe_id());
	 * for(C_Address_Book ab : abs) {
	 * if("1".equals(ab.getBo_type())) {// 办公电话
	 * opVo.setOfficephone(ab.getBo_number());
	 * } else if("2".equals(ab.getBo_type())) {// 手机
	 * opVo.setMobilephone(ab.getBo_number());
	 * } else if("5".equals(ab.getBo_type())) {// 住宅电话
	 * opVo.setHomephone(ab.getBo_number());
	 * } else if("4".equals(ab.getBo_type())) {// 邮箱
	 * opVo.setEmail(ab.getBo_number());
	 * }
	 * }
	 * opVo.setFavorite(contactFavorites.contains(op));
	 * opVos.add(opVo);
	 * }
	 * }
	 * pageView.setTotalrecord(queryResult.getTotalrecord());
	 * pageView.setRecords(opVos);
	 * } catch(Exception e) {
	 * return json(false, "查询失败", pageView);
	 * }
	 * return json(true, "查询成功", pageView);
	 * }
	 */

	@MethodLog(description = "机构人员添加")
	@Perm(privilegeValue = "personAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(OrganPersonVo opVo) {
		C_Organ_Person op = new C_Organ_Person();
		BeanUtils.copyProperties(opVo, op);
		if(opVo.getPe_sort() == 0) {
			op.setPe_sort(100);
		}
		if(!ValidateUtil.isEmpty(opVo.getOr_id())) {
			op.setOrgan(new C_Organ(opVo.getOr_id()));
		}
		/*
		 * if (!ValidateUtil.isEmpty(opVo.getPo_id())) {
		 * op.setPosition(new C_Position(opVo.getPo_id()));
		 * }
		 */
		if(!ValidateUtil.isEmpty(opVo.getPo_ids())) {
			op.setPe_poids(opVo.getPo_ids());
		}
		try {
			organPersonService.save(op);
			return json(true, "机构人员添加成功");
		} catch(Exception e) {
			e.printStackTrace();
			return json("机构人员添加失败");
		}
	}

	@MethodLog(description = "机构人员修改UI")
	@Perm(privilegeValue = "personEditip")
	@RequestMapping("/editip")
	public String editip(Integer id, Model model) {
		if(!ValidateUtil.isEmpty(id)) {
			C_Organ_Person op = organPersonService.find(id);
			OrganPersonVo oPersonVo = new OrganPersonVo();
			BeanUtils.copyProperties(op, oPersonVo);
			if(!ValidateUtil.isEmpty(op.getPe_poids())) {
				oPersonVo.setPe_jobs(positionService.getPositionNames(op.getPe_poids()));
			}
			oPersonVo.setOr_id(op.getOrgan().getOr_id());
			oPersonVo.setOr_name(op.getOrgan().getOr_name());
			model.addAttribute("person", oPersonVo);
			return "jsp/work/person/person_edit";
		}
		return "";
	}

	@MethodLog(description = "机构人员修改")
	@Perm(privilegeValue = "personEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(OrganPersonVo opVo) {
		if(ValidateUtil.isEmpty(opVo.getPe_id())) {
			return json("机构人员ID没有获取到");
		}
		C_Organ_Person op = organPersonService.find(opVo.getPe_id());
		if(opVo.getPe_sort() == 0) {
			op.setPe_sort(opVo.getPe_sort_old());
		}
		op.setOrgan(organService.find(opVo.getOr_id()));
		BeanUtils.copyProperties(opVo, op);
		if(!ValidateUtil.isEmpty(opVo.getPo_ids())) {
			op.setPe_poids(opVo.getPo_ids());
		}
		try {
			organPersonService.update(op);

		} catch(Exception e) {
			e.printStackTrace();
			return json("机构人员修改失败");
		}
		try {
			List<C_Address_Book> book = addressBookService.getAllByPeId(opVo.getPe_id());
			if(book.size() != 0) {
				for(C_Address_Book b : book) {
					b.setOrgan(organService.find(opVo.getOr_id()));
					addressBookService.save(b);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			return json("机构人员关联修改失败");
		}

		return json(true, "机构人员修改成功");
	}

	@MethodLog(description = "机构人员彻底删除")
	@Perm(privilegeValue = "personDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if(!ValidateUtil.isEmpty(id)) {
			try {
				List<C_Address_Book> book = addressBookService.findByProperty("person.pe_id", id);
				for(C_Address_Book b : book){
					addressBookService.delete(b.getBo_id());
				}
				organPersonService.delete(id);
				return json(true, "机构人员彻底删除成功");
			} catch(Exception e) {
				e.printStackTrace();
				return json("机构人员彻底删除失败");
			}
		}
		return json("没有做任何操作");
	}

	@MethodLog(description = "机构人员删除")
	@Perm(privilegeValue = "personDelup")
	@RequestMapping("/delup")
	@ResponseBody
	public Json delup(Integer id) {
		if(!ValidateUtil.isEmpty(id)) {
			C_Organ_Person person = organPersonService.find(id);
			person.setPe_del("1");
			try {
				organPersonService.update(person);
				return json(true, "机构人员删除成功");
			} catch(Exception e) {
				e.printStackTrace();
				return json("机构人员删除失败");
			}
		}
		return json("没有做任何操作");
	}

	@RequestMapping("/select/{pe_id}")
	@ResponseBody
	public C_Organ_Person select(@PathVariable Integer pe_id) {
		C_Organ_Person person = null;

		if(!ValidateUtil.isEmpty(pe_id)) {
			person = organPersonService.find(pe_id);
		}

		if(person == null) {
			person = new C_Organ_Person();
		}

		return person;
	}

	@RequestMapping("/getLeader")
	@ResponseBody
	public List<OrganPersonVo> getLeader() {
		List<V_Person> ms = personService.findByProperty("pe_leader", "1");
		return personinfo(ms);
	}

	@RequestMapping("export")
	@ResponseBody
	public Json export() {
		String rootDir = config.getProperty("contact_export_dir");
		FileOutputStream fos = null;
		HSSFWorkbook workbook = null;
		try {
			File dir = new File(rootDir);
			if(!dir.exists()) {
				dir.mkdir();
			} else if(!dir.isDirectory()) {
				dir.delete();
				dir = new File(rootDir);
				dir.mkdir();
			}

			List<C_Organ_Person> personList = organPersonService.getListEntitys();
			List<OrganPersonVo> list = new ArrayList<>();
			for(int i = 0; i < personList.size(); i++) {
				OrganPersonVo per = new OrganPersonVo();

				//获得姓名性别
				per.setPe_name(personList.get(i).getPe_name());
				per.setPe_sex(personList.get(i).getPe_sex());

				//获得职位
				per.setPe_jobs(positionService.getPositionNames(personList.get(i).getPe_poids()));

				//获得手机和办公电话
				List<C_Address_Book> numberList = addressBookService.getAllByPeId(personList.get(i).getPe_id());
				for(int y = 0; y < numberList.size(); y++) {
					if("2".equals(numberList.get(y).getBo_type())) {
						per.setMobilephone(numberList.get(y).getBo_number());
					}
					if("1".equals(numberList.get(y).getBo_type())) {
						per.setOfficephone(numberList.get(y).getBo_number());
					}
				}

				//组成固定格式的部门路径
				StringBuilder orText = new StringBuilder("企业通讯录");
				C_Organ organ = personList.get(i).getOrgan(); //当前部门对象
				while(organ.getOr_id() != 1) {
					orText.insert(5, "||" + organ.getOr_name());
					organ = organ.getOrgan();
				}
				per.setOr_name(orText.toString());
				list.add(i, per);
			}

			//写入excel
			if(list != null && list.size() > 0) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String timestamp = sdf.format(Calendar.getInstance().getTime());
				File file = new File(rootDir + "/contacts_" + timestamp + ".xls");
				file.createNewFile();
				fos = new FileOutputStream(file);
				workbook = new HSSFWorkbook();
				HSSFSheet sheet = workbook.createSheet("龙门机构人员通讯录");

				HSSFRow rowhead = sheet.createRow(0);
				HSSFCell name = rowhead.createCell(0);
				name.setCellType(Cell.CELL_TYPE_STRING);
				name.setCellValue("姓名");
				HSSFCell phone = rowhead.createCell(1);
				phone.setCellType(Cell.CELL_TYPE_STRING);
				phone.setCellValue("手机");
				HSSFCell email = rowhead.createCell(2);
				email.setCellType(Cell.CELL_TYPE_STRING);
				email.setCellValue("邮件地址");
				HSSFCell homenumber = rowhead.createCell(3);
				homenumber.setCellType(Cell.CELL_TYPE_STRING);
				homenumber.setCellValue("固定电话");
				HSSFCell homeaddress = rowhead.createCell(4);
				homeaddress.setCellType(Cell.CELL_TYPE_STRING);
				homeaddress.setCellValue("家庭地址");
				HSSFCell sex = rowhead.createCell(5);
				sex.setCellType(Cell.CELL_TYPE_STRING);
				sex.setCellValue("性别");
				HSSFCell age = rowhead.createCell(6);
				age.setCellType(Cell.CELL_TYPE_STRING);
				age.setCellValue("年龄");
				HSSFCell Position = rowhead.createCell(7);
				Position.setCellType(Cell.CELL_TYPE_STRING);
				Position.setCellValue("职位");
				HSSFCell idcard = rowhead.createCell(8);
				idcard.setCellType(Cell.CELL_TYPE_STRING);
				idcard.setCellValue("身份证");
				HSSFCell organ = rowhead.createCell(9);
				organ.setCellType(Cell.CELL_TYPE_STRING);
				organ.setCellValue("部门");
				HSSFCell OfficeNo = rowhead.createCell(10);
				OfficeNo.setCellType(Cell.CELL_TYPE_STRING);
				OfficeNo.setCellValue("办公电话");

				for(int i = 0; i < list.size(); i++) {
					OrganPersonVo c = list.get(i);
					HSSFRow row = sheet.createRow(i + 1);
					HSSFCell pe_name = row.createCell(0);
					pe_name.setCellType(Cell.CELL_TYPE_STRING);
					pe_name.setCellValue(c.getPe_name());
					HSSFCell phoneNo = row.createCell(1);
					phoneNo.setCellType(Cell.CELL_TYPE_STRING);
					phoneNo.setCellValue(c.getMobilephone());
					HSSFCell position = row.createCell(7);
					position.setCellType(Cell.CELL_TYPE_STRING);
					position.setCellValue(c.getPe_jobs());
					HSSFCell or_text = row.createCell(9);
					or_text.setCellType(Cell.CELL_TYPE_STRING);
					or_text.setCellValue(c.getOr_name());
					HSSFCell officeNo = row.createCell(10);
					officeNo.setCellType(Cell.CELL_TYPE_STRING);
					officeNo.setCellValue(c.getOfficephone());
				}
				workbook.write(fos);
				fos.flush();
				return json(true, "已导出到 " + file.getAbsolutePath());
			}
			return json(false, "未导出任何数据");
		} catch(Exception e) {
			e.printStackTrace();
			return json(false, "查询失败");
		} finally {
			if(fos != null) {
				try {
					fos.close();
				} catch(IOException e) {
					e.printStackTrace();
				}
			}
			if(workbook != null) {
				try {
					workbook.close();
				} catch(IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@RequestMapping("inport")
	@ResponseBody
	public Json inport(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "file",
		required = false) MultipartFile file) throws IOException {

		//response.setContentType("text/plain;charset=UTF-8");

		System.out.println("开始");

		MultipartHttpServletRequest re = (MultipartHttpServletRequest)request;
		MultipartFile fileM = re.getFile("file");
		CommonsMultipartFile cf = (CommonsMultipartFile)fileM;
		InputStream inputStream = cf.getInputStream();

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
		if(rowHead.getPhysicalNumberOfCells() != 11) {
			response.getWriter().write("表头数量错误，请检查excel格式");
			return null;
		}
		// 获得数据的总行数
		int totalRowNum = sheet.getLastRowNum();
		// 要获得属性
		String name = "";
		String phone = "";
		String officetel = "";
		String organName = "";
		String poids = "";

		// 获得所有数据
		for(int i = 1; i <= totalRowNum; i++) {
			C_Organ_Person op = new C_Organ_Person();
			// 获得第i行对象
			Row row = sheet.getRow(i);

			Cell c_organ = row.getCell((short)9);

			organName = c_organ.getStringCellValue().toString();
			int y = organName.lastIndexOf("||");
			organName = organName.substring(y + 2, organName.length());
			List<C_Organ> organList = organService.findByProperty("or_name", organName);
			if(organList.size() == 0) {
				response.getWriter().write("没有找到该部门：" + organName);
				return null;
			}
			C_Organ organ = organList.get(0);

			//获得数字的职位串
			Cell c_poids = row.getCell((short)7);
			poids = c_poids.getStringCellValue().toString(); //文字职位串
			if(poids.length() != 0) {
				StringBuilder sb = new StringBuilder();
				String[] ids = poids.split(",");
				for(String s : ids) {
					List<C_Position> p = positionService.findByProperty("p_name", s);
					if(p.size() == 0) {
						response.getWriter().write("没有找到该职位：" + s);
						return null;
					}
					sb.append(p.get(0).getP_id()).append(",");
				}
				if(sb.length() > 0) {
					sb.delete(sb.length() - 1, sb.length());
				}
				poids = sb.toString(); //数字职位串
				op.setPe_poids(poids);
			}

			//插入人员到C_Organ_Person
			Cell c_name = row.getCell((short)0);
			name = c_name.getStringCellValue().toString();
			List<C_Organ_Person> organPerson = organPersonService.findByProperty("pe_name", name);
			if(organPerson.size() != 0) {
				response.getWriter().write("姓名：" + name + " 的人员已存在数据库 ,无法添加");
				return null;
			}
			op.setPe_name(name);
			op.setPe_sex("F");
			op.setPe_sort(100);
			op.setPe_del("0");
			op.setPe_type("0");
			op.setOrgan(organ);
			try {
				organPersonService.save(op);
			} catch(Exception e) {
				e.printStackTrace();
				response.getWriter().write("插入姓名：" + name + "的记录时发生错误 ,请检查数据");
				return null;
			}
			organPerson = organPersonService.findByProperty("pe_name", name);
			C_Organ_Person person = organPerson.get(0);

			//插入两个号码到C_Address_Book
			Cell c_phone = row.getCell((short)1);
			Cell c_officetel = row.getCell((short)10);
			if(c_phone != null) {
				C_Address_Book ab1 = new C_Address_Book();
				c_phone.setCellType(Cell.CELL_TYPE_STRING);
				phone = c_phone.getStringCellValue().toString(); //手机号码
				ab1.setPerson(person); //插入外键person
				ab1.setOrgan(organ); //插入部门
				ab1.setBo_type("2"); //插入号码类型
				ab1.setBo_number(phone); //插入号码
				ab1.setBo_index(1);
				ab1.setBo_usertype("1");
				ab1.setBo_state("0");
				try {
					addressBookService.save(ab1);
				} catch(Exception e) {
					e.printStackTrace();
				}

			}
			if(c_officetel != null) {
				C_Address_Book ab2 = new C_Address_Book();
				c_officetel.setCellType(Cell.CELL_TYPE_STRING);
				officetel = c_officetel.getStringCellValue().toString(); //办公电话
				ab2.setPerson(person);
				ab2.setOrgan(organ);
				ab2.setBo_type("1");
				ab2.setBo_number(officetel);
				ab2.setBo_index(1);
				ab2.setBo_usertype("1");
				ab2.setBo_state("0");
				try {
					addressBookService.save(ab2);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		response.getWriter().write("导入成功");
		return null;
	}
}
