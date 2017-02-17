<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function finduser(){
	var attrArray={
			title:'选择司机',
			width:600,
			height:500,
			href: '<%=basePath%>Main/driver/getDrivers',
			buttons:[
{
	text:'确定',
	iconCls:'icon-save',
	handler:function(){
		var node = $("#usersGrid").datagrid('getSelected');
		$("#driversid").textbox('setValue',node.NAME);
		$("#userDialog").dialog('close');
	}
},{
	text:'关闭',
	iconCls:'icon-no',
	handler:function(){
		$("#userDialog").dialog('close');
	}
}
			         ]
	}; 
	$.lauvan.openCustomDialog("userDialog",attrArray,null,null);
}
</script>

<form id="mission_form" method="post" action="<%=basePath%>Main/vehicle/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">派务：</td>
		    <td>
		    <input id="atitleid" name="" type="text" class="easyui-textbox" data-options="required:true" 
		    value="${v.brand }" style="width: 300px;"/>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">选择司机：</td>
		    <td>
		   <%--  <input id="atitleid" name="" type="text" class="easyui-textbox" data-options="required:true"  
		    value="${v.vnum }" style="width: 300px;"/> --%>
		    <input id="driversid" name="" type="text" readonly="true" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/>
		    <a id="btn1" onclick="finduser()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a>
		    </td>
		    </tr>
	        <tr>
		    <td class="sp-td1">内容：</td>
		    <td>
		    <textarea id="acontentid" name=""
					class="textarea" data-options="validType:'length[0,500]'"
					style="width:300px; height:80px;">
					</textarea>
		    </td>
		    </tr>
    </table>
</form>
