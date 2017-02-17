<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				//toolbar: '#documentr_tb',
				/* toolbar: [
                  { text: '详情', iconCls: 'icon-search',handler:viewdoc,permitParams:'${pert:hasperti(applicationScope.documentview, loginModel.xdlimit)}'}
                 ], */
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/document/getrGridData",
				onDblClickRow :viewdoc
        };
		$.lauvan.dataGrid("documentrGrid",attrArray);
		
	});
	function documentr_doSearch(){
		$('#documentrGrid').datagrid('load',{
			dname: $('#dname2').val(),
			dcode: $('#dcode2').val()
			
		});	
	}
	function viewdoc(){
			var node = $("#documentrGrid").datagrid('getSelected');
			if(!node){
				$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
				return;
			}
			var attrArray={
					title:'公文详情',
					height: 500,
					width:700,
					href: '<%=basePath%>Main/document/docview/'+node.ID,
					buttons:[]
			};
			$.lauvan.openCustomDialog("docDialog",attrArray,null,null);		
	}
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>公文编号:</span>
		<input id="dcode2" type="text" class="easyui-textbox" >
		<span>公文标题:</span>
		<input id="dname2" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="documentr_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">

		<!-- <div id="documentr_tb">
		
		<a href="javascript:void(0);" onclick="viewdoc()" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">详情</a>
		</div> -->
		
			<table id="documentrGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="200">公文标题</th> 
			            <th field="CONTENT" width="500">公文内容</th>
			             <th field="RECEIVENAME" width="200">公文接收人</th>
			             <th field="SENDERNAME" width="100">公文发送人</th> 
			             <th field="SENDTIME" width="200">发送时间</th> 
			            <th field="NOTE" width="300">备注</th> 		         
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
