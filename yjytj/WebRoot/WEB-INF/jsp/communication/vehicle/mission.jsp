<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<form id="mission_form" method="post" action="<%=basePath%>Main/vehicle/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">公务：</td>
		    <td>
		     ${m.mission }
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">务派时间：</td>
		    <td>
		     ${m.time }
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">务派司机：</td>
		    <td>
		    ${m.driver }
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">司机电话：</td>
		    <td>
		    ${m.tel }
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">车牌号：</td>
		    <td>
		    ${m.vno }
		    </td>
		    </tr>   
		     <tr>
		    <td class="sp-td1">限速（km/时）：</td>
		    <td>
		    60
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">内容：</td>
		    <td>
		    <textarea id="acontentid" name=""
					class="textarea" data-options="validType:'length[0,500]'"
					style="width:300px; height:80px;">${m.content }
					</textarea>
		    </td>
		    </tr>
		 
    </table>
</form>
