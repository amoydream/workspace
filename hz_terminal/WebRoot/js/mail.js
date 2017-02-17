//采用jquery easyui loading css效果   
function ajaxLoading(){   
    $("<div class=\"datagrid-mask\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("body");   
    $("<div class=\"datagrid-mask-msg\"></div>").html("正在处理，请稍候。。。").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});   
 }   
 function ajaxLoadEnd(){   
     $(".datagrid-mask").remove();   
     $(".datagrid-mask-msg").remove();               
} 
function check_mail(mail) {
	if(mail == null || typeof mail != 'string' || mail.trim() == '') {
		return false;
	}

	var reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
	if(!reg.test(mail)) {
		return false;
	}
	return true;
}

function mailSubmit(formID){
		$('#'+formID).form('submit',{
			onSubmit:function(){
				var fboolean = $(this).form('enableValidation').form('validate');
				if(!fboolean){
					$.messager.alert('警告','请按要求填写信息！');
				}else{
					ajaxLoading();
				}
			return fboolean;
		},
		success:function(result){
			ajaxLoadEnd();
			var obj=$.parseJSON(result);
			if(obj.success){
				//关闭当前页面
				$("#mainTab").tabs('close','邮件详情');
				if(obj.msg){
					var defaults={title:'提示',msg:obj.msg,timeout:1000,showType:'slide',style:{right:'',bottom:''}};
					$.messager.show(defaults);
				}
			}else{
				$.messager.alert("错误",obj.msg,"error");
			}
			
		}
	});
	}

/**
 * 新建邮件
 * */
function addMail(){
	var mainTab=$("#mainTab");
	if (mainTab.tabs('exists', "邮件详情")){
	   mainTab.tabs('select', "邮件详情");
	   var tab = mainTab.tabs('getSelected');  // 获取选择的面板
	   tab.panel('refresh', "Main/mail/add");
	} else {
		mainTab.tabs('add',{
		   title:"邮件详情",
		   href:"Main/mail/add",
		   closable:true
		 });
	}
}

/**
 * 回复邮件
 * */
function replyMail(){
	var row = $("#mailReceGrid").datagrid("getSelected");
	if(!row){
		$.lauvan.MsgShow({msg:'请选择相应的记录！'});
		return;
	}
	var mainTab=$("#mainTab");
	if (mainTab.tabs('exists', "邮件详情")){
	   mainTab.tabs('select', "邮件详情");
	   var tab = mainTab.tabs('getSelected');  // 获取选择的面板
	   tab.panel('refresh', "Main/mail/reply/"+row.ID);
	} else {
		mainTab.tabs('add',{
		   title:"邮件详情",
		   href:"Main/mail/reply/"+row.ID,
		   closable:true
		 });
	}
}

/**
 * 转发、重新发送、编辑邮件
 * flag:zf 发件箱转发，zfrece 收件箱转发，resend 发件箱重新发送，upd 编辑草稿邮件
 * */
function mailAct(grid,flag){
	var row = $("#"+grid).datagrid("getSelected");
	if(!row){
		$.lauvan.MsgShow({msg:'请选择相应的记录！'});
		return;
	}
	var mainTab=$("#mainTab");
	if (mainTab.tabs('exists', "邮件详情")){
	   mainTab.tabs('select', "邮件详情");
	   var tab = mainTab.tabs('getSelected');  // 获取选择的面板
	   tab.panel('refresh', "Main/mail/add/"+flag+"-"+row.ID);
	} else {
		mainTab.tabs('add',{
		   title:"邮件详情",
		   href:"Main/mail/add/"+flag+"-"+row.ID,
		   closable:true
		 });
	}
}


/**
 * 关联事件
 * flag : send 发件箱关联事件，rece 收件箱关联事件
 * */
function relaEvent_mail(grid,flag){
	var rows = $("#"+grid).datagrid("getChecked");
	if(rows.length==0){
		$.lauvan.MsgShow({msg:'请选择欲关联的数据!'});
		return;
	}else{
		var ids = "";
		for(var i=0;i<rows.length;i++){
			if(i==0){
				ids=rows[i].ID;
			}else{
				ids=ids+","+rows[i].ID;
			}
		}
		$(document.body).append("<div id='relaEventMailDialog'></div>");
		$("#relaEventMailDialog").dialog({
			title:'关联事件',
			width: 800,
			height: 400,
			href: basePath+"Main/smsMg/getSmsEvent",
			onClose:function(){
				$(this).dialog('destroy');
			},
			buttons: [{text:'确定',
				iconCls:'icon-ok',
				handler:function(){
		    		var re = $("#_relaEventGrid").datagrid("getSelected");
		    		if(re){
		    			$.ajax({
			            	url:basePath+"Main/mail/relaEvent",
			            	type:'post',
			            	dataType:'json',
			            	traditional:true,
			            	data:{'ids':ids,'eventid':re.ID,'flag':flag},
			            	success:function(data){
			            		if(data.success){
									$.lauvan.MsgShow({msg:'关联成功！'});
			            			$("#relaEventMailDialog").dialog('close');
			            			$("#"+grid).datagrid('reload');
			            		}
			            		else{
			            			$("#_relaEventGrid").datagrid('clearSelections');
			            			$("#_relaEventGrid").datagrid('clearChecked');
			            			$.messager.alert('错误',data.msg,data.errorcode);
			            		}
			            	}
			            });
		    		}else{
			    		alert("请选择要关联的事件！");
		    		}
				}}]
			});
	}
}
/**
 * 取消关联事件
 * flag : unrelate_send 发件箱关联事件，unrelate_rece 收件箱关联事件
 * */
function unrelaEvent_mail(grid,flag){
	var rows = $("#"+grid).datagrid("getChecked");
	if(rows.length==0){
		$.lauvan.MsgShow({msg:'请选择欲关联的数据!'});
		return;
	}else{
		var ids = "";
		for(var i=0;i<rows.length;i++){
			if(i==0){
				ids=rows[i].ID;
			}else{
				ids=ids+","+rows[i].ID;
			}
		}
		$.messager.confirm('取消关联',"您确定取消邮件关联的事件？",function(r){
			if(r){
				$.ajax({
	            	url:basePath+"Main/mail/relaEvent",
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'ids':ids,'flag':flag},
	            	success:function(data){
	            		if(data.success){
							$.lauvan.MsgShow({msg:'取消关联成功！'});
							$("#"+grid).datagrid('clearSelections');
	            			$("#"+grid).datagrid('clearChecked');
	            			$("#"+grid).datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
  				});
			}
		});
	}
}


/**
 * 邮件详情
 * */
function viewMail(id,flag){
	//打开详情页面
		var mainTab=$("#mainTab");
		if (mainTab.tabs('exists', "邮件详情")){
	    	mainTab.tabs('select', "邮件详情");
	    	// 调用 'refresh' 方法更新选项卡面板的内容
	    	var tab = mainTab.tabs('getSelected');  // 获取选择的面板
	    	tab.panel('refresh', "Main/mail/getView/"+id+"-"+flag);
	    } else {
		    mainTab.tabs('add',{
		       title:"邮件详情",
		       href:"Main/mail/getView/"+id+"-"+flag,
		        closable:true
		    });
	    }
}


