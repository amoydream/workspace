<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'TPE_ID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加人员信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'teamPersonDialog', href:'<%=basePath%>Main/teamperson/add/${team.tea_id}', 
								width:700, height:560, formId:'form1', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.teamperAdd, loginModel.xdlimit)}'}, '-',
						  { text: '修改', title:'修改人员信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'teamPersonDialog',href:'<%=basePath%>Main/teamperson/edit',width:700,
									height:560,formId:'form1'},permitParams:'${pert:hasperti(applicationScope.teamperEdit, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/teamperson/delete'},permitParams:'${pert:hasperti(applicationScope.teamperDel, loginModel.xdlimit)}'}

						],
				url:"<%=basePath%>Main/teamperson/getGridData/${team.tea_id}"
			};
		$.lauvan.dataGrid("teamPersonGrid",attrArray);

	});
	

	</script>

			<table id="teamPersonGrid" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ID" data-options="hidden:true">ID</th> 
			            <th field="TPE_NAME" width="100">人员姓名</th>
			            <th field="SEX" width="100" CODE="SEX">性别</th> 
			            <th field="PHONE" width="100">手机</th>
			        </tr> 
			    </thead> 
			</table> 

