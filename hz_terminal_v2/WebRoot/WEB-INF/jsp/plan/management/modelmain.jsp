<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	
	var zTree_preschModel;
	var setting_preschModel = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_preschModel
		}
	};
	
	var zNodes_preschModel =[
	     		{ id:"0", pId:"0", name:"预案分类",open:true}
	     		<c:forEach items="${plist}" var="plist" >
	     		,{ id:"${plist.id}", pid:"${plist.sup_id==745?0:plist.sup_id}", name:"${plist.p_name}",pacode:"${plist.p_acode}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_preschModel(event, treeId, treeNode) {
		$('#planModelGrid').datagrid("options").queryParams={'plantype':treeNode.pacode};
		$('#planModelGrid').datagrid({url:basePath+'Main/planmodel/getGridDate?type=m'});
	};
	
	
	$(function(){
		var attrArray ={ 
		toolbar: [{ text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/plan/delete'}}],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/planmodel/getGridDate?type=m",
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			var mainTab=$("#mainTab");
			if (mainTab.tabs('exists', "应急预案管理详情")){
		    	mainTab.tabs('select', "应急预案管理详情");
		    	// 调用 'refresh' 方法更新选项卡面板的内容
		    	var tab = mainTab.tabs('getSelected');  // 获取选择的面板
		    	tab.panel('refresh', "Main/planMg/getView/"+rowData.ID+"--1");
		    } else {
			    mainTab.tabs('add',{
			       title:"应急预案管理详情",
			       href:"Main/planMg/getView/"+rowData.ID+"--1",
			        closable:true
			    });
		    }
		}
		};
		$.lauvan.dataGrid("planModelGrid",attrArray);
		$.fn.zTree.init($("#_preschmodelTree"), setting_preschModel, zNodes_preschModel);
		zTree_preschModel = $.fn.zTree.getZTreeObj('_preschmodelTree');
		});

	
	function plan_doSearch(){
		$('#planModelGrid').datagrid("options").queryParams={};
		$('#planModelGrid').datagrid('load',{
			planname: $('#planModelname').val(),
			plantype: $('#planModeltype').combotree('getValue')
		});
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
  <div data-options="region:'west',border:false" style="width: 200px;">
 	<ul id="_preschmodelTree" class="ztree"></ul>
 </div>
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>预案名称：</span>
			<input id="planModelname" type="text" class="easyui-textbox" >
			<span>预案分类：</span>
			<input class="easyui-combotree" id="planModeltype" data-options="url:'<%=basePath%>Main/busParam/getTypeTree/YAFL-0-1',method:'get',editable:false,icons:iconClear" style="width:180px;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="plan_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="planModelGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr>   
			            <th field="PRESCHNAME" width="150">预案名称</th> 
			            <th field="PRESCHTYPE" width="100" CODE="YAFL" >预案分类</th>
			            <th field="PRESCHDEPTNAME" width="150" >所属机构</th>
			            <th field="PRESCHCLASS" width="100" CODE="ZDFHJBDM" >级别</th>
			            <th field="RECNAME" width="100" >记录人</th>
			            <th field="MARKTIME" width="100"  >记录时间</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

