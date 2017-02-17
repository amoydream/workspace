<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

<form id="macapAdd" method="post"
	action="<%=basePath%>Main/materialcap/save/${mfId}"
	style="width:100%;">
	<table id="table" class="sp-table" width="100%" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="sp-td1">产品名称：</td>
			<td><input name="t_Bus_Materialcap.proname" type="text"
				class="easyui-textbox"
				data-options="prompt:'请输入要素标题',required:true,icons:iconClear"
				style="width:180px;" /></td>

			<td class="sp-td1">产品类型：</td>
			<td><input name="t_Bus_Materialcap.protype" type="text"
				class="easyui-textbox" data-options="icons:iconClear"
				style="width:180px;" /></td>
		</tr>

		<tr>
			<td class="sp-td1">日生产量：</td>
			<td><input name="t_Bus_Materialcap.dayproamount" type="text"
				data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
				class="easyui-numberbox" style="width:180px;" /></td>

			<td class="sp-td1">计量单位：</td>
			<td><select class="easyui-combobox"
				name="t_Bus_Materialcap.measureunit" panelHeight="auto"
				code="MAUNIT" style="width: 180px;" data-options="editable:false"></select></td>
		</tr>

		<tr>
			<td class="sp-td1">最近更新：</td>
			<td><input type="text" name="t_Bus_Materialcap.updatetime"
				class="easyui-datetimebox" style="width: 180px;"
				data-options="disabled:true,editable:false,value:'${nowdate}'" /></td>
		</tr>

		<tr>
			<td class="sp-td1">备注：</td>
			<td colspan="3"><textarea name="t_Bus_Materialcap.remark"
					class="textarea" data-options="validType:'length[0,500]'"
					style="width: 560px;height: 50px;"></textarea></td>
		</tr>

		</table>
</form>
