<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	
	var zTree_preschModel1;
	var setting_preschModel1 = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_preschModel1
		}
	};
	
	var zNodes_preschModel1 =[
	     		{ id:"0", pId:"0", name:"预案分类",open:true}
	     		<c:forEach items="${plist}" var="plist" >
	     		,{ id:"${plist.id}", pid:"${plist.sup_id==745?0:plist.sup_id}", name:"${plist.p_name}",pacode:"${plist.p_acode}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_preschModel1(event, treeId, treeNode) {
		$('#planModelGrid1').datagrid("options").queryParams={'plantype':treeNode.pacode};
		$('#planModelGrid1').datagrid({url:basePath+'Main/planmodel/getGridDate?type=m'});
	};
	
	
	$(function(){
		var attrArray ={ 
		fitColumns : true,
		idField:'ID',
		frozenColumns:[[]],
		url:basePath+"Main/planmodel/getGridDate?type=m",
		};
		$.lauvan.dataGrid("planModelGrid1",attrArray);
		$.fn.zTree.init($("#_preschmodelTree1"), setting_preschModel1, zNodes_preschModel1);
		zTree_preschModel1 = $.fn.zTree.getZTreeObj('_preschmodelTree1');
		});

	
	function plan_doSearch(){
		$('#planModelGrid1').datagrid("options").queryParams={};
		$('#planModelGrid1').datagrid('load',{
			planname: $('#planModelname1').val(),
			plantype: $('#planModeltype1').combotree('getValue')
		});
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
  <div data-options="region:'west',border:false" style="width: 200px;">
 	<ul id="_preschmodelTree1" class="ztree"></ul>
 </div>
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>预案名称：</span>
			<input id="planModelname1" type="text" class="easyui-textbox" >
			<span>预案分类：</span>
			<input class="easyui-combotree" id="planModeltype1" data-options="url:'<%=basePath%>Main/busParam/getTypeTree/YAFL-0-1',method:'get',editable:false,icons:iconClear" style="width:180px;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="plan_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="planModelGrid1" cellspacing="0" cellpadding="0"> 
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

