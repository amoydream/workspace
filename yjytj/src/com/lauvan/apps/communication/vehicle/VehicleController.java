package com.lauvan.apps.communication.vehicle;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/vehicle",viewPath="/communication/vehicle")
public class VehicleController extends BaseController {
    public void main(){
    	
    	render("main.jsp");
    }
    
    public void getGridData(){
    	List<Record> list = new ArrayList<Record>();
        Record r1 = new Record();
        r1.set("ID", 1);
        r1.set("BRAND", "丰田皇冠");
        r1.set("VNUM", "ARS212L-DEZUTC");
        r1.set("VNO", "粤L53258");
        r1.set("GRADE", "小型客车");
        r1.set("BOX", "三厢");
        r1.set("SEATNUM", "5");
        r1.set("SPEEDLIMIT", "60");
        Record r2 = new Record();
        r2.set("ID",2);
        r2.set("BRAND", "奥迪A6L");
        r2.set("VNUM", "50 TFSI quattro 豪华型 S tronic");
        r2.set("VNO", "粤L56565");
        r2.set("GRADE", "小型客车");
        r2.set("BOX", "三厢");
        r2.set("SEATNUM", "5");
        r2.set("SPEEDLIMIT", "60");
        Record r3 = new Record();
        r3.set("ID",3);
        r3.set("BRAND", "丰田卡罗拉");
        r3.set("VNUM", "GLX-i S-CVT");
        r3.set("VNO", "粤L36528");
        r3.set("GRADE", "小型客车");
        r3.set("BOX", "三厢");
        r3.set("SEATNUM", "5");
        r3.set("SPEEDLIMIT", "60");
        Record r4 = new Record();
        r4.set("ID",4);
        r4.set("BRAND", "大众途观");
        r4.set("VNUM", "300TSI");
        r4.set("VNO", "粤L67868");
        r4.set("GRADE", "小型客车");
        r4.set("BOX", "二厢");
        r4.set("SEATNUM", "5");
        r4.set("SPEEDLIMIT", "60");
        Record r5 = new Record();
        r5.set("ID",5);
        r5.set("BRAND", "蒙迪欧");
        r5.set("VNUM", "GTDi200");
        r5.set("VNO", "粤L85686");
        r5.set("GRADE", "小型客车");
        r5.set("BOX", "三厢");
        r5.set("SEATNUM", "5");
        r5.set("SPEEDLIMIT", "60");
        Record r6 = new Record();
        r6.set("ID",6);
        r6.set("BRAND", "迈锐宝");
        r6.set("VNUM", "SGM7202EAAB");
        r6.set("VNO", "粤L65765");
        r6.set("GRADE", "小型客车");
        r6.set("BOX", "三厢");
        r6.set("SEATNUM", "5");
        r6.set("SPEEDLIMIT", "60");
		// 调用JsonUtil函数返回datagrid表格json数据
        list.add(r1);
        list.add(r2);
        list.add(r3);
        list.add(r4);
        list.add(r5);
        list.add(r6);
		String jsonStr = JsonUtil.getGridData(list, list.size());
		renderText(jsonStr);	
    }
    
    public void missionip(){
    	String id = getPara(0);
    	setAttr("id", id);
    	render("missionlist.jsp");
    }
    
    public void missionGridData(){
    	String id = getPara("id");  	
    	List<Record> list = new ArrayList<Record>();
    	if("1".equals(id)){
    	Record r1 = new Record();
    	r1.set("ID", 1);
    	r1.set("MISSION", "公务");		
    	r1.set("DRIVER", "张航");		
    	r1.set("TEL", "13883266582");		
    	r1.set("TIME", "2016-09-23 16:12:10");		
    	r1.set("VNO", "粤L53258");
    	list.add(r1);
    	}else if("2".equals(id)){
    	Record r2 = new Record();
    	r2.set("ID", 2);
    	r2.set("MISSION", "公务");		
    	r2.set("DRIVER", "李思");		
    	r2.set("TEL", "13625067789");		
    	r2.set("TIME", "2016-09-23 15:18:08");		
    	r2.set("VNO", "粤L56565");
    	list.add(r2);
    	}else if("3".equals(id)){
    	Record r3 = new Record();
    	r3.set("ID", 3);
    	r3.set("MISSION", "公务");		
    	r3.set("DRIVER", "黄宏民");		
    	r3.set("TEL", "15789367988");		
    	r3.set("TIME", "2016-09-23 11:02:08");		
    	r3.set("VNO", "粤L36528");
    	list.add(r3);
    	}else if("4".equals(id)){
		Record r4 = new Record();
		r4.set("ID", 4);
    	r4.set("MISSION", "公务");		
    	r4.set("DRIVER", "周明宇");		
    	r4.set("TEL", "15058213781");		
    	r4.set("TIME", "2016-09-22 16:10:28");
    	r4.set("VNO", "粤L67868");
    	list.add(r4);
    	}else if("5".equals(id)){
    		Record r5 = new Record();
    		r5.set("ID", 5);
        	r5.set("MISSION", "公务");		
        	r5.set("DRIVER", "陈海波");		
        	r5.set("TEL", "13680231673");		
        	r5.set("TIME", "2016-09-22 14:20:07");		
        	r5.set("VNO", "粤L85686");
        	list.add(r5);
    	}else if("6".equals(id)){
    		Record r6 = new Record();
    		r6.set("ID", 6);
        	r6.set("MISSION", "公务");		
        	r6.set("DRIVER", "王世明");		
        	r6.set("TEL", "15823677688");		
        	r6.set("TIME", "2016-09-21 10:28:17");		
        	r6.set("VNO", "粤L65765");
        	list.add(r6);
    	}   
    	String jsonStr = JsonUtil.getGridData(list, list.size());
		renderText(jsonStr);
    }
    
