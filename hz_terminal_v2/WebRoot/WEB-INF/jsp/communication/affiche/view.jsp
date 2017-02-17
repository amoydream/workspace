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
		    <td class="sp-td1">公告标题：</td>
		    <td>
		    ${model.title }
		    </td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">发送人：</td>
		    <td>${model.username }</td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">创建时间：</td>
		    <td>${model.createtime }</td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">内容：</td>
		    <td><textarea id="report_r_content" name="t_Bus_Report.r_content"
			class="textarea" data-options="validType:'length[0,500]'"
			style="width: 573px; height: 100px;">${model.content}</textarea></td>
		    </tr>
    </table>
