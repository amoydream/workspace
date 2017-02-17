package com.lauvan.resource.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.lauvan.interceptor.Perm;
import com.lauvan.resource.entity.R_Supplies;
import com.lauvan.resource.entity.R_Supplies_Store;
import com.lauvan.resource.service.SuppliesService;
import com.lauvan.resource.service.SuppliesStoreService;
import com.lauvan.resource.vo.SuppliesStoreVo;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

@Controller
@RequestMapping("resource/suppliesstore")
public class SuppliesStoreController extends BaseController{
	
	@Autowired
	private SuppliesStoreService suppliesStoreService;
	@Autowired
	private SuppliesService suppliesService;
	
	@RequestMapping("/main")
	public String main(Integer page, String query,Integer suCode,String suName, SuppliesStoreVo suppliesStoreVo, Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Supplies_Store> pageView = new PageView<R_Supplies_Store>(15, ((page==null || page<1) ? 1:page));
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(suCode)) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.st_Suppliesid.su_Code = ?").append((params.size()+1));
				params.add("%"+suCode+"%");
			}
			if (!ValidateUtil.isEmpty(suName)) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.st_Suppliesid.su_Name like ?").append((params.size()+1));
				params.add("%"+suName.trim()+"%");
			}
			model.addAttribute("suppliesStoreVo", suppliesStoreVo);
			pageView.setQueryResult(suppliesStoreService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(),params.toArray()));
		}else {
			pageView.setQueryResult(suppliesStoreService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult()));
		}
		model.addAttribute("pageView", pageView);
		return "jsp/resource/suppliesstore/suppliesstore_main";
	}
	
	@RequestMapping("/selectList")
	public String selectList(Integer page, String query, String suName, String suCode, Integer diId, SuppliesStoreVo suppliesStoreVo, Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Supplies_Store> pageView = new PageView<R_Supplies_Store>(10, ((page == null || page < 1) ? 1 : page));
		if("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if(!ValidateUtil.isEmpty(suName)) {
				if(params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.st_Suppliesid.su_Name like ?").append((params.size() + 1));
				params.add("%" + suName.trim() + "%");
			}
			if(!ValidateUtil.isEmpty(suCode)){
				if(params.size() > 0)
					jpql.append(" and ");
				jpql.append(" o.st_Suppliesid.su_Code = ?").append((params.size() + 1));
				params.add("%" + suCode.trim() + "%");
			}
			pageView.setQueryResult(suppliesStoreService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(), jpql.toString(), params.toArray()));
		} else {
			pageView.setQueryResult(suppliesStoreService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult()));
		}
		model.addAttribute("pageView", pageView);
		model.addAttribute("diId",diId);
		return "jsp/resource/dispatchstore/dispatchstore_add";
	}
	
	@MethodLog(description="存储信息添加UI")
	@Perm(privilegeValue = "storeAddip")
	@RequestMapping("/addip")
	public String addip() {
		return "jsp/resource/suppliesstore/suppliesstore_add";
	}
	
	@MethodLog(description="存储信息添加")
	@Perm(privilegeValue = "storeAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(R_Supplies_Store store, HttpSession session) {
		UserInfoVo u = (UserInfoVo) session.getAttribute("userVo");
		store.setSt_Recordman(new T_User_Info(u.getUs_Id()));			
		store.setSt_Recorddate(new Date());
		try {
			suppliesStoreService.save(store);
			return json(true, "物资存储信息添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("物资存储信息添加失败");
		}
	}
	
	@MethodLog(description="存储信息编辑UI")
	@Perm(privilegeValue = "storeEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			R_Supplies_Store store = suppliesStoreService.find(id);
			model.addAttribute("store", store);
			return "jsp/resource/suppliesstore/suppliesstore_edit";
		}
		return null;
	}
	
	@MethodLog(description="存储信息编辑")
	@Perm(privilegeValue = "storeEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(SuppliesStoreVo suppliesStoreVo) {
		R_Supplies_Store store = suppliesStoreService.find(suppliesStoreVo.getSt_Id());
		store.setSt_Suppliesid(new R_Supplies(suppliesStoreVo.getSt_Suppliesid()));
		BeanUtils.copyProperties(suppliesStoreVo, store);
		try {
			suppliesStoreService.update(store);
			return json(true,"物资存储信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("物资存储信息修改失败");
		}
	}
	
	@MethodLog(description="存储信息删除")
	@Perm(privilegeValue = "storeDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer shId) {
		try {
			suppliesStoreService.delete(shId);
			return json(true, "物资存储信息删除成功");
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("物资存储信息删除失败");
		}
	}
	
	@RequestMapping("/search")
	@ResponseBody
	public List<R_Supplies_Store> search(Double longitude,Double latitude, Integer id) {
		double[] ar = ValidateUtil.getAround(latitude,longitude, 5000);
		List<R_Supplies_Store> ms2 = suppliesStoreService.getlatlon(ar[0], ar[1], ar[2], ar[3], id);
		return ms2;
	}

	@RequestMapping("/search2")
	@ResponseBody
	public List<R_Supplies_Store> search2(Double longitude,Double latitude, String ids, Integer radii) {
		if (!ValidateUtil.isEmpty(radii)) {
			double[] ar = ValidateUtil.getAround(latitude, longitude, radii);
			String [] idsArray = ids.split(",");
			List<R_Supplies_Store> ms2 = suppliesStoreService.getAllPoints(ar[0], ar[1], ar[2],   ar[3], idsArray);
			return ms2;
		}else{
			double[] ar = ValidateUtil.getAround(latitude, longitude, 5000);
			String [] idsArray = ids.split(",");
			List<R_Supplies_Store> ms2 = suppliesStoreService.getAllPoints(ar[0], ar[1], ar[2],   ar[3], idsArray);
			return ms2;
		}
	}
	
	@RequestMapping("/excelOut")
	public String excelOut(Model model) {
			com.zhuozhengsoft.pageoffice.excelwriter.Workbook wb = new com.zhuozhengsoft.pageoffice.excelwriter.Workbook();
			com.zhuozhengsoft.pageoffice.excelwriter.Sheet sheet = wb.openSheet("sheet1");
			List<R_Supplies_Store> list = suppliesStoreService.getListEntitys();
			
			sheet.openCell("A4").setValue("物资名称");
			sheet.openCell("B4").setValue("存放数量");
			sheet.openCell("C4").setValue("管理单位");
			sheet.openCell("D4").setValue("负责人");
			sheet.openCell("E4").setValue("负责人电话");
			sheet.openCell("F4").setValue("存放地址");
			
			int i=5;
			for(R_Supplies_Store element:list){
					    sheet.openCell("A"+i).setValue(element.getSt_Suppliesid().getSu_Name()+"");
						sheet.openCell("B"+i).setValue(element.getSt_Count()+"");
						sheet.openCell("C"+i).setValue(element.getSt_Managedept()+"");
						sheet.openCell("D"+i).setValue(element.getSt_Manageman()+"");
						sheet.openCell("E"+i).setValue(element.getSt_Managemantel()+"");
						sheet.openCell("F"+i).setValue(element.getSt_Address()+"");
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
		if (rowHead.getPhysicalNumberOfCells() != 8) {
			response.getWriter().write("表头数量不对，请检查excel格式");
			return null;
		}
		// 获得数据的总行数
				int totalRowNum = sheet.getLastRowNum();
	    //要获得的属性
				String name = "";
				String address = "";
				String dept = "";
				String man = "";
				String mantel = "";
				String num = "";
				Double longitude = 0.0;
				Double latitude = 0.0;
		// 获得所有数据
		for (int i = 1; i <= totalRowNum; i++) {
			R_Supplies_Store sto = new R_Supplies_Store();
			Row row = sheet.getRow(i);
			
			Cell sup_name = row.getCell((short) 0);
			name = sup_name.getStringCellValue().toString();
			List<R_Supplies> supList = suppliesService.findByProperty("su_Name", name);
			if(supList.size()==0){                  
				response.getWriter().write("第  " +i+ " 行错误,不存在的物资名称,请检查数据");
				return null;
			}
			
			Cell sup_address = row.getCell((short) 5);
			if(sup_address!=null){
			address = sup_address.getStringCellValue().toString();
			}
			
			Cell sup_dept = row.getCell((short) 4);
			if(sup_dept!=null){
			dept = sup_dept.getStringCellValue().toString();
			}
			
			Cell sup_man = row.getCell((short) 2);
			if(sup_man!=null){
			man = sup_man.getStringCellValue().toString();
			}
			
			Cell sup_mantel = row.getCell((short) 3);
			if(sup_mantel!=null){
			sup_mantel.setCellType(Cell.CELL_TYPE_STRING);
			mantel = sup_mantel.getStringCellValue().toString();
			}
			
			Cell sup_num = row.getCell((short) 1);
			if(sup_num!=null){
			num = sup_num.getStringCellValue().toString();
			}
			
			Cell sup_longitude = row.getCell((short) 6);
			if(sup_longitude!=null){
			sup_longitude.setCellType(Cell.CELL_TYPE_STRING);
			longitude = Double.valueOf(sup_longitude.getStringCellValue().toString());
			}
			
			Cell sup_latitude = row.getCell((short) 7);
			if(sup_latitude!=null){
			sup_latitude.setCellType(Cell.CELL_TYPE_STRING);
			latitude = Double.valueOf(sup_latitude.getStringCellValue().toString());
			}
			
			sto.setSt_Address(address);
			sto.setSt_Latitude(latitude);
			sto.setSt_Longitude(longitude);
			sto.setSt_Managedept(dept);
			sto.setSt_Manageman(man);
			sto.setSt_Managemantel(mantel);
			sto.setSt_Suppliesid(supList.get(0));
			sto.setSt_Count(num);
			
			try {
				suppliesStoreService.save(sto);
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
