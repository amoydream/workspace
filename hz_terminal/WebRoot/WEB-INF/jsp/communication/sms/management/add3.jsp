<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function smsTempSelect_A(){
	$(document.body).append("<div id='_smsTempDialog'></div>");
	$("#_smsTempDialog").dialog({
		title:'短信模板',
		width: 800,
		height: 400,
		href: basePath+"Main/smsMg/getSmsTemp",
		onClose:function(){
			$(this).dialog('destroy');
		},
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
	    		var dba = $("#_smsTemplateGrid").datagrid("getSelected");
	    		if(dba){
		    		$("#_smscontent").val(dba.CONTENT);
		    		$("#_smsTempDialog").dialog('close');
	    		}else{
		    		alert("请选择短信模板！");
	    		}
			}}]
		});	
}
function smsClick_A(){
	$(document.body).append("<div id='_smsMobileDialog'></div>");
	$("#_smsMobileDialog").dialog({
		title:'联系人',
		width: 900,
		height: 520,
		href: basePath+"Main/smsMg/getMobile",
		onClose:function(){
			$(this).dialog('destroy');
		},
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var phone_receivers = $('#select_tagger_sms').tagger('getTags');
				if(phone_receivers.length > 0) {
					$('#selected_tagger_smsA').tagger('setTags', phone_receivers);
					var mobile = "";
		    		var mobname = "";
		    		for(var i=0;i<phone_receivers.length;i++){
		    			if(mobile!=''){
		    				mobile=mobile+",";
		    				mobname=mobname+",";
		    			}
		    			mobile=mobile+phone_receivers[i].PHONENUM;
	    				mobname=mobname+phone_receivers[i].SMSNAME;
		    		}
		    		$("#_smsnum").val(mobile);
		    		$("#_smsname").val(mobname);
		    		$("#_smsMobileDialog").dialog('close');
				}else{
		    		alert("请选择要发送的手机号码！");
	    		}
			}}]
		});
}
function smsImpNum_A(){
	$(document.body).append("<div id='_smsImportDialog'></div>");
	$("#_smsImportDialog").dialog({
		title:'导入号码文件',
		width: 800,
		height: 250,
		href: basePath+"Main/smsMg/getMobileImport",
		onClose:function(){
			$(this).dialog('destroy');
		},
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
	    		var sfile = $("#_smsimpfile").val();
	    		if(sfile==null || sfile=='' || sfile==undefined){
	    			alert("请上传号码文件！");
	    		}else{
	    			$("#_smsnum").textbox('setValue',sfile);
		    		$("#_smsname").val(sfile);
		    		var sfiles = sfile.split(",");
		    		for(var i=0;i<sfiles.length;i++){
		    			var stag = {};
		    			stag.PHONENUM=sfiles[i];
		    			stag.SMSNAME=sfiles[i];
		    			$('#selected_tagger_smsA').tagger('addTag', stag);	
		    		}
		    		$("#_smsImportDialog").dialog('close');
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
        tagId : 'PHONENUM',
        tagName : 'SMSNAME',
        addBtn : true,
        clearBtn : true,
        addFn : smsClick_A,
        validateFn : check_phoneA,
        onchange:function(){
        	var phone_receivers = $('#selected_tagger_smsA').tagger('getTags');
			if(phone_receivers.length > 0) {
				var mobile = "";
	    		var mobname = "";
	    		for(var i=0;i<phone_receivers.length;i++){
	    			if(mobile!=''){
	    				mobile=mobile+",";
	    				mobname=mobname+",";
	    			}
	    			mobile=mobile+phone_receivers[i].PHONENUM;
    				mobname=mobname+phone_receivers[i].SMSNAME;
	    		}
	    		$("#_smsnum").val(mobile);
	    		$("#_smsname").val(mobname);
			}else{
	    		alert("请选择要发送的手机号码！");
    		}	
        },
        clearFn : function() {
	        $('#selected_tagger_smsA').tagger('removeTags');
        }
    };
    $('#selected_tagger_smsA').tagger(tagger_options);
    //$('#selected_tagger_smsA').tagger('setTags', ${smsreclist});
});
function check_phoneA(phone) {
	if(phone == null || typeof phone != 'string' || phone.trim() == '') {
		return false;
	}

	var reg = /^1\d{10}$/;
	if(!reg.test(phone)) {
		return false;
	}
	reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
	if(!reg.test(phone)) {
		return false;
	}
	return true;
}
</script>
	 
	 <form id="smsMgform" method="post" action="<%=basePath %>Main/smsMg/save" style="width:100%;">
	    <input type="hidden" name="act" value="send"/>
	    <table   class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		  		<td class="sp-td1">短信模板：</td>
		    	<td>
		    		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="smsTempSelect_A()" data-options="iconCls:'icon-tip',plain:true">请选择</a>
		    	</td>
		    	</tr>
	    	
		    	<tr>
		  		<td class="sp-td1">接收对象：</td>
		    	<td>
		    	<div style="float: left;">
		    		<input type="hidden" id="_smsname" name="smsname" />
		    		<input type="hidden" id="_smsnum" name="smsnum" /> 
		    		<select id="selected_tagger_smsA" style="width: 430px;" />
		    	</div>
		    		<!--  <a href="javascript:void(0);"  onclick="smsClick()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a>-->
		    	<div style="margin-top: 20px;">
		    		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="smsImpNum_A()" data-options="iconCls:'icon-undo',plain:true">导入号码文件</a>
		    	</div>
		    	<div style="clear: both;"></div>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">短信内容：</td>
		    	<td>
		    		<textarea id="_smscontent" name="smscontent" class="textarea easyui-validatebox" 
		    		 style="width: 560px;height: 100px;" ></textarea>
		    	</td>
		    	</tr>
	    </table>
    </form>