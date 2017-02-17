<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/include/inc.jsp"%>

<form id="dayreportform" method="post"
	action="<%=basePath%>Main/dayreport/save" style="width: 100%;">
	<input type="hidden" name="act" value="edit" />
	<input type="hidden" name="t_Bus_Report.r_id" value="${dayreport.r_id }"/>
	<table id="table" class="sp-table" width="100%" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="sp-td1">创建人姓名：</td>
			<td><input type="text" name="t_Bus_Report.r_username"
				value="${dayreport.r_username }" class="easyui-textbox" style="width: 180px;"
				readonly="true" /></td>
			</td>
		</tr>
		<tr>
			<td class="sp-td1">标题：</td>
			<td><input type="text" id="report_r_title" name="t_Bus_Report.r_title" value="${dayreport.r_title }"
				data-options="prompt:'请输入标题',required:true,icons:iconClear"
				class="easyui-textbox" style="width: 180px;" /></td>
		</tr>
		<tr>
			<td class="sp-td1">内容：</td>
			<td colspan="3"><textarea id="report_r_content" name="t_Bus_Report.r_content"
			class="textarea" data-options="validType:'length[0,500]'"
			style="width: 573px; height: 80px;">${dayreport.r_content }</textarea></td>
		</tr>

	</table>
</form>
