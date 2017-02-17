<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	var zTree_preschLevel;
	var setting_preschLevel = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_preschLevel
		}
	};
	
	var zNodes_preschLevel =[
	     		{ id:"1000", pId:"0", name:"事件分类分级",open:true},
	     		{ id:"1010", pid:"1000", name:"事件类型"},
	     		{ id:"8010", pid:"1000", name:"事件级别"}
	     	];
	
	function zTreeOnClick_preschLevel(event, treeId, treeNode) {
		$("#_plevel").val(treeNode.id);
		$('#preschLevelGrid').datagrid({url:'<%=basePath%>Main/planMg/getItemData?preschid=${preschid}&code='+treeNode.id});
	};
	$(document).ready(function(){
		var attrArray={
				<c:if test="${empty flag&&xgflag}">
				toolbar: [
		                  { text: '添加', iconCls: 'icon-add',
		                	  handler: function(){
	                	  		var pid = $("#_plevel").val();
	                	  		var dialogDef={
	                	  				title:'添加事件分类分级信息',
										width:700,
										height:350,
										href: '<%=basePath%>Main/planMg/add/plevel-'+pid+"-${preschid}"
								};
								$.lauvan.openCustomDialog('planMgDialog',dialogDef,null,'planMgform');
	                  		}}, '-', 
		                  { text: '修改',iconCls: 'icon-pageedit', 
	                  			handler: function(){
	                	  		var row=$("#preschLevelGrid").datagrid("getSelected");
	            				if(!row){
	            					$.lauvan.MsgShow({msg:'请选择相应的记录！'});
	            					return;
	            				}
	                	  		var dialogDef={
	                	  				title:'编辑事件分类分级信息',
										width:700,
										height:350,
										href: '<%=basePath%>Main/planMg/edit/plevel-'+row.ID+"-${preschid}"
								};
								$.lauvan.openCustomDialog('planMgDialog',dialogDef,null,'planMgform');
	                  		}}, '-',
		                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/planMg/delete/plevel'}}
		                 ],
		                 </c:if>
				fitColumns : true,
				idField:'ID',
				fit:true
	    };
		$.lauvan.dataGrid("preschLevelGrid",attrArray);
		$.fn.zTree.init($("#preschLevelTree"), setting_preschLevel, zNodes_preschLevel);
		zTree_preschLevel = $.fn.zTree.getZTreeObj('preschLevelTree');
	});
</script>
<div class="easyui-layout"  data-options="fit:true">
	<div data-options="region:'west',border:false" style="width: 200px;">
		<ul id="preschLevelTree" class="ztree"></ul>
	</div>
	<input type="hidden" id="_plevel" />
	<div data-options="region:'center',border:false">
		<table id="preschLevelGrid" cellspacing="0" cellpadding="0"> 
					    <thead> 
					        <tr> 
					            <th field="ITEMNAME" width="150">名称</th> 
					            <th field="ITEMCONTENT" width="150"  >详情</th>
					        </tr> 
					    </thead> 
		</table>
	</div>
</div>	
	
	 
	
