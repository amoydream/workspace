<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<script>
	var basePath = '<%=basePath%>';
    $(function() {
	    var attrArray = {
	        toolbar : [{
	            text : '添加',
	            title : '添加日常事件',
	            iconCls : 'icon-add',
	            dialogParams : {
	                dialogId : 'eventDialog',
	                href : basePath + "Main/eventRoutine/add?ev_reporttel=" + '${ev_reporttel}' +'&callId=' + '${callId}',
	                width : 800,
	                height : 550,
	                formId : 'routineform',
	                isNoParam : true
	            }
	        }, '-', {
	            text : '修改',
	            title : '编辑日常事件',
	            iconCls : 'icon-pageedit',
	            dialogParams : {
	                dialogId : 'eventDialog',
	                href : basePath + "Main/eventRoutine/edit",
	                width : 800,
	                height : 550,
	                formId : 'routineform'
	            }
	        }, '-', {
	            text : '删除',
	            iconCls : 'icon-delete',
	            delParams : {
		            url : basePath + 'Main/eventRoutine/delete'
	            }
	        }, '-', {
	            text : '转突发事件',
	            title : '日常事件转突发事件',
	            iconCls : 'icon-redo',
	            dialogParams : {
	                dialogId : 'eventDialog',
	                href : basePath + "Main/eventRoutine/changeEvent",
	                width : 950,
	                height : 600,
	                formId : 'emerganceform'
	            }
	        }],
	        fitColumns : true,
	        idField : 'ID',
	        url : basePath + "Main/eventRoutine/getGridData",
	        onDblClickRow : function(rowIndex, rowData) {
		        //打开详情页面
		        /* $("#routineDialog").dialog({
		            title : '日常事件详情',
		            width : 800,
		            height : 400,
		            cache : false,
		            modal : true,
		            href : basePath + "Main/eventRoutine/view/" + rowData.ID,
		            buttons : []
		        }); */
	        	var attrArray={
	    				title:'编辑日常事件',
	    				height: 550,
	    				width:800,
	    				href: '<%=basePath%>Main/eventRoutine/edit/'+rowData.ID
	    		};
	    		
	    		$.lauvan.openCustomDialog("eventDialog",attrArray,null,'routineform');
	        }
	    };
	    $.lauvan.dataGrid("routineGrid", attrArray);
    });

    function routine_doSearch() {
	    $('#routineGrid').datagrid('load', {
	        ename : $('#ename').val(),
	        etype : $('#etype').combotree('getValue'),
	        stime:$('#starttime1').datebox('getValue'),
	        etime:$('#endtime1').datebox('getValue')
	    });
    }
    function evtelFN_r(val, row, index){
    	return tel_link(row.EV_REPORTTEL, row.ID);
	}
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="padding: 5px; background: #f7f7f7;">
		<span>事件名称：</span>
		<input id="ename" type="text" class="easyui-textbox">
		<span>事件类型：</span>
		<input class="easyui-combotree" id="etype"
			data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,icons:iconClear"
			style="width: 180px;">
		<span>记录时间：</span>
		<input class="easyui-datebox" id="starttime1" data-options="editable:false,icons:iconClear" style="width: 180px;">
		<span>至</span>
		<input class="easyui-datebox" id="endtime1" data-options="editable:false,icons:iconClear" style="width: 180px;">
		<a href="javascript:void(0);" class="easyui-linkbutton" onclick="routine_doSearch()"
			data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
		<table id="routineGrid" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
				  <th field="MARKTIME" width="100"  >记录时间</th>
			       <!--  <th field="EV_DATE" width="100"  >事发时间</th> -->
			        <th field="EV_REPORTTEL" width="100"  formatter="evtelFN_r" >报告人电话</th>
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
<div id="routineDialog"></div>
