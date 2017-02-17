package com.lauvan.apps.autocreate.model;

import java.io.File;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;
import com.lauvan.core.util.AutoId;

@TableBind(name = "T_AutoView", pk = "id")
public class T_AutoView extends Model<T_AutoView> {
	private static final long		serialVersionUID	= 1L;
	public static final T_AutoView	dao					= new T_AutoView();

	public void insert(T_AutoView t) {
		t.set("id", AutoId.nextval(t));
		t.save();
	}

	/**
	 * 删除自动创建的controller类文件，以及jsp页面
	 * */
	public void deleteView(T_AutoView t) {
		//删除controller类
		String path = t.getStr("pack_path");
		String controller = t.getStr("controller");
		if(path != null && !"".equals(path)) {
			path = path.replace(".", "/");
			File file = new File(PathKit.getWebRootPath().replace("\\WebRoot", "") + "/src/" + path + "/" + controller.replaceFirst(controller.substring(0, 1), controller.substring(0, 1).toUpperCase()) + ".java");
			if(file.exists()) {
				file.delete();
			}
		}
		//删除文件
		path = t.getStr("view_path");
		if(path != null && !"".equals(path)) {
			File parent = new File(PathKit.getWebRootPath() + "/WEB-INF/jsp/" + path);
			if(parent.isDirectory()) {
				File[] files = parent.listFiles();
				if(files != null && files.length > 0) {
					for(File f : files) {
						String name = f.getName();
						if("main.jsp".equals(name) || "add.jsp".equals(name) || "edit.jsp".equals(name)) {
							f.delete();
						}
					}
				}
			}
		}
	}
}
