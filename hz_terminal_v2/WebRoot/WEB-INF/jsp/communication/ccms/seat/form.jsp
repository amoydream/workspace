<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<form id="seat_from" method="post" action="Main/communication/ccms/seat/save" style="width: 100%;">
	<c:choose>
		<c:when test="${action eq 'edit'}">
			<input type="hidden" name="seat_id" value="${seat.SEAT_ID }" />
			<input type="hidden" name="dept_id" value="${seat.DEPT_ID}">
		</c:when>
		<c:otherwise>
			<input type="hidden" name="dept_id" value="${dept_id}">
		</c:otherwise>
	</c:choose>
	<table id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td class="sp-td1">登陆IP</td>
			<td>
				<input type="text" name="loginIP" id="loginIP" required="true" data-options="prompt:'请输入IP地址',icons:iconClear"
					class="easyui-textbox" style="width: 180px;" value="${seat.LOGINIP}" />
			</td>
		</tr>
		<tr>
			<td class="sp-td1">坐席IP</td>
			<td>
				<input type="text" name="seatIP" id="seatIP" required="true" data-options="prompt:'请输入IP地址',icons:iconClear"
					class="easyui-textbox" style="width: 180px;" value="${seat.SEATIP}" />
			</td>
		</tr>
		<tr>
			<td class="sp-td1">座席号码</td>
			<td>
				<input type="number" name="seatID" id="seatID" required="true" data-options="prompt:'请输入座席号码',icons:iconClear"
					class="easyui-textbox" style="width: 180px;" value="${seat.SEATID}" />
			</td>
		</tr>
		<tr>
			<td class="sp-td1">优先级</td>
			<td>
				<input type="text" id="priority" name="priority" class="easyui-numberbox"
					data-options="min:1,max:20,icons:iconClear" style="width: 180px;" value="${seat.PRIORITY}" />
			</td>
		</tr>
	</table>
</form>
