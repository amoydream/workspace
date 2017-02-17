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
                  { text: '添加',title:'添加突发事件', iconCls: 'icon-add',
	                   dialogParams:{dialogId:'eventDialog',href:basePath+"Main/event/add",width:950,
						height:600,formId:'emerganceform',isNoParam:true}}, '-', 
                  { text: '修改',title:'编辑突发事件',iconCls: 'icon-pageedit', 
		                   dialogParams:{dialogId:'eventDialog',href:basePath+"Main/event/edit",width:950,
								height:600,formId:'emerganceform'}}, '-',
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/event/delete'}},'-',
                  { text:'详情',iconCls:'icon-search',handler:function(){
                	//打开详情页面
                	var rowData = $("#eventGrid").datagrid("getSelected");
                	if(!rowData){
    					$.lauvan.MsgShow({msg:'请选择相应的记录！'});
    					return;
    				}
          			var mainTab=$("#mainTab");
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
                  }}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/event/getGridData",
		onDblClickRow:function(rowIndex, rowData){
			var dialogDef={
	  				title:'编辑突发事件',
					width:950,
					height:600,
					href: basePath+"Main/event/edit/"+rowData.ID
			};
			$.lauvan.openCustomDialog('eventDialog',dialogDef,null,'emerganceform');
		}
		};
		$.lauvan.dataGrid("eventGrid",attrArray);
		});

	
	function event_doSearch(){
		$('#eventGrid').datagrid('load',{
			ename: $('#ename_e').val(),
			etype: $('#etype_e').combotree('getValue'),
			elevel: $('#elevel_e').combobox('getValue'),
			estatus: $('#estatus_e').combobox('getValue'),
			stime:$('#starttime2').datebox('getValue'),
	        etime:$('#endtime2').datebox('getValue')
		});
	}
	function evtelFN(val, row, index){
		return tel_link(row.EV_REPORTTEL, row.ID);
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>事件名称：</span>
			<input id="ename_e" type="text" class="easyui-textbox" >
			<span>事件类型：</span>
			<input class="easyui-combotree" id="etype_e" data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,icons:iconClear" style="width:180px;">
			<span>事件级别：</span>
			<select class="easyui-combobox" id="elevel_e"  panelHeight="auto" code="EVLV" style="width: 150px;" data-options="editable:false,icons:iconClear" ></select>
			<br/>
			<span>事件状态：</span>
			<select class="easyui-combobox" id="estatus_e"  panelHeight="auto" code="EVST" style="width: 150px;" data-options="editable:false,icons:iconClear" ></select>
			<span>记录时间：</span>
		<input class="easyui-datebox" id="starttime2" data-options="editable:false,icons:iconClear" style="width: 180px;">
		<span>&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;</span>
		<input class="easyui-datebox" id="endtime2" data-options="editable:false,icons:iconClear" style="width: 180px;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="event_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="eventGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="MARKTIME" width="100"  >记录时间</th>
			           <!--  <th field="EV_DATE" width="100"  >事发时间</th> -->
			            <th field="EV_REPORTTEL" width="100" formatter="evtelFN" >报告人电话</th>
			            <th field="OR_NAME" width="150">事发单位</th>
			            <th field="EV_NAME" width="150">事件名称</th> 
			            <th field="EV_TYPE" width="100" CODE="EVTP" >事件类型</th>
			            <th field="EV_LEVEL" width="150" CODE="EVLV">事件级别</th>
			            <th field="EV_STATUS" width="100" CODE="EVST" >事件状态</th>
			            
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

