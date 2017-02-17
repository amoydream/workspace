<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %> 
<%@ page import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
PDFCtrl pdfCtrl1 = new PDFCtrl(request);
//设置 PDFCtrl 的运行服务页面
pdfCtrl1.setFileTitle((String)request.getAttribute("title"));
pdfCtrl1.setServerPage(basePath+"poserver.do"); 

pdfCtrl1.addCustomToolButton("全屏切换", "IsFullScreen()", 4);
pdfCtrl1.addCustomToolButton("下载", "SaveAs()", 1);
pdfCtrl1.addCustomToolButton("打印", "ShowPrintDlg", 6);
pdfCtrl1.setTitlebar(false);
pdfCtrl1.setMenubar(false);

//打开PDF文档
pdfCtrl1.setJsFunction_AfterDocumentOpened("SetPageWidth()");
pdfCtrl1.webOpen((String)request.getAttribute("newPath"));
pdfCtrl1.setTagId("PDFCtrl1");
%>
<script type="text/javascript">
//全屏/还原
function IsFullScreen() {
    document.getElementById("PDFCtrl1").FullScreen = !document.getElementById("PDFCtrl1").FullScreen;
}
function SaveAs(){
	document.getElementById("PDFCtrl1").ShowDialog(3);
}
function SetPageWidth() {
    document.getElementById("PDFCtrl1").SetPageFit(1);
}
//打印
function ShowPrintDlg() {
         document.getElementById("PDFCtrl1").ShowDialog(4); //打印对话框
     }
</script>
<div >
	<po:PDFCtrl id="PDFCtrl1" />
</div>