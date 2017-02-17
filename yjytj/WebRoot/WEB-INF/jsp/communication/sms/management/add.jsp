<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function smsTempSelect(){
	$("#_smsTempDialog").dialog({
		title:'短信模板',
		width: 800,
		height: 400,
		href: basePath+"Main/smsMg/getSmsTemp",
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
function smsClick(){
	$("#_smsMobileDialog").dialog({
		title:'联系人',
		width: 800,
		height: 400,
		href: basePath+"Main/smsMg/getMobile",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
	    		var mobile = $("#_smsMobile").val();
	    		var mobname = $("#_smsMobname").val();
	    		if(mobile){
		    		//$("#_smsnum").textbox('setValue',mobile);
		    		$("#_smsnum").val(mobile);
		    		$("#_smsname").val(mobname);
		    		$("#_smsnum_text").text(mobname);
		    		$("#_smsMobileDialog").dialog('close');
	    		}else{
		    		alert("请选择要发送的手机号码！");
	    		}
			}}]
		});
}
function smsImpNum(){
	$("#_smsImportDialog").dialog({
		title:'导入号码文件',
		width: 800,
		height: 250,
		href: basePath+"Main/smsMg/getMobileImport",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
	    		var sfile = $("#_smsimpfile").val();
	    		if(sfile==null || sfile=='' || sfile==undefined){
	    			alert("请上传号码文件！");
	    		}else{
	    			$("#_smsnum").textbox('setValue',sfile);
		    		$("#_smsname").val(sfile);
		    		$("#_smsnum_text").text('');
		    		$("#_smsImportDialog").dialog('close');
	    		}
			}}]
		});
}
</script>
	 
	 <form id="smsMgform" method="post" action="<%=basePath %>Main/smsMg/save" style="width:100%;">
	    <input type="hidden" name="act" value="${flag}"/>
	    <table   class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		  		<td class="sp-td1">短信模板：</td>
		    	<td>
		    		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="smsTempSelect()" data-options="iconCls:'icon-tip',plain:true">请选择</a>
		    	</td>
		    	</tr>
	    	
		    	<tr>
		  		<td class="sp-td1">手机号码：</td>
		    	<td>
		    		<input type="hidden" id="_smsname" name="smsname" />
		    		<!-- <input type="text" id="_smsnum" name="smsnum" data-options="icons:[{iconCls:'icon-search',handler:smsClick}]" 
		    		class="easyui-textbox" style="width: 420px;"/> -->
		    		<textarea id="_smsnum" name="smsnum" class="textarea"   style="width: 400px;height: 50px;" ></textarea>
		    		<a href="javascript:void(0);"  onclick="smsClick()" class="easyui-linkbutton"  data-options="iconCls:'icon-search'"></a>
		    		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="smsImpNum()" data-options="iconCls:'icon-undo',plain:true">导入号码文件</a>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1" >姓名：</td>
		    	<td id="_smsnum_text">
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
<div id="_smsTempDialog"></div>
<div id="_smsMobileDialog"></div>
<div id="_smsImportDialog"></div>