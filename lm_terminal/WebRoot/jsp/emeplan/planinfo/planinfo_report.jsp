<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.zhuozhengsoft.pageoffice.*,java.awt.*" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>  
<%@ page import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//WordDocument doc = (WordDocument)request.getAttribute("doc");
PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);  
poCtrl1.setServerPage(basePath+"poserver.zz"); //此行必须  

poCtrl1.setTitlebar(false);
poCtrl1.addCustomToolButton("导出", "SaveAs", 1);
poCtrl1.addCustomToolButton("打印", "ShowPrintDlg", 6);
//poCtrl1.setWriter(doc);
OpenModeType ortype = OpenModeType.docAdmin;
poCtrl1.setOfficeVendor(OfficeVendorType.AutoSelect);
poCtrl1.webOpen(basePath+"upload/plan/"+request.getAttribute("docName"),ortype, "admin"); 

poCtrl1.setTagId("printDoc2"); //此行必须 
%>
<!DOCTYPE html >
<html >
<title>预案附件报表显示</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function SaveAs(){
	document.getElementById("printDoc2").ShowDialog(3);
}
//打印
function ShowPrintDlg() {
         document.getElementById("printDoc2").ShowDialog(4); //打印对话框
     }

</script>
</head>
<body style="background-color: #E0EEE0;">
<div style="height: 800px;">
<po:PageOfficeCtrl id="printDoc2" />
</div>
</body>
</html>