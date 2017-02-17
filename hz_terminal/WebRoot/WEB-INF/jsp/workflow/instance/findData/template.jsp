<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  <script>
  var basePath = '<%=basePath%>';
  function dbaSource_doSearch(){
		$('#_dbasource').datagrid('load',{
			objName: $('#_objName_v').val()
		});
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
	 <div data-options="region:'north',border:false" style="height: 35px;">
	 <div id="_dbasource_tb" style="margin-top: 5px;margin-left: 5px;">
			<span>流程名称:</span>
			<input id="_objName_v" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="dbaSource_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
	 </div>
		<div data-options="region:'center',border:false">
		
			<table id="_wfFormSource" class="easyui-datagrid" cellspacing="0" cellpadding="0" 
			data-options="url:'<%=basePath%>Main/wfInstance/getWorkFlowData',fit:true,fitColumns:true,singleSelect:true,pageSize:20,pageList:[20,50,100], pagination:true"> 
			    <thead> 
			        <tr> 
			            <th field="ID"  data-options="hidden:true"></th> 
			            <th field="TNAME" width="200">流程名称</th>
			            <th field="FNAME" width="200" >表单名称</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
		
	</div>


