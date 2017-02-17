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
import com.lauvan.organ.entity.C_Organ;
import com.lauvan.organ.service.OrganService;
import com.lauvan.resource.entity.R_Team;
import com.lauvan.resource.service.TeamService;
import com.lauvan.resource.vo.TeamVo;
import com.lauvan.system.entity.T_User_Info;
import com.lauvan.system.vo.UserInfoVo;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;

/**
 * 
 * ClassName: TeamController 
 * @Description: 救援队伍
 * @author 周志高
 * @date 2015年11月26日 上午10:34:52
 */
@Controller
@RequestMapping("resource/team")
public class TeamController extends BaseController{
	
	@Autowired
	private TeamService teamService;
	@Autowired
	private OrganService organService;
	
	private void queryList(Integer page, String query, TeamVo teamvo,
			Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Team> pageView = new PageView<R_Team>(8, ((page==null || page<1) ? 1:page));
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();			
			if (!ValidateUtil.isEmpty(teamvo.getTe_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.te_Name like ?").append((params.size()+1));
				params.add("%"+teamvo.getTe_Name().trim()+"%");
			}
			model.addAttribute("teamvo", teamvo);
			pageView.setQueryResult(teamService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(),params.toArray()));
		}else {
			pageView.setQueryResult(teamService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult()));
		}
		model.addAttribute("pageView", pageView);
	}
	
	@RequestMapping("/main")
	public String main(Integer page, String query, TeamVo teamvo, Model model) {
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		PageView<R_Team> pageView = new PageView<R_Team>(15, ((page==null || page<1) ? 1:page));
		if ("true".equals(query)) {
			StringBuffer jpql = new StringBuffer("");
			List<Object> params = new ArrayList<Object>();
			if (!ValidateUtil.isEmpty(teamvo.getTe_Name())) {
				if (params.size()>0)
					jpql.append(" and ");
				jpql.append(" o.te_Name like ?").append((params.size()+1));
				params.add("%"+teamvo.getTe_Name().trim()+"%");
			}
			model.addAttribute("teamvo", teamvo);
			pageView.setQueryResult(teamService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult(),jpql.toString(),params.toArray()));
		}else {
			pageView.setQueryResult(teamService.getScrollList(pageView.getFirstResult(), pageView.getMaxresult()));
		}
		model.addAttribute("pageView", pageView);
		return "jsp/resource/team/team_main";
	}
	
	@RequestMapping("/maplist")
	@ResponseBody
	public List<R_Team> maplist(TeamVo teamVo,String query) {
			List<R_Team> allDanger = teamService.getListEntitys();
			return allDanger;
	}
	
	@RequestMapping("/list")
	public String list(Integer page, String query, TeamVo teamvo, Model model) {
		queryList(page, query, teamvo, model);
		return "jsp/resource/team/team_select";
	}
	
	@MethodLog(description="队伍添加UI")
	@Perm(privilegeValue = "teamAddip")
	@RequestMapping("/addip")
	public String addip() {
		return "jsp/resource/team/team_add";
	}
	
	@MethodLog(description="队伍添加")
	@Perm(privilegeValue = "teamAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(R_Team team, HttpSession session) {
		UserInfoVo u = (UserInfoVo) session.getAttribute("userVo");
		team.setTe_Recordman(new T_User_Info(u.getUs_Id()));			
		team.setTe_Recorddate(new Date());
		try {
			teamService.save(team);
			return json(true, "队伍添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("队伍添加失败");
		}
	}
	
	@MethodLog(description="队伍编辑UI")
	@Perm(privilegeValue = "teamEditip")
	@RequestMapping("/editip")
	public String editip(Integer teId,Model model) {
		if (!ValidateUtil.isEmpty(teId)) {
			R_Team team = teamService.find(teId);
			model.addAttribute("team", team);
			return "jsp/resource/team/team_edit";
		}
		return null;
	}
	
	@MethodLog(description="队伍编辑")
	@Perm(privilegeValue = "teamEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(TeamVo teamVo) {
		R_Team team = teamService.find(teamVo.getTe_Id());
		BeanUtils.copyProperties(teamVo, team);
		
		try {
			teamService.update(team);
			return json(true,"队伍信息修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("队伍信息修改失败");
		}
	}
	
	@MethodLog(description="队伍删除")
	@Perm(privilegeValue = "teamDelete")
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer teId) {
		try {
			teamService.delete(teId);
			return json(true, "队伍信息删除成功");
		} catch (Exception e1) {
			e1.printStackTrace();
			return json("队伍信息删除失败");
		}
	}
	
	@RequestMapping("/search")
	@ResponseBody
	public List<R_Team> search(Double longitude,Double latitude,Model model) {
		double[] ar = ValidateUtil.getAround(latitude,longitude, 5000);
		List<R_Team> ms = teamService.getlatlon(ar[0], ar[1], ar[2], ar[3]);
		return ms;
	}
	
	@RequestMapping("/excelOut")
	public String excelOut(Model model) {
		com.zhuozhengsoft.pageoffice.excelwriter.Workbook wb = new com.zhuozhengsoft.pageoffice.excelwriter.Workbook();
		com.zhuozhengsoft.pageoffice.excelwriter.Sheet sheet = wb.openSheet("sheet1");
			List<R_Team> list = teamService.getListEntitys();
			
			sheet.openCell("A4").setValue("名称");
			sheet.openCell("B4").setValue("负责人");
			sheet.openCell("C4").setValue("负责人电话");
			sheet.openCell("D4").setValue("地址");
			
			int i=5;
			for(R_Team element:list){
					    sheet.openCell("A"+i).setValue(element.getTe_Name()+"");
						sheet.openCell("B"+i).setValue(element.getTe_Director()+"");
						sheet.openCell("C"+i).setValue(element.getTe_Directortel()+"");
						sheet.openCell("D"+i).setValue(element.getTe_Address()+"");
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
		if (rowHead.getPhysicalNumberOfCells() != 12) {
			response.getWriter().write("表头数量不对，请检查excel格式");
			return null;
		}
		// 获得数据的总行数
				int totalRowNum = sheet.getLastRowNum();
	    //要获得的属性
				String name = "";
				String mman = "";
				String mmantel = "";
				String mmanphone = "";
				String type = "";
				String dept = "";
				Integer num = 0;
				String lman = "";
				String lmantel = "";
				String address = "";
				Double longitude = 0.0;
				Double latitude = 0.0;
		// 获得所有数据
		for (int i = 1; i <= totalRowNum; i++) {
			R_Team team = new R_Team();
			Row row = sheet.getRow(i);
			
			Cell te_name = row.getCell((short) 0);
			if(te_name!=null){
			name = te_name.getStringCellValue().toString();
			}
			
			Cell te_mman = row.getCell((short) 1);
			mman = te_mman.getStringCellValue().toString();
			
			Cell te_mmantel = row.getCell((short) 2);
			if(te_mmantel!=null){
			te_mmantel.setCellType(Cell.CELL_TYPE_STRING);
			mmantel = te_mmantel.getStringCellValue().toString();
			}
			
			Cell te_mmanphone = row.getCell((short) 3);
			if(te_mmanphone!=null){
			te_mmanphone.setCellType(Cell.CELL_TYPE_STRING);
			mmanphone = te_mmanphone.getStringCellValue().toString();
			}

			Cell te_type = row.getCell((short) 4);
			if(te_type!=null){
			type = te_type.getStringCellValue().toString();
			}
			
			Cell te_dept = row.getCell((short) 5);
			if(te_dept!=null){
			dept = te_dept.getStringCellValue().toString();
			List<C_Organ> organList = organService.findByProperty("or_name", dept);
			if(organList.size()==0){ 
				response.getWriter().write("第  " +i+ " 行错误,不存在的单位,请检查数据");
				return null;
			}
			team.setTe_Deptid(organList.get(0));
			}
			
			Cell te_num = row.getCell((short) 8);
			if(te_num!=null){
			te_num.setCellType(Cell.CELL_TYPE_STRING);
			num = Integer.valueOf(te_num.getStringCellValue().toString());
			}
			
			Cell te_lman = row.getCell((short) 7);
			if(te_lman!=null){
			lman = te_lman.getStringCellValue().toString();
			}
			
			Cell te_lmantel = row.getCell((short) 8);
			if(te_lmantel!=null){
			te_lmantel.setCellType(Cell.CELL_TYPE_STRING);
			lmantel = te_lmantel.getStringCellValue().toString();
			}
			
			Cell te_address = row.getCell((short) 9);
			if(te_address!=null){
			address = te_address.getStringCellValue().toString();
			}
			
			Cell te_longitude = row.getCell((short) 10);
			if(te_longitude!=null){
			te_longitude.setCellType(Cell.CELL_TYPE_STRING);
			longitude = Double.valueOf(te_longitude.getStringCellValue().toString());
			}
			
			Cell te_latitude = row.getCell((short) 11);
			if(te_latitude!=null){
			te_latitude.setCellType(Cell.CELL_TYPE_STRING);
			latitude = Double.valueOf(te_latitude.getStringCellValue().toString());
			}
			
			team.setTe_Name(name);
			team.setTe_Director(mman);
			team.setTe_Directortel(mmantel);
			team.setTe_Directorphone(mmanphone);
			team.setTe_Type(type);
			team.setTe_Membernum(num);
			team.setTe_Linkman(lman);
			team.setTe_Linkmantel(lmantel);
			team.setTe_Address(address);
			team.setTe_Longitude(longitude);
			team.setTe_Latitude(latitude);
			
			try {
				teamService.save(team);
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
