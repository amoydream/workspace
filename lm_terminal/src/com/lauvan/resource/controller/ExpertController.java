package com.lauvan.resource.controller;

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
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.organ.service.OrganService;
import com.lauvan.resource.entity.R_Expert;
import com.lauvan.resource.entity.R_Expert_Type;
import com.lauvan.resource.service.ExpertService;
import com.lauvan.resource.service.ExpertTypeService;
import com.lauvan.resource.vo.ExpertVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/expert")
public class ExpertController extends BaseController{
	
	@Autowired
	private ExpertService expertService;
	
	@Autowired
	private ExpertTypeService expertTypeService;
	
	@Autowired
	private OrganService organService;
	
	@RequestMapping("/tabs")
	public String tabs() {
		return "jsp/resource/expert/expert_tabs";
	}
	
	@RequestMapping("/main")
	public String main() {
		return "jsp/resource/expert/expert_main";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public List<R_Expert> list(ExpertVo expertVo,String query) {
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(expertVo.getEx_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.ex_Name like ?").append((params.size()+1));
				params.add("%"+expertVo.getEx_Name().trim()+"%");
			}
			return expertService.getListEntitys(jpql.toString(), params.toArray());
		}
		if (!ValidateUtil.isEmpty(expertVo.getEx_Typeid())) {
			List<R_Expert> expert = expertService.findByProperty("ex_Typeid.ext_Id", expertVo.getEx_Typeid());
			return expert;
		}else{
			//List<R_Expert> allExpert = expertService.getListEntitys();
			return null;
		}
	}
	
	@MethodLog(description = "专家添加UI")
	@Perm(privilegeValue = "expertAddip")
	@RequestMapping("/addip")
	public String addip(Integer typeid, Model model) {
		model.addAttribute("typeid", typeid);
		return "jsp/resource/expert/expert_add";
	}
	
	@MethodLog(description = "专家添加")
	@Perm(privilegeValue = "expertAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(R_Expert expert) {
		
		try {
			expertService.save(expert);
			return json(true, "专家添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("专家添加失败");
		}
	}
	
	@MethodLog(description = "专家编辑UI")
	@Perm(privilegeValue = "expertEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			R_Expert expert = expertService.find(id);
			model.addAttribute("expert", expert);
			return "jsp/resource/expert/expert_edit";
		}
		return null;
	}
	
