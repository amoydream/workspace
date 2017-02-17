package com.lauvan.apps.autocreate.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Config;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.Record;

/**
 * 自动生成代码工具类
 * */
public class AutoCreate {
	/**自动生成java文件*
	 * @param file      模板文件路径
	 * @param className java类名称
	 * @param tablename 绑定table名称
	 * @param pkid      库表主键
	 * @param outfile   文件输出地址
	 */
	public static void createModel(String file, String className, String tablename, String pkid, String outfile) {
		//获取模板文件
		if(!file.startsWith("/") && file.indexOf(":") != 1) {
			file = PathKit.getWebRootPath() + "/" + file;
		}
		File mbfile = new File(file);
		//生成java文件
		String root = PathKit.getWebRootPath().replace("\\WebRoot", "");
		File parent = new File(root + "/src/" + outfile.replace(".", "/"));
		if(!parent.exists()) {//若不存在，则创建文件夹
			parent.mkdirs();
		}
		File javaFile = new File(root + "/src/" + outfile.replace(".", "/") + "/" + className + ".java");
		//复制，以及创建合并
		BufferedWriter outWriter = null;
		BufferedReader bufferedReader = null;
		try {
			FileInputStream fin = new FileInputStream(mbfile);
			InputStreamReader read = new InputStreamReader(fin, "UTF-8");// 考虑到编码格式
			bufferedReader = new BufferedReader(read);
			OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(javaFile), "UTF-8");
			outWriter = new BufferedWriter(out);
			String lineTxt = null;
			while((lineTxt = bufferedReader.readLine()) != null) {
				if("${package}".equals(lineTxt)) {
					lineTxt = "package " + outfile.replace("/", ".") + ";";
				} else if(lineTxt.startsWith("@TableBind")) {
					lineTxt = lineTxt.replace("${tablename}", tablename);
					lineTxt = lineTxt.replace("${pkid}", pkid);
				} else {
					lineTxt = lineTxt.replaceAll("\\$\\{classname\\}", className);
				}
				outWriter.write(lineTxt);
				outWriter.newLine();
			}
			bufferedReader.close();
			outWriter.flush();
			outWriter.close();
		} catch(Exception e) {
			e.printStackTrace();
		}

	}

	/***
	 * 自动生成jsp
	 * @param	file		模板文件路径
	 * @param	vtype		视图类型
	 * @param	outfile		存储路径
	 * @param	content		视图内容
	 * @param	viewname	视图名称
	 * */
	public static void createJSP(String file, String vtype, String outfile, String content, String viewname) {
		String view = "";
		if("00M".equals(vtype)) {
			view = "main.jsp";
		} else if("00A".equals(vtype)) {
			view = "add.jsp";
		} else {
			view = "edit.jsp";
		}
		//获取模板文件
		if(!file.startsWith("/") && file.indexOf(":") != 1) {
			file = PathKit.getWebRootPath() + "/" + file;
		}
		File mbfile = new File(file + "/" + view);
		File parent = new File(PathKit.getWebRootPath() + "/WEB-INF/jsp/" + outfile.replace(".", "/"));
		if(!parent.exists()) {//若不存在，则创建文件夹
			parent.mkdirs();
		}
		File jspFile = new File(PathKit.getWebRootPath() + "/WEB-INF/jsp/" + outfile.replace(".", "/") + "/" + view);
		//复制，以及创建合并
		BufferedWriter outWriter = null;
		BufferedReader bufferedReader = null;
		try {
			FileInputStream fin = new FileInputStream(mbfile);
			InputStreamReader read = new InputStreamReader(fin, "UTF-8");// 考虑到编码格式
			bufferedReader = new BufferedReader(read);
			OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(jspFile), "UTF-8");
			outWriter = new BufferedWriter(out);
			String lineTxt = null;
			while((lineTxt = bufferedReader.readLine()) != null) {
				if("<title></title>".equals(lineTxt.trim())) {
					lineTxt = "<title>" + viewname + "</title>";
				} else if("<!--content-->".equals(lineTxt.trim())) {
					//分段html
					int count = content.indexOf(">");
					String text = content.substring(0, count + 1);
					while(text != null && !"".equals(text)) {
						if(text.startsWith("<th")) {
							count = content.indexOf("</th>");
							text = content.substring(0, count + 5);
							count = count + 4;
						}
						if(text.startsWith("<td")) {
							count = content.indexOf("</td>");
							text = content.substring(0, count + 5);
							count = count + 4;
						}
						if(text.indexOf("<option") > 0) {
							count = content.indexOf("<option");
							text = content.substring(0, count);
							count = count - 1;
						}
						if(text.startsWith("<option")) {
							count = content.indexOf("</option>");
							text = content.substring(0, count + 9);
							count = count + 8;
						}
						//System.out.println(text);
						outWriter.write(text);
						outWriter.newLine();
						content = content.substring(count + 1);
						count = content.indexOf(">");
						text = content.substring(0, count + 1);
					}
					lineTxt = "";
				}
				outWriter.write(lineTxt);
				outWriter.newLine();
			}
			bufferedReader.close();
			outWriter.flush();
			outWriter.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/***
	 * 自动生成controller
	 * @param	file		模板文件路径
	 * @param	cname		控制类名称
	 * @param	outfile		存储路径
	 * @param	tablename	表名
	 * @param	viewpath	视图地址
	 * @param	path		绑定控制类地址
	 * */
	public static void createController(String file, String cname, String outfile, String tablename, String viewpath, String path, String viewname) {
		//获取模板文件
		if(!file.startsWith("/") && file.indexOf(":") != 1) {
			file = PathKit.getWebRootPath() + "/" + file;
		}
		File mbfile = new File(file);
		//生成java文件
		String root = PathKit.getWebRootPath().replace("\\WebRoot", "");
		File parent = new File(root + "/src/" + outfile.replace(".", "/"));
		if(!parent.exists()) {//若不存在，则创建文件夹
			parent.mkdirs();
		}
		File javaFile = new File(root + "/src/" + outfile.replace(".", "/") + "/" + cname + ".java");
		//复制，以及创建合并
		BufferedWriter outWriter = null;
		BufferedReader bufferedReader = null;
		try {
			FileInputStream fin = new FileInputStream(mbfile);
			InputStreamReader read = new InputStreamReader(fin, "UTF-8");// 考虑到编码格式
			bufferedReader = new BufferedReader(read);
			OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(javaFile), "UTF-8");
			outWriter = new BufferedWriter(out);
			String lineTxt = null;
			while((lineTxt = bufferedReader.readLine()) != null) {
				if("${package}".equals(lineTxt)) {
					lineTxt = "package " + outfile.replace("/", ".") + ";";
				} else if(" * ${viewname}控制类".equals(lineTxt)) {
					lineTxt = " * " + viewname + "控制类";
				} else if(lineTxt.startsWith("@RouteBind")) {
					lineTxt = lineTxt.replace("${path}", path);
					lineTxt = lineTxt.replace("${viewPath}", viewpath);
				} else {
					lineTxt = lineTxt.replaceAll("\\$\\{className\\}", cname);
					lineTxt = lineTxt.replace("${table_name}", tablename);
				}
				outWriter.write(lineTxt);
				outWriter.newLine();
			}
			bufferedReader.close();
			outWriter.flush();
			outWriter.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	//数据库连接
	public static boolean execute(String sql, String dbaname) {
		boolean flag = true;
		Config config = DbKit.getConfig();
		if(dbaname != null && !"".equals(dbaname)) {
			config = DbKit.getConfig(dbaname);
		}
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = config.getConnection();
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		} catch(SQLException e) {
			e.printStackTrace();
			flag = false;
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}

	//数据库连接
	public static List<Record> executeQuery(String sql, String dbaname) {
		Config config = DbKit.getConfig();
		if(dbaname != null && !"".equals(dbaname)) {
			config = DbKit.getConfig(dbaname);
		}
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		List<Record> list = new ArrayList<Record>();
		try {
			conn = config.getConnection();
			stmt = conn.createStatement();
			result = stmt.executeQuery(sql);
			int count = result.getMetaData().getColumnCount();
			if(count >= 1 && result.next()) {
				Record r = new Record();
				for(int i = 0; i < count; i++) {
					r.set(result.getMetaData().getColumnName(i + 1), result.getObject(i + 1));
				}
				list.add(r);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	public static void main(String[] args) {
		//String content = "<div data-options=\"region:'center',title:'center title'\"><table class=\"easyui-datagrid\" cellspacing=\"0\" cellpadding=\"0\" data-options=\"fitColumns:true,pageSize:20,pageList:[20,50,100], pagination:true\"  name=\"T_AutoView_grid\"> <thead> <tr><th field=\"data_source\" width=\"150\">对象</th><th field=\"view_layout\" width=\"150\">页面布局</th><th field=\"view_type\" width=\"150\">视图类型</th> </tr> </thead> </table></div>";
		String content = "<form id=\"T_AutoView_form\" method=\"post\" action=\"\" style=\"width:100%;margin: 0 auto;padding: 0;\"><input type=\"hidden\" name=\"act\" value=\"upd\"/><input type=\"hidden\" name=\"_updid\" value=\"${t.id}\"/><table class=\"sp-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\"><tr><td class=\"sp-td1\">对象：</td><td><input  type=\"text\" class=\"easyui-datebox\"  name=\"t_AutoView.data_source\" style=\"width: 150px;\" value=\"${t.data_source}\" /></td><td class=\"sp-td1\">页面布局：</td><td><input type=\"text\" class=\"easyui-textbox\"  name=\"t_AutoView.view_layout\" style=\"width: 150px;\" value=\"${t.view_layout}\" /></td></tr><tr><td class=\"sp-td1\">视图类型：</td><td><select class=\"easyui-combobox\"  panelHeight=\"auto\"  name=\"t_AutoView.view_type\" style=\"width: 80px;\" data-options=\"editable:false,value:'${t.view_type}'\" ><option value=\"1\" >4</option><option value=\"2\" >5</option><option value=\"3\" >6</option></select></td></table></form>";
		int count = content.indexOf(">");
		String text = content.substring(0, count + 1);
		while(text != null && !"".equals(text)) {
			if(text.startsWith("<th")) {
				count = content.indexOf("</th>");
				text = content.substring(0, count + 5);
				count = count + 4;
			}
			if(text.startsWith("<td")) {
				count = content.indexOf("</td>");
				text = content.substring(0, count + 5);
				count = count + 4;
			}
			if(text.indexOf("<option") > 0) {
				count = content.indexOf("<option");
				text = content.substring(0, count);
				count = count - 1;
			}
			if(text.startsWith("<option")) {
				count = content.indexOf("</option>");
				text = content.substring(0, count + 9);
				count = count + 8;
			}
			System.out.println(text);
			content = content.substring(count + 1);
			count = content.indexOf(">");
			text = content.substring(0, count + 1);
		}
		File mbfile = new File(PathKit.getWebRootPath() + "/upload/autoTemplate/model.java");
		if(mbfile.exists()) {
			System.out.println(mbfile.getAbsolutePath());
		}
	}

}
