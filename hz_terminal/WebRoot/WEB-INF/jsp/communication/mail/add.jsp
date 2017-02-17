<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
var editor_em1;
function mailTOClick(){
	var to = $('#selected_tagger_mailTO').tagger('getTags');
	var tomail = "";
	var toname = "";
	if(to.length>0){
		for(var i=0;i<to.length;i++){
			if(tomail!=''){
				tomail=tomail+",";
				toname=toname+",";
			}
			tomail=tomail+to[i].MAIL;
			toname=toname+to[i].SMSNAME;
		}
	}
	$(document.body).append("<div id='_mailDialog'></div>");
	$("#_mailDialog").dialog({
		title:'邮件联系人',
		width: 900,
		height: 520,
		href: "<%=basePath %>Main/mailbook/getMail",
		queryParams:{'rmail':tomail,'rname':toname},
		onClose:function(){
			$(this).dialog('destroy');
		},
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var mailto = $('#selected_tagger_mail').tagger('getTags');
				if(mailto.length > 0) {
					$('#selected_tagger_mailTO').tagger('setTags', mailto);
					var mail = "";
		    		var mailname = "";
		    		for(var i=0;i<mailto.length;i++){
		    			if(mail!=''){
		    				mail=mail+",";
		    				mailname=mailname+",";
		    			}
		    			mail=mail+mailto[i].MAIL;
		    			mailname=mailname+mailto[i].SMSNAME;
		    		}
		    		$("#_mailto").val(mail);
		    		$("#_mailtoname").val(mailname);
		    		$("#_mailDialog").dialog('close');
				}else{
		    		alert("请选择收件人邮件地址！");
	    		}
			}}]
		});
}

function mailCCClick(){
	var cc = $('#selected_tagger_mailCC').tagger('getTags');
	var ccmail = "";
	var ccname = "";
	if(cc.length>0){
		for(var i=0;i<cc.length;i++){
			if(ccmail!=''){
				ccmail=ccmail+",";
				ccname=ccname+",";
			}
			ccmail=ccmail+cc[i].MAIL;
			ccname=ccname+cc[i].SMSNAME;
		}
	}
	
	$(document.body).append("<div id='_mailCCDialog'></div>");
	$("#_mailCCDialog").dialog({
		title:'邮件联系人',
		width: 900,
		height: 520,
		href: "<%=basePath %>Main/mailbook/getMail",
		queryParams:{'rmail':ccmail,'rname':ccname},
		onClose:function(){
			$(this).dialog('destroy');
		},
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var mailcc = $('#selected_tagger_mail').tagger('getTags');
				if(mailcc.length > 0) {
					$('#selected_tagger_mailCC').tagger('setTags', mailcc);
					var mail = "";
		    		var mailname = "";
		    		for(var i=0;i<mailcc.length;i++){
		    			if(mail!=''){
		    				mail=mail+",";
		    				mailname=mailname+",";
		    			}
		    			mail=mail+mailcc[i].MAIL;
		    			mailname=mailname+mailcc[i].SMSNAME;
		    		}
		    		$("#_mailcc").val(mail);
		    		$("#_mailccname").val(mailname);
		    		$("#_mailCCDialog").dialog('close');
				}else{
		    		alert("请选择邮件地址！");
	    		}
			}}]
		});
}

