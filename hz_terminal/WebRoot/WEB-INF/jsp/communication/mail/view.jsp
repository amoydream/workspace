<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
var editor_emview;
$(document).ready(function(){
	editor_emview = KindEditor.create('#emailcontentView',{
		readonlyMode: true,
		items: []
	});
});

function opentab(flag,id){
	var mainTab=$("#mainTab");
	if (mainTab.tabs('exists', "邮件详情")){
	   mainTab.tabs('select', "邮件详情");
	   var tab = mainTab.tabs('getSelected');  // 获取选择的面板
	   tab.panel('refresh', "Main/mail/add/"+flag+"-"+id);
	} else {
		mainTab.tabs('add',{
		   title:"邮件详情",
		   href:"Main/mail/add/"+flag+"-"+id,
		   closable:true
		 });
	}
}

function rechangeMail(){
	if(${flag=='rece'}){
		opentab("zfrece",${mail.id});
	}
	if(${flag=='send'}){
		opentab("zfsend",${mail.id});
	}
	if(${flag=='edit'}){
		opentab("zfedit",${mail.id});
	}
	
}

function replyMail(){
	opentab("reply",${mail.id});
}

function reSendMail(){
	opentab("resend",${mail.id});
}
function delMail(){
	if(${flag=='send'}){
		$.ajax({
        	url:basePath+"Main/mail/toDel",
        	type:'post',
        	dataType:'json',
        	traditional:true,
        	data:{'ids':${mail.id}},
        	success:function(data){
        		if(data.success){
					$.lauvan.MsgShow({msg:'删除成功！'});
					$("#mainTab").tabs('close','邮件详情');
        		}
        		else{
        			$.messager.alert('错误',data.msg,data.errorcode);
        		}
        	}
	})}
	if(${flag=='rece'}){
		$.ajax({
        	url:basePath+"Main/mail/receDel",
        	type:'post',
        	dataType:'json',
        	traditional:true,
        	data:{'ids':${mail.id}},
        	success:function(data){
        		if(data.success){
					$.lauvan.MsgShow({msg:'删除成功！'});
					$("#mainTab").tabs('close','邮件详情');
        		}
        		else{
        			$.messager.alert('错误',data.msg,data.errorcode);
        		}
        	}
	})}
	if(${flag=='edit'}){
		$.ajax({
        	url:basePath+"Main/mail/cgDel",
        	type:'post',
        	dataType:'json',
        	traditional:true,
        	data:{'ids':${mail.id}},
        	success:function(data){
        		if(data.success){
					$.lauvan.MsgShow({msg:'删除成功！'});
					$("#mainTab").tabs('close','邮件详情');
        		}
        		else{
        			$.messager.alert('错误',data.msg,data.errorcode);
        		}
        	}
	})}
	if(${flag=='fq'}){
		$.ajax({
        	url:basePath+"Main/mail/realdelete",
        	type:'post',
        	dataType:'json',
        	traditional:true,
        	data:{'ids':${mail.id}},
        	success:function(data){
        		if(data.success){
					$.lauvan.MsgShow({msg:'删除成功！'});
					$("#mainTab").tabs('close','邮件详情');
        		}
        		else{
        			$.messager.alert('错误',data.msg,data.errorcode);
        		}
        	}
	})}
	if(${flag=='del'}){
		$.ajax({
        	url:basePath+"Main/mail/realdelete",
        	type:'post',
        	dataType:'json',
        	traditional:true,
        	data:{'ids':${mail.id}},
        	beforeSend: ajaxLoading,  
        	success:function(data){
        		if(data.success){
        			ajaxLoadEnd();
					$.lauvan.MsgShow({msg:'彻底删除成功！'});
					$("#mainTab").tabs('close','邮件详情');
        		}
        		else{
        			$.messager.alert('错误',data.msg,data.errorcode);
        		}
        	}
	})}
}

function ajaxLoading(){   
    $("<div class=\"datagrid-mask\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("body");   
    $("<div class=\"datagrid-mask-msg\"></div>").html("正在处理，请稍候。。。").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});   
 }   
 function ajaxLoadEnd(){   
     $(".datagrid-mask").remove();   
     $(".datagrid-mask-msg").remove();               
} 

function rebackMail(){
	$.ajax({
    	url:basePath+"Main/mail/reback",
    	type:'post',
    	dataType:'json',
    	traditional:true,
    	data:{'ids':${mail.id}},
    	success:function(data){
    		if(data.success){
				$.lauvan.MsgShow({msg:'恢复成功！'});
				$("#mainTab").tabs('close','邮件详情');
    		}
    		else{
    			$.messager.alert('错误',data.msg,data.errorcode);
    		}
    	}
})
}
</script>
	<div >
	    <div  style="padding: 5px;background:#f7f7f7;">
	    <c:if test="${flag!='del'}">
	    <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="rechangeMail()" data-options="iconCls:'icon-ok',plain:true">转发</a>
	    </c:if>
	    <c:if test="${flag=='rece'}">
	    <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="replyMail()" data-options="iconCls:'icon-undo',plain:true">回复</a>
	    </c:if>
	    <c:if test="${flag=='send'}">
	    <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="reSendMail()" data-options="iconCls:'icon-redo',plain:true">重新发送</a>
	    </c:if>
	    <c:if test="${flag=='del'}">
	    <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="rebackMail()" data-options="iconCls:'icon-undo',plain:true">恢复</a>
	    <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="delMail()" data-options="iconCls:'icon-cancel',plain:true">彻底删除</a>
	    </c:if>
	    <c:if test="${flag!='del'}">
	    <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="delMail()" data-options="iconCls:'icon-cancel',plain:true">删除</a>
	    </c:if>
	    </div>
	    <div >
	    <table   class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
	    			<td class="sp-td1">主题：</td>
	    			<td >${mail.subject}</td>
	    		</tr>
	    		<tr>
		  		<td class="sp-td1">发件人：</td>
		    	<td >${mail.sendername}</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">收件人：</td>
		    	<td >${mail.address_toname} </td>
		    	</tr>
		    	<c:if test="${!empty mail.address_cc}">
		    	<tr>
		  		<td class="sp-td1">抄送人：</td>
		    	<td >${mail.address_ccname}</td>
		    	</tr>
		    	</c:if>
		    	<c:if test="${!empty fjlist}">
		    	<tr>
		    	<td class="sp-td1">附件：</td>
		    	<td >
		    	
		    		<c:forEach items="${fjlist}" var="fjlist">
		    		<div>
		    		<a title="请点击下载" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${fjlist.id}">${fjlist.name}<a/>
		    		</div>
		    		</c:forEach>
		    	</td>
		    	</tr>
		    	</c:if>
		    	<tr>
		    	<td colspan="2">
		    		<textarea id="emailcontentView" name="emailcontentView" class="textarea" 
		    		  style="width: 100%;height: 330px;" >${mail.content}</textarea>
		    	</td>
		    	</tr>
	    </table>
	   </div>
</div>