<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<form id="locatorform" style="width:100%;">
	    <input id="luserid" type="hidden" name="userid" value="${uid }"/>	
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td class="sp-td1">开始时间：</td>
			<td>
			<input type="text" id="btimeid" name="begintime"  class="easyui-datetimebox"   
			style="width: 180px;"  data-options="editable:false,icons:iconClear"/>
			</td>
		</tr>		
		<tr>
			<td class="sp-td1">终点时间：</td>
			<td><input type="text" id="etimeid"  name="endtime"  
			class="easyui-datetimebox"   style="width: 180px;"  
			data-options="editable:false,required:true,icons:iconClear,value:'${nowdate}'"/></td>
		</tr>

		</table>    	
    </form>
