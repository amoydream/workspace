<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head></head>
<body>
	<tr>
		<td class="sp-td1">姓名：</td>
		<td><input name="t_Bus_Example.PT" type="text"
			class="easyui-textbox" data-options="prompt:'请输入',icons:iconClear"
			style="width:180px;" value="${model.PT }" /></td>

		<td class="sp-td1">类型下拉框：</td>
		<td><select class="easyui-combobox" name="t_Bus_Example.LX"
			panelHeight="auto" code="LX" style="width: 180px;"
			data-options="editable:false,value:'${model.LX}'"></select></td>

		<td class="sp-td1">日期：</td>
		<td><input type="text" name="t_Bus_Example.TI"
			class="easyui-datetimebox" style="width: 180px;"
			data-options="editable:false,value:'${model.TI}'" /></td>

		<td class="sp-td1">所在单位：</td>
		<td><input class="easyui-combotree" name="t_Bus_Example.organid"
			data-options="url:'<%=basePath%>Main/department/getComboTree',method:'get',value:'${model.organid}'"
			style="width:180px;"></td>

		<td class="sp-td1">经度：</td>
		<td><input id="ev_longitude" name="t_Bus_EventInfo.ev_longitude"
			type="text" class="easyui-textbox" style="width: 180px;"
			data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}],value:'${t.ev_longitude}'" />
		</td>

		<td class="sp-td1">纬度：</td>
		<td><input id="ev_latitude" name="t_Bus_EventInfo.ev_latitude"
			type="text" class="easyui-textbox" style="width: 180px;"
			data-options="readonly:true" value="${t.ev_latitude}" /></td>

	</tr>

</body>
</html>
