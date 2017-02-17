<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

<form id="perAdd" method="post"
	action="<%=basePath%>Main/expertgroupper/save/${egId}"
	style="width:100%;">
	<table id="table" class="sp-table" width="100%" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="sp-td1">专家姓名：</td>
			<td><input type="hidden" name="t_Bus_Expertgroup_Per.expertid"
				id="expertid" /> <input type="text" id="expertname"
				data-options="readonly:true" class="easyui-textbox"
				style="width: 150px;" /> <a id="btn" onclick="findExpert()"
				class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			</td>

			<td class="sp-td1">组中职务：</td>
			<td><input name="t_Bus_Expertgroup_Per.egp_position" type="text"
				class="easyui-textbox" data-options="prompt:'icons:iconClear"
				style="width:180px;" /></td>

		</tr>
		<tr>
			<td class="sp-td1">备注：</td>
			<td colspan="3"><textarea
					name="t_Bus_Expertgroup_Per.egp_remark" class="textarea"
					data-options="validType:'length[0,500]'"
					style="width: 560px;height: 50px;"></textarea></td>
		</tr>
	</table>
</form>
