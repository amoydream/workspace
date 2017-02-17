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
		    <td class="sp-td1">姓名：</td>
		    <td>${lm.name }</td>
		    <td class="sp-td1">手机：</td>
		    <td>
		   ${lm.tel}</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">部门：</td>
		    <td>
		    ${lm.dept}</td>
		    <td class="sp-td1">职位：</td>
		    <td>
		    ${lm.position}</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">备注：</td>
		    <td  colspan="3">
		    <div style="word-break:break-all">
		    ${lm.remark}
		    </div>
		    </td>
		    </tr>
    </table>
