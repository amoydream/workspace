package com.lauvan.dutymanage1.controller;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lauvan.aoplog.MethodLog;
import com.lauvan.base.controller.BaseController;
import com.lauvan.dutymanage1.entity.T_Duty_Schedule1;
import com.lauvan.dutymanage1.service.DutySchedule1Service;
import com.lauvan.dutymanage1.vo.DutySchedule1Vo;
import com.lauvan.interceptor.Perm;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.organ.service.OrganPersonService;
import com.lauvan.util.BaseUtil;
import com.lauvan.util.Json;
import com.lauvan.util.ValidateUtil;
/**
 * 
 * ClassName: DutySchedule1Controller 
 * @Description: 值班排班管理
 * @author 钮炜炜
 * @date 2016年3月4日 下午4:56:08
 */
@Controller
@RequestMapping("dutymanage/dutyschedule1")
public class DutySchedule1Controller extends BaseController {

	@Autowired
	private DutySchedule1Service dutySchedule1Service;
	@Autowired
	private OrganPersonService organPersonSerivce;
	
	@RequestMapping("/main")
	public String main() {
		return "jsp/dutymanage1/dutyschedule/dutyschedule_calendar";
	}
	@RequestMapping("/list")
	@ResponseBody
	public List<T_Duty_Schedule1> list(String start,String end) {
		if (!ValidateUtil.isEmpty(start) && !ValidateUtil.isEmpty(end)) {
			return dutySchedule1Service.findByBetWeen("duty_date", ValidateUtil.parseDate(start), ValidateUtil.parseDate(end));
		}
		return null;
	}
	@RequestMapping("/listtemp")
	@ResponseBody
	public List<T_Duty_Schedule1> listtemp() {
		return dutySchedule1Service.findByProperty("duty_temp", "1");
	}
	
