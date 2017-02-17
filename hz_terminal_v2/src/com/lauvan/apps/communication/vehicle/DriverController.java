package com.lauvan.apps.communication.vehicle;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.plugin.activerecord.Record;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/driver",viewPath="/communication/vehicle/driver")
public class DriverController extends BaseController {
	
	public void main(){
		
		render("main.jsp");
	}
	
	public void getGridData(){
		List<Record> list = new ArrayList<Record>();
        Record r1 = new Record();
        r1.set("ID", 1);
        r1.set("NAME", "张航");
        r1.set("SEX", "男");
        r1.set("TYPE", "C1");
        r1.set("TEL", "13883266582");
        Record r2 = new Record();
        r2.set("ID", 2);
        r2.set("NAME", "李思");
        r2.set("SEX", "男");
        r2.set("TYPE", "C1");
        r2.set("TEL", "13625067789");
        Record r3 = new Record();
        r3.set("ID", 3);
        r3.set("NAME", "黄宏民");
        r3.set("SEX", "男");
        r3.set("TYPE", "C1");
        r3.set("TEL", "15789367988");
        Record r4 = new Record();
        r4.set("ID", 4);
        r4.set("NAME", "周明宇");
        r4.set("SEX", "男");
        r4.set("TYPE", "C1");
        r4.set("TEL", "15058213781");
        Record r5 = new Record();
        r5.set("ID", 5);
        r5.set("NAME", "陈海波");
        r5.set("SEX", "男");
        r5.set("TYPE", "C1");
        r5.set("TEL", "13680231673");
        Record r6 = new Record();
        r6.set("ID", 6);
        r6.set("NAME", "王世明");
        r6.set("SEX", "男");
        r6.set("TYPE", "C1");
        r6.set("TEL", "15823677688");
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
	
	public void getDrivers(){
		render("select.jsp");
	}
	
	public void getSelectData(){
		
		List<Record> list = new ArrayList<Record>();
        Record r1 = new Record();
        r1.set("ID", 1);
        r1.set("NAME", "张航");
        r1.set("SEX", "男");
        r1.set("TYPE", "C1");
        r1.set("TEL", "13883266582");
        Record r2 = new Record();
        r2.set("ID", 2);
        r2.set("NAME", "李思");
        r2.set("SEX", "男");
        r2.set("TYPE", "C1");
        r2.set("TEL", "13625067789");
        Record r3 = new Record();
        r3.set("ID", 3);
        r3.set("NAME", "黄宏民");
        r3.set("SEX", "男");
        r3.set("TYPE", "C1");
        r3.set("TEL", "15789367988");
        Record r4 = new Record();
        r4.set("ID", 4);
        r4.set("NAME", "周明宇");
        r4.set("SEX", "男");
        r4.set("TYPE", "C1");
        r4.set("TEL", "15058213781");
        Record r5 = new Record();
        r5.set("ID", 5);
        r5.set("NAME", "陈海波");
        r5.set("SEX", "男");
        r5.set("TYPE", "C1");
        r5.set("TEL", "13680231673");
        Record r6 = new Record();
        r6.set("ID", 6);
        r6.set("NAME", "王世明");
        r6.set("SEX", "男");
        r6.set("TYPE", "C1");
        r6.set("TEL", "15823677688");
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
	
	public void add(){
		render("add.jsp");
	}
	
	
	public void edit(){
		String id = getPara(0);
		Record r = new Record();
		if("1".equals(id)){
			 r.set("NAME", "张航");
		        r.set("SEX", 1);
		        r.set("TYPE", 1);
		        r.set("TEL", "13883266582");	
		}else if("2".equals(id)){			
		        r.set("NAME", "李思");
		        r.set("SEX", 1);
		        r.set("TYPE", 1);
		        r.set("TEL", "13625067789");
		}else if("3".equals(id)){
			r.set("NAME", "黄宏民");
	        r.set("SEX", 1);
	        r.set("TYPE", 1);
	        r.set("TEL", "15789367988");	
	     }else if("4".equals(id)){
	         r.set("NAME", "周明宇");
	         r.set("SEX", 1);
	         r.set("TYPE", 1);
	         r.set("TEL", "15058213781");
         }else if("5".equals(id)){
             r.set("NAME", "陈海波");
             r.set("SEX", 1);
             r.set("TYPE", 1);
             r.set("TEL", "13680231673");
         }else if("6".equals(id)){
             r.set("NAME", "王世明");
             r.set("SEX", 1);
             r.set("TYPE", 1);
             r.set("TEL", "15823677688");
        }
		setAttr("d", r);
		render("edit.jsp");
	}
     
}
