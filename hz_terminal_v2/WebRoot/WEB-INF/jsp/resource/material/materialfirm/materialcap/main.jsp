<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'CAP_ID',
				fitColumns : true, 
				toolbar: [
						  { text:'添加', title:'添加要素', iconCls: 'icon-add',
								dialogParams:{dialogId:'macapDialog', href:'<%=basePath%>Main/materialcap/add/${model.mf_id}', 
								width:700, height:560, formId:'macapAdd', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.macapAdd, loginModel.xdlimit)}'}, '-',
						  { text: '修改', title:'修改要素',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'macapDialog',href:'<%=basePath%>Main/materialcap/edit',width:700,
									height:560,formId:'macapEdit'},permitParams:'${pert:hasperti(applicationScope.macapEdit, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/materialcap/delete'},permitParams:'${pert:hasperti(applicationScope.macapDel, loginModel.xdlimit)}'}

						],
				url:"<%=basePath%>Main/materialcap/getGridData/${model.mf_id}"
			};
		$.lauvan.dataGrid("macapGrid",attrArray);

	});

	</script>

			<table id="macapGrid" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="CAP_ID" data-options="hidden:true">ID</th> 
			            <th field="PRONAME" width="100">产品名称</th> 
			            <th field="DAYPROAMOUNT" width="100">日生产量</th>
			            <th field="MEASUREUNIT" width="100" CODE="MAUNIT">计量单位</th>
			        </tr> 
			    </thead> 
			</table> 

