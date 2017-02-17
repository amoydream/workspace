$.extend(true, {
	ccms : {
	    callEnded : function(ACTM, ACTS, BusinessID, CALLFEES, CALLROUTE, CCID, CEID, CallID, CallVocNO, ChannelNO, DateTime, FAXST, NETWID, ORGCEID, OutCTime, RecdTime, TalkTime,
	        TotalTime, UGRPNO, UserID, VocRecdFile, WaitTime) {

	    },

	    call : function(tel_number, ev_id) {
		    var eventId = typeof (ev_id) !== 'undefined' ? ev_id : null;
		    if(_.check_TEL(tel_number)) {
			    if(!_.conf.confirmMode || confirm(_.CALL.CALL_CONFIRM)) {
				    _.CtiSeatCALL(tel_number);
			    }
		    } else {
			    _.msg(_.CALL.CALL_INVALIDE_NO.replace('_TEL_', tel_number));
		    }
	    },

	    meetingCall : function() {
	    }
	}
});