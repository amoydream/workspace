
var faxQueue = [];
var faxOptions = {};

function ccmsSendFax(fax_numbers, options) {
	if(faxQueue.length != 0) {
		$.lauvan.msg('请等待当前传真任务完毕');
		return;
	}

	if(typeof (fax_numbers) == 'undefined' || fax_numbers == null) {
		$.lauvan.msg('请选择传真接收部门');
		return;
	}
	if(typeof (options.tifFile) == 'undefined' || options.tifFile == null) {
		$.lauvan.msg('请上传传真文件');
		return;
	}

	faxQueue = fax_numbers;

	faxOptions = {
	    confirmMode : true,
	    needConfirm : false,
	    callid : null,
	    tifFile : null,
	    eventId : null,
	    dialogId : null,
	    onSendComplete : function() {
	    }
	};

	faxOptions = $.extend(faxOptions, options);

	var confirmed = !faxOptions.confirmMode;

	confirmed = confirmed || confirm('点击【确定】发送传真');
	if(confirmed) {
		if(faxQueue.length == 1) {
			if(faxOptions.needConfirm) {
				CtiSeatCALL(faxQueue[0]);
				confirmed = confirm('请在听到传真音后点击【确定】发送传真');
				if(confirmed) {
					CtiSeatAPI('FAXS', faxOptions.tifFile);
				}
			} else {
				CtiSendFAX(faxQueue[0], faxOptions.tifFile, to_number(faxOptions.eventId));
			}
		} else {
			for(var i = 0; i < faxQueue.length; i++) {
				CtiSendFAX(faxQueue[i], faxOptions.tifFile, to_number(faxOptions.eventId));
			}
		}
	}

	if(confirmed) {
		fax_sending();
		if(faxOptions.dialogId != null) {
			$('#' + faxOptions.dialogId).dialog('destroy');
			$('#' + faxOptions.dialogId).remove();
		}
	} else {
		faxQueue = [];
	}
}

function fax_sending() {
	var MSG_ID = 'FAXS';
	$.messenger.destroy(MSG_ID);
	var message = '<div id="faxs_message" class="messenger-content">';
	var FAX_NUMBER;
	for(var i = 0; i < faxQueue.length && i < 10; i++) {
		FAX_NUMBER = faxQueue[i];
		message += '<p class="faxs sedding" id="faxs_' + FAX_NUMBER + '">传真【' + getOR_NAME(FAX_NUMBER) + '】正在发送</p>';
	}
	if(faxQueue.length >= 10) {
		for(var i = 10; i < faxQueue.length; i++) {
			FAX_NUMBER = faxQueue[i];
			message += '<p class="faxs sending" style="display:none;" id="faxs_' + FAX_NUMBER + '">传真【' + getOR_NAME(FAX_NUMBER) + '】正在发送</p>';
		}
		message += '<p>...</p>';
	}
	message += '</div>';
	$.messenger.post({
	    id : MSG_ID,
	    type : 'faxsend',
	    message : message,
	    onClickClose : function() {
		    if(faxQueue.length > 0) {
			    $('#faxs_message').hide();
			    $.messenger.update({
			        id : MSG_ID,
			        message : $('#faxs_message').prop('outerHTML') + '<p>传真正在发送中...</p>'
			    });
		    }
	    }
	});
}

function fax_read(callid) {
	$(document.body).append('<div id="fax_read_dialog"></div>');
	$('#fax_read_dialog').dialog({
	    title : '阅读传真',
	    width : 720,
	    height : 400,
	    cache : false,
	    modal : true,
	    href : 'Main/communication/ccms/fax/read/' + callid,
	    onClose : function() {
		    $('#fax_read_dialog').dialog('destroy');
		    $('#fax_read_dialog').remove();
	    }
	});
}

function fax_view(callid, a) {
	var MSG_ID = 'FAXR';
	if($.messenger.msg(MSG_ID) != null) {
		if($('#faxr_message').find('.faxr').length < 2) {
			$.messenger.destroy(MSG_ID);
		} else {
			$(a).parent().remove();
			$.messenger.update({
			    id : MSG_ID,
			    message : $('#faxr_message').prop('outerHTML')
			});
		}
	}

	faxrecv_notice(false);

	fax_read(callid);
}

var notice_timer = null;

function faxrecv_notice(flag) {
	if(flag) {
		if($('#faxrecv_notice').length == 0) {
			$(document.body).append('<audio id="faxrecv_notice" autoplay loop src="sound/faxnotice.mp3"/>');
			if(notice_timer != null) {
				clearTimeout(notice_timer);
			}
			notice_timer = setTimeout('faxrecv_notice(false)', 15000 * 10);
		}
	} else if($('#faxrecv_notice').length != 0) {
		$('#faxrecv_notice').removeAttr('src');
		$('#faxrecv_notice').remove();
		clearTimeout(notice_timer);
		notice_timer = null;
	}
}

function tag_faxrecv() {
	faxrecv_notice(false);
	$.messenger.destroy('FAXR');
	addTab({
	    text : FAXST == '传真接收记录',
	    url : 'Main/communication/ccms/fax/received'
	});
}

function faxr_messenger_close() {
	faxrecv_notice(false);
	$.messenger.destroy('FAXR');
}

var send_buttons = [{
    text : '直接发送',
    iconCls : 'icon-print',
    handler : function() {
	    sendFax(false);
    }
}, {
    text : '确认发送',
    iconCls : 'icon-telephone',
    handler : function() {
	    sendFax(true);
    }
}];

function fax_send(options) {
	if(typeof (options) != 'object') {
		$.lauvan.msg('参数有误');
		return;
	}
	var defaults = {
	    action : 'new',
	    callid : null,
	    fax_number : null,
	    userId : null,
	    eventId : null,
	    onClose : function() {
		    $('#fax_send_dialog').dialog('destroy');
		    $('#fax_send_dialog').remove();
	    }
	};

	var opt = $.extend(defaults, options);

	var title = opt.action == 'reply' ? '回复传真' : opt.action == 'resend' ? '重发传真' : '发送传真';
	var href = 'Main/communication/ccms/fax/send?action=';

	if(opt.action == 'resend') {
		href += 'resend&callid=' + opt.callid;
	} else if(opt.action == 'reply') {
		href += 'reply&callid=' + opt.callid;
	} else {
		href += 'new' + (opt.fax_number != null ? '?fax_number=' + opt.fax_number : '') + (opt.eventId != null ? '&eventId=' + opt.eventId : '');
	}

	$.lauvan.openCustomDialog('fax_send_dialog', {
	    title : title,
	    width : 600,
	    height : 300,
	    cache : false,
	    modal : true,
	    href : href,
	    buttons : send_buttons,
	    onClose : opt.onClose
	});
}

function fax_test() {
	ccmsSendFax([$.ccms.fax_number], {
	    confirmMode : false,
	    needConfirm : false,
	    tifFile : '_fax_test.tif'
	});
}

function fax_link(options) {
	if(typeof (options) != 'object' && typeof (options.tel_number) != 'undefined') {
		return '<a href="javascript:void(0);" onclick="fax_send(options)">' + options.fax_number + '</a>';
	}

	return '';
}