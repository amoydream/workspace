<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  <script>
  var basePath = '<%=basePath%>';
  function dbaformatter_1(value,row,index){
		if(value!=null && value!=''){
			return value;
		}else{
			return '默认';
		}
	}
  function dbaSource_doSearch(){
		$('#dbasource').datagrid('load',{
			objName: $('#objName_v').val(),
			objCode: $('#objCode').val()
		});
	}
	</script>

 <div class="easyui-layout"  data-options="fit:true">
	 <div data-options="region:'north',border:false" style="height: 35px;">
	 <div id="dbasource_tb" style="margin-top: 5px;margin-left: 5px;">
			<span>对象名称:</span>
			<input id="objName_v" type="text" class="easyui-textbox" >
			<span>对象编码:</span>
			<input id="objCode" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="dbaSource_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
	 </div>
		<div data-options="region:'center',border:false">
		
			<table id="dbasource" class="easyui-datagrid" cellspacing="0" cellpadding="0" 
			data-options="url:'<%=basePath%>Main/autoView/getSourceData',fit:true,fitColumns:true,singleSelect:true,pageSize:20,pageList:[20,50,100], pagination:true"> 
			    <thead> 
			        <tr> 
			            <th field="ID"  data-options="hidden:true"></th> 
			            <th field="TABLE_NAME" width="150">对象名称</th>
			            <th field="TABLE_CODE" width="200" >对象编码</th> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
		
	</div>