	@MethodLog(description = "专家编辑")
	@Perm(privilegeValue = "expertEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(ExpertVo expertVo) {
		R_Expert expert = expertService.find(expertVo.getEx_Id());
		BeanUtils.copyProperties(expertVo, expert);
		expert.setEx_Deptid(new C_Organ(expertVo.getEx_Deptid()));
		expert.setEx_Typeid(new R_Expert_Type(expertVo.getEx_Typeid()));
		try {
			expertService.update(expert);
			return json(true,"专家信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("专家信息修改失败");
		}
	}
	
	@MethodLog(description = "专家删除")
	@Perm(privilegeValue = "expertDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer exId) {
		try {
			expertService.delete(exId);
			return json(true, "专家信息删除成功");
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("专家信息删除失败");
		}
	}
	
	@RequestMapping("/excelOut")
	public String excelOut(Model model) {
			com.zhuozhengsoft.pageoffice.excelwriter.Workbook wb = new com.zhuozhengsoft.pageoffice.excelwriter.Workbook();
			com.zhuozhengsoft.pageoffice.excelwriter.Sheet sheet = wb.openSheet("sheet1");
			List<R_Expert> list = expertService.getListEntitys();
			
			sheet.openCell("A4").setValue("姓名");
			sheet.openCell("B4").setValue("专家类型");
			sheet.openCell("C4").setValue("联系地址");
			
			int i=5;
			for(R_Expert element:list){
					    sheet.openCell("A"+i).setValue(element.getEx_Name()+"");
						sheet.openCell("B"+i).setValue(element.getEx_Typeid().getExt_Name()+"");
						sheet.openCell("C"+i).setValue(element.getEx_Linkaddress()+"");
						i++;
			}
			model.addAttribute("wb",wb);
			return "jsp/poffice/resreport";
	}
	
	@RequestMapping("excelin")
	@ResponseBody
	public Json excelin(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "file", required = false) MultipartFile file)
			throws IOException {
		
		MultipartHttpServletRequest re = (MultipartHttpServletRequest) request;
		MultipartFile fileM = re.getFile("file");
		CommonsMultipartFile cf = (CommonsMultipartFile) fileM;
		InputStream inputStream = cf.getInputStream();

		Workbook wookbook = null;
		try {
			// 2003版本的excel，用.xls结尾
			wookbook = new HSSFWorkbook(inputStream);// 得到工作簿
		} catch (Exception ex) {
			// ex.printStackTrace();
			try {
				// 2007版本的excel，用.xlsx结尾
				wookbook = new XSSFWorkbook(inputStream);// 得到工作簿
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 得到一个工作表
		Sheet sheet = wookbook.getSheetAt(0);
		// 获得表头
		Row rowHead = sheet.getRow(0);
		// 判断表头是否正确
		if (rowHead.getPhysicalNumberOfCells() != 7) {
			response.getWriter().write("表头数量不对，请检查excel格式");
			return null;
		}
		// 获得数据的总行数
				int totalRowNum = sheet.getLastRowNum();
	    //要获得的属性
				String name = "";
				String sex = "1";
				String type = "";
				String dept = "";
				String email = "";
				String address = "";
				String speciality = "";
		// 获得所有数据
		for (int i = 1; i <= totalRowNum; i++) {
			R_Expert expert = new R_Expert();
			Row row = sheet.getRow(i);
			
			Cell ex_name = row.getCell((short) 0);
			if(ex_name!=null){
			name = ex_name.getStringCellValue().toString();
			}
			
			Cell ex_sex = row.getCell((short) 1);
			if(ex_sex!=null){
			   if(ex_sex.getStringCellValue().equals("女")){
				   sex="0";
			   }
			}
			
			Cell ex_type = row.getCell((short) 2);
			if(ex_type!=null){
			type = ex_type.getStringCellValue().toString();
			List<R_Expert_Type> typeList = expertTypeService.findByProperty("ext_Name", type);
			if(typeList.size()==0){ 
				response.getWriter().write("第  " +i+ " 行错误,不存在的专家类型,请检查数据");
				return null;
			}
			expert.setEx_Typeid(typeList.get(0));
			}
			
			Cell ex_dept = row.getCell((short) 3);
			if(ex_dept!=null){
			dept = ex_dept.getStringCellValue().toString();
			List<C_Organ> organList = organService.findByProperty("or_name", dept);
			if(organList.size()==0){ 
				response.getWriter().write("第  " +i+ " 行错误,不存在的单位,请检查数据");
				return null;
			}
			expert.setEx_Deptid(organList.get(0));
			}
			
			Cell ex_email = row.getCell((short) 4);
			if(ex_email!=null){
			email = ex_email.getStringCellValue().toString();
			}
			
			Cell ex_address = row.getCell((short) 5);
			if(ex_address!=null){
			address = ex_address.getStringCellValue().toString();
			}
			
			Cell ex_speciality = row.getCell((short) 6);
			if(ex_speciality!=null){
			speciality = ex_speciality.getStringCellValue().toString();
			}
			
			expert.setEx_Name(name);
			expert.setEx_Email(email);
			expert.setEx_Linkaddress(address);
			expert.setEx_Speciality(speciality);
			expert.setEx_Sex(sex);
			
			try {
				expertService.save(expert);
			} catch (Exception e) {
				e.printStackTrace();
				response.getWriter().write("第  " +i+ " 行错误,请检查数据");
				return null;
			}
		}		
		response.getWriter().write("导入成功");	
		return null;
	}

}
