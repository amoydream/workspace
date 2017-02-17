<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %> 
<%@ page import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*,com.zhuozhengsoft.pageoffice.excelwriter.*"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);  
poCtrl1.setServerPage(basePath+"poserver.do"); //此行必须  
poCtrl1.setTitlebar(false);
poCtrl1.setMenubar(false);
poCtrl1.addCustomToolButton("保存", "Save", 1);
poCtrl1.addCustomToolButton("打开", "openLCfile", 13);
poCtrl1.addCustomToolButton("导出", "SaveAs", 11);
poCtrl1.addCustomToolButton("打印", "ShowPrintDlg", 6);
String id = (String)request.getAttribute("id");
poCtrl1.setSaveFilePage(basePath+"Main/template/pageSave/"+id);
String flag = (String)request.getAttribute("flag");
OpenModeType df = OpenModeType.docNormalEdit;
if("excel".equals(flag)){
	df = OpenModeType.xlsNormalEdit;
}
poCtrl1.setOfficeVendor(OfficeVendorType.AutoSelect);
poCtrl1.webOpen((String)request.getAttribute("newPath"), df, (String)request.getAttribute("username"));
poCtrl1.setTagId("templateView"); //此行必须 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:v="urn:schemas-microsoft-com:vml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<title>惠州应急指挥平台</title>
<style type="text/css">
html,body{ width:100%; height:100%; overflow:hidden;}
body {margin:0; padding:0; }
</style>
<script type="text/javascript">
function Save() {
	var tname = document.getElementById("tempname").value;
	if(tname==''){
		alert("请输入模板名称！");
		return;
	}
	document.getElementById("act").value="save";
	document.getElementById("templateView").WebSave();
	var tgrid = window.opener.$("#tempalteGrid");
	if(tgrid!=null && tgrid!=undefined){
		tgrid.datagrid('reload');
	}
	window.close();
}
function SaveAs(){
	document.getElementById("templateView").ShowDialog(3);
}
//打印
function ShowPrintDlg() {
    document.getElementById("templateView").ShowDialog(4); //打印对话框
}
//打开本地文件
function openLCfile(){
	document.getElementById("templateView").ShowDialog(1);
}
</script>
</head>
<body>
<form id="form1">
<div style="width: 900px;font-size: 14px;margin: 0 auto;">
        <span style="color: Red;">模板名称：</span>
        <input id="act" name="act" type="hidden" value="edit" />
        <input id="tempname" name="tempname" type="text" value="${t.name}" style="width: 200px;"/>
        <span >模板描述：</span>
        <input  name="remark" type="text" value="${t.remark}" style="width: 400px;"/>
    </div>
<div style="height: 97%;">
	<po:PageOfficeCtrl id="templateView" />
</div>
</form>
</body>
</html>