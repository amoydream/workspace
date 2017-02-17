package com.lauvan.apps.dailymanager.eventtj.controller;

import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.dailymanager.eventtj.model.T_Bus_MonSorce;
import com.lauvan.apps.event.model.T_Bus_EventInfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.DateTimeUtil;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
@RouteBind(path="Main/eventMonTj",viewPath="/dailymanager/eventtj")
public class EventMonTjController extends BaseController {
	public void index(){
		String nowtj = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_FORMAT);;
		setAttr("nowtj",nowtj);
		render("main.jsp");
	}
	
	public void getGridView(){
		String etjtime = getPara("etjtime");
		if(etjtime==null || "".equals(etjtime)){
			//当前时间
			etjtime = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_D_FORMAT);
		}
		String nowtj = etjtime.substring(0, 7);
		String start = etjtime.substring(0, 7)+"-01 00:00:00";
		String[] day = etjtime.split("-");
		Integer mon = Integer.parseInt(day[1])+1;
		Integer year = Integer.parseInt(day[0]);
		if(mon>12){
			year = year+1;
			mon = 1;
		}
		
		String end = year.toString()+"-"+(mon<10?("0"+mon):mon)+"-01 00:00:00";
		List<Record> elist = T_Bus_EventInfo.dao.getEVtjList(start, end);
		if(elist!=null && elist.size()>0){
			int num = 0;
			String str = "";
			float sum = 0;
			for(int i=0;i<elist.size();i++){
				Record r = elist.get(i);
				String organname = r.getStr("organname");
				float df = r.getNumber("df").floatValue();
				if(df<0){//得分为负数清零
					df=0;
				}
				String dfStr = String.valueOf(df);
				if(dfStr.endsWith(".0")){
					dfStr = dfStr.replace(".0", ""); 
				}
				r.set("df", dfStr);
				if(!str.equals(organname)){
					str = organname;
					if(i>0 && (i-num+1)>0){
						Record r2 = elist.get(i-num);
						r2.set("clospan", num);
						BigDecimal bydf = new   BigDecimal(sum/num);
						float byfloat = bydf.setScale(2,   BigDecimal.ROUND_HALF_UP).floatValue();
						String byStr = String.valueOf(byfloat);
						if(byStr.endsWith(".0")){
							byStr = byStr.replace(".0", ""); 
						}
						r2.set("bydf", byStr);
						//上月累计得分
						float lastsorce = T_Bus_MonSorce.dao.getlastSorce(day[0],day[1], r2.getStr("organname"));
						float ljdf = 0;
						if(lastsorce==0){
							ljdf =  byfloat;
						}else{
							ljdf =  lastsorce+byfloat;
						}
						String ljStr = String.valueOf(ljdf);
						if(ljStr.endsWith(".0")){
							ljStr = ljStr.replace(".0", ""); 
						}
						r2.set("ljdf",ljStr);
						//更新累计得分
						T_Bus_MonSorce nowsorce = T_Bus_MonSorce.dao.getMonSorce(nowtj, r2.getStr("organname"));
						if(nowsorce==null){
							nowsorce = new  T_Bus_MonSorce();
							nowsorce.set("organname", r2.getStr("organname"));
							nowsorce.set("montime", nowtj);
							nowsorce.set("bydf", byfloat);
							nowsorce.set("ljdf", ljdf);
							T_Bus_MonSorce.dao.insert(nowsorce);
						}else{
							nowsorce.set("ljdf", ljdf);
							nowsorce.set("bydf", byfloat);
							nowsorce.update();
						}
					}
					if(i==elist.size()-1){
						r.set("clospan", 1);
						r.set("bydf", dfStr);
						//上月累计得分
						float lastsorce = T_Bus_MonSorce.dao.getlastSorce(day[0],day[1], organname);
						float ljdf = 0;
						if(lastsorce==0){
							ljdf =  df;
							
						}else{
							ljdf =  lastsorce+df;
						}
						String ljStr = String.valueOf(ljdf);
						if(ljStr.endsWith(".0")){
							ljStr = ljStr.replace(".0", ""); 
						}
						r.set("ljdf",ljStr);
						//更新累计得分
						T_Bus_MonSorce nowsorce = T_Bus_MonSorce.dao.getMonSorce(nowtj, organname);
						if(nowsorce==null){
							nowsorce = new  T_Bus_MonSorce();
							nowsorce.set("organname", organname);
							nowsorce.set("montime", nowtj);
							nowsorce.set("bydf", df);
							nowsorce.set("ljdf", ljdf);
							T_Bus_MonSorce.dao.insert(nowsorce);
						}else{
							nowsorce.set("ljdf", ljdf);
							nowsorce.set("bydf", df);
							nowsorce.update();
						}
					}
					sum = df;
					num = 1;
				}else{
					sum = sum + df;
					num++;
					if(i==elist.size()-1){
						Record r2 = elist.get(i-num+1);
						r2.set("clospan", num);
						BigDecimal bydf = new   BigDecimal(sum/num);
						float byfloat = bydf.setScale(2,   BigDecimal.ROUND_HALF_UP).floatValue();
						String byStr = String.valueOf(byfloat);
						if(byStr.endsWith(".0")){
							byStr = byStr.replace(".0", ""); 
						}
						r2.set("bydf", byStr);
						//上月累计得分
						float lastsorce = T_Bus_MonSorce.dao.getlastSorce(day[0],day[1], r2.getStr("organname"));
						float ljdf = 0;
						if(lastsorce==0){
							ljdf =  byfloat;
						}else{
							ljdf =  lastsorce+byfloat;
						}
						String ljStr = String.valueOf(ljdf);
						if(ljStr.endsWith(".0")){
							ljStr = ljStr.replace(".0", ""); 
						}
						r2.set("ljdf",ljStr);
						//更新累计得分
						T_Bus_MonSorce nowsorce = T_Bus_MonSorce.dao.getMonSorce(nowtj, r2.getStr("organname"));
						if(nowsorce==null){
							nowsorce = new  T_Bus_MonSorce();
							nowsorce.set("organname", r2.getStr("organname"));
							nowsorce.set("montime", nowtj);
							nowsorce.set("bydf", byfloat);
							nowsorce.set("ljdf", ljdf);
							T_Bus_MonSorce.dao.insert(nowsorce);
						}else{
							nowsorce.set("ljdf", ljdf);
							nowsorce.set("bydf", byfloat);
							nowsorce.update();
						}
					}
				}
			}
			
		}
		setAttr("eyear",day[0]);
		setAttr("emon",Integer.parseInt(day[1]));
		setAttr("elist",elist);
		render("table.jsp");
	}
	public void export(){
		String etjtime = getPara("etjtime");
		if(etjtime==null || "".equals(etjtime)){
			//当前时间
			etjtime = DateTimeUtil.formatDate(new Date(), DateTimeUtil.Y_M_FORMAT);
		}
		String start = etjtime.substring(0, 7)+"-01 00:00:00";
		String[] day = etjtime.split("-");
		Integer mon = Integer.parseInt(day[1])+1;
		Integer year = Integer.parseInt(day[0]);
		if(mon>12){
			year = year+1;
			mon = 1;
		}
		String end = year.toString()+"-"+(mon<10?("0"+mon):mon)+"-01 00:00:00";
		List<Record> elist = T_Bus_EventInfo.dao.getEVtjList(start, end);
		//导出头
		HttpServletResponse res = getResponse();
		res.setContentType("application/vnd.ms-excel");
		try {
			res.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode(day[0]+"年"+Integer.parseInt(day[1])+"月份各县（区）有关单位报告突发事件信息采用情况", "UTF-8")+".xls");
			OutputStream os = res.getOutputStream();
			jxl.WorkbookSettings settings = new jxl.WorkbookSettings();
			jxl.write.WritableWorkbook wb = jxl.Workbook.createWorkbook(os, settings);
			jxl.write.WritableSheet sheet = wb.createSheet("突发事件信息采用情况", 0);
			
			sheet.setRowView(0, 740);
			sheet.setRowView(2, 360);
			sheet.setRowView(3, 540);
			
			sheet.setColumnView(1, 43);
			sheet.setColumnView(2, 7);
			sheet.setColumnView(3, 6);
			sheet.setColumnView(4, 6);
			sheet.setColumnView(5, 6);
			sheet.setColumnView(6, 6);
			sheet.setColumnView(7, 6);
			
			sheet.setColumnView(8, 9);
			sheet.setColumnView(9, 9);
			sheet.setColumnView(10, 6);
			sheet.setColumnView(11, 7);
			sheet.setColumnView(12, 8);
			//设置表格表头样式
			WritableFont font = new WritableFont(WritableFont.createFont("宋体"), 20, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE);
			WritableCellFormat headerFormat = new WritableCellFormat(NumberFormats.TEXT);
			headerFormat.setFont(font);
			//headerFormat.setBorder(Border.ALL, BorderLineStyle.THICK, Colour.BLACK);
			headerFormat.setAlignment(Alignment.CENTRE);
			headerFormat.setVerticalAlignment(VerticalAlignment.BOTTOM);
			//表格内容样式
			WritableFont font2 = new WritableFont(WritableFont.createFont("宋体"), 12, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE);
			WritableCellFormat bodyFormat1 = new WritableCellFormat(font2);
			bodyFormat1.setBackground(Colour.WHITE);
			bodyFormat1.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
			bodyFormat1.setAlignment(Alignment.CENTRE);
			bodyFormat1.setVerticalAlignment(VerticalAlignment.CENTRE);
			bodyFormat1.setWrap(true);
			//表格内容样式
			WritableFont font3 = new WritableFont(WritableFont.createFont("仿宋"), 12, WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE);
			WritableCellFormat bodyFormat = new WritableCellFormat(font3);
			bodyFormat.setBackground(Colour.WHITE);
			bodyFormat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
			bodyFormat.setAlignment(Alignment.CENTRE);
			bodyFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
			
			WritableCellFormat bodyFormat3 = new WritableCellFormat(font3);
			bodyFormat3.setBackground(Colour.WHITE);
			bodyFormat3.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
			
			sheet.addCell(new jxl.write.Label(0, 0, day[0]+"年"+Integer.parseInt(day[1])+"月份各县（区）有关单位报告突发事件信息采用情况", headerFormat));
			sheet.mergeCells(0, 0, 13, 0);
			
			//表头
			sheet.addCell(new jxl.write.Label(0, 2,"单位", bodyFormat1));
			sheet.addCell(new jxl.write.Label(1, 2,"题目", bodyFormat1));
			sheet.addCell(new jxl.write.Label(2, 2,"报送\r\n时效", bodyFormat1));
			sheet.addCell(new jxl.write.Label(3, 2,"使用情况", bodyFormat1));
			//sheet.addCell(new jxl.write.Label(8, 1,"国家领导批示", bodyFormat1));
			sheet.addCell(new jxl.write.Label(8, 2,"省领导\r\n批示", bodyFormat1));
			sheet.addCell(new jxl.write.Label(9, 2,"市领导\r\n批示", bodyFormat1));
			sheet.addCell(new jxl.write.Label(10, 2,"现场\r\n图片", bodyFormat1));
			sheet.addCell(new jxl.write.Label(11, 2,"得分", bodyFormat1));
			sheet.addCell(new jxl.write.Label(12, 2,"本月\r\n得分", bodyFormat1));
			sheet.addCell(new jxl.write.Label(13, 2,"累计\r\n得分", bodyFormat1));
			sheet.mergeCells(0, 2, 0, 3);
			sheet.mergeCells(1, 2, 1, 3);
			sheet.mergeCells(2, 2, 2, 3);
			sheet.mergeCells(3, 2, 7, 2);
			sheet.mergeCells(8, 2, 8, 3);
			sheet.mergeCells(9, 2, 9, 3);
			sheet.mergeCells(10, 2, 10, 3);
			sheet.mergeCells(11, 2, 11, 3);
			sheet.mergeCells(12, 2, 12, 3);
			sheet.mergeCells(13, 2, 13, 3);
			//sheet.mergeCells(14, 1, 14, 2);
			sheet.addCell(new jxl.write.Label(3, 3,"专报", bodyFormat1));
			sheet.addCell(new jxl.write.Label(4, 3,"传阅", bodyFormat1));
			sheet.addCell(new jxl.write.Label(5, 3,"综合", bodyFormat1));
			sheet.addCell(new jxl.write.Label(6, 3,"备查", bodyFormat1));
			sheet.addCell(new jxl.write.Label(7, 3,"约稿", bodyFormat1));
			
			
			//数据
			if(elist!=null && elist.size()>0){
				int mernum = 0;
				String mer = "";
				float sum = 0;
				for(int i=0;i<elist.size();i++){
					Record r = elist.get(i);
					String organname = r.getStr("organname");
					sheet.addCell(new jxl.write.Label(1, 4+i,r.getStr("title"), bodyFormat3));
					sheet.addCell(new jxl.write.Label(2, 4+i,r.getStr("bssx"), bodyFormat));
					sheet.addCell(new jxl.write.Label(3, 4+i,"1".equals(r.get("zb").toString())?"●":"", bodyFormat));
					sheet.addCell(new jxl.write.Label(4, 4+i,"1".equals(r.get("cy").toString())?"●":"", bodyFormat));
					sheet.addCell(new jxl.write.Label(5, 4+i,"1".equals(r.get("zh").toString())?"●":"", bodyFormat));
					sheet.addCell(new jxl.write.Label(6, 4+i,"1".equals(r.get("bc").toString())?"●":"", bodyFormat));
					sheet.addCell(new jxl.write.Label(7, 4+i,"1".equals(r.get("yg").toString())?"●":"", bodyFormat));
					//sheet.addCell(new jxl.write.Label(8, 4+i,"1".equals(r.get("guops").toString())?"●":"", bodyFormat));
					sheet.addCell(new jxl.write.Label(8, 4+i,"1".equals(r.get("shengps").toString())?"●":"", bodyFormat));
					sheet.addCell(new jxl.write.Label(9, 4+i,"1".equals(r.get("ships").toString())?"●":"", bodyFormat));
					sheet.addCell(new jxl.write.Label(10, 4+i,"1".equals(r.get("evimg").toString())?"●":"", bodyFormat));
					float df  = r.getNumber("df").floatValue();
					if(df<0){//得分为负数清零
						df=0;
					}
					String dfStr = String.valueOf(df);
					if(dfStr.endsWith(".0")){
						dfStr = dfStr.replace(".0", ""); 
					}
					sheet.addCell(new jxl.write.Label(11, 4+i,dfStr, bodyFormat));
					if(!mer.equals(organname)){
						sheet.addCell(new jxl.write.Label(0, 4+i,organname, bodyFormat));
						if(i>0 && (i-mernum)>0){
							//合并标题
							sheet.mergeCells(0, 4+(i-mernum-1), 0, 4+i-1);
							Record r2 = elist.get(i-mernum-1);
							BigDecimal bydf = new   BigDecimal(sum/(mernum+1));
							float byfloat = bydf.setScale(2,   BigDecimal.ROUND_HALF_UP).floatValue();
							String byStr = String.valueOf(byfloat);
							if(byStr.endsWith(".0")){
								byStr = byStr.replace(".0", ""); 
							}
							sheet.addCell(new jxl.write.Label(12, 4+(i-mernum-1),byStr, bodyFormat));
							sheet.mergeCells(12, 4+(i-mernum-1), 12, 4+i-1);
							//上月累计得分
							float lastsorce = T_Bus_MonSorce.dao.getlastSorce(day[0],day[1], r2.getStr("organname"));
							float ljdf = 0;
							if(lastsorce==0){
								ljdf =  byfloat;
							}else{
								ljdf =  lastsorce+byfloat;
							}
							String ljStr = String.valueOf(ljdf);
							if(ljStr.endsWith(".0")){
								ljStr = ljStr.replace(".0", ""); 
							}
							sheet.addCell(new jxl.write.Label(13, 4+(i-mernum-1),ljStr, bodyFormat));
							sheet.mergeCells(13, 4+(i-mernum-1), 13, 4+i-1);
						}
						if(i==elist.size()-1){
							
							sheet.addCell(new jxl.write.Label(12, 4+i,dfStr, bodyFormat));
							//上月累计得分
							float lastsorce = T_Bus_MonSorce.dao.getlastSorce(day[0],day[1], organname);
							float ljdf = 0;
							if(lastsorce==0){
								ljdf =  r.getNumber("df").floatValue();
								
							}else{
								ljdf =  lastsorce+r.getNumber("df").floatValue();
							}
							String ljStr = String.valueOf(ljdf);
							if(ljStr.endsWith(".0")){
								ljStr = ljStr.replace(".0", ""); 
							}
							sheet.addCell(new jxl.write.Label(13, 4+i,ljStr, bodyFormat));
						}
						sum = df;
						mernum = 0;
						mer = organname;
					}else{
						sum = sum + df;
						mernum++;
						if(i==elist.size()-1){
							Record r2 = elist.get(i-mernum);
							//合并标题
							sheet.mergeCells(0, 4+(i-mernum), 0, 4+i);
							BigDecimal bydf = new   BigDecimal(sum/(mernum+1));
							float byfloat = bydf.setScale(2,   BigDecimal.ROUND_HALF_UP).floatValue();
							String byStr = String.valueOf(byfloat);
							if(byStr.endsWith(".0")){
								byStr = byStr.replace(".0", ""); 
							}
							sheet.addCell(new jxl.write.Label(12, 4+(i-mernum),byStr, bodyFormat));
							sheet.mergeCells(12, 4+(i-mernum), 12, 4+i);
							//上月累计得分
							float lastsorce = T_Bus_MonSorce.dao.getlastSorce(day[0],day[1], r2.getStr("organname"));
							float ljdf = 0;
							if(lastsorce==0){
								ljdf =  byfloat;
							}else{
								ljdf =  lastsorce+byfloat;
							}
							String ljStr = String.valueOf(ljdf);
							if(ljStr.endsWith(".0")){
								ljStr = ljStr.replace(".0", ""); 
							}
							sheet.addCell(new jxl.write.Label(13, 4+(i-mernum),ljStr, bodyFormat));
							sheet.mergeCells(13, 4+(i-mernum), 13, 4+i);
						}
					}
				}
			}
			wb.write();
			wb.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			renderNull();
		}
	}
}
