<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script>
$(function(){
var attrArray={
			idField:'EQS_ID',
			fitColumns : true,
			frozenColumns:[[]],
	        url:'<%=basePath%>Main/planmodel/getdatabymatid2?itemid=${itemid}',
	        view: detailview,
			detailFormatter:function(index,row){
				return '<div style="padding:2px;"><div id="estorecontent-' + index + '"></div></div>';
			},
			onExpandRow: function(index,row){
				//展示内容
				$("#estorecontent-"+index).load(basePath+"Main/planmodel/getContent2",
						{"id":row.EQS_ID},function(){
					$('#estorecontentGrid').datagrid('fixDetailRowHeight',index);});
				
			}
		};
	$.lauvan.dataGrid("estorecontentGrid",attrArray);
});
</script>
 <div class="easyui-layout"  data-options="fit:true">
	  <div data-options="region:'north',border:false">
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
	    <td class="sp-td1">装备名称：</td>
		<td>${model.eqn_name}</td>
		
		<td class="sp-td1">装备类型：</td>
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
		<td colspan="3">${str:translate(model.measureunit,'MAUNIT')}</td>
		
		</tr>
		<tr>
		
		<td class="sp-td1">备注：</td>
		<td colspan="3">${model.remark}</td>		
		
		</tr>
		<tr>
		    	
	    </table>
	    </div>
		<div data-options="region:'center',border:false">
			<table id="estorecontentGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EQS_ID" data-options="hidden:true">ID</th> 
			            <th field="EQN_NAME" width="150">装备名称</th>
			            <th field="EQUIPNUM" width="80">存放数量</th>
			            <th field="MEASUREUNIT" width="80" CODE="MAUNIT">计量单位</th>
			            <th field="ADDRESS" width="200">地址</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>