$.extend(true, {
	ccms : {
	    CtiOpen : function() {
		    _.send('OPEN;' + _.conf.host + ';;' + _.conf.seatID);
	    },

	    CtiClose : function() {
		    _.send('CLOSE;');
	    },

	    CtiSeatLogin : function() {
		    _.send('LOGIN;' + _.conf.seatID + ';' + _.user.userID + ';;' + _.user.ugrpNO + ';;' + _.user.callLevel + ';' + _.user.userName + ';---');
	    },

	    CtiSeatLogOut : function() {
		    _.send('LOGOUT;' + _.conf.seatID + ';---');
	    },

	    CtiSeatCALL : function(CEID) {
		    _.send('SEATCALL;' + _.conf.seatID + ';' + CEID + ';;;---');
	    },

	    CtiSendFAX : function(CEID, tifFile) {
		    _.send('SENDFAXCALL;' + CEID + ';' + tifFile + ';;;---');
	    },

	    CtiRecvFAX : function(CEID, tifFile) {
		    _.send('RECVFAXCALL;' + CEID + ';' + tifFile + ';;;---');y
	    },

	    CtiSeatHangUP : function() {
		    _.send('SEATHANGUP;' + _.conf.seatID + ';---');
	    },

	    CtiSeatSetBusy : function() {
		    _.send('SETBUSY;' + _.conf.seatID + ';---');
	    },

	    CtiSeatSetFree : function() {
		    _.send('SETFREE;' + _.conf.seatID + ';---');
	    },

	    CtiGetSeatList : function(SELECTMD) {
		    return _.send('SEATLIST;' + _.user.ugrpNO + ';' + SELECTMD + ';;;---');
	    },

	    CtiReCALL : function(CCID) {
		    _.send('SEATCALL;' + _.conf.seatID + ';' + CCID + ';;;---');
	    },

	    CtiSeatHold : function() {
		    _.send('SEATHOLD;' + _.conf.seatID + ';;;---');
	    },

	    CtiSeatSwitch : function() {
		    _.send('SEATSWITCH;' + _.conf.seatID + ';;;---');
	    },

	    CtiSeatMeeting : function() {
		    _.send('SEATLINK;' + _.conf.seatID + ';;;---');
	    },

	    CtiMeetingCALL : function(MemberTels, CallerID, BussinessID) {
		    _.send('CTIMEETCALL;' + _.conf.seatID + ';' + MemberTels + ';' + CallerID + ';' + BussinessID + ';;;---')
	    },

	    CtiSeatSDFAX : function(IVRID, tifFile) {
		    _.send('SEATIVR;' + _.conf.seatID + ';' + IVRID + ';' + tifFile + ';;;---');
	    },

	    CtiVocRePlay : function(CEID, CallVocNO) {
		    _.send('VOCCALLREPLAY;' + CEID + ';' + CallVocNO + ';;;---');
	    },

	    CtiIVRCall : function(CEID, IVRID) {
		    _.send('IVRDCALL;' + CEID + ';' + IVRID + ';;;---');
	    },

	    CtiSeatIVR : function(IVRID, PRAM) {
		    _.send('SEATIVR;' + _.conf.seatID + ';' + IVRID + ';' + PRAM + ';;;---');
	    },

	    CtiCallIVR : function(CallID, IVRID, PRAM) {
		    _.send('CALLIVR;' + CallID + ';' + IVRID + ';' + PRAM + ';;;---');
	    },

	    CtiSeatAPI : function(APIID, PRAM) {
		    _.send('SEATAPI;' + _.conf.seatID + ';' + APIID + ';' + PRAM + ';;;---');
	    },

	    CtiCallAPI : function(CallID, APIID, PRAM) {
		    _.send('CALLAPI;' + CallID + ';' + APIID + ';' + PRAM + ';;;---');
	    },

	    CtiSetACDMH : function() {
		    _.send('SETACDM;' + _.user.ugrpNO + ';H;;;---');
	    },

	    CtiSetACDMC : function() {
		    _.send('SETACDM;' + _.user.ugrpNO + ';C;;;---');
	    },

	    CtiSetIVRMEM : function() {
		    _.send('SETIVRMEM;0;日间模式;;;---');
	    },

	    CtiSetIVRMEM2 : function() {
		    _.send('SETIVRMEM;0;夜间模式;;;---');
	    }
	}
});