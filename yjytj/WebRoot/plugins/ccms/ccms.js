var socket = null;
var connected = false;
var ccmsMsg;
var reOpen = false;
var HdTimer;
var IsLogin = false;

function connect() {
	if(connected) {
		return;
	}
	socket = new WebSocket($.ccms.ws_location);
	socket.onopen = function(msg) {
		connected = true;
		if(ccmsMsg != '')
			try {
				socket.send(ccmsMsg);
			} catch(e) {
				alert('呼叫中心连接失败');
			}
		ccmsMsg = '';
		if(!IsLogin) {
			setTimeout('CtiSeatLogin()', 1000);
		}
	};

	socket.onmessage = function(msg) {
		if(typeof msg.data != 'string') {
			return;
		}
		var obj = eval('(' + msg.data + ')');
		var event = obj.Event;
		if(event == 'OnCallEnded') {
			OnCallEnded(obj.ACTM, obj.ACTS, obj.BusinessID, obj.CallFEES, obj.CALLROUTE, obj.CCID, obj.CEID, obj.CallID, obj.CallVocNO,
			            obj.ChannelNO, obj.DateTime, obj.FAXST, obj.NETWID, obj.ORGCEID, obj.OutCTime, obj.RecdTime, obj.TalkTime, obj.TotalTime,
			            obj.UGRPNO, obj.UserID, obj.VocRecdFile, obj.WaitTime);
		} else if(event == 'OnCallIN') {
			OnCallIN(obj.CCID, obj.CEID, obj.CallID, obj.ChannelNO);
		} else if(event == 'OnCallOUT') {
			OnCallOUT(obj.CCID, obj.CEID, obj.CallID, obj.ChannelNO);
		} else if(event == 'OnUGRPStatus') {
			OnUGRPStatus(obj.ACDM, obj.CEIDList, obj.CallCount, obj.CallWait, obj.MEMO, obj.MissLtdN, obj.PTNETWID, obj.SeatMaxNum, obj.SeatFreeNum,
			             obj.TotalUGRP, obj.UGRPNO, obj.UGRPName);
		} else if(event == 'OnSeatLink') {
			OnSeatLink(obj.BusinessID, obj.CaseNO, obj.CCID, obj.CEID, obj.CallVocNO, obj.SeatCallID, obj.SeatID, obj.UGRPNO, obj.UserID,
			           obj.UserName);
		} else if(event == 'OnSeatStatus') {
			OnSeatStatus(obj.CaseNO, obj.CallLevel, obj.ConnectCount, obj.NETWID, obj.OpLevel, obj.OpenTime, obj.OutCallTime, obj.SeatID, obj.SeatIP,
			             obj.SeatStatus, obj.TalkTime, obj.UGRPNO, obj.UnConnectCount, obj.UserID, obj.UserName, obj.WaitTime);
		} else if(event == 'OnIVRBIOS') {
			OnIVRBIOS(obj.BusinessID, obj.CCID, obj.CEID, obj.CallID, obj.ChannelNO, obj.DTMFKEYS, obj.DTMFMEM1, obj.DTMFMEM2, obj.Event, obj.IVRID);
		} else if(event == 'OnSeatList') {
			OnSeatList(obj.Result, obj.CResult, obj.FromID);
		} else if(event == 'SessionConnected') {

		} else {

		}
	};

	socket.onclose = function(msg) {
		connected = false;
	};
}

function startTimer() {
	if(HdTimer != null) {
		clearTimeout(HdTimer);
	}
	HdTimer = setTimeout('startTimer()', 30000);
	if((!connected) && (reOpen)) {
		CtiOpen();
		return;
	}
}

function stopTimer() {
	clearTimeout(HdTimer);
	HdTimer = null;
}

function disconnect() {
	try {
		connected = false;
		IsLogin = false;
		if(socket != null) {
			socket.close();
			socket = null;
		}
	} catch(e) {
		throw e;
	}
}

function send(msg) {
	if(!connected) {
		if(!reOpen) {
			return;
		}
		if(socket != null) {
			socket.close();
			socket = null;
		}
		connect();
		ccmsMsg = msg;
		return;
	}

	socket.send(msg);
}

window.onload = function() {
	if($.ccms.seatID !== 'undefined' && $.ccms.seatID !== null) {
		CtiOpen();
		HdTimer = setTimeout('startTimer()', 30000);
	}
};

window.onbeforeunload = function() {
	if($.ccms.seatID !== 'undefined' && $.ccms.seatID !== null) {
		try {
			socket.close();
			socket = null;
			connected = false;
			IsLogin = false;
		} catch(e) {
		}
	}
};

