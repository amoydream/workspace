<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={ toolbar: [
                  //{ text: '上传',title:'上传模板', iconCls: 'icon-add',
	              //     dialogParams:{dialogId:'templateDialog',href:basePath+"Main/template/add",width:500,
				//		height:350,formId:'templateform',isNoParam:true}}, '-', 
                  { text: '新增word模板',title:'新增word模板',iconCls: 'icon-pageedit', handler:createWordTemp}, '-',
				{ text: '新增excel模板',title:'新增excel模板',iconCls: 'icon-pageedit',handler:createExcelTemp}, '-',
				{ text: '修改',title:'修改模板',iconCls: 'icon-pageedit', handler:editTemp}, '-',
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/template/delete'}}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/template/getDataGrid",
		onDblClickRow:function(rowIndex, rowData){
			window.open(basePath+"Main/template/edit/"+rowData.ID);
		}
		};
		$.lauvan.dataGrid("tempalteGrid",attrArray);
		});

	function createWordTemp(){
		window.open(basePath+"Main/template/add/word");
	}

	function createExcelTemp(){
		window.open(basePath+"Main/template/add/excel");
	}

	function editTemp(){
		var row=$("#tempalteGrid").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择相应的记录！'});
			return;
		}
		window.open(basePath+"Main/template/edit/"+row.ID);
	}
	
	function template_doSearch(){
		$('#tempalteGrid').datagrid('load',{
			tname: $('#tname').val(),
			ttype: $('#ttype').val()
		});
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>模板名称：</span>
			<input id="tname" type="text" class="easyui-textbox" >
			<span>模板类型：</span>
			<input id="ttype" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="template_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="tempalteGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="150">模板名称</th> 
			            <th field="M_TYPE" width="100"  >模板类型</th>
			            <th field="M_SIZE" width="100" >模板大小</th>
			            <th field="REMARK" width="250"  >描述</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

