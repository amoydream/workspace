var cti,vo_Code,mcode='7980003',fcode='7988100';
/**
 * 记录语音日志
 */
function AddLog(text) {
 $.post("system/voice/write",{text:text},function(data,status){});
}

/**
 * 初始化语音中间件
 */
function init() {
	vo_Code = $("#main_vo_Code").val();
	if(cti==null){
		cti = document.getElementById('callCenter');
		cti.attachEvent('OnLinkStatus', OnLinkStatus); // 监听语音状态
	    cti.attachEvent('OnSeatLINK', OnSeatLINK);  //坐席电话分转通知
		cti.attachEvent('OnCallEnded', OnCallEnded); // 挂机事件
		//setTimeout(CtiOpen(), 5000);
		CtiOpen();
	}
	
}
/**
 * 系统接口初始化
 */
function CtiOpen() {
	var retVal = cti.CtiOpen(GetValue('cti1IP'), GetValue('cti1Pswd'),
			GetValue('cti1AgentId'), "");
	if (retVal >= 0) {
		AddLog('CtiOpen> 系统接口初始化--成功' + retVal);
		msgsuc(retVal);
	} else {
		AddLog('CtiOpen> 系统接口初始化--失败' + retVal);
		/*layer.open({
			skin: 'layui-layer-molv',
		    closeBtn: 1,
		    shade: [0],
		    area: ['200px', '200px'],
		    offset: 'rb', //右下角弹出
		    shift: 2,
		    content: '请刷新网页重新连接！'
		});*/
		windowNoAutoOut('请刷新网页重新连接！');
	}
}
function msgsuc(retVal){
	if(retVal>0){
		var msg = '';
		if(retVal==10001){
			msg = "系统重新启动";
		}else if(retVal==10002){
			msg = "设备驱动正常";
		}else if(retVal==10003){
			msg = "关闭设备连接";
		}else if(retVal==10004){
			msg = "设备连接中..";
		}else if(retVal==10005){
			msg = "读设备信息OK";
		}else if(retVal==10006){
			msg = "读系统信息OK";
		}else if(retVal==10007){
			msg = "读系统信息XX";
		}else if(retVal==10008){
			return;
			msg = "系统运行正常";
		}else if(retVal==10009){
			msg = "系统未经授权";
		}else if(retVal==10010){
			msg = "系统已经关闭";
		}else{
			msg = "语音连接成功，可以使用系统打电话了！";
		}
		/*layer.open({
			skin: 'layui-layer-molv',
		    closeBtn: 1,
		    shade: [0],
		    area: ['200px', '200px'],
		    offset: 'rb', //右下角弹出
		    shift: 2,
		    content: '语音连接成功，可以使用系统打电话了！'
		});*/
		windowAutoOut(msg);
	}else{
		/*layer.open({
			skin: 'layui-layer-molv',
		    closeBtn: 1,
		    shade: [0],
		    area: ['200px', '200px'],
		    offset: 'rb', //右下角弹出
		    shift: 2,
		    time: 5000,
		    content: '语音正在连接中，请耐心等待！'
		});*/
		windowAutoOut('语音正在连接中，请耐心等待！');
	}
}
/**
 * 弹出框手动消失
 * @param msg
 */
function windowNoAutoOut(msg){
	layer.open({
		skin: 'layui-layer-molv',
	    closeBtn: 1,
	    shade: [0],
	    area: ['200px', '200px'],
	    offset: 'rb', //右下角弹出
	    shift: 2,
	    content: msg
	});
}
/**
 * 弹出框自动消失
 * @param msg
 */
function windowAutoOut(msg){
	layer.open({
		skin: 'layui-layer-molv',
		closeBtn: 1,
		shade: [0],
		area: ['200px', '200px'],
		offset: 'rb', //右下角弹出
		shift: 2,
		time: 1000,
		content: msg
	});
}
/**
 * 注销语音中间件
 */