function CtiOpen() {
	if(!('WebSocket' in window)) {
		return;
	}
	if($.ccms.userID == 'admin' || $.ccms.userID == 'super') {
		return;
	}
	reOpen = true;
	var host = $.ccms.ws_location.substring($.ccms.ws_location.indexOf('//') + 2, $.ccms.ws_location.lastIndexOf(':'));
	send('OPEN;' + host + ';;' + $.ccms.seatID);
}

function CtiClose() {
	reOpen = false;
	IsLogin = false;
	send('CLOSE;');
}

function CtiSeatLogin() {
	if($.ccms.userID == 'admin' || $.ccms.userID == 'super') {
		return;
	}
	IsLogin = true;
	CtiSeatLogOut();
	send('LOGIN;' + $.ccms.seatID + ';' + $.ccms.userID + ';;' + $.ccms.ugrpNO + ';;' + $.ccms.callLevel + ';' + $.ccms.userName + ';---');
}

function CtiSeatLogOut() {
	IsLogin = false;
	send('LOGOUT;' + $.ccms.seatID + ';---');
}

function CtiSeatCALL(CEID, BusinessID) {
	if(typeof (BusinessID) !== 'number') {
		BusinessID = '';
	}
	send('SEATCALL;' + $.ccms.seatID + ';' + CEID + ';;' + BusinessID + ';---');
}

function CtiSendFAX(CEID, tifFile, BusinessID) {
	if(typeof (BusinessID) !== 'number') {
		BusinessID = '';
	}
	send('SENDFAXCALL;' + CEID + ';' + tifFile + ';;' + BusinessID + ';---');
}

function CtiRecvFAX(CEID, tifFile) {
	send('RECVFAXCALL;' + CEID + ';' + tifFile + ';;;---');
}

function CtiSeatHangUP() {
	send('SEATHANGUP;' + $.ccms.seatID + ';---');
}

function CtiSeatSetBusy() {
	send('SETBUSY;' + $.ccms.seatID + ';---');
}

function CtiSeatSetFree() {
	send('SETFREE;' + $.ccms.seatID + ';---');
}

function CtiGetSeatList(UGRPNO, SELECTMD) {
	return send('SEATLIST;' + UGRPNO + ';' + SELECTMD + ';;;---');
}

function CtiReCALL(CCID) {
	send('SEATCALL;' + $.ccms.seatID + ';' + CCID + ';;;---');
}

function CtiSeatHold() {
	send('SEATHOLD;' + $.ccms.seatID + ';;;---');
}

function CtiSeatSwitch() {
	send('SEATSWITCH;' + $.ccms.seatID + ';;;---');
}

function CtiSeatMeeting() {
	send('SEATLINK;' + $.ccms.seatID + ';;;---');
}

function CtiMeetingCALL(MemberTels, CallerID, BussinessID) {
	if(typeof (BussinessID) !== 'number') {
		BussinessID = '';
	}
	send('CTIMEETCALL;' + $.ccms.seatID + ';' + MemberTels + ';' + CallerID + ';' + BussinessID + ';;;---')
}

function CtiSeatSDFAX(IVRID, tifFile) {
	send('SEATIVR;' + $.ccms.seatID + ';' + IVRID + ';' + tifFile + ';;;---');
}

function CtiVocRePlay(CEID, CallVocNO) {
	send('VOCCALLREPLAY;' + CEID + ';' + CallVocNO + ';;;---');
}

function CtiIVRCall(CEID, IVRID) {
	send('IVRDCALL;' + CEID + ';' + IVRID + ';;;---');
}

function CtiSeatIVR(IVRID, PRAM) {
	send('SEATIVR;' + $.ccms.seatID + ';' + IVRID + ';' + PRAM + ';;;---');
}

function CtiCallIVR(CallID, IVRID, PRAM) {
	send('CALLIVR;' + CallID + ';' + IVRID + ';' + PRAM + ';;;---');
}

function CtiSeatAPI(APIID, PRAM) {
	send('SEATAPI;' + $.ccms.seatID + ';' + APIID + ';' + PRAM + ';;;---');
}

function CtiCallAPI(CallID, APIID, PRAM) {
	send('CALLAPI;' + CallID + ';' + APIID + ';' + PRAM + ';;;---');
}

function CtiSetACDMH() {
	send('SETACDM;' + $.ccms.ugrpNO + ';H;;;---');
}

function CtiSetACDMC() {
	send('SETACDM;' + $.ccms.ugrpNO + ';C;;;---');
}

function CtiSetIVRMEM() {
	send('SETIVRMEM;0;日间模式;;;---');
}

function CtiSetIVRMEM2() {
	send('SETIVRMEM;0;夜间模式;;;---');
}
