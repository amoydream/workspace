<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<form id="vehicle_form" method="post" action="<%=basePath%>Main/vehicle/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">车辆品牌：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">车辆型号：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">车牌号：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/>
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">等级：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox"  style="width: 300px;"/>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">厢型：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox"  style="width: 300px;"/>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">座数：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox"  style="width: 300px;"/>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">限速（km/时）：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox"  style="width: 300px;"/>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">停放地点：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox"  style="width: 300px;"/>
		    </td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">备注：</td>
		    <td><textarea id="acontentid" name="t_Bus_Affiche.content"
					class="textarea" data-options="validType:'length[0,500]'"
					style="width:300px; height:80px;"></textarea>
		    </td>
		    </tr>		  
    </table>
</form>
