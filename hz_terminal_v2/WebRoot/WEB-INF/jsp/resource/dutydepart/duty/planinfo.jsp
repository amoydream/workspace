<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={ toolbar: [
                
                 ],
		fitColumns : true,
		checkbox:false,
		idField:'ID',
		url:basePath+"Main/plan/getGridDate/${deptid}",
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			$(document.body).append("<div id='planViewDialog'></div>");
			$("#planViewDialog").dialog({
				title:'预案基本信息',
				width: 800,
				height: 500,
				cache: false,
			    modal: true,
				href: basePath+"Main/plan/getView/"+rowData.ID,
				buttons: []
				});	
		}
		};
		$.lauvan.dataGrid("planGrid2",attrArray);
		});

	
	function plan_doSearch(){
		$('#planGrid2').datagrid('load',{
			planname: $('#planname2').val(),
			plantype: $('#plantype2').combotree('getValue')
		});
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>预案名称：</span>
			<input id="planname2" type="text" class="easyui-textbox" >
			<span>预案分类：</span>
			<input class="easyui-combotree" id="plantype2" data-options="url:'<%=basePath%>Main/busParam/getTypeTree/YAFL-0-1',method:'get',editable:false,icons:iconClear" style="width:180px;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="plan_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="planGrid2" cellspacing="0" cellpadding="0"> 
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

