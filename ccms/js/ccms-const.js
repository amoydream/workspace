$.extend(true, {
	ccms : {
	    MSG : {
	        SYS_MSG : '系统消息> ',
	        WS_NOT_SUPPORT : '浏览器不支持WebSocket',
	        WS_CONTECTED : '已连接',
	        EV_MSG : '事件消息> ',
	        ONCALLENDED : '电话结束> ',
	        ONCALLIN : '电话呼入> ',
	        ONCALLOUT : '电话呼出> ',
	        ONUGRPSTATUS : '技能组态> ',
	        ONSEATLINK : '坐席分转> ',
	        ONSEATSTATUS : '坐席状态> ',
	        SESSIONCONNECTED : '联接信息> ',
	        OTHERMSG : ', 其他信息> ',
	        CALLID : ', 记录编号: ',
	        SEATCALLID : ', 记录编号: ',
	        CHANNELNO : ', 通道号: ',
	        ACTM : ', : ',
	        ACTS : ', 电路消息: ',
	        CCID : ', 主叫号: ',
	        CEID : ', 被叫号: ',
	        CALLVOCNO : ', 录音号: ',
	        DATETIME : ', 记录时间: ',
	        OUTCTIME : ', 外拨时间: ',
	        RECDTIME : ', 记录时长: ',
	        TOTALTIME : ', 总时长: ',
	        WAITTIME : ', 等待时长: ',
	        TALKTIME : ', 通话时长: ',
	        VOCRECDFILE : ', 文件路径: ',
	        FAXST : ', 传真状态: ',
	        UGRPNO : ', 技能组号: ',
	        UGRPBANE : ', 技能组名: ',
	        ACDM : ', 排队: ',
	        SEATMAXNUM : ', 坐席总数: ',
	        SEATFREENUM : ', 开通数: ',
	        USERID : ', 用户编号: ',
	        USERNAME : ', 用户名称: ',
	        SEATIP : ', 坐席IP: ',
	        OPENTIME : ', 开通时长',
	        SEATSTATUS : ', 坐席状态',
	        CALLLEVEL : ', 拨打权限: ',
	        OPLEVEL : ', 操作权限: ',
	        OUTCALLCOUNT : ', 外拨次数: ',
	        CONNECTCOUNT : ', 连接数: ',
	        UNCONNECTCOUNT : ', 未连接数: '
	    },

	    ERROR : {
		    CONNECT_FAILED : '呼叫中心连接失败'
	    },

	    API : {
		    FAXS : 'FAXS'
	    },

	    LEVEL : {
	        ADMIN : 1,
	        OFFICER : 2,
	        MONITER : 3,
	        OPERATOR : 4
	    },

	    ACTION : {
	        CTI_SEAT_CALL : 'CtiSeatCALL',
	        CTI_SEND_FAX : 'CtiSendFAX',
	        CTI_RECV_FAX : 'CtiRecvFAX',
	        CTI_OPEN : 'CtiOpen',
	        CTI_CLOSE : 'CtiClose',
	        CTI_SEAT_LOGIN : 'CtiSeatLogin',
	        CTI_SEAT_LOGOUT : 'CtiSeatLogout',
	        CTI_SEAT_HANDUP : 'CtiSeatHangUP',
	        CTI_SEAT_SET_BYSY : 'CtiSeatSetBusy',
	        CTI_SEAT_SET_FREE : 'CtiSeatSetFree',
	        CTI_GET_SEAT_LIST : 'CtiGetSeatList',
	        CTI_RECALL : 'CtiReCALL',
	        CTI_SEAT_HOLD : 'CtiSeatHold',
	        CTI_SEAT_SWITCH : 'CtiSeatSwitch',
	        CTI_SEAT_MEETING : 'CtiSeatMeeting',
	        CTI_SEAT_SDFAX : 'CtiSeatSDFAX',
	        CTI_VOC_REPLAY : 'CtiVocRePlay',
	        CTI_ICR_CALL : 'CtiIVRCall',
	        CTI_SEAT_IVR : 'CtiSeatIVR',
	        CTI_CALL_IVR : 'CtiCallIVR',
	        CTI_SEAT_API : 'CtiSeatAPI',
	        CTI_CALL_API : 'CtiCallAPI',
	        CTI_SET_ACDMH : 'CtiSetACDMH',
	        CTI_SET_ACDMC : 'CtiSetACDMC',
	        CTI_SET_IVRMEM : 'CtiSetIVRMEM',
	        CTI_SET_IVRMEM2 : 'CtiSetIVRMEM2'
	    },

	    EVENT : {
	        ON_CALL_ENDED : 'OnCallEnded',
	        ON_CALL_IN : 'OnCallIN',
	        ON_CALL_OUT : 'OnCallOut',
	        ON_UGRP_STATUS : 'OnUGRPStatus',
	        ON_SEAT_LINK : 'OnSeatLink',
	        ON_SEAT_STATUS : 'OnSeatStatus',
	        ON_IVR_BIOS : 'OnIVRBIOS',
	        ON_SEAT_LIST : 'OnSeatList',
	        ON_SESSION_CONNECTED : 'SessionConnected'
	    },

	    CASE : {
	        CASE_1 : '坐席分转',
	        CASE_2 : '坐席摘机',
	        CASE_3 : '坐席未接',
	        CASE_4 : '坐席结束',
	        CASE_5 : '坐席外呼'
	    },

	    CALL : {
	        CALL_CONFIRM : '点击【确定】拨打电话',
	        CALL_INVALID_NO : '电话号码【_TEL_】格式错误'
	    },

	    FAX : {
	        SEND_CONFIRM : '点击【确认】发送传真',
	        SEND_CONFIRM_CALL : '请在听到传真音后点击【确定】发送传真',
	        SEND_WAITFOR : '请等待当前传真任务完成',
	        SEND_NO_FAXNO : '未提供传真号码',
	        SEND_NO_FILE : '未提供传真文件',
	        SEND_CANCEL : '取消发送',
	        SEND_BEGIN : '开始发送',
	        SEND_COMPLETE : '发送完毕',
	        SEND_ALL_COMPLETE : '全部发送完毕',
	    }
	}
});

$.ccms = window._ = $.ccms;
$.ccms.MSG = window._M = $.ccms.MSG;