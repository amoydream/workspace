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
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/event/getGridData",
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			var	mainTab = parent.$("#mainTab");
			if (mainTab.tabs('exists', "事件详情")){
		    	mainTab.tabs('select', "事件详情");
		    	// 调用 'refresh' 方法更新选项卡面板的内容
		    	var tab = mainTab.tabs('getSelected');  // 获取选择的面板
		    	tab.panel('refresh', "Main/event/view/"+rowData.ID);
		    } else {
			    mainTab.tabs('add',{
			       title:"事件详情",
			       href:"Main/event/view/"+rowData.ID,
			        closable:true
			    });
		    }
		}
		};
		$.lauvan.dataGrid("dpeventGrid",attrArray);
		});

	
	function event_doSearch(){
		$('#dpeventGrid').datagrid('load',{
			ename: $('#dpename_e').val(),
			etype: $('#dpetype_e').combotree('getValue'),
			elevel: $('#dpelevel_e').combobox('getValue'),
			estatus: $('#dpestatus_e').combobox('getValue')
		});
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>事件名称：</span>
			<input id="dpename_e" type="text" class="easyui-textbox" >
			<span>事件类型：</span>
			<input class="easyui-combotree" id="dpetype_e" data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,icons:iconClear" style="width:165px;">
			<br/>
			<span>事件级别：</span>
			<select class="easyui-combobox" id="dpelevel_e"  panelHeight="auto" code="EVLV" style="width: 165px;" data-options="editable:false,icons:iconClear" ></select>
			<span>事件状态：</span>
			<select class="easyui-combobox" id="dpestatus_e"  panelHeight="auto" code="EVST" style="width: 165px;" data-options="editable:false,icons:iconClear" ></select>
			&nbsp;&nbsp;<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="event_doSearch()" data-options="">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dpeventGrid" cellspacing="0" cellpadding="0"  data-options="fit:true"> 
			    <thead> 
			        <tr> 
			            <th field="EV_NAME" width="150">事件名称</th> 
			            <th field="EV_TYPE" width="100" CODE="EVTP" >事件类型</th>
			            <th field="EV_LEVEL" width="150" CODE="EVLV">事件级别</th>
			            <th field="EV_DATE" width="100"  >事发时间</th>
			            <th field="EV_STATUS" width="100" CODE="EVST" >事件状态</th>
			            <th field="MARKTIME" width="100"  >登记时间</th>
			        </tr> 
			    </thead> 
			</table> 
			</div>
		</div>

