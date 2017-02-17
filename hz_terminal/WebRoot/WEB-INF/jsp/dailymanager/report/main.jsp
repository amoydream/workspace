<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script>
	var basePath = '<%=basePath%>';
	var button_send = [{
		text:'发送',
		iconCls:'icon-save',
		handler:function(){
			alert("未开通传真接口...");
			/* $("#reportfaxform").form('options').queryParams={'act':'fk'};
			$.lauvan.dialogSubmit('reportfaxform','faxDialog'); */
		}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#faxDialog").dialog('close');
		}
	}]
	var button_dayreport = [
			{
				text : '发送传真',
				iconCls : 'icon-ok',
				handler : function() {	
					var rtitle = $("#report_r_title").val();
					var rcontent = $("#report_r_content").val();
					var attrArray={
							title:'每日快报传真',
							height: 600,
							width:1000,
							href: basePath + "Main/dayreport/faxSave",
							queryParams:{'rtitle':rtitle,'rcontent':rcontent},
					        buttons : button_send
					};					
					$.lauvan.openCustomDialog("faxDialog",attrArray); 
				}
			},
			{
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					$("#dayreportform").form('options').queryParams = {
						'act' : 'add'
					};
					$.lauvan.dialogSubmit('dayreportform',
							'dayReportDialog');
				}
			}, {
				text : '关闭',
				iconCls : 'icon-no',
				handler : function() {
					$("#dayReportDialog").dialog('close');
				}
			} ]
		
	var button_weekreport = [
	            			{
	            				text : '发送传真',
	            				iconCls : 'icon-ok',
	            				handler : function() {
	            					var rtitle = $("#report_r_title").val();
	            					var rcontent = $("#report_r_content").val();            
	            					var attrArray={
	            							title:'每周快报传真',
	            							height: 600,
	            							width:1000,
	            							href: basePath + "Main/dayreport/faxSave",
	            							queryParams:{'rtitle':rtitle,'rcontent':rcontent},
	            					        buttons : button_send
	            					};					
	            					$.lauvan.openCustomDialog("faxDialog",attrArray); 	            					
				                }
			},
			{
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					$("#weekreportform").form('options').queryParams = {
						'act' : 'add'
					};
					$.lauvan.dialogSubmit('weekreportform', 'weekReportDialog');
				}
			}, {
				text : '关闭',
				iconCls : 'icon-no',
				handler : function() {
					$("#weekReportDialog").dialog('close');
				}
			} ]

	$(function() {
		var attrArrayDay = {
			toolbar : [
					{
						text : '添加',
						title : '添加每日要情快报',
						iconCls : 'icon-add',
						permitParams : "${pert:hasperti(applicationScope.dayreportAdd, loginModel.xdlimit)}",
						dialogParams : {
							dialogId : 'dayReportDialog',
							href : basePath + "Main/dayreport/add",
							width : 800,
							height : 300,
							formId : 'dayreportform',
							isNoParam : true,
							buttons : button_dayreport
						}
					},
					'-',
					{
						text : '修改',
						title : '修改每日要情快报',
						iconCls : 'icon-edit',
						permitParams : "${pert:hasperti(applicationScope.dayreportEdit, loginModel.xdlimit)}",
						dialogParams : {
							dialogId : 'dayReportDialog',
							href : basePath + "Main/dayreport/edit",
							width : 800,
							height : 380,
							formId : 'dayreportform',
							buttons : button_dayreport
						}
					}, '-', {
						text : '删除',
						iconCls : 'icon-delete',
						permitParams : "${pert:hasperti(applicationScope.dayreportDelete, loginModel.xdlimit)}",
						delParams : {
							url : basePath + 'Main/dayreport/delete'
						}
					} ],
			fitColumns : true,
			idField : 'R_ID',
			url : basePath + "Main/dayreport/getGridData",
			onDblClickRow : function(rowIndex, rowData) {
				//打开详情页面
				$("#viewReportDialog").dialog({
					title : '每日要情快报',
					width : 800,
					height : 380,
					cache : false,
					modal : true,
					href : basePath + "Main/dayreport/view/" + rowData.R_ID,
					buttons : []
				});
			}
		};
		$.lauvan.dataGrid("dayreportGrid", attrArrayDay);

		var attrArrayWeek = {
			toolbar : [
					{
						text : '添加',
						title : '添加每周要情快报',
						iconCls : 'icon-add',
						permitParams : "${pert:hasperti(applicationScope.weekreportAdd, loginModel.xdlimit)}",
						dialogParams : {
							dialogId : 'weekReportDialog',
							href : basePath + "Main/weekreport/add",
							width : 800,
							height : 300,
							formId : 'weekreportform',
							isNoParam : true,
							buttons : button_weekreport
						}
					},
					'-',
					{
						text : '修改',
						title : '修改每周要情快报',
						iconCls : 'icon-edit',
						permitParams : "${pert:hasperti(applicationScope.weekreportEdit, loginModel.xdlimit)}",
						dialogParams : {
							dialogId : 'weekReportDialog',
							href : basePath + "Main/weekreport/edit",
							width : 800,
							height : 380,
							formId : 'weekreportform',
							buttons : button_weekreport
						}
					}, '-', {
						text : '删除',
						iconCls : 'icon-delete',
						permitParams : "${pert:hasperti(applicationScope.weekreportDelete, loginModel.xdlimit)}",
						delParams : {
							url : basePath + 'Main/weekreport/delete'
						}
					} ],
			fitColumns : true,
			idField : 'R_ID',
			url : basePath + "Main/weekreport/getGridData",
			onDblClickRow : function(rowIndex, rowData) {
				//打开详情页面
				$("#viewReportDialog").dialog({
					title : '每周要情快报',
					width : 800,
					height : 380,
					cache : false,
					modal : true,
					href : basePath + "Main/weekreport/view/" + rowData.R_ID,
					buttons : []
				});
			}
		};
		$.lauvan.dataGrid("weekreportGrid", attrArrayWeek);
	});

	function report_doSearch() {
		var pp = $('#tabid').tabs('getSelected');
		var title = pp.panel('options').title;
		if (title == '每日要情快报') {
			$('#dayreportGrid').datagrid('load', {
				rname : $('#rname').val(),
				username : $('#username').val()
			});
		} else {
			$('#weekreportGrid').datagrid('load', {
				rname : $('#rname').val(),
				username : $('#username').val()
			});
		}
	}

	function faxcontent(value, row, index) {
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
				+ "<a  onClick=\"faxMsg();\" >传真详情</a></li>"
				+ "</ul>";
		return act;
	}
	
	function faxMsg(){
		alert("传真接口未开通...");
	}
</script>

<div class="easyui-layout" data-options="fit:true">
    <div data-options="region:'north',border:false"
		style="padding: 5px; background: #f7f7f7;">
		<span>标题：</span> <input id="rname" type="text" class="easyui-textbox">
		<span>创建人：</span> <input id="username" type="text"
			class="easyui-textbox"> <a href="javascript:void(0);"
			class="easyui-linkbutton" onclick="report_doSearch()"
			data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
		<div id="tabid" class="easyui-tabs" style="width: 100%;"
			data-options="fit:true">
			<div title="每日要情快报">
				<table id="dayreportGrid" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th field="R_TITLE" width="150">标题</th>
							<th field="R_USERNAME" width="100">创建人</th>
							<th field="R_CREATETIME" width="100">创建时间</th>
							<th field="FAX" width="180" formatter="faxcontent">操作</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="每周要情快报">
				<table id="weekreportGrid" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th field="R_TITLE" width="150">标题</th>
							<th field="R_USERNAME" width="100">创建人</th>
							<th field="R_CREATETIME" width="100">创建时间</th>
							<th field="FAX" width="180" formatter="faxcontent">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<div id="viewReportDialog"></div>