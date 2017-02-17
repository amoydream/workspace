<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				fitColumns : true,
				idField:'DANGERID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				url:"<%=basePath%>Main/danger/getGridData" ,
				onDblClickRow:function(rowIndex, rowData){
					var attrArray={
							title:'重大危险源详情',
							width: 1200,
							height: 500,
							href:"<%=basePath%>Main/danger/dangerview/"+rowData.DANGERID,
							buttons:[]
					};
					
					$.lauvan.openCustomDialog("dangerView",attrArray,null);
				}
				};
		$.lauvan.dataGrid("dangerGrid",attrArray);
		
	});
	function danger_doSearch(){
		$('#dangerGrid').datagrid('load',{
			dangername: $('#dangername1').val()
		});	
	}
	

	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>名称:</span>
		<input id="dangername1" type="text" class="easyui-textbox" >
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="danger_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dangerGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="NUCODE" width="100">统一识别码</th> 
			            <th field="DANGERNAME" width="150">名称</th>	
			            <th field="DANGERTYPECODE" code="WXYFXYHQFL" width="100">类型</th>	
			            <th field="LEVELCODE" code="ZDFHJBDM" width="100">级别</th>  
			             <th field="DISTRICTCODE" code="441303" width="100">行政区划</th>   
			             <th field="ADDRESS"  width="300">地址</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
