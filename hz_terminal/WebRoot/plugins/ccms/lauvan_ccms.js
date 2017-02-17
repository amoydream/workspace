function OnCallEnded(ACTM, ACTS, BusinessID, CallFEES, CALLROUTE, CCID, CEID, CallID, CallVocNO, ChannelNO, DateTime, FAXST, NETWID, ORGCEID,
                     OutCTime, RecdTime, TalkTime, TotalTime, UGRPNO, UserID, VocRecdFile, WaitTime) {
	if(FAXST != 0) {
		if(FAXST == 9999 || FAXST == -9999) {
			setTimeout('recvResult(' + CallID + ')', 10000);
		} else if(FAXST == 8888 || FAXST == -8888) {
			setTimeout('sendResult(' + CallID + ',' + CEID + ')', 10000);
		}
	}
}

function recvResult(CALLID) {
	$.post('Main/communication/ccms/fax/faxResult', {
		CALLID : CALLID
	}, function(result) {
		if(result != null) {
			var MSG_ID = 'FAXR';
			var message;
			if($.messenger.msg(MSG_ID) != null) {
				if($('#faxr_message').find('.faxr').length == 10) {
					$('#faxr_message').find('.faxr:last').remove();
					if($('#faxr_more').length == 0) {
						$('#faxr_message').append('<p><a id="faxr_more" href="javascript:void(0);" ');
						$('#faxr_message').append('onclick="tag_faxrecv(\'S\')">更多...<a></p>');
					}
				}
				var faxr_html = '<p class="faxr"><a href="javascript:void(0);" ';
				faxr_html += 'onclick="fax_view(' + result.CALLID + ', this)">';
				faxr_html += '【' + result.OR_NAME + '】' + format_time(result.DATETIME) + '</a></p>';
				$('#faxr_message').prepend(faxr_html);

				message = $('#faxr_message').prop('outerHTML');
				$.messenger.update({
				    id : MSG_ID,
				    message : message
				});
			} else {
				message = '<div id="faxr_message" class="messenger-content">';
				message += '<p><a href="javascript:void(0);" onclick="fax_view(' + result.CALLID + ', this)">';
				message += '【' + result.OR_NAME + '】' + format_time(result.DATETIME) + '</a></p></div>';
			}

			$.messenger.post({
			    id : MSG_ID,
			    type : 'faxrecv',
			    message : message,
			    onClickClose : function() {
				    faxrecv_notice(false);
				    Messenger().destroy(MSG_ID);
			    }
			});

			faxrecv_notice(true);
		}
	});
}

function sendResult(CALLID, CEID) {
	for(var i = 0; i < faxQueue.length; i++) {
		if(faxQueue[i] == CEID) {
			faxQueue.splice(i, 1);
			break;
		}
	}

	$.post('Main/communication/ccms/fax/faxResult', {
		CALLID : CALLID
	}, function(result) {
		if(result != null) {
			if($.messenger.msg('FAXS') != null) {
				var MSG_ID = 'FAXS';
				var faxs = $('#faxs_' + CEID);
				faxs.html('传真【' + getOR_NAME(CEID) + '】发送' + (result.FAXST == 'S' ? '成功' : '失败'));
				faxs.prop('class', 'faxs sent');
				faxs.show();
				var visible_faxs = $('#faxs_message').find('.faxs:visible');
				var hidden_faxs = $('#faxs_message').find('.sending:hidden');
				if(hidden_faxs.length > 0 && visible_faxs.length >= 10) {
					$('#faxs_message').find('.sending:hidden:first').show();
					if($('#faxs_message').find('.sent:visible').length > 0) {
						$('#faxs_message').find('.sent:visible:first').hide();
					} else {
						$('#faxs_message').find('.faxs:visible:first').hide();
					}
				}
				$.messenger.update({
				    id : MSG_ID,
				    message : $('#faxs_message').prop('outerHTML')
				});

				if(faxQueue.length == 0) {
					$('#faxs_message').show();
					var faxs = $('#faxs_message').find('.faxs');
					for(var i = 0; i < faxs.length && i < 10; i++) {
						$(faxs[i]).show();
					}
					if(faxs.length > 10) {
						for(var i = 10; i < faxs.length; i++) {
							$(faxs[i]).hide();
						}
					}
					var message = $('#faxs_message').prop('outerHTML');
					$.messenger.update({
					    id : MSG_ID,
					    type : 'faxsent',
					    message : message,
					    onClickClose : function() {
						    $.messenger.destroy(MSG_ID);
					    }
					});

					faxOptions.onSendComplete();
				}
			}
		}
	});
}

