<%@ page language="java" pageEncoding="utf-8"%>
<script type="text/javascript">
	$(function() {
	    var toolbar = [{
	        text : '新建',
	        title : '新建传真',
	        iconCls : 'icon-add',
	        handler : fax_create
	    }, '-'];
	    if('${sender}' == 'Y') {
		    toolbar.push({
		        text : '重发',
		        title : '重发传真',
		        iconCls : 'icon-print',
		        handler : fax_resend
		    });
		    toolbar.push('-');
	    } else if('${sender}' == 'N') {
		    toolbar.push({
		        text : '回复',
		        title : '回复传真',
		        iconCls : 'icon-print',
		        handler : fax_reply
		    });
		    toolbar.push('-');
	    }

	    toolbar.push({
	        text : '关联事件',
	        title : '关联事件',
	        iconCls : 'icon-edit',
	        handler : fax_relateEvent
	    });
	    toolbar.push('-');
	    toolbar.push({
	        text : '取消关联',
	        title : '取消关联',
	        iconCls : 'icon-delete',
	        handler : fax_unrelateEvent
	    });
	    toolbar.push('-');
	    toolbar.push({
	        text : '删除',
	        title : '删除传真',
	        iconCls : 'icon-delete',
	        delParams : {
		        url : 'Main/communication/ccms/fax/delete'
	        }
	    });
	    toolbar.push('-');
	    toolbar.push({
	        text : '测试',
	        title : '测试传真',
	        iconCls : 'icon-add',
	        handler : fax_test
	    });

	    var options = {
	        fitColumns : true,
	        idField : 'CALLID',
	        remoteSort : false,
	        url : 'Main/communication/ccms/fax/search?sender=${sender}',
	        toolbar : toolbar,
	        onDblClickRow : function(index, data) {
		        fax_read(data.CALLID);
		        if(data.READ == 'N') {
			        $('#faxGrid_${sender}').datagrid('updateRow', {
			            index : index,
			            row : {
				            READ : 'Y'
			            }
			        });

			        $('#faxGrid_${sender}').datagrid('sort', {
			            sortName : 'READ',
			            sortOrder : 'asc'
			        });
		        }
	        }
	    };

	    $.lauvan.dataGrid('faxGrid_${sender}', options);
    });

    function fax_relateEvent() {
	    var rows = $('#faxGrid_${sender}').datagrid('getChecked');
	    if(rows.length == 0) {
		    $.lauvan.msg('请选择要关联的传真');
		    return;
	    }
	    $.lauvan.openCustomDialog('fax_event_dialog', {
	        title : '选择事件',
	        width : 800,
	        height : 480,
	        href : 'Main/communication/ccms/fax/event?action=select',
	        buttons : [{
	            text : '确定',
	            iconCls : 'icon-ok',
	            handler : function() {
		            var ev = $('#fax_eventGrid').datagrid('getSelected');
		            if(ev) {
			            var callids = '';
			            for(var i = 0; i < rows.length; i++) {
			            	callids += ',' + rows[i]['CALLID'];
			            }
			            callids = callids.substr(1);
			            $.post('Main/communication/ccms/fax/event?action=relate', {
			            	callids : callids,
			                eventId : ev['ID']
			            }, function(result) {
				            if(!result.success) {
					            $.lauvan.msg('关联事件失败');
				            } else {
				            	fax_search_${sender}();
					            $('#fax_event_dialog').dialog('close');
				            }
			            });
		            } else {
			            $.lauvan.msg('请选择关联事件');
		            }
	            }
	        }]
	    });
    }
    
    function fax_unrelateEvent() {
    	var rows = $('#faxGrid_${sender}').datagrid('getChecked');
	    if(rows.length == 0) {
		    $.lauvan.msg('请选择要取消关联的记录');
		    return;
	    }
	    if(confirm('点击【确定】取消关联事件')) {
    		var callids = '';
            for(var i = 0; i < rows.length; i++) {
            	callids += ',' + rows[i]['CALLID'];
            }
            callids = callids.substr(1);
	    	$.post('Main/communication/ccms/fax/unrelateEvent', {
	    		callids : callids
		    }, function(result) {
		    	if(!result.success) {
		            $.lauvan.msg('取消关联失败');
	            } else {
	            	fax_search_${sender}();
	            }
		    });
    	}
    }

    function fax_create() {
	    fax_send({
	        action : 'new',
	        onClose : function() {
	        	fax_search_${sender}();
		        $('#fax_send_dialog').dialog('destroy');
	        }
	    });
    }

    function fax_reply() {
	    var row = $('#faxGrid_${sender}').datagrid('getSelected');
	    if(!row) {
		    $.lauvan.msg('请选择要回复的传真');
		    return;
	    }
	    fax_send({
	        action : 'reply',
	        callid : row.CALLID,
	        onClose : function() {
	        	fax_search_${sender}();
		        $('#fax_send_dialog').dialog('destroy');
	        }
	    });
    }

    function fax_resend() {
	    var row = $('#faxGrid_${sender}').datagrid('getSelected');
	    if(!row) {
		    $.lauvan.msg('请选择要重发的传真');
		    return;
	    }
	    fax_send({
	        action : 'resend',
	        callid : row.CALLID,
	        onClose : function() {
		        fax_search_${sender}();
		        $('#fax_send_dialog').dialog('destroy');
	        }
	    });
    }

    function fax_update() {
	    var form = $('#fax_readForm');
	    $.post('Main/communication/ccms/fax/update', {
	        CALLID : form.find(':input[id="callid"]').val(),
	        TITLE : form.find(':input[id="fax_title"]').val(),
	        REMARK : form.find(':input[id="fax_remark"]').val()
	    }, function(result) {
		    $.lauvan.msg(result.msg);
	    });
    }
    
    function fax_eventLink(val, row, index) {
    	return _eventEditFN(row.EVENTID, row.EV_STATE, row.EV_NAME, 'fax_search_${sender}()');
    }
    
    function fax_faxstFmt(val, row, index) {
    	return row.FAXST == 'S'? '成功' : '失败';
    }
    
    function fax_readFmt(val, row, index) {
    	return row.READ == 'Y'? '已读' : '未读';
    }

    $(function() {
	    var form = $('#faxForm_${sender}');
	    var dateTime = form.find(':input[id="fax_dateTime_${sender}"]');
	    dateTime.datepicker({
	        changeMonth : true,
	        changeYear : true,
	        showButtonPanel : true,
	        dateFormat : 'yy-mm-dd'
	    });
    });
    
    function fax_search_${sender}() {
	    var form = $('#faxForm_${sender}');
	    $('#faxGrid_${sender}').datagrid('load', {
	        sender : '${sender}',
	        or_name : form.find(':input[id="or_name"]').val(),
	        fax_number : form.find(':input[id="fax_number"]').val(),
	        dateTime : form.find(':input[id="fax_dateTime_${sender}"]').val(),
	        ev_name : form.find(':input[id="ev_name"]').val()
	    });
    }
</script>