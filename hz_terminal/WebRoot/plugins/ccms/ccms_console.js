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

function get_contact(TEL_NUMBER) {
	if(typeof (TEL_NUMBER) != 'undefined' && TEL_NUMBER != null) {
		if(typeof TEL_NUMBER !== 'string') {
			TEL_NUMBER = TEL_NUMBER.toString();
		}
		for(var i = 0; i < $ccms_contacts.length; i++) {
			var contact = $ccms_contacts[i];
			var _TEL_NUMBER = contact.TEL_NUMBER;
			if((',' + _TEL_NUMBER + ',').indexOf(',' + TEL_NUMBER + ',') != -1) {
				return contact;
			} else {
				var TEL_HOME = contact.TEL_HOME;
				var TEL_OFFICE = contact.TEL_OFFICE;
				var FAX_NUMBER = contact.FAX_NUMBER;
				if(checkTEL(TEL_NUMBER, TEL_HOME) || checkTEL(TEL_NUMBER, TEL_OFFICE) || checkTEL(TEL_NUMBER, FAX_NUMBER)) {
					return contact;
				}
			}
		}
	}

	return null;
}

function checkTEL(TEL_NUMBER, TEL_NUMBERS) {
	if(typeof (TEL_NUMBERS) != 'undefined' && TEL_NUMBERS != null) {
		if(typeof TEL_NUMBERS !== 'string') {
			TEL_NUMBERS = TEL_NUMBERS.toString();
		}

		if(TEL_NUMBERS == '') {
			return false;
		}

		if(TEL_NUMBER == TEL_NUMBERS) {
			return true;
		}

		TEL_NUMBER = reverse_str(TEL_NUMBER);
		var TEL_NUMBER_7 = TEL_NUMBER;
		var TEL_NUMBER_8 = TEL_NUMBER;
		if(TEL_NUMBER.length > 8 && TEL_NUMBER.indexOf('0') == 0) {
			TEL_NUMBER_7 = TEL_NUMBER.substring(0, 7);
			TEL_NUMBER_8 = TEL_NUMBER.substring(0, 8);
		}

		var _TEL_NUMBER = null;
		var _TEL_NUMBER_7 = null;
		var _TEL_NUMBER_8 = null;
		var TEL_NUMBER_ARR = TEL_NUMBERS.split(',');
		for(var i = 0; i < TEL_NUMBER_ARR.length; i++) {
			_TEL_NUMBER = reverse_str(TEL_NUMBER_ARR[i]);
			_TEL_NUMBER_7 = _TEL_NUMBER;
			_TEL_NUMBER_8 = _TEL_NUMBER;

			if(_TEL_NUMBER.length >= 8) {
				_TEL_NUMBER_7 = _TEL_NUMBER.substring(0, 7);
				_TEL_NUMBER_8 = _TEL_NUMBER.substring(0, 8);
			}

			if(TEL_NUMBER_7 == _TEL_NUMBER_7 || TEL_NUMBER_8 == _TEL_NUMBER_8) {
				return true;
			}
		}
	}

	return false;
}

function reverse_str(str) {
	result = "";
	for(var i = str.length; i > 0; i--) {
		result += str.charAt(i - 1);
	}

	return result;
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
