<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$(function(){
	$("#exptand").load("<%=basePath%>Main/protectobj/getview",{"tablename":"${tablename}"});
});
</script>
<form id="exptand_form" method="post" action="<%=basePath%>Main/protectobj/expSave"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
 	<input id="tablename" type="hidden" name="tablename" value="${tablename }"/>
 	<input type="hidden" name="tableid" value="${tableid }"/>
 	<div id="exptand"></div>
</form>
