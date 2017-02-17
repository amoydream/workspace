$.extend(true, {
	ccms : {
	    eventId : null,
	    faxAccepted : false,
	    OnCallEnded : function(ACTM, ACTS, BusinessID, CALLFEES, CALLROUTE, CCID, CEID, CallID, CallVocNO, ChannelNO, DateTime, FAXST, NETWID, ORGCEID, OutCTime, RecdTime,
	        TalkTime, TotalTime, UGRPNO, UserID, VocRecdFile, WaitTime) {
		    _.log(_M.ONCALLENDED + _M.CALLID + CallID + _M.CCID + CCID + _M.CEID + CEID + _M.ACTM + ACTM + _M.ACTS + ACTS + _M.USERID + UserID + _M.FAXST + FAXST + _M.CALLVOCNO +
		        CallVocNO + _M.VOCRECDFILE + VocRecdFile + _M.DATETIME + DateTime + _M.OUTCTIME + OutCTime + _M.RECDTIME + RecdTime + _M.WAITTIME + WaitTime + _M.TALKTIME +
		        TalkTime + _M.TOTALTIME + TotalTime);
		    if(FAXST === 0) {
			    _.callEnded(ACTM, ACTS, BusinessID, CALLFEES, CALLROUTE, CCID, CEID, CallID, CallVocNO, ChannelNO, DateTime, FAXST, NETWID, ORGCEID, OutCTime, RecdTime, TalkTime,
			        TotalTime, UGRPNO, UserID, VocRecdFile, WaitTime);
		    } else {
			    if(FAXST == 9999 || FAXST == -9999) {
				    _.faxRecvEnded(ACTM, ACTS, BusinessID, CALLFEES, CALLROUTE, CCID, CEID, CallID, CallVocNO, ChannelNO, DateTime, FAXST, NETWID, ORGCEID, OutCTime, RecdTime,
				        TalkTime, TotalTime, UGRPNO, UserID, VocRecdFile, WaitTime);
			    } else if(FAXST == 8888 || FAXST == -8888) {
				    _.faxSendEnded(ACTM, ACTS, BusinessID, CALLFEES, CALLROUTE, CCID, CEID, CallID, CallVocNO, ChannelNO, DateTime, FAXST, NETWID, ORGCEID, OutCTime, RecdTime,
				        TalkTime, TotalTime, UGRPNO, UserID, VocRecdFile, WaitTime);
			    }
		    }
	    },

	    OnSeatLink : function(BusinessID, CaseNO, CCID, CEID, CallVocNO, SeatCallID, SeatID, UGRPNO, UserID, UserName) {
		    _.log(_M.ONSEATLINK + _M.CASENO + CaseNO + _M.SEATCALLID + SeatCallID + _M.CCID + CCID + _M.CEID + CEID + _M.USERID + UserID + _M.USERNAME + UserName + _M.SEATID +
		        SeatID + _M.CALLVCONO + CallVocNO + _M.UGRPNO + UGRPNO);
		    if(CaseNO == '1') {
			    return 'CASE_1';
		    } else if(CaseNO == '2') {
			    return 'CASE_2';
		    } else if(CaseNO == '3') {
			    return 'CASE_3';
		    } else if(CaseNO == '4') {
			    return 'CASE_4';
		    } else if(CaseNO == '5') {
			    return 'CASE_5';
		    }
	    },

	    OnCallIN : function(CCID, CEID, CallID, ChannelNO) {
		    _.log(_M.ONCALLIN + CallID + _M.CHANNELNO + ChannelNO + _M.CCID + CCID + _M.CEID + CEID);
	    },

	    OnCallOUT : function(CCID, CEID, CallID, ChannelNO) {
		    _.log(_M.ONCALLOUT + CallID + _M.CHANNELNO + ChannelNO + _M.CCID + CCID + _M.CEID + CEID);
	    },

	    OnIVRBIOS : function(BusinessID, CCID, CEID, CallID, ChannelNO, DTMFKEYS, DTMFMEM1, DTMFMEM2, Event, IVRID) {
	    },

	    OnUGRPStatus : function(ACDM, CEIDList, CallCount, CallWait, MEMO, MissLtdN, PTNETWID, SeatMaxNum, SeatFreeNum, TotalUGRP, UGRPNO, UGRPName) {
	    },

	    OnSeatStatus : function(CaseNO, CallLevel, ConnectCount, NETWID, OpLevel, OpenTime, OutCallCount, SeatID, SeatIP, SeatStatus, TalkTime, UGRPNO, UnConnectCount, UserID,
	        UserName, WaitTime) {
		    _.log(_M.ONSEATSTATUS + _M.CASENO + CaseNO + _M.CALLLEVEL + CallLevel + _M.OPLEVEL + OpLevel + _M.CONNECTCOUNT + ConnectCount + _M.UNCONNECTCOUNT + UnConnectCount +
		        _M.USERID + UserID + _M.USERNAME + UserName + _M.SEATIP + SeatIP + _M.SEATSTATUS + SeatStatus + _M.UGRPNO + UGRPNO + _M.OUTCALLCOUNT + OutCallCount + _M.WAITTIME +
		        WaitTime + _M.TALKTIME + TalkTime);
	    }
	}
});
