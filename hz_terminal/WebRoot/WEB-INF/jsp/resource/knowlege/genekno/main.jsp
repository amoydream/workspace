<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	<script>
	
	$(function(){
		var attrArray={
				idField:'KNOID',
				fitColumns : true, 
				toolbar: [
						   
						  { text:'添加', title:'添加应急常识信息', iconCls: 'icon-add',
								dialogParams:{dialogId:'geneknoDialog', href:'<%=basePath%>Main/genekno/add', 
								width:660, height:480, formId:'form1', isNoParam:true}}, '-',
						  { text: '修改', title:'修改应急常识信息',iconCls: 'icon-pageedit',
									  dialogParams:{dialogId:'geneknoDialog',href:'<%=basePath%>Main/genekno/edit',width:660,
									height:480,formId:'form1'}}, '-',
						  { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/genekno/delete'}}, '-',
						{ text: '查看',iconCls: 'icon-eye', handler:viewGenekno}
						],
				url:"<%=basePath%>Main/genekno/getGridData",
				onDblClickRow:function(rowIndex, rowData){
					viewGenekno();

				}
			};
		$.lauvan.dataGrid("genekno_data",attrArray);

	});

	function geneknoSrh(){
		$("#genekno_data").datagrid('load', {
			title: $("#geneknotitle").val(),
			typecode: $("#geneknotc").combotree('getValue')

		});
	}

	function viewGenekno(){
		var row = $("#genekno_data").datagrid('getSelected');
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}

		var para = {
			title: '常识详情',
			height: 400,
			width: 660,
			href:'<%=basePath%>Main/genekno/view/' + row.KNOID,
			buttons:[]
		};
		$.lauvan.openCustomDialog("geneknoDialog",para,null,null);	
	}

	function onComplete(event, queueId, fileObj, response, data){
		var obj = eval( "(" + response + ")" );
		if($("#fjid").length>0){
			deleteFile($("#fjval").val());
		}
		var html = "<input type='hidden' id='fjid' value='" + obj.id +"' name='fjid'/>";
		html += "<a class='btnAttach' title='请点击另存为'></a><a title='请点击另存为' target='_blank' href='<%=basePath%>Main/attachment/downloadFJ/";
		html += obj.id + "' >" + obj.name +　"</a>（" + obj.size + "）<a href='javascript:deleteFile(" + obj.id +");'><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
		$("#filebox").html(html);
  	}

  	function deleteFile(fjid){
		//$("#filebox").load("<%=basePath%>Main/attachment/delete/" + fjid);
		$.post("<%=basePath%>Main/attachment/delete/" + fjid, null ,null);
		$("#filebox").empty();

  	}
	</script>
			 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>常识标题：</span>
			<input id="geneknotitle" type="text" class="easyui-textbox" data-options="icons:iconClear"/>
			<span>常识类型：</span>
			<input id="geneknotc" type="text" class="easyui-combotree" style="width:180px;"  data-options="url:'<%=basePath%>Main/genekno/getTypeTreeByAcode/GENEKNO', method:'get',editable:false,icons:iconClear"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="geneknoSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="genekno_data" cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="KNOID" data-options="hidden:true">ID</th> 
			            <th field="KNOTITLE" width="100">标题</th> 
			            <th field="P_NAME" width="100">类型</th>
			            <th field="KNOKEYWORD" width="100">主题词</th>
			            <th field="KNOSOURCE" width="100">应急常识来源</th>
			            <th field="UPDATETIME" width="100">最新更新日期</th>
			        </tr> 
			    </thead> 
			</table> 
</div></div>
