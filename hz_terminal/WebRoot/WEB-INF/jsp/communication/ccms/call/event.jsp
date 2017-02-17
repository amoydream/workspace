<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<script>
	$(function() {
	    var options = {
	        fitColumns : true,
	        idField : 'ID',
	        frozenColumns : [[]],
	        url : 'Main/eventSearch/getGridData?noevtype=07'
	    };
	    $.lauvan.dataGrid('call_eventGrid', options);
    });

    function call_eventSearch() {
	    $('#call_eventGrid').datagrid('load', {
		    ename : $('#call_ename').val()
	    });
    }

    function call_eventFmt(value, row, index) {
	    return '00A' == value ? '日常事件' : '00X' == value ? '突发事件' : value;
    }
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="padding: 5px; background: #f7f7f7;">
		<span>事件名称：</span>
		<input id="call_ename" type="text" class="easyui-textbox">
		<a href="javascript:void(0);" class="easyui-linkbutton" onclick="call_eventSearch()"
			data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'center',border:false">
		<table id="call_eventGrid" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="EV_NAME" width="20%">事件名称</th>
					<th field="EV_DATE" width="20%" sortable="true">事发时间</th>
					<th field="EV_ADDRESS" width="30%">事发地点</th>
					<th field="EV_STATUS" width="15%" CODE="EVST">事件状态</th>
					<th field="EV_STATE" width="15%" formatter="call_eventFmt">事件性质</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
