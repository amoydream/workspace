<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<script>
	$(function() {
	    if('${error}') {
		    $.lauvan.msg('${error}');
	    }
	    if('${empty fax.RECDFILE}') {
		    $('#faxFile').uploadify({
		        buttonText : '选择文件',
		        uploader : 'plugins/uploadify/scripts/uploadify.swf',
		        script : 'Main/communication/ccms/fax/upload',
		        cancelImg : 'plugins/uploadify/cancel.png',
		        auto : true,
		        multi : false,
		        fileDataName : 'faxFile',
		        fileQueue : 'fileQueue',
		        fileExt : '*.pdf;*.xls;*.xlsx;*.doc;*.docx;*.ppt;*.wps;*.png;*.jpg;*.gif;*.txt;*.tif',
		        fileDesc : '*.pdf;*.xls;*.xlsx;*.doc;*.docx;*.ppt;*.wps;*.png;*.jpg;*.gif;*.txt;*.tif',
		        onComplete : uploadComplete
		    });
	    }
    });

    function uploadComplete(event, queueId, file, response, data) {
	    var result = eval('(' + response + ')');
	    if(result.success == 'true') {
		    $('#tifFile').val(result.tifFile);
		    $('#sp_file').html(result.tifFile);
	    } else {
		    $.lauvan.msg(result.msg);
	    }
    }

    function sendFax(needConfirm) {
	    fax_receivers = $('#selected_tagger').tagger('getTags');
	    if(fax_receivers.length < 1 && '${fax.FAX_NUMBER}' == '') {
		    $.lauvan.msg('请选择传真接收部门');
		    return false;
	    }

	    var tifFile = $('#tifFile').val();
	    if(tifFile == null || tifFile == '') {
		    $.lauvan.msg('请上传传真文件');
		    return false;
	    }

	    var fax_numbers = [];
	    if('${fax.FAX_NUMBER}' == '') {
		    if(fax_receivers.length > 0) {
			    for(var i = 0; i < fax_receivers.length; i++) {
				    fax_numbers.push(fax_receivers[i].FAX_NUMBER);
			    }
		    }
	    } else {
		    fax_numbers[0] = '${fax.FAX_NUMBER}';
	    }

	    ccmsSendFax(fax_numbers, {
	        needConfirm : needConfirm,
	        callid : $('#callid').val(),
	        tifFile : $('#tifFile').val(),
	        eventId : $('#fax_eventId').val(),
	        dialogId : 'fax_send_dialog',
	        onSendComplete : onSendComplete
	    });
    }

    function onSendComplete(result) {
    }

    var fax_receivers = [];
    function select_receiver() {
	    fax_receivers = $('#selected_tagger').tagger('getTags');
	    $.lauvan.openCustomDialog('fax_receiver_dialog', {
	        title : '选择部门',
	        width : 760,
	        height : 400,
	        href : 'Main/communication/ccms/fax/receiver',
	        buttons : [{
	            text : '确定',
	            iconCls : 'icon-ok',
	            handler : function() {
		            fax_receivers = $('#select_tagger').tagger('getTags');
		            if(fax_receivers.length > 0) {
			            $('#selected_tagger').tagger('setTags', fax_receivers);
		            } else {
			            $.lauvan.msg('请选择传真接收部门');
		            }
		            $('#fax_receiver_dialog').dialog('close');
	            }
	        }]
	    });
    }

    function fax_selectEvent() {
	    $.lauvan.openCustomDialog('fax_receiver_dialog', {
	        title : '选择事件',
	        width : 800,
	        height : 400,
	        href : 'Main/communication/ccms/fax/event?action=select',
	        buttons : [{
	            text : '确定',
	            iconCls : 'icon-ok',
	            handler : function() {
		            var ev = $('#fax_eventGrid').datagrid('getSelected');
		            if(ev) {
			            $('#fax_eventId').val(ev.ID);
			            $('#fax_evName').textbox('setValue', ev.EV_NAME);
		            } else {
			            $.lauvan.msg('选择关联事件失败');
		            }
		            $('#fax_receiver_dialog').dialog('close');
	            }
	        }]
	    });
    }

    $(function() {
	    var tagger_options = {
	        placeholderText : 'Add...',
	        maxNbTags : false,
	        confirmDelete : true,
	        caseSensitive : false,
	        disableAdd : false,
	        tagId : 'FAX_NUMBER',
	        tagName : 'OR_NAME',
	        addBtn : true,
	        clearBtn : true,
	        addFn : select_receiver,
	        validateFn : check_FAX,
	        clearFn : function() {
		        $('#selected_tagger').tagger('removeTags');
	        }
	    };
	    $('#selected_tagger').tagger(tagger_options);
    });
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',border:false">
		<form id="fax_createForm" style="width: 100%;">
			<input type="hidden" id="callid" name="callid" value="${fax.CALLID}">
			<table id="table" class="sp-table" width="100%" cellpadding="0"
				cellspacing="0">
				<tr>
					<td class="sp-td1">接收部门</td>
					<input type="hidden" id="fax_numbers" name="fax_numbers"
						value="${fax.FAX_NUMBER}">
					<c:choose>
						<c:when test="${empty fax.FAX_NUMBER}">
							<td><select id="selected_tagger" style="width: 468px;" /></td>
						</c:when>
						<c:otherwise>
							<td colspan="2">${fax.OR_NAME}</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td class="sp-td1" width="10%">关联事件</td>
					<input type="hidden" id="fax_eventId" name="fax_eventId"
						value="${fax.EVENTID}" />
					<c:choose>
						<c:when test="${empty fax.EVENTID}">
							<td colspan="2"><input type="text" id="fax_evName"
								name="fax_evName"
								data-options="icons:[{iconCls:'icon-search',handler:fax_selectEvent}]"
								class="easyui-textbox" style="width: 480px;" /></td>
						</c:when>
						<c:otherwise>
							<td colspan="2">${fax.EV_NAME}</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<td class="sp-td1">传真文件</td>
					<input id="tifFile" name="tifFile" type="hidden"
						value="${fax.tifFile}" />
					<c:choose>
						<c:when test="${empty fax.RECDFILE}">
							<td colspan="2"><span id="sp_file"> <input
									id="faxFile" type="file" />
							</span></td>
						</c:when>
						<c:otherwise>
							<td colspan="2">${fax.RECDFILE}</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</form>
	</div>
</div>
