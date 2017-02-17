<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.zhuozhengsoft.pageoffice.*,java.awt.*" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>  
<%@ page import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.excelwriter.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Workbook wb = (Workbook)request.getAttribute("wb");
PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);  
poCtrl1.setServerPage(basePath+"poserver.zz"); //此行必须  

poCtrl1.setTitlebar(false);
poCtrl1.addCustomToolButton("导出", "SaveAs", 1);
poCtrl1.addCustomToolButton("打印", "ShowPrintDlg", 6);
poCtrl1.setWriter(wb);
OpenModeType ortype = OpenModeType.xlsNormalEdit;
poCtrl1.setOfficeVendor(OfficeVendorType.AutoSelect);
poCtrl1.webOpen(basePath+"jsp/poffice/res.xls",ortype, "admin"); 

poCtrl1.setTagId("printxls"); //此行必须 
%>
<!DOCTYPE html >
<html >
<title>应急资源</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function SaveAs(){
	document.getElementById("printxls").ShowDialog(3);
}
//打印
function ShowPrintDlg() {
         document.getElementById("printxls").ShowDialog(4); //打印对话框
     }

</script>
</head>
<body style="background-color: #E0EEE0;">
<div style="height: 800px;">
<po:PageOfficeCtrl id="printxls" />
</div>
</body>
</html>