<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
.actstatus_ul{
	margin-left:20px;
	margin-top:30px;
}
.actstatus_ul li{
	float:left;
	padding-left:10px;
}
</style>
	<script>
	
	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
 	<form id="form1" method="post" action="<%=basePath%>Main/geographic/dispatch/setActStatus">
 		<input type="hidden" name="evactid" value="${evactid}"/>
 		<ul class="actstatus_ul">
			<c:if test="${status !='E'}"><li><input type="radio" value="E" name="status"/>正在执行</li></c:if>
			<li><input type="radio" value="D" name="status" />执行完成</li>
			<li><input type="radio" value="F" name="status"/>执行失败</li>
		</ul>
	</form>
</div>

