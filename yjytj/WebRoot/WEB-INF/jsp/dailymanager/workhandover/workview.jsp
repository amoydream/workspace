<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
</script> 
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    <c:if test="${record.eventname!=null }">
	    <tr>
		    <td class="sp-td1">事件：</td>
		    <td>${record.eventname }</td>
		    </tr>
		    </c:if>
		<tr>
			<td class="sp-td1">值班纪要类型：</td>
			<td>
		${record.type}
			</td>
		</tr>
		<tr>
		<td class="sp-td1">编辑时间：</td>
		<td>${record.marktime}</td>
		</tr>
		<c:if test="${record.content!=null }">
		<tr>
			<td class="sp-td1">值班纪要内容：</td>
			<td>${record.content }</td>
		</tr>
		</c:if>
		</table>    	
