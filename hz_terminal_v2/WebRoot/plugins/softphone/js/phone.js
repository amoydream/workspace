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
  /*$('#the-left').slideToggle(2000);*/
	var emt = "<div style='margin: 8px 13px;'>";
	emt += "<select id='input-select' class='input-select'>";
	emt += "</select>";
	emt += "<button type='button' class='btn btn-success' onclick='sureNumber();'>确定</button>";
    emt += "</div>";
    emt += "<div id='left-book-data'>";
	emt += "<iframe src='Main/softphone/getBook' width='100%' height='700'";
	emt += "frameborder='0' scrolling='auto'></iframe>";
    emt += "</div>";
    $("#left-data").empty();
    $("#left-data").append(emt);
	showBlock('the-left');
});
// 短消息
jQuery('#phone_sms').click(function() {
	/*$('#the-left').slideToggle(2000);*/
	var emt = "<div>";	
	 emt +="<div class='right-number-book'>";
	 emt +="<img id='right-book' style='margin-right:10px;border:none;' height='20px' width='20px' src='plugins/softphone/images/contacts_book.png'/>";
	 emt +="<span style='font-weight: bold;'>通讯录</span>";
	/* emt +="<span id='right-book' class='glyphicon glyphicon-book'></span>";*/
	 emt +="<a class='a-text' href='javascript:;'>号码总数<span id='mobilecounts' class='span-badge'>0</span></a>";
	 emt +="</div>";
	 emt +="<div class='right-number-area'>";
	 emt +="<ul id='results_number'>";
	 emt +="</ul>";
	 emt +="</div>";
	 emt +="<div style='margin:6px 2px;'>";
	 emt +="<input id='rightsms-input-add' class='input-text' type='text' placeholder='添加发送号码...'></input>";
	 emt +="<button type='button' class='btn btn-success' onclick='addNumber();'>添加</button>";
	 emt +="</div>";
	 emt +="<div style='margin:6px 2px;'>";
	 emt +="<button id='rightsms-btn-delete' class='btn btn-warming' onclick='deleteSelect();'>删除选定</button>";
	 emt +="<button class='btn btn-danger' onclick='clearAllNumber();'>清空</button>";
	 emt +="</div>";
	 emt +="</div>";
	 emt +="<div>";
	 emt +="<textarea id='rightsms-textarea' class='textarea-text' rows='10'></textarea>";
	 emt +="<div style='margin:6px 2px;'>";
	 emt +="<button class='btn btn-warming' onclick='clearMsg();'>清空</button>"; 
	 emt +="<button type='button' class='btn btn-success' onclick='sendSms();'>发送</button>";
	 emt +="</div>";
	 emt +="</div>";
	$("#right-data").empty();
	$("#right-data").append(emt);
	//右侧发送短信调用通讯簿
	jQuery('#right-book').click(function() {
		smsClick();
	});
	showBlock('the-right');
	//smsClick();
});
//一键拨打
jQuery('#speed_dial').click(function() {
	/*$("#right-data").empty();
	$("#right-data").append("一键拨打");*/
	$.post("Main/softphone/getBookXls",{},function(result){
		if(result.success){
			var str = "<div id='right-speed-div' class='right-speed-div'>";
			for(var i=0;i<result.datalist.length;i=i+2){
                str += "<div class='right-speed-btn-div'>";
				str += "<button class='sbutton blue' data-num='"+result.datalist[i].number+"' onclick='speedDial(this);'>"+result.datalist[i].name+" "+result.datalist[i].number+"</button>";
				if(i+1<result.datalist.length){		
				str += "<button class='sbutton blue' data-num='"+result.datalist[i+1].number+"' onclick='speedDial(this);'>"+result.datalist[i+1].name+" "+result.datalist[i+1].number+"</button>";
				}
				str += "</div>";
			}
			str += "</div>";
			str += "<div class='right-speed-edit-div'>";
			str += "<button type='button' class='btn btn-success' onclick='editSpeedDial();'>编辑</button>";
			str += "</div>";
			$("#right-data").empty();
			$("#right-data").append(str);
		}
	});	
	
	showBlock('the-right');	
});

//通讯历史
jQuery('#phone_record').click(function() {
	var emt = "<iframe src='Main/softphone/getAllDialRecord' width='100%' height='99.5%' style='overflow-y:scroll;'";
	    emt += "frameborder='0' scrolling='auto'></iframe>";
	$("#left-data").empty();
	$("#left-data").append(emt);
	showBlock('the-left');
});

//录音
jQuery('#phone_voice').click(function() {
	var emt = "<iframe src='Main/softphone/getYDialRecord' width='100%' height='99.5%' style='overflow-y:scroll;'";
    emt += "frameborder='0' scrolling='auto'></iframe>";
	$("#right-data").empty();
	$("#right-data").append(emt);
	showBlock('the-right');
});

//清除键
jQuery('#phone_clear').click(function() {
	setDisplayVal('');
});

//关闭左侧
jQuery('#phone_left_close').click(function() {
	hideBlock('the-left');
});

jQuery('#phone_right_close').click(function() {
	hideBlock('the-right');
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
	$("#_smsNumberDialog").dialog({
		title:'联系人',
		width: 800,
		height: 400,
		href:"Main/softphone/getSmsBook",
		buttons: []
		});
}

//显示
function showBlock(id){ 
	/* $("#"+id).show(); */
	 $("#"+id).css('visibility','visible');
	/* $("#"+id).addClass("from-below"); */
	 setTimeout(function(){$("#"+id).addClass("effeckt-show");},300); 
  }

//隐藏
function hideBlock(id){ 	
	 $("#"+id).removeClass("effeckt-show"); 
  } 
//拨打电话入口
function callDial(num){
	callout(num,null);
}