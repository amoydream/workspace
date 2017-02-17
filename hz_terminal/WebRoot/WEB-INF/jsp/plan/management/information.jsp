<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={
				<c:if test="${empty flag&&xgflag}">
				toolbar: [
		                  { text: '添加',title:'添加发布对象', iconCls: 'icon-add',
			                   dialogParams:{dialogId:'planMgDialog',href:basePath+"Main/planMg/add",width:700,
		                	  outerParam:'pinformation--${id}',height:350,formId:'planMgform',isNoParam:true}}, '-', 
		                  { text: '修改',iconCls: 'icon-pageedit',
		                		  handler:function(){
	                		   		var row=$('#informationGrid').datagrid("getSelected");
			           				if(!row){
			           					$.lauvan.MsgShow({msg:'请选择相应的记录！'});
			           					return;
			           				}
	                		   var dialogDef={
										title:'编辑发布对象',
										href: basePath+'Main/planMg/edit/pinformation-'+row.ID
								};
								$.lauvan.openCustomDialog('planMgDialog',dialogDef,null,'planMgform');
	                	   	}}, '-',
		                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/planMg/delete'}}
		                 ], 
		                 </c:if>
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/planMg/getItemData?preschid=${id}&code=D000"
		};
		$.lauvan.dataGrid("informationGrid",attrArray);
		});

	
	function plan_doSearch(){
		$('#informationGrid').datagrid('load',{
			itemname: $('#infOrgName').val()
		});
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>通知单位名称：</span>
			<input id="infOrgName" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="plan_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="informationGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr>   
			            <th field="ITEMNAME" width="150">通知单位名称</th> 
			            <th field="ITEMCONTENT" width="100"  >备注</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

