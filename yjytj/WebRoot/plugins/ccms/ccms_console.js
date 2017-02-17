$(function() {
	$ccms_contacts = [];

	Messenger.options = {
	    extraClasses : 'messenger-fixed messenger-on-bottom messenger-on-right',
	    id : 'Only-one-message',
	    theme : 'ice'
	};

	$.post('Main/communication/ccms/contacts', {}, function(contacts) {
		if(contacts) {
			$ccms_contacts = contacts;
		}

		$.post('Main/communication/ccms/fax/unreadFax', {}, function(result) {
			if(result) {
				var records = result;
				if(records.length > 0) {
					var MSG_ID = 'FAXR';
					var message = '<div id="faxr_message" class="messenger-content">';
					for(var i = 0; i < records.length && i < 10; i++) {
						var fax = records[i];
						message += '<p class="faxr"><a href="javascript:void(0);" onclick="fax_view(' + fax.CALLID + ', this)">';
						message += '【' + getOR_NAME(fax.FAX_NUMBER) + '】' + format_time(fax.DATETIME) + '</a></p>';
					}
					if(records.length > 10) {
						message += '<p><a id="faxr_more" href="javascript:void(0);" onclick="tag_faxrecv();">更多...<a></p>';
					}
					message += '</div>';
					$.messenger.post({
					    id : MSG_ID,
					    type : 'faxrecv',
					    message : message,
					    onClickClose : function() {
						    faxrecv_notice(false);
						    $.messenger.destroy(MSG_ID);
					    }
					});
				}
			}
		});
	});

	$(document.body).append('<div id="ccms_console" />');
	$('#ccms_console').dialog({
	    title : '呼叫中心',
	    width : 640,
	    height : 480,
	    top : 0,
	    closed : true,
	    collapsed : true,
	    collapsible : true,
	    minimizable : true,
	    maximizable : false,
	    closable : false,
	    resizable : false,
	    modal : false,
	    href : 'Main/communication/ccms/console',
	    buttons : [],
	    onCollapse : function() {
		    $('#ccms_console').dialog('collapse');
	    },
	    onExpand : function() {
		    $('#ccms_console').dialog('expand');
	    }
	});
});

function open_ccmsconsole() {
	$('#ccms_console').dialog('open');
}

function get_contact(tel_number) {
	for(var i = 0; i < $ccms_contacts.length; i++) {
		var TEL_NUMBER = $ccms_contacts[i].TEL_NUMBER;
		if(typeof (TEL_NUMBER) != 'undefined' && TEL_NUMBER != null) {
			if((',' + TEL_NUMBER + ',').indexOf(',' + tel_number + ',') != -1) {
				return $ccms_contacts[i];
			}
		}
	}

	return null;
}

function getOR_NAME(tel_number) {
	var contact = get_contact(tel_number);
	if(contact == null) {
		return tel_number;
	}

	return contact.OR_NAME == null ? tel_number : contact.OR_NAME;
}

function format_time(dateTime) {
	var Y_M_D = dateTime.split(' ')[0].split('-');
	var h_m_s = dateTime.split(' ')[1].split(':');
	dateTime = Y_M_D[0] + '年';
	dateTime += (Y_M_D[1].indexOf('0') == 0 ? Y_M_D[1].substr(1) : Y_M_D[1]) + '月';
	dateTime += (Y_M_D[2].indexOf('0') == 0 ? Y_M_D[2].substr(1) : Y_M_D[2]) + '日';
	dateTime += (h_m_s[0].indexOf('0') == 0 ? h_m_s[0].substr(1) : h_m_s[0]) + '时';
	dateTime += (h_m_s[1].indexOf('0') == 0 ? h_m_s[1].substr(1) : h_m_s[1]) + '分';
	return dateTime;
}