function uninit() {
	cti.detachEvent('OnLinkStatus', OnLinkStatus);
	cti.attachEvent('OnSeatLINK', OnSeatLINK);
	cti.detachEvent('OnCallEnded', OnCallEnded);
	CtiClose();
}

/**
 * 根据ID获取值
 */
function GetValue(id) {
	return document.getElementById(id).value;
}

/**
 * 系统接口注销
 */
function CtiClose() {
    var retVal = cti.CtiClose();
	if (retVal >= 0) {
		AddLog('CtiOpen> 系统接口注销--成功' + retVal);
	} else {
		AddLog('CtiOpen> 系统接口注销--失败' + retVal);
	}
}
/**
 * 监听语音状态
 * @param LinkStatus
 */
function OnLinkStatus(LinkStatus) {
	msgsuc(LinkStatus);
	AddLog('CTI连接状态> ' + LinkStatus);
	
}

/**
 * 電話接入
 * @param CallID  通道
 * @param ChannelNO 被叫號
 * @param CEID   被叫号
 * @param CCID   主叫号
 */
function OnCallIN(CallID, ChannelNO, CEID, CCID) {
	var myDate = new Date();
	AddLog('电话接入> ' + 'ID:' + CallID + ' 通道:' + ChannelNO + ' 被叫号:' + CEID
			+ ' 主叫号:' + CCID+'  '+myDate);
	
}
/**
 * 電話呼出
 * @param CallID   電話識別ID
 * @param ChannelNO  通道
 * @param CEID   被叫號
 * @param CCID   主叫號
 */
function OnCallOUT(CallID, ChannelNO, CEID, CCID) {
	var myDate = new Date();
	AddLog('电话呼出> ' + 'ID:' + CallID + ' 通道:' + ChannelNO + ' 被叫号:' + CEID
			+ ' 主叫号:' + CCID+'  '+myDate);
}

/**
 * 電話呼入彈窗
 * @param CEID 主叫號碼
 */
var callIn_dialog;
function openCallIn(CCID){
	callIn_dialog = layer.open({
        type: 2,
        title: '电话呼入',
        closeBtn: 0,
        shadeClose: true, //点击遮罩关闭层
        area : ['400px' , '240px'],
        content: ['system/voice/callIn?CCID='+CCID,'no']
    });
	
}
function layer_close(index){
	layer.close(index);
}
/**
 * 電話呼出彈窗
 * @param CEID 被叫號碼
 */
var callOut_dialog;
function openCallOut(CEID){
	callOut_dialog = layer.open({
        type: 2,
        title: '电话呼出',
        closeBtn: 0,
        shadeClose: true, //点击遮罩关闭层
        area : ['400px' , '240px'],
        content: ['system/voice/callOut?CEID='+CEID,'no']
    });
}


/**
 * 電話掛機
 * @param CallID  
 * @param ChannelNO  通道
 * @param CEID   被叫号
 * @param CCID   主叫号
 * @param CallVocNO  
 * @param BusinessID
 * @param UGRPNO
 * @param USERID
 * @param TotalTime  总时
 * @param WaitTime   等待
 * @param TalkTime   联通
 * @param OutCallTime  外呼
 * @param ActAs
 * @param Actions
 * @param RecdFile 录音文件全路径名
 * @param CallFEER 接收传真返回的状态，8888:发送成功,9999:接收成功
 */
