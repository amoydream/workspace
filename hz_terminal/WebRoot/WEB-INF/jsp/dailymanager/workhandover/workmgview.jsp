<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
</script>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td class="sp-td1">交班人：</td>
			<td>${wh.givername}</td>
		</tr>
		<tr>
		    <td class="sp-td1">接班人：</td>
		    <td>
		    ${wh.receivename }</td>
		    </tr>
		<tr>
		<tr>
		    <td class="sp-td1">值班主任：</td>
		    <td>
		    ${wh.manager }
		    </td>
		    </tr>
		<tr>
			<td class="sp-td1">交班时间：</td>
			<td>${wh.dutydate}</td>
		</tr>
		<c:if test="${wh.getduty!=null}">
		<td class="sp-td1">接班时间：</td>
			<td>${wh.getduty}</td>
		</c:if>
		<tr>
			<td class="sp-td1">备注：</td>
			<td>${wh.bak }</td>
		</tr>
		</table>    	
