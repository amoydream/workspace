<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  <script>
  var basePath = '<%=basePath%>';
  function dbaSource_doSearch(){
		$('#wfCheckUser').datagrid('load',{
			objName: $('#objName_v').val()
		});
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
	 <div data-options="region:'north',border:false" style="height: 35px;">
	 <div id="dbasource_tb" style="margin-top: 5px;margin-left: 5px;">
			<span>用户名称:</span>
			<input id="objName_v" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="dbaSource_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
	 </div>
		<div data-options="region:'center',border:false">
		
			<table id="wfCheckUser" class="easyui-datagrid" cellspacing="0" cellpadding="0" 
			data-options="url:'<%=basePath%>Main/wfInstance/getCheckUserData',fit:true,fitColumns:true,singleSelect:true,checkbox:true,pageSize:20,pageList:[20,50,100], pagination:true,
			queryParams:{ftype:'${ftype}',instid:'${instid}',flag:'${flag}',pointid:'${pointid}'}"> 
			    <thead> 
			        <tr> 
			            <th field="USER_ID"  data-options="hidden:true"></th> 
			            <th field="USER_NAME" width="200">用户名称</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
		
	</div>