$status = 1;
var faxLayer;  //接收传真弹窗layer的index
function OnCallEnded(CallID, ChannelNO, CEID, CCID, CallVocNO, BusinessID, UGRPNO, USERID, TotalTime, WaitTime, TalkTime, OutCallTime, ActAs, Actions, RecdFile, CallFEER, CallFEES) {
	AddLog('电话结束> ' + ' CallID:' + CallID + ' 通道:' + ChannelNO + ' 被叫号:' + CEID + ' 主叫号:' + CCID + ' CallVocNO:' + CallVocNO + 
			' 总时:' + TotalTime + ' 等待:' + WaitTime + ' 联通:' + 
			TalkTime + ' 外呼:' + OutCallTime + ' 传真监控信息:' + Actions+"  ActAs:"+ActAs+"  BusinessID:"+BusinessID + " 传真返回值" +CallFEER);
	if(vo_Code.indexOf(CEID)>=0 || vo_Code.indexOf(CCID)>=0){
		$.post("system/voice/add",{vo_callid:CallID,vo_channelno:ChannelNO,vo_ceid:CEID,vo_ccid:CCID,vo_totalTime:TotalTime,
			vo_waitTime:WaitTime,vo_talkTime:TalkTime,vo_outCallTime:OutCallTime,
			vo_actAs:ActAs,vo_actions:Actions,vo_Code:vo_Code,vo_CallFEER:CallFEER,callVocNO:CallVocNO,eventId:eventid},function(data,status){});
	}
	if(mcode==CCID || mcode==CEID){
		$.post("system/voice/add",{vo_callid:CallID,vo_channelno:ChannelNO,vo_ceid:CEID,vo_ccid:CCID,vo_totalTime:TotalTime,
			vo_waitTime:WaitTime,vo_talkTime:TalkTime,vo_outCallTime:OutCallTime,
			vo_actAs:ActAs,vo_actions:Actions,vo_Code:vo_Code,vo_CallFEER:CallFEER,callVocNO:CallVocNO,eventId:eventid},function(data,status){});
	}
	//传真
	if(CallFEER==9999||CallFEER==8888){
		$.post("system/voice/add",{vo_callid:CallID,vo_channelno:ChannelNO,vo_ceid:CEID,vo_ccid:CCID,vo_totalTime:TotalTime,
			vo_waitTime:WaitTime,vo_talkTime:TalkTime,vo_outCallTime:OutCallTime,
			vo_actAs:ActAs,vo_actions:Actions,vo_Code:vo_Code,vo_CallFEER:CallFEER,callVocNO:CallVocNO,eventId:eventid},function(data,status){});
	    if(CallFEER==9999){
	    	$.post("system/voice/iffileexist",{callid:CallID},function(j) {
				if (j.success) {
					faxLayer = layer.open({
						skin: 'layui-layer-molv',
					    closeBtn: 1,
					    shade: [0],
					    area: ['200px', '200px'],
					    offset: 'rb', //右下角弹出
					    shift: 2,
					    content: "<a onclick='tofax()' href='javascript:void(0);' >接收到新传真！点我跳转</a><audio id='faxRing' autoplay='true' loop='loop' hidden='hidden' src='upload/faxRing.mp3'/>"
					});
				} 
			}, 'json');
	    }
	    if(CallFEER==8888){
	    	layer.open({
				skin: 'layui-layer-molv',
			    closeBtn: 1,
			    shade: [0],
			    area: ['200px', '200px'],
			    offset: 'rb', //右下角弹出
			    shift: 2,
			    content: '传真发送成功！'
			});
	    }
	}
	$status = 0;
	if(callOut_dialog!=undefined){
		layer_close(callOut_dialog);
		callOut_dialog = undefined;
		return;
	}
	if(callIn_dialog!=undefined){
		layer_close(callIn_dialog);
		callIn_dialog = undefined;
		return;
	}
	
}


/**
 * 坐席登錄
 */
function CtiSeatLogin() {
    var retVal = cti.CtiSeatLogin(GetValue('cti2AgentId'), GetValue('cti2UserId'), GetValue('cti1Pswd'), GetValue('cti2GroupNo'), GetValue('cti2OperateLevel'), 9, "");
    AddLog('CtiSeatSysLogin> ' + ' SEATID:' + GetValue('cti2AgentId') + ' 返回值(' + retVal + ')');
}

/**
 * 坐席登出
 */
function CtiSeatLogout() {
    var retVal = cti.CtiSeatLOGOUT(GetValue('cti2AgentId'));
    AddLog('CtiSeatLOGOUT> ' + ' SEATID:' + GetValue('cti2AgentId') + ' 返回值(' + retVal + ')');
}

