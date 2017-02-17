<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$(function(){
	$("#expdanger").load("<%=basePath%>Main/danger/getview",{"tablename":"${tablename}"});
});
</script>
<form id="expdanger_form" method="post" action="<%=basePath%>Main/danger/expSave"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
 	<input id="dantablename" type="hidden" name="tablename" value="${tablename }"/>
 	<input type="hidden" name="tableid" value="${tableid }"/>
 	<div id="expdanger"></div>
</form>
