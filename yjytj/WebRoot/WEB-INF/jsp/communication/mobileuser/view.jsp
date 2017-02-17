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
		    <td>
		    ${mu.realname }
		    </td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">用户名：</td>
		    <td>${mu.username }</td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">密码：</td>
		    <td>XXXXXX</td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">职位：</td>
		    <td>${mu.depposname}</td>
		    </tr>
    </table>
