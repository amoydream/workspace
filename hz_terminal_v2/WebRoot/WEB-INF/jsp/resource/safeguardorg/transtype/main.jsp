<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'TRANSTYPEID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加运输工具型号信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'transtypeDialog', href:'<%=basePath%>Main/transtype/add', 
								width:660, height:400, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改运输工具型号信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'transtypeDialog',href:'<%=basePath%>Main/transtype/edit',width:660,
									height:400,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/transtype/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewTranstype}
						],
				url:"<%=basePath%>Main/transtype/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewTranstype();

				}
			};
		$.lauvan.dataGrid("transtype_data",attrArray);

	});

	function transtypeSrh(){
		$("#transtype_data").datagrid('load', {
			transtype: $("#transtype").val(),
			transwaycode: $("#transwaycode").combobox('getValue')

		});
	}

	function viewTranstype(){
		var row = $("#transtype_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '运输工具型号详情',
			height: 380,
			width: 660,
			href:'<%=basePath%>Main/transtype/view/' + row.TRANSTYPEID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("transtypeDialog",para,null,null);	
	}
	</script>
			 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>运输工具型号：</span>
			<input id="transtype" type="text" class="easyui-textbox" data-options="icons:iconClear"/>
			<span>运输方式：</span>
			<input id="transwaycode" type="text" class="easyui-combobox" style="width:180px;" code="YSFS" data-options="editable:false,icons:iconClear,panelHeight:135"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="transtypeSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="transtype_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="TRANSTYPEID" data-options="hidden:true">ID</th> 
			            <th field="TRANSTYPE" width="100">运输工具型号</th> 
			            <th field="PRODUCEVENDER" width="100">生产企业</th>
			            <th field="TRANSLOAD" width="100">载重</th>
			            <th field="USEFUEL" width="100">使用燃料</th>
			            <th field="TRANSWAYNAME" width="100">运输方式</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
