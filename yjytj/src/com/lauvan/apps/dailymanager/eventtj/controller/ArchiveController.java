package com.lauvan.apps.dailymanager.eventtj.controller;
/**
 * 信息归档控制类
 * */
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.apps.dailymanager.eventtj.model.T_Bus_Archive;
import com.lauvan.apps.dailymanager.eventtj.model.T_Bus_ArchiveFile;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.ArrayUtils;
import com.lauvan.util.FileUtils;
import com.lauvan.util.JsonUtil;
@RouteBind(path="Main/archive",viewPath="/dailymanager/archive")
public class ArchiveController extends BaseController {
	public void index(){
		//时间树
		List<Record> tlist = T_Bus_Archive.dao.getTimeList(null);
		if(tlist!=null && tlist.size()>0){
			Map<String,Object> ymap = new HashMap<String,Object>();
			//月份数
			List<Record> mlist = new ArrayList<Record>();
			List<Record> ylist = new ArrayList<Record>();
			for(Record y : tlist){
				String time = y.getStr("archivetime");
				String[] ts = time.split("-");
				String year = ts[0];
				String month = String.valueOf(Integer.parseInt(ts[1]));
				Record m = new Record();
				m.set("id", time);
				m.set("pid", year);
				m.set("name", month+"月");
				mlist.add(m);
				ymap.put(year, year);
			}
			//年份树
			if(ymap.size()>0){
				Set<String>  ykey = ymap.keySet();
				for(String key : ykey){
					Record r = new Record();
					r.set("id", key);
					r.set("pid", 0);
					r.set("name", key+"年");
					ylist.add(r);
				}
			}
			//归档目录树
			List<Record> list = T_Bus_Archive.dao.getListBySupcode(null);
			
			setAttr("ylist",ylist);
			setAttr("mlist",mlist);
			setAttr("list",list);
			//分类目录树
			List<T_Sys_Parameter> plist = T_Sys_Parameter.dao.getChildByAcode("GDFL");
			setAttr("plist",plist);
		}
		render("main.jsp");
	}
	
	public void getTreeData(){
		//时间树
		List<Record> list = new ArrayList<Record>();
		String id = getPara("id");
		if(id==null || "0".equals(id)){
			List<Record> tlist = T_Bus_Archive.dao.getTimeList(null);
			Record root = new Record();
			root.set("id", 0);
			root.set("pid", 0);
			root.set("name", "归档目录");
			list.add(root);
			if(tlist!=null && tlist.size()>0){
				Map<String,Object> ymap = new HashMap<String,Object>();
				//月份数
				List<Record> mlist = new ArrayList<Record>();
				for(Record y : tlist){
					String time = y.getStr("archivetime");
					String[] ts = time.split("-");
					String year = ts[0];
					String month = String.valueOf(Integer.parseInt(ts[1]));
					Record m = new Record();
					m.set("id", time);
					m.set("pid", year);
					m.set("name", month+"月");
					m.set("isleaf", 0);
					mlist.add(m);
					ymap.put(year, year);
				}
				//年份树
				if(ymap.size()>0){
					Set<String>  ykey = ymap.keySet();
					for(String key : ykey){
						Record r = new Record();
						r.set("id", key);
						r.set("pid", 0);
						r.set("name", key+"年");
						r.set("isleaf", 0);
						list.add(r);
					}
				}
				for(Record r :mlist){
					list.add(r);
				}
				//归档目录树
				List<Record> alist = T_Bus_Archive.dao.getListBySupcode(null);
				//分类目录树
				List<T_Sys_Parameter> plist = T_Sys_Parameter.dao.getChildByAcode("GDFL");
				for(Record a :alist){
					Record r = new Record();
					r.set("id", a.getNumber("id").toString());
					r.set("pid", a.getStr("archivetime"));
					r.set("name", a.getStr("archivename"));
					r.set("isleaf", 0);
					list.add(r);
					for(T_Sys_Parameter p :plist){
						Record r1 = new Record();
						r1.set("id", a.getNumber("id")+"_"+p.getStr("p_acode"));
						r1.set("pid", a.getNumber("id").toString());
						r1.set("name", p.getStr("p_name"));
						r1.set("isleaf", 1);
						list.add(r1);
					}
				}
			}else{
				root.set("isleaf", 1);
			}
		}
		renderJson(list);
	}
	