	@MethodLog(description = "值班添加")
	@Perm(privilegeValue = "dutyAdd")
	@RequestMapping("/add")
	@ResponseBody
	public Json add(DutySchedule1Vo dutySchedule1Vo) {
		T_Duty_Schedule1 schedule1 = new T_Duty_Schedule1();
		BeanUtils.copyProperties(dutySchedule1Vo, schedule1);
		if (!ValidateUtil.isEmpty(dutySchedule1Vo.getPe_id())) {
			if (!dutySchedule1Service.exsit("duty_date", dutySchedule1Vo.getDuty_date(), "person.pe_id", dutySchedule1Vo.getPe_id())) {
				schedule1.setPerson(new C_Organ_Person(dutySchedule1Vo.getPe_id()));
			}else {
				return json("重复数据");
			}
		}
		try {
			dutySchedule1Service.save(schedule1);
			return json(true, "值班排班添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("值班排班添加失败");
		}
	}
	
	@MethodLog(description = "值班编辑UI")
	@Perm(privilegeValue = "dutyEditip")
	@RequestMapping("/editip")
	public String editip(Integer id,Model model) {
		if (!ValidateUtil.isEmpty(id)) {
			T_Duty_Schedule1 schedule = dutySchedule1Service.find(id);
			model.addAttribute("schedule", schedule);
			return "jsp/dutymanage1/dutyschedule/dutyschedule_edit";
		}
		return "";
	}
	
	@MethodLog(description = "值班编辑")
	@Perm(privilegeValue = "dutyEdit")
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(DutySchedule1Vo dutySchedule1Vo) {
		if (ValidateUtil.isEmpty(dutySchedule1Vo.getDuty_id())) {
			return json("值班排班ID没有获取到");
		}
		T_Duty_Schedule1 schedule1 = dutySchedule1Service.find(dutySchedule1Vo.getDuty_id());
		if (!ValidateUtil.isEmpty(dutySchedule1Vo.getDays())) {
			schedule1.setDuty_date(ValidateUtil.dateAddOrSub(schedule1.getDuty_date(), dutySchedule1Vo.getDays()));
		}else {
			BeanUtils.copyProperties(dutySchedule1Vo, schedule1);
			if (!ValidateUtil.isEmpty(dutySchedule1Vo.getPe_id())) {
				schedule1.setPerson(new C_Organ_Person(dutySchedule1Vo.getPe_id()));
			}
		}
		
		try {
			dutySchedule1Service.update(schedule1);
			return json(true, "值班排班修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("值班排班修改失败");
		}
	}
	@RequestMapping("/addDrop")
	@ResponseBody
	public Json addDrop(DutySchedule1Vo dutySchedule1Vo) {
		if (ValidateUtil.isEmpty(dutySchedule1Vo.getDuty_id())) {
			return json("值班排班ID没有获取到");
		}
		T_Duty_Schedule1 schedule1 = dutySchedule1Service.find(dutySchedule1Vo.getDuty_id());
		T_Duty_Schedule1 schedule = new T_Duty_Schedule1();
		BeanUtils.copyProperties(schedule1, schedule);
		schedule.setDuty_date(dutySchedule1Vo.getDuty_date());
		schedule.setDuty_id(null);
		schedule.setDuty_temp(null);
		try {
			dutySchedule1Service.save(schedule);
			return json(true, "值班排班添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("值班排班添加失败");
		}
	}
	@RequestMapping("/tempoff")
	@ResponseBody
	public Json tempoff(Integer id) {
		if (ValidateUtil.isEmpty(id)) {
			return json("值班排班ID没有获取到");
		}
		T_Duty_Schedule1 schedule = dutySchedule1Service.find(id);
		schedule.setDuty_temp(null);
		
		try {
			dutySchedule1Service.save(schedule);
			return json(true, "模板取消成功");
		} catch (Exception e) {
			e.printStackTrace();
			return json("模板取消失败");
		}
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Json delete(Integer id) {
		if (!ValidateUtil.isEmpty(id)) {
			try {
				dutySchedule1Service.delete(id);
				return json(true, "值班排班删除成功");
			} catch (Exception e) {
				e.printStackTrace();
				return json("值班排班删除失败");
			}
		}
		return json("没有做任何操作");
	}
	/**
	 * 值班报表
	 * @param start
	 * @param end
	 * @param duty_ifleader
	 * @param model
	 * @return
	 */
	@RequestMapping("/reportOut")
	public String reportOut(String start,String end,String duty_ifleader,Model model) {
		if (!ValidateUtil.isEmpty(start) && !ValidateUtil.isEmpty(end)) {
			com.zhuozhengsoft.pageoffice.excelwriter.Workbook wb = new com.zhuozhengsoft.pageoffice.excelwriter.Workbook();
			com.zhuozhengsoft.pageoffice.excelwriter.Sheet sheet = wb.openSheet("sheet1");
			//设置日期
			sheet.openCell("A2").setValue(start+"至"+end);
			//[name,id]
			List<Object> list = dutySchedule1Service.getDutyPersonName(start, end,duty_ifleader);
			if(list!=null && list.size()>0){
				//表头数据域
				int num = list.size();
				char c = 'A';
				int cn1 = num%26;
				int cn2 = num/26;
				c = (char) (c + cn1);
				String str="";
				if(cn2>0){
					for(int i=0;i<cn2;i++){
						str = str+"A";
					}
				}
				str = str + String.valueOf(c);
				com.zhuozhengsoft.pageoffice.excelwriter.Table table = sheet.openTable("B3:"+str+"4");//数据域
				table.getBorder().setBorderType(com.zhuozhengsoft.pageoffice.excelwriter.XlBorderType.xlFullGrid);
				table.getBorder().setLineStyle(com.zhuozhengsoft.pageoffice.excelwriter.XlBorderLineStyle.xlContinuous);
				table.getBorder().setWeight(com.zhuozhengsoft.pageoffice.excelwriter.XlBorderWeight.xlThin);
				table.getBorder().setLineColor(java.awt.Color.black);
				for (int i = 0; i < list.size(); i++) {
					Object[] obj = (Object[]) list.get(i);
					sheet.openTable((char)('B'+i)+"3:"+(char)('B'+i)+"4").merge();
					//插入值班人员
					table.getDataFields().get(i).setValue(obj[0].toString());
				}
				table.nextRow();
				table.close();
				//设置数据
				List<T_Duty_Schedule1> duty_Schedule1s = dutySchedule1Service.getDutys(ValidateUtil.parseDate(start), ValidateUtil.parseDate(end),duty_ifleader);
				com.zhuozhengsoft.pageoffice.excelwriter.Table table2 = sheet.openTable("A5:"+str+"5");//数据域
				table2.getBorder().setBorderType(com.zhuozhengsoft.pageoffice.excelwriter.XlBorderType.xlFullGrid);
				table2.getBorder().setLineStyle(com.zhuozhengsoft.pageoffice.excelwriter.XlBorderLineStyle.xlContinuous);
				table2.getBorder().setWeight(com.zhuozhengsoft.pageoffice.excelwriter.XlBorderWeight.xlThin);
				table2.getBorder().setLineColor(java.awt.Color.black);
				
				for(int i= 0;i<duty_Schedule1s.size();i++){
					for(int m1=0;m1<table2.getDataFields().size();m1++){
						if(m1==0){
							try {
								table2.getDataFields().get(m1).setValue(BaseUtil.parseDateToString(duty_Schedule1s.get(i).getDuty_date()));
							} catch (Exception e) {
								table2.getDataFields().get(m1).setValue("");
								e.printStackTrace();
							}
						}else{
							Object[] obj = (Object[]) list.get(m1-1);
							System.out.println(Integer.parseInt(obj[1]==null?"":obj[1].toString()));
							List<T_Duty_Schedule1> duList= dutySchedule1Service.getIfDuty(duty_Schedule1s.get(i).getDuty_date().toString(), Integer.parseInt(obj[1]==null?"":obj[1].toString()));
							if(duList.size()!=0){
								table2.getDataFields().get(m1).setValue("值班");
							}else{
								table2.getDataFields().get(m1).setValue("\\");
							}
						}
					}
					if(i==0||!duty_Schedule1s.get(i).getDuty_date().equals(duty_Schedule1s.get(i-1).getDuty_date())){
						table2.nextRow();
					}
				}
				table2.close();
			
				
				/*for (T_Duty_Schedule1 duty_Schedule1 : duty_Schedule1s) {
					Integer pid = duty_Schedule1.getPerson().getPe_id();
					for(int m1=0;m1<table2.getDataFields().size();m1++){
						if(m1==0){
							try {
								table2.getDataFields().get(m1).setValue(BaseUtil.parseDateToString(duty_Schedule1.getDuty_date()));
							} catch (Exception e) {
								table2.getDataFields().get(m1).setValue("");
								e.printStackTrace();
							}
						}else{
							Object[] obj = (Object[]) list.get(m1-1);
							if(pid.equals(obj[1])){
								table2.getDataFields().get(m1).setValue("值班");
							}else{
								table2.getDataFields().get(m1).setValue("\\");
							}
						}
					}
					table2.nextRow();
				}
				table2.close();*/
			}
			
			model.addAttribute("wb",wb);
			return "jsp/poffice/zbreport";
		}
		return "";
	}
	
	
}