function OnSeatLINK(CaseNo, SEATID, SeatCallID, CallID, ChannelNO, CEID, CCID, CallVocNO, BusinessID, GUESTNAME, USERID, UserNAME, UGRPNO, SeatIP, WaitTime, TalkTime) {
	var FunName;
    switch (CaseNo) {
        case 1:
            FunName = '分转坐席';
            break;
        case 2:
            FunName = '坐席摘机';
            var index = callIn_dialog;
       	    var audio = $("#layui-layer-iframe"+index).contents().find("#telRing")[0]
            audio.pause();
            break;
        case 3:
            FunName = '坐席未接';
            var index = callIn_dialog;
       	    var audio = $("#layui-layer-iframe"+index).contents().find("#telRing")[0]
            audio.pause();
            break;
        case 4:
            FunName = '坐席结束';
            break;
        case 5:
            FunName = '坐席外呼';
            break;
        default:
            FunName = '其他情况';
            break;
    }
    log(CaseNo, SEATID, SeatCallID, CallID, ChannelNO, CEID, CCID, CallVocNO, BusinessID, GUESTNAME, USERID, UserNAME, UGRPNO, SeatIP, WaitTime, TalkTime);
    AddLog(FunName + '> ' + '坐席ID:' + SEATID + ' 通道:' + ChannelNO + ' 被叫号:' + CEID + ' 主叫号:' + CCID + '(' + GUESTNAME + ') ' + CallID + ' 组:' + UGRPNO + ' 接线员:' + USERID + '-' + UserNAME + ' [' + CallVocNO + '] 转接人工服务时等待时长（秒）：('+WaitTime+')人工服务通话时长（秒）:('+TalkTime+')');
    
}

function aaa(){
	//console.info(11);
    log(2,8801,12385,12386,63,0752-2383888,8801,12386,'','','','',0,'172.12.10.183#49778',18,0);
}

function log(CaseNo, SEATID, SeatCallID, CallID, ChannelNO, CEID, CCID, CallVocNO, BusinessID, GUESTNAME, USERID, UserNAME, UGRPNO, SeatIP, WaitTime, TalkTime){
	if(CaseNo==1){//分转坐席
		if(vo_Code.indexOf(SEATID)>=0){//电话呼入
			if(callIn_dialog==undefined){
				openCallIn(CCID);
			}
			
			return;
		}
	}
	if(CaseNo==5){
		if(vo_Code.indexOf(SEATID)>=0){//电话呼出
			openCallOut(CEID);
			return;
		}
		if(vo_Code.indexOf(CEID)>=0){//电话呼入
			if(callIn_dialog==undefined){
				openCallIn(CCID);
			}
			return;
		}
	}
	if(CaseNo==2){//坐席摘机
		/*if(vo_Code.indexOf(CEID)>=0){
			alarmDo(CallID,CCID,CallVocNO);
		}*/
		
		if(vo_Code.indexOf(SEATID)>=0){//判断分机号
			if(mcode==CEID){//判断被叫号码
				alarmDo(CallID,CCID,CallVocNO);
			}
		}
		
		if(callIn_dialog!=undefined){
			layer_close(callIn_dialog);
			callIn_dialog = undefined;
			return;
		}
		if(callOut_dialog!=undefined){
			layer_close(callOut_dialog);
			callOut_dialog = undefined;
			return;
		}
		
	}
	if(CaseNo==3 || CaseNo==4){//坐席未接,坐席结束
		if(callIn_dialog!=undefined){
			layer_close(callIn_dialog);
			callIn_dialog = undefined;
			return;
		}
		if(callOut_dialog!=undefined){
			layer_close(callOut_dialog);
			callOut_dialog = undefined;
			return;
		}
	}
}
/**
 * 打出电话
 * @param to 呼出的电话
 */
