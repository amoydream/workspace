<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %> 
<%@ page import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);  
poCtrl1.setServerPage(basePath+"poserver.do"); //此行必须  
poCtrl1.setTitlebar(false);
poCtrl1.setMenubar(false);
poCtrl1.addCustomToolButton("导出", "SaveAs", 11);
poCtrl1.addCustomToolButton("打印", "ShowPrintDlg", 6);
//poCtrl1.setSaveFilePage(basePath+"Main/eventReport/pageSave/"+id);
poCtrl1.setOfficeVendor(OfficeVendorType.AutoSelect);
OpenModeType otype = OpenModeType.docReadOnly;
String ftype = (String)request.getAttribute("ftype");
if("xls".equals(ftype) || "xlsx".equals(ftype)){
	otype = OpenModeType.xlsReadOnly;
}
poCtrl1.webOpen((String)request.getAttribute("newPath"),otype , (String)request.getAttribute("username"));
poCtrl1.setTagId("eventFaxView"); //此行必须 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:v="urn:schemas-microsoft-com:vml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<title>政府综合应急平台</title>
<style type="text/css">
html,body{ width:100%; height:100%; overflow:hidden;}
body {margin:0; padding:0; }
</style>
<script type="text/javascript">
function SaveAs(){
	document.getElementById("eventFaxView").ShowDialog(3);
}
//打印
function ShowPrintDlg() {
    document.getElementById("eventFaxView").ShowDialog(4); //打印对话框
}

</script>
</head>
<body >
<form id="form1">
<div style="height: 100%;float: left;margin: 0 auto;padding: 0 auto;width: 100%;">
	<po:PageOfficeCtrl id="eventFaxView" />
</div>
</form>
</body>
</html>