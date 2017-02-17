package com.lauvan.apps.attachment.controller;
/**
 * 系统模板文件管理控制类
 * @author 黄丽凯
 * */
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.jfinal.aop.Clear;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.attachment.model.T_Template;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.FileUtils;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/template",viewPath="/template")
public class TemplateController extends BaseController {
	public void index(){
		render("main.jsp");
	}
	//获取模板列表
	public void getDataGrid(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String tname = getPara("tname");
		String ttype = getPara("ttype");
		Page<Record> page=T_Template.dao.getPage(pageSize, pageNumber, tname, ttype);
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	//新增模板
	public void add(){
		String flag = getPara(0);
		if(flag!=null && !"".equals(flag)){
			//打开在线编辑页面
			LoginModel login = getSessionAttr("loginModel");
			setAttr("flag",flag);
			setAttr("username",login.getUserName());
			render("add_office.jsp");
		}else{
			render("add.jsp");
		}
	}
	//修改模板
	public void edit(){
		//根据id获取模板
		String id = getPara(0);
		T_Template t = T_Template.dao.findById(id);
		if(t!=null){
			String newPath = t.getStr("url");
			LoginModel login = getSessionAttr("loginModel");
			setAttr("t",t);
			if(!newPath.startsWith("/") && newPath.indexOf(":")!=1){
				newPath  = PathKit.getWebRootPath() +"/"+ newPath;
			}
			setAttr("newPath",newPath);
			setAttr("id",id);
			String flag = "word";
			if(".xls".equals(t.getStr("m_type"))||".xlsx".equals(t.getStr("m_type"))){
				flag = "excel";
			}
			setAttr("flag",flag);
			setAttr("username",login.getUserName());
			render("edit.jsp");
		}else{
			renderText("该模板不存在，请联系管理员！");
		}
	}
	
	//office页面编辑保存
	public void pageSave(){
		com.zhuozhengsoft.pageoffice.FileSaver fs = new com.zhuozhengsoft.pageoffice.FileSaver(getRequest(),getResponse());
		String id = getPara(0);
		String fext = fs.getFileExtName();
		String fsize = FileUtils.getFileSize(fs.getFileSize());
		String tempname = fs.getFormField("tempname");
		String remark = fs.getFormField("remark");
		String act = fs.getFormField("act");
		if("save".equals(act)){
			//保存地址
			T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("TPDZ", "UPDZ");
			String path  =  "/upload/template";
			if(p!=null){
				path = p.getStr("p_acode");
			}
			T_Template t = new T_Template();
			t.set("m_size", fsize);
			t.set("m_type", fext);
			t.set("m_type", fext);
			t.set("name", tempname);
			t.set("remark", remark);
			if(id==null || "".equals(id)){
				//插入新模板
				id = T_Template.dao.insert(t,path,fext);
			}else{
				t.set("id", id);
				t.set("url", path+"/"+id+fext);
				//修改模板大小，类型，路径
				t.update();
			}
			if(!path.startsWith("/")&&path.indexOf(":")!=1){
				path  = PathKit.getWebRootPath() +"/"+ path;
			}
			path = path+"/"+id+fext;
			fs.saveToFile(path);
		}
		fs.close();
		renderNull();
	}
	//删除模板
	public void delete(){
		String[] id = getParaValues("ids");
		String ids = ArrayUtils.ArrayToString(id);
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="清除成功！";
		String errorCode="info";
		try {
			List<T_Template> list = T_Template.dao.getListByIds(ids);
			if(list!=null && list.size()>0){
				//删除文件
				for(T_Template t : list){
					String url = t.getStr("url");
					if(!url.startsWith("/") && url.indexOf(":")!=1){
						url = PathKit.getWebRootPath() + "/" + url;
					}
					File file = new File(url);
					if (file.exists()) {
						file.delete();
					}
				}
				success = T_Template.dao.deleteByIDS(ids);
			}
		} catch (Exception e) {
			errorCode="error";
			msg=e.getMessage();
			e.printStackTrace();
		}finally{
			map.put("success", success);
			map.put("msg", msg);
			map.put("errorcode", errorCode);
			renderJson(map);
		}
	}
	//下载模板文件
	@Clear
	public void download(){
		String id = getPara(0);
		T_Template fj = T_Template.dao.findById(id);
		if(fj!=null){
			try{
				HttpServletResponse res = getResponse();
				res.setContentType("text/html; charset=UTF-8");
				res.setContentType("application/x-msdownload");
				res.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode(fj.getStr("name")+fj.getStr("m_type"), "UTF-8"));
				OutputStream out = res.getOutputStream();
				String url = fj.getStr("url");
				if(!url.startsWith("/") && url.indexOf(":")!=1){
					url = PathKit.getWebRootPath() + "/" + url;
				}
				File file = new File(url);
				if(file.exists()){
					FileInputStream fis=new FileInputStream(file);
			        BufferedInputStream buff=new BufferedInputStream(fis);
			        byte [] b=new byte[1024];//相当于我们的缓存
			        long k=0;//该值用于计算当前实际下载了多少字节
			        while(k<file.length()){
			            int j=buff.read(b,0,1024);
			            k+=j;
			            //将b中的数据写到客户端的内存
			            out.write(b,0,j);
			        }
				}
		        //将写入到客户端的内存的数据,刷新到磁盘
		        out.flush();
		        out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				renderNull();
			}
		}else{
			renderText("该文件不存在！id：" + id);
		}
	}
}
