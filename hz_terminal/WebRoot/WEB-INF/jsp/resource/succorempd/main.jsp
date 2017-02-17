<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'PERSID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加简历信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'succorempdDialog', href:'<%=basePath%>Main/succorempd/add/${s.personid}', 
								width:700, height:460, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改简历信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'succorempdDialog',href:'<%=basePath%>Main/succorempd/edit',width:700,
									height:460,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/succorempd/delete'}}

						],
				url:"<%=basePath%>Main/succorempd/getGridData/${s.personid}"
			};
		$.lauvan.dataGrid("succorempd_data",attrArray);

	});

	//查找部门
	function findbusorg(){
		var param = {
			title:'选择部门',
			width:600,
			height:500,
			href:'<%=basePath%>Main/emsperson/getBusOrg',
			buttons:[{
				text:'确定',
				iconCls:'icon-save',
				handler: function(){
					var row = $("#orgGrid").datagrid("getSelected");
					$("#equdeptid").val(row.OR_ID);
					$("#equdeptname").textbox('setValue', row.OR_NAME);
					$dialog.dialog('close');
				}
			},{
				text:'关闭',
				iconCls:'icon-no',
				handler:function(){
					$dialog.dialog('close');
				}

			}]
		};
		$.lauvan.openCustomDialog("orgDialog", param, null, null);
	
	}

	</script>

			<table id="succorempd_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="PERSID" data-options="hidden:true">ID</th> 
			            <th field="STARTTIME" width="100">起始时间</th> 
			            <th field="ENDTIME" width="100">终止时间</th>
			            <th field="PERDEPT" width="100">所在单位</th> 
			            <th field="PERDUTY" width="100">职务</th> 
			        </tr> 
			    </thead> 
			</table> 

