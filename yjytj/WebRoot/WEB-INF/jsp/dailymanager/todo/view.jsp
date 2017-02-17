<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

</script>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <c:if test="${it.type=='001'}">
	        <tr>
		    <td class="sp-td1">事件编码：</td>
		    <td>
		    ${it.code}
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">事件：</td>
		    <td>
		    ${it.ev_name }
		    </td>
		    </tr>
		    </c:if>
		    <tr>
		    <td class="sp-td1">事宜名称：</td>
		    <td>
		    ${it.name }
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">记录人：</td>
		    <td>
		    ${it.user_name}</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">记录时间：</td>
		    <td>
		    ${it.recordtime}</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">接收人：</td>
		    <td>
		    ${it.receivername}</td>
		    </tr>
		    <tr>
		    <tr>
			<td class="sp-td1">事宜内容：</td>
			<td>${it.content}</td>
		    </tr>
		    <tr>
			<td class="sp-td1">备注：</td>
			<td>${it.note}</td>
		    </tr>
</table>
