package com.lauvan.resource.controller;

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
import com.lauvan.resource.entity.R_Supplies;
import com.lauvan.resource.entity.R_Supplies_Type;
import com.lauvan.resource.service.SuppliesService;
import com.lauvan.resource.service.SuppliesTypeService;
import com.lauvan.resource.vo.SuppliesVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/supplies")
public class SuppliesController extends BaseController{
	
	@Autowired
	private SuppliesService suppliesService;
	
	@Autowired
	private SuppliesTypeService suppliesTypeService;
	
	@RequestMapping("/main")
	public String main() {
		return "jsp/resource/supplies/supplies_main";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public List<R_Supplies> list(Integer page, SuppliesVo suppliesVo,String query) {
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(suppliesVo.getSu_Code())) {
				System.out.println(suppliesVo.getSu_Code());
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.su_Code like ?").append((params.size()+1));
				params.add("%"+suppliesVo.getSu_Code().trim()+"%");
			}
			if (!ValidateUtil.isEmpty(suppliesVo.getSu_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.su_Name like ?").append((params.size()+1));
				params.add("%"+suppliesVo.getSu_Name().trim()+"%");
			}
			return suppliesService.getListEntitys(jpql.toString(), params.toArray());
		}
		if (!ValidateUtil.isEmpty(suppliesVo.getSu_Typeid())) {
			List<R_Supplies> supplies = suppliesService.findByProperty("su_Typeid.ty_Id", suppliesVo.getSu_Typeid());
			return supplies;
		}else{
			//List<R_Supplies> allSupplies = suppliesService.getListEntitys();
			return null;
		}
	}
	
	@MethodLog(description="物资信息添加UI")
	@Perm(privilegeValue = "suppliesAddip")
	@RequestMapping("/addip")
	public String addip(Integer typeid, Model model) {
		model.addAttribute("typeid", typeid);
		return "jsp/resource/supplies/supplies_add";
	}
	
	@MethodLog(description="物资信息添加")
	@Perm(privilegeValue = "suppliesAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(R_Supplies supplies, Integer typeid) {
		supplies.setSu_Typeid(new R_Supplies_Type(typeid));		
		try {
			suppliesService.save(supplies);
			return json(true, "物资添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("物资添加失败");
		}
	}
	
	@MethodLog(description="物资信息编辑UI")
	@Perm(privilegeValue = "suppliesEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			R_Supplies supplies = suppliesService.find(id);
			model.addAttribute("supplies", supplies);
			return "jsp/resource/supplies/supplies_edit";
		}
		return null;
	}
	
	@MethodLog(description="物资信息编辑")
	@Perm(privilegeValue = "suppliesEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(SuppliesVo suppliesVo) {
		R_Supplies supplies = suppliesService.find(suppliesVo.getSu_Id());
		BeanUtils.copyProperties(suppliesVo, supplies);
		try {
			suppliesService.update(supplies);
			return json(true,"物资信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("物资信息修改失败");
		}
	}
	
	@MethodLog(description="物资信息删除")
	@Perm(privilegeValue = "suppliesDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer suId) {
		try {
			suppliesService.delete(suId);
			return json(true, "物资信息删除成功");
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("物资信息删除失败");
		}
	}
	
	@RequestMapping("/excelOut")
	public String excelOut(Model model) {
			com.zhuozhengsoft.pageoffice.excelwriter.Workbook wb = new com.zhuozhengsoft.pageoffice.excelwriter.Workbook();
			com.zhuozhengsoft.pageoffice.excelwriter.Sheet sheet = wb.openSheet("sheet1");
			List<R_Supplies> list = suppliesService.getListEntitys();
			
			sheet.openCell("A4").setValue("物资名称");
			sheet.openCell("B4").setValue("类型");
			sheet.openCell("C4").setValue("型号");
			sheet.openCell("D4").setValue("规格");
			
			int i=5;
			for(R_Supplies element:list){
					    sheet.openCell("A"+i).setValue(element.getSu_Name()+"");
						sheet.openCell("B"+i).setValue(element.getSu_Typeid().getTy_Name()+"");
						sheet.openCell("C"+i).setValue(element.getSu_Type()+"");
						sheet.openCell("D"+i).setValue(element.getSu_Size()+"");
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
		if (rowHead.getPhysicalNumberOfCells() != 5) {
			response.getWriter().write("表头数量不对，请检查excel格式");
			return null;
		}
		// 获得数据的总行数
				int totalRowNum = sheet.getLastRowNum();
	    //要获得的属性
				String name = "";
				String typeid = "";
				String type = "";
				String size = "";
				String measure = "";
		// 获得所有数据
		for (int i = 1; i <= totalRowNum; i++) {
			R_Supplies sup = new R_Supplies();
			Row row = sheet.getRow(i);
			
			Cell sup_name = row.getCell((short) 0);
			if(sup_name!=null){
			name = sup_name.getStringCellValue().toString();
			}
			
			Cell sup_typeid = row.getCell((short) 1);
			if(sup_typeid!=null){
			typeid = sup_typeid.getStringCellValue().toString();
			List<R_Supplies_Type> typeList = suppliesTypeService.findByProperty("ty_Name", typeid);
			if(typeList.size()==0){ 
				response.getWriter().write("第  " +i+ " 行错误,不存在的物资类型,请检查数据");
				return null;
			}
			sup.setSu_Typeid(typeList.get(0));
			}
			
			
			Cell su_type = row.getCell((short) 2);
			if(su_type!=null){
			type = su_type.getStringCellValue().toString();
			}
			
			Cell su_size = row.getCell((short) 3);
			if(su_size!=null){
			size = su_size.getStringCellValue().toString();
			}
			
			Cell su_measure = row.getCell((short) 4);
			if(su_measure!=null){
			measure = su_measure.getStringCellValue().toString();
			}
			
			sup.setSu_Name(name);
			sup.setSu_Type(type);
			sup.setSu_Size(size);
			sup.setSu_Measureunit(measure);
			
			try {
				suppliesService.save(sup);
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
