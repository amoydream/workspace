<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%@ include file="../js/call.jsp"%>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="padding: 5px; background: #f7f7f7;">
		<form id="callForm_${caller}">
			<span>联系人：</span>
			<input id="contact_name" name="contact_name" type="text" class="easyui-textbox">
			<span>部门：</span>
			<input id="or_name" name="or_name" type="text" class="easyui-textbox">
			<span>电话号码：</span>
			<input id="tel_number" name="tel_number" type="tel" class="easyui-textbox">
			<span>事件名称：</span>
			<input id="ev_name" name="ev_name" type="text" class="easyui-textbox">
			<span>呼入时间：</span>
			<input id="call_dateTime_${caller}" name="dateTime" type="text" class="datepicker-textbox">
			<a href="javascript:void(0);" class="easyui-linkbutton" onclick="call_search_${caller}();"
				data-options="iconCls:'icon-search',plain:true">搜索</a>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table id="callGrid_${caller}" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="CONTACT_NAME" width="15%" sortable="true">联系人</th>
					<th field="OR_NAME" width="15%" sortable="true">部门</th>
					<th field="TEL_NUMBER" width="15%" formatter="call_numberFmt" sortable="true">电话号码</th>
					<th field="DATETIME" width="15%" sortable="true">呼入时间</th>
					<th field="EV_NAME" width="20%" formatter="call_eventLink" sortable="true">事件名称</th>
					<th field="EV_TYPE" width="10%" sortable="true">事件类型</th>
					<th field="ANSWERED" width="10%" formatter="call_answeredFmt" sortable="true">电话状态</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
