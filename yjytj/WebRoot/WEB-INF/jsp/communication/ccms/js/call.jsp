<%@ page language="java" pageEncoding="utf-8"%>
<style>
.tel_link {
	color: blue; text-decoration: none;
}

.tel_link:hover {
	color: purple; text-decoration: underline;
}
</style>
<script type="text/javascript">
	$(function() {
	    $.lauvan.dataGrid('callGrid_${caller}', {
	        fitColumns : true,
	        idField : 'CALLID',
	        url : 'Main/communication/ccms/call/search?caller=${caller}',
	        toolbar : [{
	            text : '关联事件',
	            title : '关联事件',
	            iconCls : 'icon-edit',
	            handler : call_relateEvent
	        }, '-', {
	            text : '取消关联',
	            title : '取消关联',
	            iconCls : 'icon-delete',
	            handler : call_unrelateEvent
	        }, '-', {
	            text : '删除',
	            title : '删除记录',
	            iconCls : 'icon-delete',
	            delParams : {
		            url : 'Main/communication/ccms/call/delete'
	            }
	        }],
	        onDblClickRow : function(index, data) {
		        call_recdplay(data.CALLID);
	        }
	    });
    });

    function call_relateEvent() {
	    var rows = $('#callGrid_${caller}').datagrid('getChecked');
	    if(rows.length == 0) {
		    $.lauvan.msg('请选择要关联的记录');
		    return;
	    }
	    $.lauvan.openCustomDialog('call_event_dialog', {
	        title : '选择事件',
	        width : 800,
	        height : 480,
	        href : 'Main/communication/ccms/call/event?action=select',
	        buttons : [{
	            text : '确定',
	            iconCls : 'icon-ok',
	            handler : function() {
		            var ev = $('#call_eventGrid').datagrid('getSelected');
		            if(ev) {
			            var callids = '';
			            for(var i = 0; i < rows.length; i++) {
			            	callids += ',' + rows[i]['CALLID'];
			            }
			            callids = callids.substr(1);
			            $.post('Main/communication/ccms/call/event?action=relate', {
			            	callids : callids,
			                eventId : ev['ID']
			            }, function(result) {
				            if(!result.success) {
					            $.lauvan.msg('关联事件失败');
				            } else {
					            call_search_${caller}();
					            $('#call_event_dialog').dialog('close');
				            }
			            });
		            } else {
			            $.lauvan.msg('请选择关联事件');
		            }
	            }
	        }]
	    });
    }
    
    function call_unrelateEvent() {
	    var rows = $('#callGrid_${caller}').datagrid('getChecked');
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
    		$.post('Main/communication/ccms/call/unrelateEvent', {
    			callids : callids
		    }, function(result) {
		    	if(!result.success) {
		            $.lauvan.msg('取消关联失败');
	            } else {
		            call_search_${caller}();
	            }
		    });
    	}
    }
    
    function call_numberFmt(val, row, index) {
    	return tel_link(row.TEL_NUMBER, row.EVENTID);
    }
    
    function call_answeredFmt(val, row, index) {
    	return row.ANSWERED == 'Y'? '已接听' : '未接听';
    }
    
    function call_eventLink(val, row, index) {
    	return _eventEditFN(row.EVENTID, row.EV_STATE, row.EV_NAME, 'call_search_${caller}()');
    }

    $(function() {
	    var form = $('#callForm_${caller}');
	    var dateTime = form.find(':input[id="call_dateTime_${caller}"]');
	    dateTime.datepicker({
	        changeMonth : true,
	        changeYear : true,
	        showButtonPanel : true,
	        dateFormat : 'yy-mm-dd'
	    });
    });
    
    function call_search_${caller}() {
	    var form = $('#callForm_${caller}');
	    $('#callGrid_${caller}').datagrid('load', {
	        caller : '${caller}',
	        contact_name : form.find(':input[id="contact_name"]').val(),
	        or_name : form.find(':input[id="or_name"]').val(),
	        tel_number : form.find(':input[id="tel_number"]').val(),
	        dateTime : form.find(':input[id="call_dateTime_${caller}"]').val(),
	        ev_name : form.find(':input[id="ev_name"]').val()
	    });
    }
</script>
