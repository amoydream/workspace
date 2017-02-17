<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head></head>

<script type="text/javascript">
	//打开地图
	function DTClick() {
		$.lauvan.openGisDialog($("#longitude").val(), $("#latitude").val(),
				function(lng, lat) {
					$("#longitude").textbox('setValue', lng);
					$("#latitude").textbox('setValue', lat);
				});
	}
</script>

<body>

	<tr>
		<td class="sp-td1">编号：</td>
		<td><input name="t_Bus_Example.code" type="text"
			data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
			class="easyui-numberbox" style="width:180px;" /></td>

		<td class="sp-td1">普通文本框：</td>
		<td><input name="t_Bus_Example.PT" type="text"
			class="easyui-textbox" data-options="prompt:'请输入',icons:iconClear"
			style="width:180px;" /></td>

		<td class="sp-td1">类型下拉框：</td>
		<td><select class="easyui-combobox" name="t_Bus_Example.LX"
			panelHeight="auto" code="LX" style="width: 180px;"
			data-options="editable:false"></select></td>

		<td class="sp-td1">日期框：</td>
		<td><input type="text" name="t_Bus_Example.borndate"
			class="easyui-datetimebox" style="width: 180px;"
			data-options="editable:false,icons:iconClear,value:'${nowdate}'" /></td>

		<td class="sp-td1">单位：</td>
		<td><input class="easyui-combotree" name="t_Bus_Example.organid"
			data-options="url:'<%=basePath%>Main/department/getComboTree',method:'get'"
			style="width:180px;"></td>
	<tr>
		<td class="sp-td1">经度：</td>
		<td><input id="longitude" name="t_Bus_Example.longitude"
			type="text" class="easyui-textbox" style="width: 180px;"
			data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}]" />
		</td>

		<td class="sp-td1">纬度：</td>
		<td><input id="latitude" name="t_Bus_Example.latitude"
			type="text" class="easyui-textbox" style="width: 180px;"
			data-options="readonly:true" /></td>
	</tr>

	<tr>
		<td class="sp-td1">文本域：</td>
		<td colspan="3"><textarea name="t_Bus_Example.WB"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 560px;height: 50px;"></textarea></td>

		<td class="sp-td1">树类型：</td>
		<td><input class="easyui-combotree" name="t_Bus_Example.SHU"
			data-options="url:'<%=basePath%>Main/expert/getComboTree',method:'get',required:true<c:if test="${pid!='0'}">,value:${pid }</c:if>"
			style="width:180px;"></td>

	</tr>

	<td colspan="3"></td>

</body>
</html>
