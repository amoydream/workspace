<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.zhuozhengsoft.pageoffice.*,java.awt.*" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>  
<%@ page import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
WordDocument doc = request.getAttribute("doc")==null?null:(WordDocument)request.getAttribute("doc");
PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);  
poCtrl1.setServerPage(basePath+"poserver.zz"); //此行必须  
String id = (String)request.getAttribute("id");
poCtrl1.setSaveFilePage(basePath+"event/eventReport/reportSave?id="+id);//如要保存文件，此行必须
poCtrl1.setTitlebar(false);
poCtrl1.addCustomToolButton("导出", "SaveAs", 11);
poCtrl1.addCustomToolButton("保存", "Save", 1);
poCtrl1.addCustomToolButton("打开", "openLCfile", 13);
poCtrl1.addCustomToolButton("打印", "ShowPrintDlg", 6);
if(doc!=null){
poCtrl1.setWriter(doc);
}
OpenModeType ortype = OpenModeType.docAdmin;
poCtrl1.setOfficeVendor(OfficeVendorType.AutoSelect);
poCtrl1.webOpen(basePath+(String)request.getAttribute("newPath"),ortype, "admin"); 

poCtrl1.setTagId("printDoc"); //此行必须 
%>
<!DOCTYPE html >
<html >
<title>专报管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript">
//导出
function SaveAs(){
	document.getElementById("printDoc").ShowDialog(3);
}
//保存
function Save(){
	document.getElementById("printDoc").WebSave();
	window.close();
}
//打开本地文件
function openLCfile(){
	document.getElementById("printDoc").ShowDialog(1);
}
//打印
function ShowPrintDlg() {
         document.getElementById("printDoc").ShowDialog(4); //打印对话框
     }

</script>
</head>
<body style="background-color: #E0EEE0;">
<div style="height: 800px;">
<po:PageOfficeCtrl id="printDoc" />
</div>
</body>
</html>