    public void addmission(){
    	render("addmission.jsp");
    }
    
    public void getmissionview(){
    	String id = getPara(0);  	
    	Record r = new Record();
    	if("1".equals(id)){
    	r.set("mission", "公务");		
    	r.set("driver", "张航");		
    	r.set("tel", "13883266582");		
    	r.set("time", "2016-09-23 16:12:10");		
    	r.set("vno", "粤L53258");
    	r.set("content", "公务详情");
    	}else if("2".equals(id)){
    	r.set("mission", "公务");		
    	r.set("driver", "李思");		
    	r.set("tel", "13625067789");		
    	r.set("time", "2016-09-23 15:18:08");		
    	r.set("vno", "粤L56565");
    	r.set("content", "公务详情");
    	}else if("3".equals(id)){
    	r.set("mission", "公务");		
    	r.set("driver", "黄宏民");		
    	r.set("tel", "15789367988");		
    	r.set("time", "2016-09-23 11:02:08");		
    	r.set("vno", "粤L36528");
    	r.set("content", "公务详情");
    	}else if("4".equals(id)){
    	r.set("mission", "公务");		
    	r.set("driver", "周明宇");		
    	r.set("tel", "15058213781");		
    	r.set("time", "2016-09-22 16:10:28");
    	r.set("vno", "粤L67868");
    	r.set("content", "公务详情");
    	}else if("5".equals(id)){   	
        	r.set("mission", "公务");		
        	r.set("driver", "陈海波");		
        	r.set("tel", "13680231673");		
        	r.set("time", "2016-09-22 14:20:07");		
        	r.set("vno", "粤L85686");
        	r.set("content", "公务详情");
    	}else if("6".equals(id)){   		
        	r.set("mission", "公务");		
        	r.set("driver", "王世明");		
        	r.set("tel", "15823677688");		
        	r.set("time", "2016-09-21 10:28:17");		
        	r.set("vno", "粤L65765");
        	r.set("content", "公务详情");
    	}   
    	setAttr("m", r);
    	render("mission.jsp");
    }
    
    public void add(){
    	render("add.jsp");
    }
    
    public void edit(){
    	String id = getPara(0);
    	Record r = new Record();
    	if("1".equals(id)){
    	        r.set("brand", "丰田皇冠");
    	        r.set("vnum", "ARS212L-DEZUTC");
    	        r.set("vno", "粤L53258");  	     
    	        r.set("grade", "小型客车");
    	        r.set("box", "三厢");
    	        r.set("seatnum", "5");
    	        r.set("address", "市政府大院A停车场8号");
    	        r.set("speedlimit", "60");  	       
    	}else if("2".equals(id)){
    	        r.set("brand", "奥迪A6L");
    	        r.set("vnum", "50 TFSI quattro 豪华型 S tronic");
    	        r.set("vno", "粤L56565");
    	        r.set("grade", "小型客车");
    	        r.set("box", "三厢");
    	        r.set("seatnum", "5");
    	        r.set("address", "市政府大院A停车场6号");
    	        r.set("speedlimit", "60");
    	}else if("3".equals(id)){
    		    r.set("brand", "丰田卡罗拉");
    	        r.set("vnum", "GLX-i S-CVT");
    	        r.set("vno", "粤L36528");
    	        r.set("grade", "小型客车");
    	        r.set("box", "三厢");
    	        r.set("seatnum", "5");
    	        r.set("address", "市政府大院A停车场11号");
    	        r.set("speedlimit", "60");
    	}else if("4".equals(id)){
    		r.set("BRAND", "大众途观");
            r.set("VNUM", "300TSI");
            r.set("VNO", "粤L67868");
            r.set("GRADE", "小型客车");
            r.set("BOX", "二厢");
            r.set("SEATNUM", "5");
            r.set("address", "市政府大院B停车场10号");
            r.set("SPEEDLIMIT", "60");
    	}else if("5".equals(id)){
    		r.set("BRAND", "蒙迪欧");
            r.set("VNUM", "GTDi200");
            r.set("VNO", "粤L85686");
            r.set("GRADE", "小型客车");
            r.set("BOX", "三厢");
            r.set("SEATNUM", "5");
            r.set("address", "市政府大院B停车场2号");
            r.set("SPEEDLIMIT", "60");
    	}else if("6".equals(id)){
    	        r.set("BRAND", "迈锐宝");
    	        r.set("VNUM", "SGM7202EAAB");
    	        r.set("VNO", "粤L65765");
    	        r.set("GRADE", "小型客车");
    	        r.set("BOX", "三厢");
    	        r.set("SEATNUM", "5");
    	        r.set("address", "市政府大院B停车场20号");
    	        r.set("SPEEDLIMIT", "60");
    	}
    	setAttr("v", r);
    	render("edit.jsp");
    }
}