function callOut(to){
	var me = "";
	if(vo_Code.indexOf(",")>=0){
		me = vo_Code.substring(0,vo_Code.indexOf(","));
	}else{
		me = vo_Code;
	}
	to = String(to);
	var main_callOut = layer.confirm('点击【确定】拨打【' + to + '】', {
	    btn: ['确定','取消'] //按钮
	}, function(){
		if(to.length>6){
			if(to.indexOf("-")>=0){
				to = to.replace("-","");
			}
    		//to = 9+to;
    	}else if(to.length<1){
    		layer.msg('电话号码格式错误', {icon: 1});
    	}
        var retVal = cti.CtiSeatCALL(to, me, "", "");
        AddLog('CtiSeatCALL>' + ' SEATID:'+me+' 返回值(' + retVal + ')');
        layer.close(main_callOut);
	}, function(){
	    
	});
}
/**
 * 打出电话
 * @param to 呼出的电话
 * @param id 事件的ID
 */
var eventid = 0;
function callOut(to,id){
	if(id>0){
		eventid = id;
	}
	var me = "";
	if(vo_Code.indexOf(",")>=0){
		me = vo_Code.substring(0,vo_Code.indexOf(","));
	}else{
		me = vo_Code;
	}
	to = String(to);
	//alert(to);
	var main_callOut = layer.confirm('点击【确定】拨打【' + to + '】', {
	    btn: ['确定','取消'] //按钮
	}, function(){
		if(to.length>6){
			if(to.indexOf("-")>=0){
			    to = to.replace("-","");
			}
    		//to = 9+to;
    	}else if(to.length<1){
    		layer.msg('电话号码格式错误', {icon: 1});
    	}
        var retVal = cti.CtiSeatCALL(to, me, "", "");
        AddLog('CtiSeatCALL>' + ' SEATID:'+me+' 返回值(' + retVal + ')');
        layer.close(main_callOut);
	}, function(){
	    
	});
}

/**
 * 电话摘机弹出事件
 * @param CallID 录音文件id
 * @param CCID 主叫号
 * @param CallVocNO 文件名
 */
var call_check;
function alarmDo(CallID,CCID,CallVocNO)  {
	call_check = layer.open({
		type : 2,
		title : '事件列表',
		area : [ '900px', '500px' ],
		scrollbar : false,
		content : [ 'event/eventinfo/list2?ev_reportPhone=' + CCID+'&CallID='+CallID]
	});
}


/**
 * 
 * @param FaxNum 传真号码
 * @param FileName 传真文件名
 */
function CtiCallSendFax(FaxNum,FileName) {
	//onCallEnd("19999", "63", "8825", "8821", "", BusinessID, UGRPNO, USERID, TotalTime, WaitTime, TalkTime, OutCallTime, ActAs, Actions)
	var retVal = cti.CtiSendFaxCALL(FaxNum,FileName,"","");
    AddLog('CtiSendFaxCALL>' + ' CallNum:' + FaxNum+' FaxFile:'+FileName+' 返回值(' + retVal + ')');
    return retVal;
}

/**
 * 接收到传真弹窗，点击窗口文字跳转到传真调度页面
 */
function tofax(){
	parent.tabs_open2("tab_fax","传真调度","dutymanage/fax/main",1);
	layer.close(faxLayer);
}


/**
 * 呼出转传真
 * @param to
 */
function callOutSend(to){
	var me = "";
	if(vo_Code.indexOf(",")>=0){
		me = vo_Code.substring(0,vo_Code.indexOf(","));
	}else{
		me = vo_Code;
	}
	to = String(to);
	
	if(to.length>6){
		if(to.indexOf("-")>=0){
			to = to.replace("-","");
		}
		//to = 9+to;
	}else if(to.length<1){
		layer.msg('请输入正确的电话号码！', {icon: 1});
	}
    var retVal = cti.CtiSeatCALL(to, me, "", "");
    AddLog('CtiSeatCALL>' + ' SEATID:'+me+' 返回值(' + retVal + ')');
    
    return me;
}

