package com.lauvan.apps.attachment.controller;

/**
 * 控制管理器
 * */
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.jfinal.aop.Clear;
import com.jfinal.kit.PathKit;
import com.jfinal.render.JsonRender;
import com.jfinal.upload.UploadFile;
import com.lauvan.apps.attachment.model.T_Attachment;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.base.basemodel.model.T_Sys_Parameter;
import com.lauvan.config.JFWebConfig;
import com.lauvan.core.annotation.RouteBind;
import com.lauvan.util.FileUtils;

@RouteBind(path = "Main/attachment")
public class AttachmentController extends BaseController {

	private String	saveDirectory	= JFWebConfig.saveDirectory;
	private int		maxPostSize		= JFWebConfig.maxPostSize;

	//private static final Logger log = Logger.getLogger(AttachmentContorller.class);
	@Clear
	public void save() {
		//组装地址
		String str = getPara(0);//文件夹名称
		String dlname = getPara(1);//账号名称
		Date date = new Date();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String datePath = format.format(date);
		String savepath = saveDirectory;//默认地址是upload
		String url = saveDirectory;
		T_Sys_Parameter p = T_Sys_Parameter.dao.getByCode("FJDZ", "UPDZ");
		if(p != null) {
			url = p.getStr("p_acode") + "/";
			savepath = p.getStr("p_acode");
		}
		if(str != null && !"".equals(str)) {
			url = url + str + "/";
		}
		if(dlname != null && !"".equals(dlname)) {
			url = url + dlname + "/";
		}
		url = url + datePath;
		Integer size = getParaToInt(3);
		if(size != null && !"".equals(size)) {
			maxPostSize = size;
		}
		//将相对路径的upload去掉
		if(savepath.startsWith("upload/")) {
			url = url.substring(7);
		}
		UploadFile file = getFile("file", url, maxPostSize);
		String fileName = file.getFileName();
		String m_type = fileName.substring(fileName.lastIndexOf('.') + 1);
		String m_size = FileUtils.getFileSize(file.getFile().length());
		url = url + "/" + fileName;
		;
		if(!savepath.startsWith("/") && savepath.indexOf(":") != 1) {
			url = "upload/" + url;
		}
		T_Attachment t = new T_Attachment();
		t.set("name", fileName);
		t.set("url", url);
		t.set("m_type", m_type);
		t.set("m_size", m_size);
		t.set("marktime", datePath);
		t.set("uploadid", getPara(2));
		//t.save();
		String id = T_Attachment.dao.insert(t);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("name", fileName);
		String nurl = url;
		if(nurl.startsWith("/") || nurl.indexOf(":") == 1) {
			nurl = nurl.replace(savepath, "/yj/fjdoc");
		}
		map.put("url", nurl);
		map.put("error", 0);
		map.put("size", m_size);
		map.put("type", m_type);
		if(isIE()) {
			render(new JsonRender(map).forIE()); //ie返回json，会出现下载提示
		} else {
			renderJson(map);
		}
	}

	@Clear
	public void delete() {
		Integer id = getParaToInt(0);
		T_Attachment model = T_Attachment.dao.findById(id);
		try {
			if(model != null) {
				String url = model.getStr("url");
				if(!url.startsWith("/") && url.indexOf(":") != 1) {
					url = PathKit.getWebRootPath() + "/" + model.getStr("url");
				}
				File file = new File(url);
				if(file.exists()) {
					file.delete();
				}
				model.delete();
			}

		} catch(Exception e) {
			//log.error("附件删除错误！id：" + id);
			e.printStackTrace();
		}
		renderNull();
	}

	@Clear
	public void downloadFJ() {
		String id = getPara(0);
		T_Attachment fj = T_Attachment.dao.findById(id);
		if(fj != null) {
			try {
				HttpServletResponse res = getResponse();
				res.setContentType("text/html; charset=UTF-8");
				res.setContentType("application/x-msdownload");
				res.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fj.getStr("name"), "UTF-8"));
				OutputStream out = res.getOutputStream();
				String url = fj.getStr("url");
				if(!url.startsWith("/") && url.indexOf(":") != 1) {
					url = PathKit.getWebRootPath() + "/" + url;
				}
				File file = new File(url);
				if(file.exists()) {
					FileInputStream fis = new FileInputStream(file);
					BufferedInputStream buff = new BufferedInputStream(fis);
					byte[] b = new byte[1024];//相当于我们的缓存
					long k = 0;//该值用于计算当前实际下载了多少字节
					while(k < file.length()) {
						int j = buff.read(b, 0, 1024);
						k += j;
						//将b中的数据写到客户端的内存
						out.write(b, 0, j);
					}
				}
				//将写入到客户端的内存的数据,刷新到磁盘
				out.flush();
				out.close();
			} catch(IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				renderNull();
			}
		} else {
			renderText("该文件不存在！id：" + id);
		}
	}

	private boolean isIE() {
		String user_agent = getRequest().getHeader("User-Agent");
		if(null == user_agent || "".equals(user_agent)) {
			return false;
		}
		String upperStr = user_agent.toUpperCase();
		return upperStr.indexOf("MSIE") >= 0 || upperStr.indexOf("RV:11") >= 0 && upperStr.indexOf("GECKO") >= 0 ? true : false;
	}

}
