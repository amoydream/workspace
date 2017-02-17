<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<style>
.event_link {
	color: blue; text-decoration: none;
}

.event_link:hover {
	color: purple; text-decoration: underline;
}
</style>
<script type="text/javascript">
	function fax_editEvent() {
	    var form = $('#fax_readForm');
	    var eventId = form.find(':input[name="fax_eventId"]').val();
	    var ev_state = form.find(':input[name="ev_state"]').val();
	    if(eventId != '') {
		    if('00X' == ev_state) {
			    $.lauvan.openCustomDialog('event_edit_dialog', {
			        title : '修改事件',
			        width : 950,
			        height : 640,
			        href : 'Main/event/edit/' + eventId,
			        buttons : [{
			            text : '保存',
			            iconCls : 'icon-save',
			            handler : function() {
				            $.lauvan.dialogSubmit('emerganceform', 'event_edit_dialog');
				            $('#event_edit_dialog').dialog('close');
			            }
			        }, {
			            text : '关闭',
			            iconCls : 'icon-no',
			            handler : function() {
				            $('#event_edit_dialog').dialog('close');
			            }
			        }]
			    });
		    } else {
			    $.lauvan.openCustomDialog('event_edit_dialog', {
			        title : '修改事件',
			        width : 800,
			        height : 640,
			        href : 'Main/eventRoutine/edit/' + eventId,
			        buttons : [{
			            text : '保存',
			            iconCls : 'icon-save',
			            handler : function() {
				            $.lauvan.dialogSubmit('routineform', 'event_edit_dialog');
				            $('#event_edit_dialog').dialog('close');
			            }
			        }, {
			            text : '关闭',
			            iconCls : 'icon-no',
			            handler : function() {
				            $('#event_edit_dialog').dialog('close');
			            }
			        }]
			    });
		    }
	    }
    }

    function fax_download() {
	    try {
		    $('#download_frame').attr('src', 'Main/communication/ccms/fax/download?callid=' + '${fax.CALLID}');
	    } catch(e) {
	    }
    }

    var options = {};

    $(function() {
	    var callid = '${fax.CALLID}';
	    options = {
	        callid : callid,
	        action : '${fax.SENDER}' == 'N' ? 'reply' : 'resend',
	        eventId : '${fax.EVENTID}',
	        user_id : '${fax.USER_ID}'
	    };

	    var buttonsHTML = '<div id="buttons" class="dialog-button" style="position: relative; top: -1px; width: 696px;">';
	    buttonsHTML += '<a class="l-btn l-btn-small" onclick="fax_update();"><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text">保存</span>';
	    buttonsHTML += '<span class="l-btn-icon icon-save">&nbsp;</span></span></a>';
	    buttonsHTML += '<a class="l-btn l-btn-small" onclick="fax_send(options);"><span class="l-btn-left l-btn-icon-left">';
	    buttonsHTML += '<span class="l-btn-text">';
	    buttonsHTML += '${fax.SENDER}' == 'N' ? '回复' : '重发';
	    buttonsHTML += '</span><span class="l-btn-icon icon-print">&nbsp;</span></span></a>';
	    if('${fax.FAXST}' == 'S') {
		    buttonsHTML += '<a class="l-btn l-btn-small" onclick="fax_download();"><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text">下载</span>';
		    buttonsHTML += '<span class="l-btn-icon icon-diskdownload">&nbsp;</span></span></a>';
	    }
	    buttonsHTML += '</div>';
	    $('#fax_read_dialog').after(buttonsHTML);
    });
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',border:false">
		<form id="fax_readForm" method="post" action="Main/communication/ccms/fax/read" style="width: 100%;">
			<input type="hidden" id="callid" name="callid" value="${fax.CALLID}">
			<input type="hidden" id="fax_eventId" name="fax_eventId" value="${fax.EVENTID}">
			<input type="hidden" id="ev_state" name="ev_state" value="${fax.EV_STATE}">
			<table id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="sp-td1">标题</td>
					<td colspan="2">
						<input type="text" name="fax_title" id="fax_title" class="easyui-textbox" style="width: 480px;"
							value="${fax.TITLE}" />
					</td>
				</tr>
				<tr>
					<c:choose>
						<c:when test="${fax.SENDER == 'N'}">
							<td class="sp-td1">发送部门</td>
						</c:when>
						<c:otherwise>
							<td class="sp-td1">接收部门</td>
						</c:otherwise>
					</c:choose>
					<td>${fax.OR_NAME}</td>
				</tr>
				<tr>
					<td class="sp-td1">传真号码</td>
					<td>${fax.FAX_NUMBER}</td>
				</tr>
				<tr>
					<td class="sp-td1">关联事件</td>
					<c:choose>
						<c:when test="${empty fax.EVENTID}">
							<td>${fax.EV_NAME}</td>
						</c:when>
						<c:otherwise>
							<td>
								<a class="event_link" href="javascript:void(0);" onclick="fax_editEvent();">${fax.EV_NAME}</a>
							</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td class="sp-td1">传真文件</td>
					<td>${fax.RECDFILE}</td>
				</tr>
				<tr>
					<td rowspan="10" class="sp-td1">备注</td>
					<td colspan="2">
						<textarea id="fax_remark" name="fax_remark" class="textbox easyui-validatebox"
							data-options="validType:'length[0,200]'" style="width: 480px; height: 100px;">${fax.REMARK}</textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>