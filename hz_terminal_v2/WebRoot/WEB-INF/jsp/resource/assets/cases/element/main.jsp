<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var eleId = 2;
		var attrArray={
				idField:'ELE_ID',
				fitColumns : true, 
				toolbar: [
						  { text:'添加', title:'添加要素', iconCls: 'icon-add',
								dialogParams:{dialogId:'elementDialog', href:'<%=basePath%>Main/caseselement/add/${cases.cas_id}', 
								width:700, height:560, formId:'elementForm', isNoParam:true},permitParams:'${pert:hasperti(applicationScope.elementAdd, loginModel.xdlimit)}'}, '-',
						  { text: '修改', title:'修改要素',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'elementDialog',href:'<%=basePath%>Main/caseselement/edit',width:700,
									height:560,formId:'elementForm'},permitParams:'${pert:hasperti(applicationScope.elementEdit, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/caseselement/delete'},permitParams:'${pert:hasperti(applicationScope.elementDel, loginModel.xdlimit)}'}

						],
				url:'<%=basePath%>Main/caseselement/getGridData/${cases.cas_id}',
				  onDblClickRow: function(rowIndex, rowData){
						view();
					}
			};
		$.lauvan.dataGrid("elementGrid",attrArray);

	});
	
	function view(){
		var row = $("#elementGrid").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '详情',
			height: 560,
			width: 700,
			href:'<%=basePath%>Main/caseselement/getview/' +row.ELE_ID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("viewDialog",para,null,null);		
	}


	</script>

			<table id="elementGrid" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="ELE_ID" data-options="hidden:true">ID</th> 
			            <th field="CONTENT" width="100">要素标题</th> 
			            <th field="ELEMENTDESC" width="100">内容描述</th>
			        </tr> 
			    </thead> 
			</table> 

