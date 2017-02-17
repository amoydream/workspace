$.extend(true, {
	ccms : {
	    socket : null,
	    connected : false,
	    reOpen : false,
	    ccmsMsg : null,
	    IsLogin : false,

	    open : function(conf) {
		    if(!('WebSocket' in window)) {
			    _.msg(_.MSG.WS_NOT_SUPPORT);
			    return;
		    }
		    _.conf = $.extend(_.conf, conf);
		    _.reOpen = true;
		    _.CtiOpen();
		    _.connTimer.timer = setTimeout(_.connTimer.start, _.connTimer.delay);
	    },

	    login : function(user) {
		    _.user = $.extend(_.user, user);
		    _.CtiSeatLogin();
		    _.IsLogin = true;
	    },

	    logout : function() {
		    _.IsLogin = false;
		    _.CtiSeatLogOut();
	    },

	    close : function() {
		    if(!_.conf.keepLogin) {
			    _.CtiSeatLogOut();
			    _.reOpen = false;
			    _.IsLogin = false;
			    _.CtiClose();
		    }
		    _.disconnect();
	    },

	    connect : function() {
		    if(_.connected) {
			    _.msg(_.MSG.WS_CONNECTED);
			    return;
		    }
		    var url = 'ws://' + _.conf.host + ':' + _.conf.port + '/';
		    _.socket = new WebSocket(url);
		    _.socket.onopen = function(msg) {
			    _.connected = true;
			    if(_.ccmsMsg !== '')
				    try {
					    _.socket.send(_.ccmsMsg);
				    } catch(e) {
					    _.msg(_.ERROR.CONNECT_FAILED);
				    }
			    _.ccmsMsg = '';
		    };
			
		    _.socket.onmessage =
		        function(msg) {
			        if(typeof msg.data != 'string') {
				        return;
			        }
			        var _o = eval('(' + msg.data + ')');
			        var _e = _o.Event;
			        if(_e == _.EVENT.ON_CALL_ENDED) {
				        _.OnCallEnded(_o.ACTM, _o.ACTS, _o.BusinessID, _o.CALLFEES, _o.CALLROUTE, _o.CCID, _o.CEID, _o.CallID, _o.CallVocNO, _o.ChannelNO, _o.DateTime, _o.FAXST,
				            _o.NETWID, _o.ORGCEID, _o.OutCTime, _o.RecdTime, _o.TalkTime, _o.TotalTime, _o.UGRPNO, _o.UserID, _o.VocRecdFile, _o.WaitTime);
			        } else if(_e == _.EVENT.ON_CALL_IN) {
				        _.OnCallIN(_o.CCID, _o.CEID, _o.CallID, _o.ChannelNO)
			        } else if(_e == _.EVENT.ON_CALL_OUT) {
				        _.OnCallOUT(_o.CCID, _o.CEID, _o.CallID, _o.ChannelNO);
			        } else if(_e == _.EVENT.ON_UGRP_STATUS) {
				        _.OnUGRPStatus(_o.ACDM, _o.CEIDList, _o.CallCount, _o.CallWait, _o.MEMO, _o.MissLtdN, _o.PTNETWID, _o.SeatMaxNum, _o.SeatFreeNum, _o.TotalUGRP, _o.UGRPNO,
				            _o.UGRPName);
			        } else if(_e == _.EVENT.ON_SEAT_LINK) {
				        _.OnSeatLink(_o.BusinessID, _o.CaseNO, _o.CCID, _o.CEID, _o.CallVocNO, _o.SeatCallID, _o.SeatID, _o.UGRPNO, _o.UserID, _o.UserName);
			        } else if(_e == _.EVENT.ON_SEAT_STATUS) {
				        _.OnSeatStatus(_o.CaseNO, _o.CallLevel, _o.ConnectCount, _o.NETWID, _o.OpLevel, _o.OpenTime, _o.OutCallCount, _o.SeatID, _o.SeatIP, _o.SeatStatus,
				            _o.TalkTime, _o.UGRPNO, _o.UnConnectCount, _o.UserID, _o.UserName, _o.WaitTime);
			        } else if(_e == _.EVENT.ON_IVR_BIOS) {
				        _.OnIVRBIOS(_o.BusinessID, _o.CCID, _o.CEID, _o.CallID, _o.ChannelNO, _o.DTMFKEYS, _o.DTMFMEM1, _o.DTMFMEM2, _o.Event, _o.IVRID);
				        
			        } else if(_e == _.EVENT.ON_SEAT_LIST) {
				        _.OnSeatList(_o.Result, _o.CResult, _o.FromID);
			        } else if(_e == _.EVENT.ON_SESSION_CONNECTED) {

			        } else {

			        }
		        };

		    _.socket.onclose = function(msg) {
			    _.connected = false;
		    };
	    },

	    disconnect : function() {
		    try {
			    _.connected = false;
			    if(_.socket !== null) {
				    _.socket.close();
				    _.socket = null;
			    }
		    } catch(e) {
			    throw e;
		    }
	    },

	    send : function(msg) {
		    if(!_.connected) {
			    if(!_.reOpen) {
				    return;
			    }
			    if(_.socket !== null) {
				    _.socket.close();
				    _.socket = null;
			    }
			    _.connect();
			    _.ccmsMsg = msg;
			    return;
		    }
		    _.log(msg);
		    _.socket.send(msg);
	    }
	}
});