function OnSeatLink(BusinessID, CaseNO, CCID, CEID, CallVocNO, SeatCallID, SeatID, UGRPNO, UserID, UserName) {
	if(CaseNO == '1') {
		return '坐席分转';
	} else if(CaseNO == '2') {
		return '坐席摘机';
	} else if(CaseNO == '3') {
		$.messenger.destroy('CALLIN_' + CCID);
		$.messenger.destroy('CALLIN_' + CEID);
		return '坐席未接';
	} else if(CaseNO == '4') {
		$.messenger.destroy('CALLIN_' + CCID);
		$.messenger.destroy('CALLIN_' + CEID);
		return '坐席结束';
	} else if(CaseNO == '5') {
		return '坐席外呼';
	}
}

function OnCallIN(CCID, CEID, CallID, ChannelNO) {
	if(CCID == CEID && check_CCMS_SEAT(CCID)) {

	} else if(check_CCMS_SEAT(CEID)) {
		callin_msg(CCID);
	}
}

function OnCallOUT(CCID, CEID, CallID, ChannelNO) {
	if(CCID == '' || CEID == '' || CCID == CEID || CCID == $.ccms.seatID || check_CCMS_TEL(CCID)) {
		return;
	} else if(check_CCMS_SEAT(CEID)) {
		callin_msg(CCID);
	} else if(!check_CCMS_SEAT(CCID) && check_CCMS_TEL(CEID)) {
		callin_msg(CCID);
	}
}

function callin_msg(tel_number) {
	var MSG_ID = 'CALLIN_' + tel_number;
	if($.messenger.msg(MSG_ID) == null) {
		var contact = get_contact(tel_number);
		if(contact == null) {
			contact = {
			    CONTACT_NAME : '未知',
			    OR_NAME : '未知'
			};
		}
		var message = '<div align="center" class="messenger-content">';
		message += '<img src="images/callin.gif" />';
		message += '<p><span style="font-weight: bold;">姓名</span>: ';
		message += contact.CONTACT_NAME;
		message += '</p><p><span style="font-weight: bold;">部门</span>: ';
		message += contact.OR_NAME;
		message += '</p><p><span style="font-weight: bold;">电话号码</span>: ';
		message += '<a href="javascript:void(0);" onclick="callout(\'' + tel_number + '\')">';
		message += tel_number;
		message += '</a></p></div>';
		$.messenger.post({
		    id : MSG_ID,
		    type : 'callin',
		    message : message
		});
	}
}

function OnIVRBIOS(BusinessID, CCID, CEID, CallID, ChannelNO, DTMFKEYS, DTMFMEM1, DTMFMEM2, Event, IVRID) {
}

function OnUGRPStatus(ACDM, CEIDList, CallCount, CallWait, MEMO, MissLtdN, PTNETWID, SeatMaxNum, SeatFreeNum, TotalUGRP, UGRPNO, UGRPName) {
}

function OnSeatStatus(CaseNO, CallLevel, ConnectCount, NETWID, OpLevel, OpenTime, OutCallTime, SeatID, SeatIP, SeatStatus, TalkTime, UGRPNO,
                      UnConnectCount, UserID, UserName, WaitTime) {
}

function check_CCMS_SEAT(tel_number) {
	return $.ccms.seatIDs.indexOf(tel_number) >= 0;
}

function check_CCMS_TEL(tel_number) {
	return $.ccms.tel_number.indexOf(tel_number) >= 0;
}

function check_CCMS_FAX(fax_number) {
	return $.ccms.fax_number.indexOf(fax_number) >= 0;
}

function check_TEL(tel_number) {
	if(tel_number === null || typeof (tel_number) === 'undefined') {
		return false;
	}
	if(typeof tel_number !== 'string') {
		tel_number = tel_number.toString();
	}

	tel_number = tel_number.trim();
	if(tel_number == '') {
		return false;
	}

	var tel_numbers = tel_number.split(',');
	if(tel_numbers.length == 1) {
		var reg = /^0\d{2,3}-?[1-9]{1}\d{6,7}-?\d{1,6}$/;
		if(!reg.test(tel_number)) {
			reg = /^0\d{2,3}-?\d{7,8}$/;
			if(!reg.test(tel_number)) {
				reg = /^[1-9]{1}\d{6,7}$/;
				if(!reg.test(tel_number)) {
					reg = /^[0]*1\d{10}$/;
					if(!reg.test(tel_number)) {
						reg = /^[1-9]{1}\d{2,14}$/;
						if(!reg.test(tel_number)) {
							return false;
						}
					}
				}
			}
		}
	} else {
		for(var i = 0; i < tel_numbers.length; i++) {
			if(!check_TEL(tel_numbers[i])) {
				return false;
			}
		}
	}

	return true;
}

function check_FAX(fax_number) {
	if(fax_number == null || typeof fax_number != 'string' || fax_number.trim() == '') {
		return false;
	}

	var reg = /^0\d{2,3}-?[1-9]{1}\d{6,7}$/;
	if(!reg.test(fax_number)) {
		reg = /^[1-9]{1}\d{6,7}$/;
		if(!reg.test(fax_number)) {
			return false;
		}
	}

	return true;
}
