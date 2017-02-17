<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script>
$(function(){
var attrArray={
			idField:'STO_ID',
			fitColumns : true, 
			frozenColumns:[[]],
	        url:'<%=basePath%>Main/planmodel/getdatabymatid?itemid=${itemid}',
			view: detailview,
			detailFormatter:function(index,row){
				return '<div style="padding:2px;"><div id="storecontent-' + index + '"></div></div>';
			},
			onExpandRow: function(index,row){
				//展示内容
				$("#storecontent-"+index).load(basePath+"Main/planmodel/getContent",
						{"id":row.STO_ID},function(){
					$('#storecontentGrid').datagrid('fixDetailRowHeight',index);});
				
			}
		};
	$.lauvan.dataGrid("storecontentGrid",attrArray);
});
</script>
<div class="easyui-layout" data-options="fit:true">
	  <div data-options="region:'north',border:false" >
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
	    <td class="sp-td1">物资名称：</td>
		<td>${model.mn_name}</td>
		
		<td class="sp-td1">物资类型：</td>
		<td>${typename}</td>
		</tr>
		<tr>
		<td class="sp-td1">型号：</td>
		<td>${model.typeclass}</td>
			
		<td class="sp-td1">规格：</td>
		<td>${model.sizeclass}</td>
		
		</tr>
		<tr>
		<td class="sp-td1">计量单位：</td>
		<td colspan="3">${str:translate(model.measureunit,'MAUNIT')}</td></tr>
		<tr>
		
		<td class="sp-td1">备注：</td>
		<td colspan="3">${model.remark}</td>		
		
		</tr>
		<tr>    	
	    </table>
	    </div>

	<div data-options="region:'center',border:false">
		<table id="storecontentGrid" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="STO_ID" data-options="hidden:true"></th>
					<th field="STO_CODE" width="200">编号</th>
					<th field="MN_NAME" width="200">物资名称</th>
					<th field="NUM" width="400">存储数量</th>
					<th field="NAME" width="400">仓库名称</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
	    