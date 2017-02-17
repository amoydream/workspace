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
	PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);
	poCtrl1.setServerPage(basePath+"poserver.do"); //此行必须  
	poCtrl1.setTitlebar(false);
	poCtrl1.setCustomToolbar(false);
    //poCtrl1.addCustomToolButton("全屏/还原", "IsFullScreen", 4);
	poCtrl1.setMenubar(false);
	//poCtrl1.setSaveFilePage(path+"/Main/WorkingLog/savepage");
	String type=(String)request.getAttribute("type");
	if(type.equals("xls")||type.equals("xlsx")){
		poCtrl1.webOpen((String) request.getAttribute("newPath"),OpenModeType.xlsReadOnly,(String) request.getAttribute("username"));	
	}else if(type.equals("doc")||type.equals("docx")){
		poCtrl1.webOpen((String) request.getAttribute("newPath"),OpenModeType.docReadOnly,(String) request.getAttribute("username"));		
	}else{
		poCtrl1.webOpen((String) request.getAttribute("newPath"),OpenModeType.pptReadOnly,(String) request.getAttribute("username"));	
	}
	poCtrl1.setTagId("xlsmodel1"); //此行必须
%>
<script type="text/javascript">

</script>
<div style="height:100%;">
	<po:PageOfficeCtrl id="xlsmodel1" />
</div>
