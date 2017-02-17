package com.lauvan.resource.controller;

import java.io.File;
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
import com.lauvan.resource.entity.R_Expert;
import com.lauvan.resource.entity.R_Expert_Type;
import com.lauvan.resource.entity.R_Legal;
import com.lauvan.resource.entity.R_Legal_Type;
import com.lauvan.resource.service.LegalService;
import com.lauvan.resource.service.LegalTypeService;
import com.lauvan.resource.vo.LegalVo;
import com.lauvan.util.DateUtil;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
import com.zhuozhengsoft.pageoffice.wordwriter.WordDocument;

@Controller
@RequestMapping("resource/legal")
public class LegalController extends BaseController{
	
	@Autowired
	private LegalService legalService;
	@Autowired
	private LegalTypeService legalTypeService;
	
	@RequestMapping("/main")
	public String main() {
		return "jsp/resource/legal/legal_main";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public List<R_Legal> list(LegalVo legalVo,String query) {
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(legalVo.getLe_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.le_Name like ?").append((params.size()+1));
				params.add("%"+legalVo.getLe_Name().trim()+"%");
			}
			return legalService.getListEntitys(jpql.toString(), params.toArray());
		}
		if (!ValidateUtil.isEmpty(legalVo.getLe_Typeid())) {
			List<R_Legal> legal = legalService.findByProperty("le_Typeid.lt_Id", legalVo.getLe_Typeid());
			return legal;
		}else{
			/*List<R_Legal> allLegal = legalService.getListEntitys();
			return allLegal;*/
			return null;
		}
	}
	
	@MethodLog(description="法律添加UI")
	@Perm(privilegeValue = "legalAddip")
	@RequestMapping("/addip")
	public String addip(Integer pid, Model model) {
		model.addAttribute("typeid", pid);
		return "jsp/resource/legal/legal_add";
	}
	
	@MethodLog(description="法律添加")
	@Perm(privilegeValue = "legalAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(R_Legal legal, Integer typeid) {
		legal.setLe_Typeid(new R_Legal_Type(typeid));		
		try {
			legalService.save(legal);
			return json(true, "法律添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("法律添加失败");
		}
	}
	
	@MethodLog(description="法律编辑UI")
	@Perm(privilegeValue = "legalEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			R_Legal legal = legalService.find(id);
			model.addAttribute("legal", legal);
			return "jsp/resource/legal/legal_edit";
		}
		return null;
	}
	
