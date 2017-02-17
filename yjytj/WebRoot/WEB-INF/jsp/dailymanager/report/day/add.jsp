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
	<table id="table" class="sp-table" width="100%" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="sp-td1">创建人姓名：</td>
			<td><input id="report_r_username" type="text" name="t_Bus_Report.r_username"
				value="${username }" class="easyui-textbox" style="width: 180px;"
				readonly="true" /></td>
			</td>
		</tr>
		<tr>
			<td class="sp-td1">标题：</td>
			<td><input id="report_r_title" type="text" name="t_Bus_Report.r_title"
				data-options="prompt:'请输入标题',required:true,icons:iconClear"
				class="easyui-textbox" style="width: 180px;" /></td>
		</tr>
		<tr>
			<td class="sp-td1">内容：</td>
			<td colspan="3"><textarea id="report_r_content" name="t_Bus_Report.r_content"
					class="textarea" data-options="validType:'length[0,500]'"
					style="width: 573px; height: 80px;"></textarea></td>
		</tr>

	</table>
</form>
