function callout(tel_number, eventId, confirmMode) {
	if(tel_number == null || typeof (tel_number) === 'undefined') {
		return;
	} else if(typeof (tel_number) !== 'string') {
		tel_number = tel_number.toString();
	}

	tel_number = tel_number.trim();

	if(tel_number == '') {
		return;
	}

	var tel_numbers = tel_number.split(',');
	if(tel_numbers.length == 1) {
		if(check_TEL(tel_number)) {
			var confirmed = false;
			if(typeof (confirmMode) !== 'undefined') {
				confirmed = !confirmMode;
			}
			confirmed = confirmed || confirm('点击【确定】拨打【' + tel_number + '】');
			if(confirmed) {
				CtiSeatCALL(tel_number, eventId);
			}
		} else {
			$.lauvan.msg('电话号码【' + tel_number + '】格式错误');
		}
	} else {
		var content = '<div style="margin-left:15px; font-size:16px;"><br>';
		for(var i = 0; i < tel_numbers.length; i++) {
			content += tel_link(tel_numbers[i]) + '<br><br>';
		}
		content += '</div>';
		$(document.body).append('<div id="sel_tel_number"></div>');
		$('#sel_tel_number').dialog({
		    title : '选择号码',
		    width : 200,
		    height : 200,
		    maximizable : false,
		    resizable : true,
		    modal : false,
		    content : content,
		    buttons : [],
		    onClose : function() {
			    $('#sel_tel_number').dialog('destroy');
			    $('#sel_tel_number').remove();
		    }
		});
	}
}

function call_test(tel_number) {
	callout(tel_number, null, false);
}

function call_recdplay(callid) {
	if($('#vocrecd').length != 0) {
		if($userAgent == 'IE') {
			$('#vocrecd')[0].stop();
		} else {
			$('#vocrecd').removeAttr('src');
		}
	}

	if($('#vocrecdplay').length != 0) {
		$('#vocrecdplay').dialog('destroy');
		$('#vocrecdplay').remove();
	}

	$.post('Main/communication/ccms/call/play', {
		callid : callid
	}, function(result) {
		if(typeof (result.vocRecdUrl) != 'undefined') {
			var vocrecd_html = '';
			if($userAgent == 'IE') {
				vocrecd_html = '<embed id="vocrecd" autostart ';
			} else {
				vocrecd_html = '<audio id="vocrecd" controls autoplay onended="$(\'#vocrecdplay\').dialog(\'close\')" ';
			}
			vocrecd_html += 'src="' + result.vocRecdUrl + '" />';
			$(document.body).append('<div id="vocrecdplay"></div>');
			$('#vocrecdplay').dialog({
			    title : '播放录音',
			    width : 314,
			    height : 100,
			    maximizable : false,
			    resizable : true,
			    modal : false,
			    content : vocrecd_html,
			    buttons : [],
			    onClose : function() {
				    if($userAgent == 'IE') {
					    $('#vocrecd')[0].stop();
				    } else {
					    $('#vocrecd').removeAttr('src');
				    }
				    $('#vocrecdplay').dialog('destroy');
				    $('#vocrecdplay').remove();
			    }
			});
		} else {
			$.lauvan.msg('录音文件不存在');
		}
	});
}

function tel_link(tel_number) {
	return '<a class="tel_link" href="javascript:void(0);" onclick="callout(\'' + tel_number + ')">' + tel_number + '</a>';
}

function tel_link(tel_number, eventId) {
	return '<a class="tel_link" href="javascript:void(0);" onclick="callout(\'' + tel_number + '\',\'' + eventId + '\')">' + tel_number + '</a>';
}
