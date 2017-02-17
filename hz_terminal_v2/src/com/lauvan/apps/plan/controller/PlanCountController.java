package com.lauvan.apps.plan.controller;
/**
 * 应急预案统计分析控制类
 * @author 郭广欢
 * */

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;

import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.communication.comdecivemanagement.controller.ComDeciveMgController;
import com.lauvan.apps.plan.model.T_Bus_Preschinfo;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
@RouteBind(path="Main/plancount",viewPath="/plan/count")
public class PlanCountController extends BaseController {
	private static final Logger log = Logger.getLogger(ComDeciveMgController.class);
	public void index(){
		setAttr("counttype","001");
		render("main.jsp");
	}
	public void gethistogram(){
		String counttype=getPara("counttype");
		setAttr("counttype",counttype);
		renderJsp("histogram.jsp");
	}
	public void getCount(List<Record> oldlist){
		Map<String,Object> map=new HashMap<String,Object>();
		List<Record> mapleaf=new ArrayList<Record>();
		for(Record r:oldlist){
			if(r.get("lvl").toString().equals("0")){
			map.put(r.get("id").toString(), 0);	
			}else{
			if(r.get("countnum")==null){
				r.set("countnum", 0);
			}
			mapleaf.add(r);
			}
		}
		while(!map.isEmpty()){
		for	(Record temp:mapleaf){
			String pid=temp.get("sup_id").toString();
			int value=Integer.valueOf(temp.get("countnum").toString());
			int oldvalue=Integer.valueOf(map.get(pid)==null?"0":map.get(pid).toString());
			map.put(pid, oldvalue+value);
		}
		mapleaf.clear();
		for(Entry<String, Object> entry:map.entrySet()){
			for(Record temp:oldlist){
				if(entry.getKey().toString().equals(temp.get("id").toString())){
				temp.set("countnum", entry.getValue());
				mapleaf.add(temp);
				}
			}
			map.remove(entry.getKey());
		}
		}
	}
	public void getData(){
		String counttype=getPara("counttype");
		String[] type={"00A"};
		Map<String, Object> result = new HashMap<String, Object>(); 
		try{
		if(counttype.equals("001")){
		List<Record> list=T_Bus_Preschinfo.dao.getcountListbytype();	
		getCount(list);
		Number[] nowdata = new Number[list.size()];
		String[] hang = new String[list.size()];
		for(int i=0; i<nowdata.length; i++){
			Record r = list.get(i);
			nowdata[i] = r.get("countnum");
			hang[i] = r.getStr("p_name");
		}
		for(int i=0;i<list.size();i++){
			if(list.get(i).get("lvl").toString().equals("0")){
				list.remove(i);
				i--;
			}
		}
		result.put("type", type);
		result.put("nowdata", nowdata);
		result.put("piedata", list.toArray());
		result.put("hang", hang);
		}else if(counttype.equals("002")){
		List<Record> list=T_Bus_Preschinfo.dao.getcountListbydept();	
		Number[] nowdata = new Number[list.size()];
		String[] hang = new String[list.size()];
		for(int i=0; i<nowdata.length; i++){
			Record r = list.get(i);
			nowdata[i] = r.get("countnum");
			hang[i] = r.getStr("p_name");
		}
		result.put("nowdata", nowdata);
		result.put("piedata", list.toArray());
		result.put("hang", hang);
		result.put("type", type);
		}else if(counttype.equals("003")){
		Record sb=T_Bus_Preschinfo.dao.getcountbysb();
		Record sp=T_Bus_Preschinfo.dao.getcountbysp();
		Number[] nowdata = new Number[2];
		String[] hang = new String[2];
		Number sbcountnum=sb.getNumber("countnum");
		Number spcountnum=sp.getNumber("countnum");
		nowdata[0] =sbcountnum;
		hang[0] ="上报";
		nowdata[1] =spcountnum;
		hang[1] ="审批";
		List<Record> list=new ArrayList<Record>();
		sb.set("countnum", Integer.valueOf(sbcountnum.toString())-Integer.valueOf(spcountnum.toString()));
		list.add(sb);
		list.add(sp);
		result.put("nowdata", nowdata);
		result.put("piedata", list.toArray());
		result.put("hang", hang);
		result.put("type", type);
		}else if(counttype.equals("004")){
		List<Record> deptlist=T_Bus_Preschinfo.dao.getdept();
		List<Record> hanglist=T_Bus_Preschinfo.dao.gethang();
		String[] deptsize = new String[deptlist.size()];
		String[] hang = new String[hanglist.size()];
		List<Number[]> countlist=new ArrayList<Number[]>();
		for(int i=0;i<deptlist.size();i++){
		List<Record> count=T_Bus_Preschinfo.dao.getNumbydept(deptlist.get(i).getStr("dept"));
		deptsize[i]=deptlist.get(i).getStr("dept");
		getCount(count);
		Number[] countdata = new Number[hanglist.size()];
		for(int j=0; j<hanglist.size(); j++){
		countdata[j]=count.get(j).getNumber("countnum");	
		}
		countlist.add(countdata);
		}
        result.put("countdatalist", countlist);

		for(int i=0; i<hanglist.size(); i++){
			Record r = hanglist.get(i);
			hang[i] = r.getStr("p_name");
		}
		String[] type2={"00B"};
		result.put("type", type2);
		result.put("hang", hang);
		result.put("deptsize", deptsize);
			List<Record> list=T_Bus_Preschinfo.dao.getcountListbytype();	
			getCount(list);
			for(int i=0;i<list.size();i++){
				if(list.get(i).get("lvl").toString().equals("0")){
					list.remove(i);
					i--;
				}
			}
		List<Record> outlist=new ArrayList<Record>();
		List<Record> hangwithout0=T_Bus_Preschinfo.dao.gethangwithout0();
		for(Record r:hangwithout0){
		List<Record> count=T_Bus_Preschinfo.dao.getNumbytype(r.getStr("p_acode"));
		if(!count.isEmpty()){
			for(Record cr:count){
				outlist.add(cr);
			}
		}
		}
			result.put("piedata", list.toArray());
			result.put("outpiedata", outlist.toArray());
		}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			renderJson(result);
		}
	}
}
