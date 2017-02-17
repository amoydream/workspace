<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%@ include file="../js/fax.jsp"%>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="padding: 5px; background: #f7f7f7;">
		<form id="faxForm_${sender}">
			<span>接收部门：</span>
			<input id="or_name" name="or_name" type="text" class="easyui-textbox">
			<span>传真号码：</span>
			<input id="fax_number" name="fax_number" type="tel" class="easyui-textbox">
			<span>事件名称：</span>
			<input id="ev_name" name="ev_name" type="text" class="easyui-textbox">
			<span>发送日期：</span>
			<input id="fax_dateTime_${sender}" name="faxTime" type="text" class="datepicker-textbox">
			<a href="javascript:void(0);" class="easyui-linkbutton" onclick="fax_search_${sender}();"
				data-options="iconCls:'icon-search',plain:true">搜索</a>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table id="faxGrid_${sender}" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="OR_NAME" width="20%" sortable="true">接收部门</th>
					<th field="FAX_NUMBER" width="20%" sortable="true">传真号码</th>
					<th field="DATETIME" width="20%" sortable="true">发送时间</th>
					<th field="EV_NAME" width="20%" formatter="fax_eventLink" sortable="true">关联事件</th>
					<th field="EV_TYPE" width="10%" sortable="true">事件类型</th>
					<th field="FAXST" width="10%" formatter="fax_faxstFmt" sortable="true">传真状态</th>
				</tr>
			</thead>
		</table>
	</div>
</div>