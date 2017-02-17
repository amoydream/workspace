<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<form id="driver_form" method="post" action="<%=basePath%>Main/vehicle/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">姓名：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">性别：</td>
		    <td>
		    <select id="sex" class="easyui-combobox" data-options="panelHeight:'50px'" name="sex" style="width:300px;">
			<option value="1">男</option>
			<option value="2">女</option>			
			</select>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">准驾车型：</td>
		    <td>
		     <select id="type" class="easyui-combobox" data-options="panelHeight:'150px'" name="type" style="width:300px;">
			<option value="1">A1</option>
			<option value="2">A3</option>			
			<option value="3">B1</option>
			<option value="4">B2</option>			
			<option value="5">C1</option>
			<option value="6">C2</option>								
			</select>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">电话：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox"  style="width: 300px;"/>
		    </td>
		    </tr>	   
    </table>
</form>
