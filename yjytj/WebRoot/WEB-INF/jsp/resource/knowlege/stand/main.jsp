<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'STANDID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加规范信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'standDialog', href:'<%=basePath%>Main/stand/add', 
								width:680, height:550, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改规范信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'standDialog',href:'<%=basePath%>Main/stand/edit',width:680,
									height:550,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/stand/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewstand}
						],
				url:"<%=basePath%>Main/stand/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewstand();

				}
			};
		$.lauvan.dataGrid("stand_data",attrArray);

	});

	function standSrh(){
		$("#stand_data").datagrid('load', {
			standname: $("#standname").val(),
			typecode: $("#standtypecode").combotree('getValue')

		});
	}

	function viewstand(){
		var row = $("#stand_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '规范详情',
			height: 480,
			width: 660,
			href:'<%=basePath%>Main/stand/view/' +row.STANDID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("standDialog",para,null,null);		
	}
	</script>
			 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>名称：</span>
			<input id="standname" type="text" class="easyui-textbox" data-options="icons:iconClear"/>
			<span>类型：</span>
			<input id="standtypecode" type="text" class="easyui-combotree" style="width:180px;"  data-options="url:'<%=basePath%>Main/genekno/getTypeTreeByAcode/GENEKNO', method:'get',editable:false,icons:iconClear"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="standSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="stand_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="STANDID" data-options="hidden:true">ID</th> 
			            <th field="STANDNAME" width="150">名称</th> 
			            <th field="FILENO" width="100">标准号</th>
			            <th field="STANDKEYWORD" width="150">主题词</th>
			            <th field="CREATEORG" width="100">制定单位</th>
			            <th field="PUBDATE" width="100">发布时间</th>
			            <th field="EFFDATE" width="100">生效时间</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
