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
import com.lauvan.resource.entity.R_Danger;
import com.lauvan.resource.entity.R_Danger_Type;
import com.lauvan.resource.service.DangerService;
import com.lauvan.resource.service.DangerTypeService;
import com.lauvan.resource.vo.DangerVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/danger")
public class DangerController extends BaseController{
	
	@Autowired
	private DangerService dangerService;
	@Autowired
	private DangerTypeService dangerTypeService;
	
	@RequestMapping("/main")
	public String main() {
		return "jsp/resource/danger/danger_main";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public List<R_Danger> list(DangerVo dangerVo,String query) {
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(dangerVo.getDa_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.da_Name like ?").append((params.size()+1));
				params.add("%"+dangerVo.getDa_Name().trim()+"%");
			}
			return dangerService.getListEntitys(jpql.toString(), params.toArray());
		}
		if (!ValidateUtil.isEmpty(dangerVo.getDa_Typeid())) {
			List<R_Danger> danger = dangerService.findByProperty("da_Typeid.dt_Id", dangerVo.getDa_Typeid());
			return danger;
		}else{
			/*List<R_Danger> danger = dangerService.findByProperty("da_Typeid", "2");
			return danger;*/
			return null;
		}
	}
	
	@MethodLog(description = "危险源添加UI")
	@Perm(privilegeValue = "dangerAddip")
	@RequestMapping("/addip")
	public String addip(Integer typeid, Model model) {
		model.addAttribute("typeid", typeid);
		return "jsp/resource/danger/danger_add";
	}
	
	@MethodLog(description = "危险源添加")
	@Perm(privilegeValue = "dangerAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(R_Danger danger, Integer typeid) {
		danger.setDa_Typeid(new R_Danger_Type(typeid));	
		try {
			dangerService.save(danger);
			return json(true, "危险源添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("危险源添加失败");
		}
	}
	
	@MethodLog(description = "危险源编辑UI")
	@Perm(privilegeValue = "dangerEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			R_Danger danger = dangerService.find(id);
			model.addAttribute("danger", danger);
			return "jsp/resource/danger/danger_edit";
		}
		return null;
	}
	
	@MethodLog(description = "危险源编辑")
	@Perm(privilegeValue = "dangerEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(DangerVo dangerVo) {
		R_Danger danger = dangerService.find(dangerVo.getDa_Id());
		BeanUtils.copyProperties(dangerVo, danger);
			
		try {
			dangerService.update(danger);
			return json(true,"危险源信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("危险源信息修改失败");
		}
	}
	
	@MethodLog(description = "危险源删除")
	@Perm(privilegeValue = "dangerDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer daId) {
		try {
			dangerService.delete(daId);
			return json(true, "危险源信息删除成功");
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("危险源信息删除失败");
		}
	}
	
	@RequestMapping("/excelOut")
	public String excelOut(Model model) {
			com.zhuozhengsoft.pageoffice.excelwriter.Workbook wb = new com.zhuozhengsoft.pageoffice.excelwriter.Workbook();
			com.zhuozhengsoft.pageoffice.excelwriter.Sheet sheet = wb.openSheet("sheet1");
			List<R_Danger> list = dangerService.getListEntitys();
			
			sheet.openCell("A4").setValue("名称");
			sheet.openCell("B4").setValue("负责人");
			sheet.openCell("C4").setValue("负责人电话");
			sheet.openCell("D4").setValue("地址");
			sheet.openCell("E4").setValue("危险源类型");
				
			int i=5;
			for(R_Danger element:list){
					    sheet.openCell("A"+i).setValue(element.getDa_Name()+"");
						sheet.openCell("B"+i).setValue(element.getDa_Patrolman()+"");
						sheet.openCell("C"+i).setValue(element.getDa_Patrolmantel()+"");
						sheet.openCell("D"+i).setValue(element.getDa_Address()+"");
						sheet.openCell("E"+i).setValue(element.getDa_Typeid().getDt_Name()+"");
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
		if (rowHead.getPhysicalNumberOfCells() != 9) {
			response.getWriter().write("表头数量不对，请检查excel格式");
			return null;
		}
		// 获得数据的总行数
				int totalRowNum = sheet.getLastRowNum();
	    //要获得的属性
				String name = "";
				String type = "";
				String address = "";
				String dept = "";
				String level = "";
				String man = "";
				String mantel = "";
				String longitude = "";
				String latitude = "";
		// 获得所有数据
		for (int i = 1; i <= totalRowNum; i++) {
			R_Danger danger = new R_Danger();
			Row row = sheet.getRow(i);
			
			Cell da_name = row.getCell((short) 0);
			if(da_name!=null){
			name = da_name.getStringCellValue().toString();
			}
			
			Cell da_type = row.getCell((short) 1);
			type = da_type.getStringCellValue().toString();
			List<R_Danger_Type> typeList = dangerTypeService.findByProperty("dt_Name", type);
			if(typeList.size()==0){                  
				response.getWriter().write("第  " +i+ " 行错误,不存在的危险源类型,请检查数据");
				return null;
			}
			
			Cell da_address = row.getCell((short) 2);
			if(da_address!=null){
			address = da_address.getStringCellValue().toString();
			}
			
			Cell da_dept = row.getCell((short) 3);
			if(da_dept!=null){
			dept = da_dept.getStringCellValue().toString();
			}
			
			Cell da_level = row.getCell((short) 4);
			if(da_level!=null){
			man = da_level.getStringCellValue().toString();
			}
			
			Cell da_man = row.getCell((short) 5);
			if(da_man!=null){
			da_man.setCellType(Cell.CELL_TYPE_STRING);
			mantel = da_man.getStringCellValue().toString();
			}
			
			Cell da_mantel = row.getCell((short) 6);
			if(da_mantel!=null){
			da_mantel.setCellType(Cell.CELL_TYPE_STRING);
			mantel = da_mantel.getStringCellValue().toString();
			}
			
			Cell da_longitude = row.getCell((short) 7);
			if(da_longitude!=null){
			da_longitude.setCellType(Cell.CELL_TYPE_STRING);
			longitude = da_longitude.getStringCellValue().toString();
			}
			
			Cell da_latitude = row.getCell((short) 8);
			if(da_latitude!=null){
			da_latitude.setCellType(Cell.CELL_TYPE_STRING);
			latitude = da_latitude.getStringCellValue().toString();
			}
			
			danger.setDa_Name(name);
			danger.setDa_Typeid(typeList.get(0));
			danger.setDa_Address(address);
			danger.setDa_Dept(dept);
			danger.setDa_Level(level);
			danger.setDa_Patrolman(man);
			danger.setDa_Patrolmantel(mantel);
			danger.setDa_Longitude(longitude);
			danger.setDa_Latitude(latitude);
			
			try {
				dangerService.save(danger);
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
