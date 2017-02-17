<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'FUNDID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加募捐现存资金信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'collfundDialog', href:'<%=basePath%>Main/collfund/add/${dept.deptid}', 
								width:660, height:230, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改募捐现存资金信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'collfundDialog',href:'<%=basePath%>Main/collfund/edit',width:660,
									height:230,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/collfund/delete'}}, '-'
					//	{ text: '查看',iconCls: 'icon-eye', handler:viewCollfund}
						],
				url:"<%=basePath%>Main/collfund/getGridData/${dept.deptid}",
				view:detailview,
				detailFormatter: function(rowIndex, rowData){
					var note = rowData.NOTES;
					if(!note){

						note= "无";
					}
					return '<table style="width:760px;height:50px;"><tr><td style="font-weight:bold;width:50px;">备注：</td><td>'+ note +'</td></tr></table>';
				}
			};
		$.lauvan.dataGrid("collfund_data",attrArray);

	});

	function viewCollfund(){
		var row = $("#collfund_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '募捐现存资金详情',
			height: 200,
			width: 660,
			href:'<%=basePath%>Main/collfund/view/' + row.FUNDID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("collfundDialog",para,null,null);	
	}

	
	</script>
			 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
			<table id="collfund_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="FUNDID" data-options="hidden:true">ID</th> 
			            <th field="CURFUND" width="100">现存资金</th> 
			            <th field="SOURCEDEPTCODE" code="ZDFHSJLYDW" width="100">数据来源</th>
			            <th field="UPDATETIME" width="100">最新更新日期</th>
			            <th field="NOTES" data-options="hidden:true" >备注</th> 
			        </tr> 
			    </thead> 
			</table> 
</div></div>
