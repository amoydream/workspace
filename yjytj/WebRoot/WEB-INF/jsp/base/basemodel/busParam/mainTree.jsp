<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
	$(document).ready(function(){
		$('#'+'${ztreename}').tree({    
		    url:'<%=basePath%>Main/busParam/getTreeData/${ztreename}',
		    onClick: function(node){
		    	$('#'+'${ztreename}'+"_grid").datagrid({url:'<%=basePath%>Main/busParam/getGridData?searchid=${searchid}&pid='+node.id});
				$("#_selNodeID_"+'${ztreename}').val(node.id);
			}
		});
		var attrArray={
				toolbar: [
		                   { text: '添加', iconCls: 'icon-add',
		                	   handler: function(){
									var selnode = $("#_selNodeID_"+'${ztreename}').val();
									var dialogDef={
											title:'新增参数',
											href: '<%=basePath%>Main/busParam/add/'+selnode
									};
									$.lauvan.openCustomDialog('busParamDialog',dialogDef,null,'busParam_form');
		                	   }}, '-', 
		                   { text: '修改',title:'参数编辑',iconCls: 'icon-pageedit', 
				                   dialogParams:{dialogId:'busParamDialog',href:'<%=basePath%>Main/busParam/edit'
					                   ,formId:'busParam_form'}}, '-',
		                   { text: '删除',iconCls: 'icon-delete',delParams:{url:'<%=basePath%>Main/busParam/delete'}}
		                  ],
				fitColumns : true,
				idField:'ID',
				fit:true,
				url:'<%=basePath%>Main/busParam/getGridData?searchid=${searchid}&pid=${apId}'
	    };
		$.lauvan.dataGrid("${ztreename}_grid",attrArray);
		
		
	});
	
</script>
<div class="easyui-layout"  data-options="fit:true">
<div data-options="region:'west',border:false" style="width: 200px;">
	
	<ul id="${ztreename}" ></ul>
	
</div>
<div data-options="region:'center',border:false">
	<div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<input type="hidden" id="_selNodeID_${ztreename}" value="${apId}"/>
			<span>参数名称：</span>
			<input id="_pname_${ztreename}" type="text" class="easyui-textbox" >
			<a id="_${ztreename}_search" href="javascript:void(0);" class="easyui-linkbutton"   data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false" >
			<table id="${ztreename}_grid" cellspacing="0" cellpadding="0"> 
						    <thead> 
						        <tr> 
						           <th field="ID" width="100" data-options="hidden:true">ID</th> 
						            <th field="P_NAME" width="250">参数名称</th> 
						            <th field="P_ACODE" width="200" >参数编码</th> 
						            <th field="SUP_ID" width="100" data-options="hidden:true">pID</th> 
						            <th field="REMARK"  width="350" >备注</th> 
						        </tr> 
						    </thead> 
			</table>
		</div>
	</div>
</div>
</div>	
	
	 
	
