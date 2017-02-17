<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'TOOLID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加运输工具信息', iconCls: 'icon-add', dialogParams:{dialogId:'transtoolDialog', href:'<%=basePath%>Main/transtool/add', 
							  width:680,height:500, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改运输工具信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'transtoolDialog',href:'<%=basePath%>Main/transtool/edit',width:680,
									height:500,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/transtool/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewTranstool}
						],
				url:"<%=basePath%>Main/transtool/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewTranstool();

				}
				
			};
		$.lauvan.dataGrid("transtool_data",attrArray);

		
	});

	function transtoolSrh(){
		$("#transtool_data").datagrid('load', {
			toolname: $("#toolname").val(),
			transtypeid: $("#transtypeid").val(),
			firmname: $("#firmname").val()
		});
	}

	function viewTranstool(){
		var row = $("#transtool_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var para = {
				title: '运输工具基本详情',
				height:400,
				width: 680,
				href:'<%=basePath%>Main/transtool/view/' +row.TOOLID,
				buttons:[]
			};
			$.lauvan.openCustomDialog("transtoolDialog",para,null,null);	
	}

	function findFirm(){
		var param = {
			title:'选择运输企业',
			width:430,
			height:450,
			href:'<%=basePath%>Main/transtool/getTransFirmList',
			buttons:[{
				text:'确定',
				iconCls:'icon-save',
				handler:function(){
					var row = $("#transfirmGird").datagrid("getSelected");
					$("#firmid").val(row.FIRMID);
					$("#ttfirmname").textbox('setValue', row.FIRMNAME);
					$("#tflistDialog").dialog('close');
				}
	
			},{
				text:'关闭',
				iconCls: 'icon-no',
				handler:function(){
					$("#tflistDialog").dialog('close');
				}
			}]
		};
		$.lauvan.openCustomDialog("tflistDialog", param, null, null);
	}	

	function findTranstype(){
		var param = {
				title:'选择运输工具型号',
				width:430,
				height:450,
				href:'<%=basePath%>Main/transtool/getTransTypeList',
				buttons:[{
					text:'确定',
					iconCls:'icon-save',
					handler:function(){
						var row = $("#transtypeGrid").datagrid("getSelected");
						$("#transtooltype").val(row.TRANSTYPEID);
						$("#transtypename").textbox('setValue', row.TRANSTYPE);
						$("#ttlistDialog").dialog('close');
					}
		
				},{
					text:'关闭',
					iconCls: 'icon-no',
					handler:function(){
						$("#ttlistDialog").dialog('close');
					}
				}]
			};
			$.lauvan.openCustomDialog("ttlistDialog", param, null, null);
	}
	
	</script>
	 <div class="easyui-layout"  data-options="fit:true">
	 	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>工具名称：</span>
			<input id="toolname" type="text" class="easyui-textbox" data-options="icons:iconClear" style="width:150px;"/>
			<span>运输企业：</span>
			<input id="firmname" type="text" class="easyui-textbox" data-options="icons:iconClear" style="width:150px;"/>
			<span>型号编号：</span>
			<input id="transtypeid" type="text" class="easyui-textbox" data-options="icons:iconClear" style="width:150px;"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="transtoolSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
		<div data-options="region:'center',border:false">
			<table id="transtool_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="TOOLID" data-options="hidden:true">ID</th> 
			            <th field="TOOLNAME" width="100">工具名称</th> 
			            <th field="FIRMNAME" width="100">运输企业</th> 
			            <th field="TRANSTYPE" width="150">型号编号</th>
			            <th field="USUALUSECODE" code="YSGJRCYT" width="100">日常用途</th>
			            <th field="LOADTYPECODE" code="YSHWLX" width="100">运送货物类型</th>
			            <th field="TOOLNUM" width="100">运输工具数量</th>
			            <th field="MEASUREUNIT" width="100">计量单位</th>
			            <th field="DEPOSITPLACE" width="130">存放地点</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