	public void getArchiveData(){
		//根据类型还有目录归属查询数据
		String id = getPara("aid");
		String type = getPara("type");
		String filename = getPara("filename");
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		StringBuffer str = new StringBuffer();
		if(id!=null && !"".equals(id)){
			str.append(" and f.archiveid=").append(id);
		}
		if(type!=null && !"".equals(type)){
			str.append(" and f.archivetype='").append(type).append("'");
		}
		if(filename!=null && !"".equals(filename)){
			str.append(" and f.filename  like '%").append(filename).append("%'");
		}
		Page<Record> page = T_Bus_ArchiveFile.dao.getPageList(pageSize, pageNumber, str.toString());
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	
	public void add(){
		String aid = getPara("aid");
		if(aid!=null && !"".equals(aid)){
			String atype = getPara("atype");
			T_Bus_Archive archive = T_Bus_Archive.dao.findById(aid);
			setAttr("archive",archive);
			setAttr("atype",atype);
			render("addfile.jsp");
		}else{
			render("add.jsp");
		}
	}
	
	public void save(){
		String flag = getPara("flag");
		LoginModel login = getSessionAttr("loginModel");
		//归档地址
		String gddz = "upload/gddz";
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("GDDZ", "UPDZ");
		if(p!=null){ 
			gddz = p.getStr("p_acode");
		}
		if(gddz.startsWith("/") && gddz.indexOf(":")!=1){
			gddz = PathKit.getWebRootPath() + "/" + gddz;
		}
		File path = new File(gddz);
		if(!path.exists()){
			path.mkdirs();
		}
		if("folder".equals(flag)){
			//添加目录
			T_Bus_Archive a = getModel(T_Bus_Archive.class);
			a.set("user_id", login.getUserId());
			a.set("supcode", login.getOrgCode());
			String archivename = a.getStr("archivename");
			//判断该归档目录是否存在
			T_Bus_Archive g = T_Bus_Archive.dao.getByName(archivename);
			if(g!=null){
				toDwzText(false, "该归档目录已存在，请检查！", "", "", "", "");
				return;
			}
			
			T_Bus_Archive.dao.insert(a);
			//创建目录
			
			File folder = new File(gddz+"/"+archivename);
			folder.mkdir();
			//创建分类目录
			List<T_Sys_Parameter> plist = T_Sys_Parameter.dao.getChildByAcode("GDFL");
			for(T_Sys_Parameter ps : plist){
				String pname = ps.getStr("p_name");
				File folders = new File(gddz+"/"+archivename+"/"+pname);
				folders.mkdir();
			}
		}else{
			String filesid = getPara("fids");
			T_Bus_ArchiveFile a = getModel(T_Bus_ArchiveFile.class);
			String atype = a.getStr("archivetype");
			a.set("user_id", login.getUserId());
	
			T_Sys_Parameter pa = T_Sys_Parameter.dao.getByCode2(atype, "GDFL");
			if(pa!=null){
				String aname = pa.getStr("p_name");
				/*String remark = pa.getStr("remark");
				String[] str = remark.split(";");
				StringBuffer column = new StringBuffer();
				String table = "";
				for(int i=0;i<str.length;i++){
					if(str[i].indexOf(":")>=0){
						String[] c = str[i].split(":");
						if(column.length()>0){
							column.append(",");
						}
						column.append(c[0]).append(" as ").append(c[1]);
					}else{
						table = str[i];
					}
				}
				List<Record> flist = T_Bus_ArchiveFile.dao.getFileByType(table, column.toString(), filesid);*/
				List<Record> flist = T_Bus_ArchiveFile.dao.getFileByType(atype,filesid);
				//添加文件
				if(flist!=null && flist.size()>0){
					try {
						T_Bus_Archive gd = T_Bus_Archive.dao.findById(a.get("archiveid"));
						if(gd!=null){
							String gdurl = gddz +"/"+gd.getStr("archivename")+"/"+aname;
							File gdlj = new File(gdurl);
							if(!gdlj.exists()){
								gdlj.mkdirs();
							}
							for(Record r : flist){
								String url = r.getStr("url");
								String name = r.getStr("name");
								String ftype = r.getStr("ftype");
								//专报地址特殊处理
								if("001".equals(atype)){
									//专报存放地址
									T_Sys_Parameter zb = T_Sys_Parameter.dao.getByCode("ZBDZ", "UPDZ");
									String zbdz = "upload/eventReport";
									if(zb!=null){
										zbdz = zb.getStr("p_acode");
									}
									url = zbdz+"/"+url;
								}
								if(!url.startsWith("/") && url.indexOf(":")!=1){
									url = PathKit.getWebRootPath() + "/" + url;
								}
								File file1 = new File(url);
								if(file1.exists()){
									//复制到归档文件夹中
									if(name.indexOf(".")<0){
										name = name + ".doc";
									}
									File nfile = new File(gdurl+"/"+name);
									nfile.createNewFile();
									FileInputStream fi = new FileInputStream(file1);
									FileOutputStream fo = new FileOutputStream(nfile);
									FileChannel in = fi.getChannel();
									FileChannel out = fo.getChannel();
									in.transferTo(0, in.size(), out);
									fi.close();
									in.close();
									fo.close();
									out.close();
									//保存归档记录
									String size = FileUtils.getFileSize(nfile.length());
									a.set("filename", name);
									a.set("filesize", size);
									a.set("filetype", ftype);
									a.set("fileurl", gdurl+"/"+name);
									T_Bus_ArchiveFile.dao.insert(a);
								}
							}
						}else{
							toDwzText(false, "归档目录不存在，请检查！", "", "", "", "");
							return;
						}
					} catch (Exception e) {
						e.printStackTrace();
						toDwzText(false, "归档异常，请检查！", "", "", "", "");
						return;
					}
					
				}
				
			}else{
				toDwzText(false, "归档类型不存在，请检查！", "", "", "", "");
			}
		}
		renderText("{\"success\":true,\"dialogid\":\"archiveDialog\",\"gridid\":\"_archiveGrid"
				+"\",\"msg\":\"保存成功！\",\"treeObj\":\"_archiveTree\",\"reloadid\":0,\"idkey\":\"id\"}");
	}
	
	public void delete(){
		String aid = getPara("aid");
		String flag = getPara("flag");
		Map<String,Object> map = new HashMap<String,Object>();
		boolean success=false;
		String msg="删除异常，请检查！";
		String errorCode="info";
		try {
			if("folder".equals(flag)){
				//删除目录
				List<Record> flist = T_Bus_ArchiveFile.dao.getListByAid(aid, null);
				//先删除文件
				if(flist!=null && flist.size()>0){
					for(Record f : flist){
						String url = f.getStr("fileurl");
						if(url.startsWith("/") && url.indexOf(":")!=1){
							url = PathKit.getWebRootPath() + "/" + url;
						}
						File file = new File(url);
						if(file.exists()){
							file.delete();
						}
					}
				}
				//在删除目录
				//归档地址
				String gddz = "upload/gddz";
				T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("GDDZ", "UPDZ");
				if(p!=null){ 
					gddz = p.getStr("p_acode");
				}
				if(gddz.startsWith("/") && gddz.indexOf(":")!=1){
					gddz = PathKit.getWebRootPath() + "/" + gddz;
				}
				T_Bus_Archive a = T_Bus_Archive.dao.findById(aid);
				String archivename = a.getStr("archivename");
				File folder = new File(gddz+"/"+archivename);
				if(folder.exists()){
					File[] files = folder.listFiles();
					if(files!=null && files.length>0){
						for(File file1 : files){
							if(file1.exists()){
								file1.delete();
							}
						}
					}
					folder.delete();
				}
				//最后删除数据
				T_Bus_ArchiveFile.dao.deleteByAid(aid);
				success = a.delete();
			}else{
				//删除文件
				String[] ids=getParaValues("ids");
				if(ids!=null){
					ids = ArrayUtils.removeDuplicate(ids);
				}
				String id = ArrayUtils.ArrayToString(ids);
				List<T_Bus_ArchiveFile> afiles = T_Bus_ArchiveFile.dao.getListByIds(id);
				if(afiles!=null && afiles.size()>0){
					for(T_Bus_ArchiveFile f : afiles){
						String url = f.getStr("fileurl");
						if(url.startsWith("/") && url.indexOf(":")!=1){
							url = PathKit.getWebRootPath() + "/" + url;
						}
						File file = new File(url);
						if(file.exists()){
							file.delete();
						}
					}
				}
				success = T_Bus_ArchiveFile.dao.deleteByIds(id);
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
	//获取文件列表
	public void getArchiveFileList(){
		String type = getPara("atype");
		String ids = getPara("ids");
		List<Record> flist = T_Bus_ArchiveFile.dao.getFileByType(type, ids);
		setAttr("arcfilesel",flist);
		setAttr("atype",type);
		setAttr("ids",ids);
		render("findData/archiveFiles.jsp");
	}
	//获取文件数据
	public void getArchiveFileData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		String atype = getPara("atype");
		String arcname = getPara("arcname");
		String jsonStr="[]";
		StringBuffer sqlWhere = new StringBuffer(); 
		if(arcname!=null && !"".equals(arcname)){
			sqlWhere.append(" and f.name like '%").append(arcname).append("%'");
		}
		
		/*T_Sys_Parameter pa = T_Sys_Parameter.dao.getByCode(atype, "GDFL");
		if(pa!=null){
			String remark = pa.getStr("remark");
			String[] str = remark.split(";");
			StringBuffer column = new StringBuffer();
			String table = "";
			for(int i=0;i<str.length;i++){
				if(str[i].indexOf(":")>=0){
					String[] c = str[i].split(":");
					if(column.length()>0){
						column.append(",");
					}
					column.append(c[0]).append(" as ").append(c[1]);
				}else{
					table = str[i];
				}
			}
			
			Page<Record> page = T_Bus_ArchiveFile.dao.getPageListByType(pageSize, pageNumber, sqlWhere.toString(), table, column.toString());
			List<Record> list=page.getList();
			int totalCount=page.getTotalRow();
			//调用JsonUtil函数返回datagrid表格json数据
			jsonStr=JsonUtil.getGridData(list, totalCount);
		}*/
		Page<Record> page = T_Bus_ArchiveFile.dao.getPageListByType(pageSize, pageNumber, sqlWhere.toString(),atype );
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	public void getFileview(){
		String id = getPara(0);
		String atype = getPara(1);
		String flag = getPara(2);
		Record r = T_Bus_ArchiveFile.dao.getFileByIdType(id, atype);
		if(r!=null){
			String ftype = r.getStr("ftype").toLowerCase();
			String url = r.getStr("url");
			String fname = r.getStr("name");
			if(!url.startsWith("/") && url.indexOf(":")!=1){
				url = PathKit.getWebRootPath() + "/" + url;
			}
			File file = new File(url);
			LoginModel login = getSessionAttr("loginModel");
			if(file.exists()){
				if("media".equals(flag)){
					//输出视频文件
					try {
						HttpServletResponse res = getResponse();
						res.setContentType("text/html; charset=UTF-8");
						res.setContentType("application/x-msdownload");
						res.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode(fname, "UTF-8"));
						OutputStream out = res.getOutputStream();
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
						out.flush();
						out.close();
					} catch (Exception e) {
						renderHtml("<script>window.close();alert(\"操作异常，请检查！\");</script>");
						e.printStackTrace();
					}finally{
						renderNull();
					}
				}else if("doc".equals(ftype)||"docx".equals(ftype)||"xls".equals(ftype)||"xlsx".equals(ftype)||"pdf".equals(ftype)){
					//doc,xls,pdf文件直接打开
					setAttr("newPath",url);	
					setAttr("username", login.getUserName());
					setAttr("type",ftype);
					if("pdf".equals(ftype)){
						render("findData/pdfview.jsp");
					}else{
						render("findData/fjview.jsp");
					}
				}else if("jpg".equals(ftype)||"gif".equals(ftype)||"png".equals(ftype)){
					//图片、视频、音频文件直接打开
					//转相对路径
					T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("XDLJ1", "UPDZ");
					String xdlj = p.getStr("p_acode");
					T_Sys_Parameter p2 = T_Sys_Parameter.dao.getByCode("XDLJ2", "UPDZ");
					String thlj = p2.getStr("p_acode");
					url = r.getStr("url");
					if(url.startsWith("/") || url.indexOf(":")==1){
						url = url.replace(thlj, xdlj);
					}else{
						String path = getRequest().getContextPath();
						String basePath = getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort()+path+"/";
						url=basePath+url;
					}
					setAttr("furl",url);	
					setAttr("ftype","jpg");
					render("findData/jpgview.jsp");
				}else if("mp4".equals(ftype)||"wav".equals(ftype)||"3gp".equals(ftype)||"mp3".equals(ftype)){
					//图片、视频、音频文件直接打开
					setAttr("aid",id);
					setAttr("atype",atype);
					setAttr("ftype","media");
					render("findData/jpgview.jsp");
				}else{
					//其他下载形式
					try {
						HttpServletResponse res = getResponse();
						res.setContentType("text/html; charset=UTF-8");
						res.setContentType("application/x-msdownload");
						res.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode(fname, "UTF-8"));
						OutputStream out = res.getOutputStream();
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
						out.flush();
						out.close();
					} catch (Exception e) {
						renderHtml("<script>window.close();alert(\"操作异常，请检查！\");</script>");
						e.printStackTrace();
					}finally{
						renderNull();
					}
				}
			}else{
				renderHtml("<script>window.close();alert( \"该文件不存在！\");</script>");
			}
		}else{
			//renderText("该文件不存在，请检查！");
			renderHtml("<script>window.close();alert(\"该文件不存在！\");</script>");
		}
	}
	
	public void getView(){
		String id = getPara(0);
		String flag = getPara(1);
		T_Bus_ArchiveFile a = T_Bus_ArchiveFile.dao.findById(id);
		if(a!=null){
			String ftype = a.getStr("filetype").toLowerCase();
			String url = a.getStr("fileurl");
			String fname = a.getStr("filename");
			if(!url.startsWith("/") && url.indexOf(":")!=1){
				url = PathKit.getWebRootPath() + "/" + url;
			}
			File file = new File(url);
			LoginModel login = getSessionAttr("loginModel");
			if(file.exists()){
				if("media_gd".equals(flag)){
					//输出视频文件
					try {
						HttpServletResponse res = getResponse();
						res.setContentType("text/html; charset=UTF-8");
						res.setContentType("application/x-msdownload");
						res.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode(fname, "UTF-8"));
						OutputStream out = res.getOutputStream();
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
						out.flush();
						out.close();
					} catch (Exception e) {
						renderHtml("<script>window.close();alert(\"操作异常，请检查！\");</script>");
						e.printStackTrace();
					}finally{
						renderNull();
					}
				}else if("doc".equals(ftype)||"docx".equals(ftype)||"xls".equals(ftype)||"xlsx".equals(ftype)||"pdf".equals(ftype)){
					//doc,xls,pdf文件直接打开
					setAttr("newPath",url);	
					setAttr("username", login.getUserName());
					setAttr("type",ftype);
					if("pdf".equals(ftype)){
						render("findData/pdfview.jsp");
					}else{
						render("findData/fjview.jsp");
					}
				}else if("jpg".equals(ftype)||"gif".equals(ftype)||"png".equals(ftype)){
					//图片、视频、音频文件直接打开
					//转相对路径
					T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("XDLJ1", "UPDZ");
					String xdlj = p.getStr("p_acode");
					T_Sys_Parameter p2 = T_Sys_Parameter.dao.getByCode("XDLJ2", "UPDZ");
					String thlj = p2.getStr("p_acode");
					url = a.getStr("url");
					if(url.startsWith("/") || url.indexOf(":")==1){
						url = url.replace(thlj, xdlj);
					}else{
						String path = getRequest().getContextPath();
						String basePath = getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort()+path+"/";
						url=basePath+url;
					}
					setAttr("furl",url);	
					setAttr("ftype","jpg");
					render("findData/jpgview.jsp");
				}else if("mp4".equals(ftype)||"wav".equals(ftype)||"3gp".equals(ftype)||"mp3".equals(ftype)){
					//图片、视频、音频文件直接打开
					setAttr("aid",id);
					setAttr("ftype","media_gd");
					render("findData/jpgview.jsp");
				}else{
					//其他下载形式
					try {
						HttpServletResponse res = getResponse();
						res.setContentType("text/html; charset=UTF-8");
						res.setContentType("application/x-msdownload");
						res.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode(fname, "UTF-8"));
						OutputStream out = res.getOutputStream();
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
						out.flush();
						out.close();
					} catch (Exception e) {
						renderHtml("<script>window.close();alert(\"操作异常，请检查！\");</script>");
						e.printStackTrace();
					}finally{
						renderNull();
					}
				}
			}else{
				renderHtml("<script>window.close();alert( \"该文件不存在！\");</script>");
			}
		}else{
			renderHtml("<script>window.close();alert(\"该文件不存在！\");</script>");
		}
	}
}
