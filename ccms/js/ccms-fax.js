$.extend(true, {
	ccms : {
	    faxOptions : {},

	    faxRecvEnded : function(ACTM, ACTS, BusinessID, CALLFEES, CALLROUTE, CCID, CEID, CallID, CallVocNO, ChannelNO, DateTime, FAXST, NETWID, ORGCEID, OutCTime, RecdTime,
	        TalkTime, TotalTime, UGRPNO, UserID, VocRecdFile, WaitTime) {
	    },

	    faxSendEnded : function(ACTM, ACTS, BusinessID, CALLFEES, CALLROUTE, CCID, CEID, CallID, CallVocNO, ChannelNO, DateTime, FAXST, NETWID, ORGCEID, OutCTime, RecdTime,
	        TalkTime, TotalTime, UGRPNO, UserID, VocRecdFile, WaitTime) {
	    },

	    sendFax : function(options) {
		    $faxQueue = _.faxOptions.faxQueue;
		    if($faxQueue && $faxQueue.length !== 0) {
			    _.msg(_.FAX.SEND_WAITFOR);
			    return 'SEND_WAITFOR';
		    }
		    _.faxOptions = {
			    confirmSend : false
		    };

		    _.faxOptions = $.extend(_.faxOptions, options);
		    $faxQueue = _.faxOptions.faxQueue;

		    if(!$faxQueue || $faxQueue.length === 0) {
			    _.msg(_.FAX.SEND_NO_FAXNO);
			    return 'SEND_NO_FAXNO';
		    }

		    if(!_.faxOptions.tifFile) {
			    _.msg(_.FAX.SEND_NO_FILE);
			    return 'SEND_NO_FILE';
		    }

		    var confirmed = !_.ccmsOptions.confirmMode || confirm(_.FAX.SEND_CONFIRM);
		    if(confirmed) {
			    if($faxQueue.length == 1) {
				    if(_.faxOptions.confirmSend) {
					    _.CtiSeatCALL($faxQueue[0]);
					    confirmed = confirm(_.FAX.SEND_CONFIRM_CALL);
					    if(confirmed) {
						    _.CtiSeatAPI(_.API.FAXS, _.faxOptions.tifFile);
					    }
				    } else {
					    _.CtiSendFAX($faxQueue[0], _.faxOptions.tifFile);
				    }
			    } else {
				    for(var i = 0; i < $faxQueue.length; i++) {
					    _.CtiSendFAX($faxQueue[i], _.faxOptions.tifFile);
				    }
			    }
		    }

		    if(confirmed) {
			    return 'SEND_BEGIN';
		    } else {
			    _.faxOptions = {};
			    return 'SEND_CANCEL';
		    }
	    }
	}
});