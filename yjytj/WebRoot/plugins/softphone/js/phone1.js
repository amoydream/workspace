
/***
 * 全局变量 
*/
var display = jQuery('#total');


//日志方法
function write(x) {
  console.log(x);
}
// 增加原来的结果值
function changeDisplayVal(i) {
  display.val(display.val() + i);
}

// 设置结果值
function setDisplayVal(x) {
  display.val(x);
}
// 触碰按钮动画
function animateButton(obj) {
  var button = obj.addClass('hovering');
  setTimeout(function() {
      button.removeClass('hovering');
  }, 100);
}


//返回键
function backspace() {
  if ( display.val() !== '') {
    display.val( display.val().substring(0, display.val().length - 1) );
  }
}

/**
 ** 点击键盘事件
*/

//点击输入键
jQuery('.dial_int').each(function() {
  jQuery(this).click(function() {
    var value = jQuery(this).val();
    changeDisplayVal(value);	
  });
});


//拨打电话
jQuery('#phone_dial').click(function() {
	callDial(display.val());
});

//挂机
jQuery('#phone_hangup').click(function() {
	CtiSeatHangUP();
});

// 通讯录
jQuery('#phone_books').click(function() {
	showBlock("the-left","通讯录","Main/turn/getBook");
});
// 短消息
    var winsms = 0;
jQuery('#phone_sms').click(function() {	
	 if(winsms)
	   {
	     if(!winsms.closed)
	    	 winsms.close();
	   }
	var url = 'Main/turn/getSms';
	var name='newwindow1';                    //网页名称，可为空; 
    var iWidth=951;                          //弹出窗口的宽度; 
    var iHeight=600;                         //弹出窗口的高度; 
    //获得窗口的垂直位置 
    var iTop = (window.screen.availHeight - 30 - iHeight) / 2; 
    //获得窗口的水平位置 
    var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; 
    winsms = window.open(url, name, 'height=' + iHeight + ',innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no'); 
	//右侧发送短信调用通讯簿
	//window.open('Main/turn/getSms', 'newwindow1', 'height=600, width=951, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
	jQuery('#right-book').click(function() {
		smsClick();
	});
});
//一键拨打
jQuery('#speed_dial').click(function() {	
	showBlock('the-right','一键拨打','Main/turn/getSpeedDial');	
});

//通讯历史
jQuery('#phone_record').click(function() {
	showBlock('the-left','通讯历史','Main/turn/getAllDialRecord');
});

//录音
jQuery('#phone_voice').click(function() {
	showBlock('the-right','录音','Main/turn/getDialVoice');
});

//清除键
jQuery('#phone_clear').click(function() {
	setDisplayVal('');
});

//关闭左侧
jQuery('#phone_left_close').click(function() {
	$('#the-left').dialog('close');
});

jQuery('#phone_right_close').click(function() {
	$('#the-right').dialog('close');
});

//span关闭左侧
jQuery('#left_close').click(function() {
	hideBlock('the-left');
});


//span关闭右侧
jQuery('#right_close').click(function() {
	hideBlock('the-right');
});

// click backspace
jQuery('#phone_back').click(function() {
  backspace();
});


/*
** 按键拨打事件
*/
// keydown for backspace and return
jQuery(document).keydown(function (e) {
  // the character code
  var charCode = e.which;
  // return
  if ( charCode === 13 ) {
	  var number = display.val();
	if((number!=null&&number!='')||$('#rightsms-textarea').is(':focus')){	
		animateButton(jQuery('#phone_dial'));
		callDial(number);
		return false;
	}else{
		return true;
	} 
  }
});

//电话号输入事件
function keyEvents(){
	  var keyCode = event.keyCode;  
	  var key = String.fromCharCode(keyCode);
	  if(event.shiftKey&&event.keyCode==51){
		  key='#';
	  }
	  if(event.keyCode==8){
		  key='backspace';
	  }
	  if(event.keyCode==46){
		  display.val('');
		  key='delete';
	  }
	  if(event.shiftKey&&event.keyCode==56){
		  key='*';
	  }
	  if (keyCode===8||keyCode===35||keyCode===42||keyCode===46||(keyCode >= 48 && keyCode <= 57)){  
		  jQuery('#the-buttons button').each(function() {
			    var value = jQuery(this).val();
			    if ( value === key ) {
			      animateButton(jQuery(this));
			    }
			  });
		 event.returnValue = true;    
	  }else {    
		 event.returnValue = false;    
	  }    
}


function smsClick(){
	alert("cheshi");
	$("#_smsNumberDialog").dialog({
		title:'联系人',
		width: 800,
		height: 400,
		href:"Main/softphoneone/getSmsBook",
		buttons: []
		});
}

//显示
 var winshow = 0;
function showBlock(id,title,url){ 
	if(winshow)
	{
	   if(!winshow.closed)
	       winshow.close();
	}
    var name='newwindow';                            //网页名称，可为空; 
    var iWidth=351;                          //弹出窗口的宽度; 
    var iHeight=600;                         //弹出窗口的高度; 
    //获得窗口的垂直位置 
    var iTop = (window.screen.availHeight - 30 - iHeight) / 2; 
    //获得窗口的水平位置 
    var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; 
    winshow = window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no'); 
	//window.open(url, 'newwindow', 'height=600, width=351, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
	 
  }

//隐藏
function hideBlock(id){ 	
	 $("#"+id).removeClass("effeckt-show"); 
  } 
//拨打电话入口
function callDial(num){
	callout(num,null);
}