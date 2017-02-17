<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%@ page
	import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*,com.zhuozhengsoft.pageoffice.excelwriter.*"%>
<%@ include file="/include/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);
	poCtrl1.setServerPage(basePath + "poserver.do"); //此行必须  
	poCtrl1.setTitlebar(false);
	poCtrl1.setMenubar(false);
	poCtrl1.addCustomToolButton("保存", "Save", 1);
	poCtrl1.addCustomToolButton("打开", "openLCfile", 13);
	poCtrl1.addCustomToolButton("导出", "SaveAs", 11);
	poCtrl1.addCustomToolButton("打印", "ShowPrintDlg", 6);
	poCtrl1.setSaveFilePage(basePath + "Main/template/pageSave");
	String flag = (String) request.getAttribute("flag");
	DocumentVersion df = DocumentVersion.Word2003;
	if ("excel".equals(flag)) {
		df = DocumentVersion.Excel2003;
	}
	poCtrl1.webCreateNew((String) request.getAttribute("username"), df);
	poCtrl1.setTagId("templateView"); //此行必须
%>
<script type="text/javascript">
	function Save() {
	    var tname = document.getElementById("tempname").value;
	    if(tname == '') {
		    alert("请输入模板名称！");
		    return;
	    }
	    document.getElementById("act").value = "save";
	    document.getElementById("templateView").WebSave();
	    var tgrid = window.opener.$("#tempalteGrid");
	    if(tgrid != null && tgrid != undefined) {
		    tgrid.datagrid('reload');
	    }
	    window.close();
    }
    function SaveAs() {
	    document.getElementById("templateView").ShowDialog(3);
    }
    //打印
    function ShowPrintDlg() {
	    document.getElementById("templateView").ShowDialog(4); //打印对话框
    }
    //打开本地文件
    function openLCfile() {
	    document.getElementById("templateView").ShowDialog(1);
    }
</script>
<form id="form1">
	<div style="width: 900px; font-size: 14px; margin: 0 auto;">
		<span style="color: Red;">模板名称：</span>
		<input id="act" name="act" type="hidden" value="add" />
		<input id="tempname" name="tempname" type="text" value="" style="width: 200px;" />
		<span>模板描述：</span>
		<input name="remark" type="text" value="" style="width: 400px;" />
	</div>
	<div style="height: 97%;">
		<po:PageOfficeCtrl id="templateView" />
	</div>
</form>
