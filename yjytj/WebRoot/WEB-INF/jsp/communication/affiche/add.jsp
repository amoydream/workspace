<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<form id="affiche_form" method="post" action="<%=basePath%>Main/affiche/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">标题：</td>
		    <td>
		    <input id="atitleid" name="t_Bus_Affiche.title" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/>
		    </td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">内容：</td>
		    <td><textarea id="acontentid" name="t_Bus_Affiche.content"
					class="textarea" data-options="validType:'length[0,500]'"
					style="width:573px; height:100px;"></textarea>
		    </td>
		    </tr>		  
    </table>
</form>