$(document).ready(function(){
    var tagger_options = {
        placeholderText : 'Add...',
        maxNbTags : false,
        confirmDelete : true,
        caseSensitive : false,
        disableAdd : false,
        tagId : 'MAIL',
        tagName : 'SMSNAME',
        addBtn : true,
        clearBtn : true,
        addFn : mailTOClick,
        validateFn : check_mail,
        onchange:function(){
        	var mailto = $('#selected_tagger_mailTO').tagger('getTags');
			if(mailto.length > 0) {
				var mail = "";
	    		var mailname = "";
	    		for(var i=0;i<mailto.length;i++){
	    			if(mail!=''){
	    				mail=mail+",";
	    				mailname=mailname+",";
	    			}
	    			mail=mail+mailto[i].MAIL;
	    			mailname=mailname+mailto[i].SMSNAME;
	    		}
	    		$("#_mailto").val(mail);
	    		$("#_mailtoname").val(mailname);
			}else{
				alert("请选择收件人邮件地址！");
			}	
        },
        clearFn : function() {
	        $('#selected_tagger_mailTO').tagger('removeTags');
        }
    };
    $('#selected_tagger_mailTO').tagger(tagger_options);
    
    var tagger_optionscc = {
            placeholderText : 'Add...',
            maxNbTags : false,
            confirmDelete : true,
            caseSensitive : false,
            disableAdd : false,
            tagId : 'MAIL',
            tagName : 'SMSNAME',
            addBtn : true,
            clearBtn : true,
            addFn : mailCCClick,
            validateFn : check_mail,
            onchange:function(){
            	var mailcc = $('#selected_tagger_mailCC').tagger('getTags');
    			if(mailcc.length > 0) {
    				var mail = "";
    	    		var mailname = "";
    	    		for(var i=0;i<mailcc.length;i++){
    	    			if(mail!=''){
    	    				mail=mail+",";
    	    				mailname=mailname+",";
    	    			}
    	    			mail=mail+mailcc[i].MAIL;
    	    			mailname=mailname+mailcc[i].SMSNAME;
    	    		}
    	    		$("#_mailcc").val(mail);
    	    		$("#_mailccname").val(mailname);
    	    		 console.info(mail);
    			}	
            },
            clearFn : function() {
    	        $('#selected_tagger_mailCC').tagger('removeTags');
            }
        };
        $('#selected_tagger_mailCC').tagger(tagger_optionscc);
    
    $("#mailFJfile").uploadify({
    	'buttonText'     : '上传附件', //按钮上的文字 
        'uploader': '<%=basePath %>plugins/uploadify/scripts/uploadify.swf',
        'script': '<%=basePath%>Main/attachment/save/emailSend',
        'cancelImg': '<%=basePath %>plugins/uploadify/cancel.png',
        'auto'           : true, //是否自动开始     
        'multi'          : true, //是否支持多文件上传
        fileDataName   : 'file',
        fileQueue     :  'fileQueue',
	    onComplete:_onCompleteMailFJ,		 	    
        onError: function(event, queueID, fileObj) {     
            alert("文件:" + fileObj.name + "上传失败");     
         }	            
    });
    
    KindEditor.options.imageTabIndex = 1;
	editor_em1= KindEditor.create('#emailcontent',{
		emoticonsPath:'http://kindeditor.net/ke4/plugins/emoticons/images/',
		items: ['fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'cut', 'copy', 'paste','plainpaste', 'wordpaste','|', 
				'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist'],//, '|', 'emoticons', 'image'
		afterBlur: function(){ editor_em1.sync(); },
		afterCreate: function () {
            var self = this;
            KindEditor.ctrl(document, 13, function () {
                self.sync();
                k('form[name=mailMgform_ADD]')[0].submit();
            });
            KindEditor.ctrl(self.edit.doc, 13, function () {
                self.sync();
                KindEditor('form[name=mailMgform_ADD]')[0].submit();
            }); 
        }
	});
	editor_em1.focus();
	
});

function _onCompleteMailFJ(event, queueId, fileObj, response, data){	
	var htmlBody="";
	var obj = eval( "(" + response + ")" );//转换后的JSON对象
	htmlBody+="<div id='emTXfile_"+obj.id+"' style='height:25px;line-height:25px;font-size:12px;'>";
	htmlBody+="<span style='display:none'><input type='checkbox' name='emfjid' value='"+obj.id+"' checked/></span>";
	htmlBody+="<a title='请点击另存为' target='_blank' href='<%=basePath %>Main/attachment/downloadFJ/"+obj.id+"'>"+obj.name+"<a/> （"
				+obj.size+"）<a href='javascript:deleteEMFile("+obj.id+");'><img src='<%=basePath %>plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
	htmlBody+="</div>";
	$("#mailFJfileList").append(htmlBody);
}
//删除文件ajax请求
function deleteEMFile(id){
	$("#emTXfile_"+id).load("<%=basePath %>Main/attachment/delete/"+id);
	$("#emTXfile_"+id).remove();
}


function sendMail(){
	$("#_mailact").val("add");
	mailSubmit('mailMgform_ADD');
}

function saveMail(){
	$("#_mailact").val("cg");
	mailSubmit('mailMgform_ADD');
}

function closeMail(){
	$("#mainTab").tabs('close','邮件详情');
}
</script>   
<div >
	   
	    <div  style="padding: 5px;background:#f7f7f7;">
	    <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="sendMail()" data-options="iconCls:'icon-ok',plain:true">发送</a>
	    <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="saveMail()" data-options="iconCls:'icon-save',plain:true">存草稿</a>
	    <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="closeMail()" data-options="iconCls:'icon-cancel',plain:true">取消</a>
	    </div>
	    <div >
	     <form id="mailMgform_ADD" name="mailMgform_ADD" method="post" action="<%=basePath %>Main/mail/save" style="width:100%;">
	     <input type="hidden" id="_mailact" name="act" />
	    <table   class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
	    			<td class="sp-td1">主题：</td>
	    			<td ><input  type="text" class="easyui-textbox" name="t_Bus_Mail_To.subject" ></td>
	    		</tr>
		    	<tr>
		  		<td class="sp-td1">收件人：</td>
		    	<td>
		    		<input type="hidden" id="_mailto" name="mailto" />
		    		<input type="hidden" id="_mailtoname" name="mailtoname" /> 
		    		<select id="selected_tagger_mailTO" style="width:90%;" />
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">抄送人：</td>
		    	<td>
		    		<input type="hidden" id="_mailcc" name="mailcc" />
		    		<input type="hidden" id="_mailccname" name="mailccname" /> 
		    		<select id="selected_tagger_mailCC" style="width: 90%;" />
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">附件：</td>
		    	<td >
		    	<input  id="mailFJfile"  type="file" name="file"/>
		    	<div id="mailFJfileList" style="width: 900px;"></div>
		    	</td>
		    	</tr>
		    	<tr>
		    	<td colspan="2">
		    		<textarea id="emailcontent" name="t_Bus_Mail_To.content" class="textarea" 
		    		  style="width: 100%;height: 220px;" ></textarea>
		    	</td>
		    	</tr>
	    </table>
	     </form>
	    </div>
	    
</div>
   