	@MethodLog(description="法律编辑")
	@Perm(privilegeValue = "legalEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(LegalVo legalVo) {
		R_Legal legal = legalService.find(legalVo.getLe_Id());
		BeanUtils.copyProperties(legalVo, legal);
			
		try {
			legalService.update(legal);
			return json(true,"法律信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("法律信息修改失败");
		}
	}
	
	@MethodLog(description="法律删除")
	@Perm(privilegeValue = "legalDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer leId) {
		try {
			legalService.delete(leId);
			return json(true, "法律信息删除成功");
		}  catch (Exception e1) {
			e1.printStackTrace();
			return json("法律信息删除失败");
		}
	}
	
	
	
	@RequestMapping("/upload")
	public String upload(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "file", required = false) MultipartFile file,
			Integer leId) throws IOException {
        
		response.setContentType("text/plain;charset=UTF-8");
		
		System.out.println("开始");
		String path = request.getSession().getServletContext()
				.getRealPath("/") + "upload/legal/";
		String fileName = file.getOriginalFilename();
		System.out.println(path);
		File uploadFile = new File(path, fileName);
		if (!uploadFile.exists()) {
			System.out.println("创建");
			uploadFile.mkdirs();
			
			try {
				file.transferTo(uploadFile);
			} catch (Exception e) {
				e.printStackTrace();
				response.getWriter().write("1");
			}
			
			R_Legal legal = legalService.find(leId);
			legal.setLe_Filename(fileName);
			try {
				legalService.update(legal);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@RequestMapping("/viewdoc")
	public String viewdoc(Integer leId,Model model) {
		R_Legal legal = legalService.find(leId);
		model.addAttribute("docName", legal.getLe_Filename());
		return "jsp/resource/legal/legal_viewdoc";
	}
	
	
	@RequestMapping("/infoshow")
	public String infoshow(Integer le_Id,Model model){
		if(ValidateUtil.isEmpty(le_Id)){
			return null;
		}
		R_Legal legal = legalService.find(le_Id);
		WordDocument doc = new WordDocument();
		doc.openDataTag("{PO_le_Name}").setValue(legal.getLe_Name());
		doc.openDataTag("{PO_le_Code}").setValue(legal.getLe_Code());
		doc.openDataTag("{PO_le_State}").setValue(legal.getLe_State());
		doc.openDataTag("{PO_le_Shortcontent}").setValue(legal.getLe_Shortcontent());
		if(legal.getLe_Typeid()==null){
			doc.openDataTag("{PO_lt_Name}").setValue("");
		}else{
		doc.openDataTag("{PO_lt_Name}").setValue(legal.getLe_Typeid().getLt_Name());
		}
		doc.openDataTag("{PO_le_Range}").setValue(legal.getLe_Range());
		doc.openDataTag("{PO_le_Lowdept}").setValue(legal.getLe_Lowdept());
		if(legal.getLe_Effectivedate()==null){
	     doc.openDataTag("{PO_le_Effectivedate}").setValue("");
		}else{
		doc.openDataTag("{PO_le_Effectivedate}").setValue(DateUtil.getDate(legal.getLe_Effectivedate()));
		}
		if(legal.getLe_Validity()==null){
			doc.openDataTag("{PO_le_Validity}").setValue("");
		}else{
			doc.openDataTag("{PO_le_Validity}").setValue(DateUtil.getDate(legal.getLe_Validity()));
		}
		doc.openDataTag("{PO_le_Savedirectory}").setValue(legal.getLe_Savedirectory());	
		if(legal.getLe_Formate()==null){
			doc.openDataTag("{PO_le_Formate}").setValue("");
		}else{	
			doc.openDataTag("{PO_le_Formate}").setValue(legal.getLe_Formate());	
		}
		doc.openDataTag("{PO_le_Content}").setValue(legal.getLe_Content());	
		
		model.addAttribute("doc", doc);
		return "jsp/poffice/legalinfoprint";
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
		if (rowHead.getPhysicalNumberOfCells() != 4) {
			return json(false, "表头数量不对，请检查excel格式");
		}
		// 获得数据的总行数
				int totalRowNum = sheet.getLastRowNum();
	    //要获得的属性
				String code = "";
				String name = "";
				String type = "";
				String content = "";
		// 获得所有数据
		for (int i = 1; i <= totalRowNum; i++) {
			R_Legal legal = new R_Legal();
			Row row = sheet.getRow(i);
			
			Cell le_code = row.getCell((short) 0);
			if(le_code!=null){
		    le_code.setCellType(Cell.CELL_TYPE_STRING);
			code = le_code.getStringCellValue().toString();
			}
			
			Cell le_name = row.getCell((short) 1);
			if(le_name!=null){
		    name=le_name.getStringCellValue().toString();
			}
			
			Cell le_type = row.getCell((short) 2);
			if(le_type!=null){
			type = le_type.getStringCellValue().toString();
			List<R_Legal_Type> typeList = legalTypeService.findByProperty("lt_Name", type);
			if(typeList.size()==0){ 
				return json(false,"第  " +i+ " 行错误,不存在的法律类型,请检查数据");
			}
			legal.setLe_Typeid(typeList.get(0));
			}
			
			Cell le_content = row.getCell((short) 3);
			if(le_content!=null){
			content = le_content.getStringCellValue().toString();
			}
			
			legal.setLe_Name(name);
			legal.setLe_Code(code);
			legal.setLe_Content(content);
			
			try {
				legalService.save(legal);
			} catch (Exception e) {
				e.printStackTrace();
				return json(false,"第  " +i+ " 行错误,请检查数据");
			}
		}		
		return json(true, "导入成功");	
	}

	
}
