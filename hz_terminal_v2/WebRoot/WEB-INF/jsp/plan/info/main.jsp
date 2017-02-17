<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	var zTree_preschType;
	var setting_preschType = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_preschType
		}
	};
	
	var zNodes_preschType =[
	     		{ id:"0", pId:"0", name:"预案分类",open:true}
	     		<c:forEach items="${plist}" var="plist" >
	     		,{ id:"${plist.id}", pid:"${plist.sup_id==745?0:plist.sup_id}", name:"${plist.p_name}",pacode:"${plist.p_acode}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_preschType(event, treeId, treeNode) {
		$('#planGrid').datagrid("options").queryParams={'plantype':treeNode.pacode};
		$('#planGrid').datagrid({url:basePath+'Main/plan/getGridDate'});
	};
	$(function(){
		var attrArray ={ toolbar: [
                  { text: '添加',title:'添加预案基本信息', iconCls: 'icon-add',
	                   dialogParams:{dialogId:'planDialog',href:basePath+"Main/plan/add",width:800,
						height:450,formId:'planform',isNoParam:true}}, '-', 
                  { text: '修改',title:'编辑预案基本信息',iconCls: 'icon-pageedit', 
		                   dialogParams:{dialogId:'planDialog',href:basePath+"Main/plan/edit",width:800,
								height:450,formId:'planform'}}, '-',
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/plan/delete'}}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/plan/getGridDate",
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			$(document.body).append("<div id='planViewDialog'></div>");
			$("#planViewDialog").dialog({
				title:'预案基本信息',
				width: 800,
				height: 450,
				cache: false,
			    modal: true,
				href: basePath+"Main/plan/getView/"+rowData.ID,
				buttons: []
				});	
		}
		};
		$.lauvan.dataGrid("planGrid",attrArray);
		$.fn.zTree.init($("#_preschtypeTree"), setting_preschType, zNodes_preschType);
		zTree_preschType = $.fn.zTree.getZTreeObj('_preschtypeTree');
		});

	
	function plan_doSearch(){
		//清空节点参数
		$('#planGrid').datagrid("options").queryParams={};
		$('#planGrid').datagrid('load',{
			planname: $('#planname').val(),
			plantype: $('#plantype').combotree('getValue')
		});
	}
	function _planisVerFN(val, row){
		return val=='00S'?'已审批':'未审批';
	}
	function _planisMoFN(val, row){
		return val=='0'?'否':'是';
	}
	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'west',border:false" style="width: 200px;">
 	<ul id="_preschtypeTree" class="ztree"></ul>
 </div>
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>预案名称：</span>
			<input id="planname" type="text" class="easyui-textbox" >
			<span>预案分类：</span>
			<input class="easyui-combotree" id="plantype" data-options="url:'<%=basePath%>Main/busParam/getTypeTree/YAFL-1-1',method:'get',editable:false,icons:iconClear" style="width:180px;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="plan_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="planGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr>   
			            <th field="PRESCHNAME" width="150">预案名称</th> 
			            <th field="PRESCHTYPE" width="100" CODE="YAFL" >预案分类</th>
			            <th field="PRESCHDEPTNAME" width="150" >所属机构</th>
			            <th field="PRESCHCLASS" width="80" CODE="ZDFHJBDM" >级别</th>
			            <th field="RECNAME" width="80" >记录人</th>
			            <th field="MARKTIME" width="100"  >记录时间</th>
			            <th field="ISVERIFY" width="80"  formatter="_planisVerFN">审批状态</th>
			            <th field="TYPE" width="50"  formatter="_planisMoFN">模板</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

