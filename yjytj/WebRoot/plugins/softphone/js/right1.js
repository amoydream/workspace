/**
 * 短消息
 */
//添加电话号
function addNumber(){
	var value = $("#rightsms-input-add").val();
	var numbers = $("#results_number input[name='number']");
	var flag = true;
	if(checkPhone(value)==false){
		alert("您添加的号码有误！");
		return;
	}	
	numbers.each(function(){
		if($(this).val()==value){	
			$.lauvan.MsgShow({msg:'该号码已经添加!'});
			flag = false;
			return;
		}
		
	});
	if(flag==true){		
		$("#mobilecounts").text(parseInt($("#mobilecounts").text())+1);
		$("#results_number").append("<li><input type='hidden' name='number' value='"+value+"'></input><span>"+value+"</span></li>");
		$("#results_number li").click(function() {
			$("#results_number li").removeClass("active");
			$(this).addClass("active");
		});
	}
}


$("#results_number li").click(function() { 
	$("#results_number li").removeClass("active");
	$(this).addClass("active");
});
//删除电话号
function deleteSelect(){	
	$("#results_number li.active").remove();
	$("#mobilecounts").text(parseInt($("#mobilecounts").text())-1);
}
//清空所有电话号
function clearAllNumber(){
	$("#results_number").empty();
	$("#mobilecounts").text(0);
}

function clearMsg(){
	$("#rightsms-textarea").val('');
}
//验证手机号
function checkPhone(num){ 
    if(!(/^1[34578]\d{9}$/.test(num))){ 
        return false; 
    } 
}
//发送短信
function sendSms(){
	var content = $("#rightsms-textarea").val();
	var numbers = $("#results_number input[name='number']");
	console.info(numbers);
	var smsnum = '';
	numbers.each(function(){
		if(checkPhone($(this).val())==false){
	        alert($(this).val()+",该手机号码有误！");  
			return;
		}
		if(smsnum!=''){
			smsnum = smsnum+","+$(this).val();
		}else{
			smsnum = $(this).val();	
		}
	});
	if(smsnum==null||smsnum==''){
		alert("手机号为空！");
		return;
	}
	if(content==null||content==''){
		alert("内容为空！");
		return;
	}
	 $.post("Main/softphoneone/getSendSms",{smsnum:smsnum,smscontent:content},function(result){
	       if(result.success){
	    	   $.lauvan.MsgShow({msg:result.msg}); 
	       }else{
	    	   $.lauvan.MsgShow({msg:result.msg}); 
	       }
	    });
}

/**
 * 一键拨号*/
//获取所有号码
function editSpeedDial(){
	
	window.open("Main/softphoneone/getEditXls");
}

//一键拨打方法
function speedDial(obj){
	var number = $(obj).attr("data-num");
	if(number==null||number==''){
		$.lauvan.MsgShow({msg:'您的号码有误'}); 	
		return;
	}
	callDial(number);
}


