<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script>
$(function(){
	var param = {
			'buttonText'     : '上传附件', //按钮上的文字 
            'uploader': '<%=basePath %>plugins/uploadify/scripts/uploadify.swf',
            'script': '<%=basePath%>Main/attachment/save/safeguardorg--${userid}',
            'cancelImg': '<%=basePath %>plugins/uploadify/cancel.png',
            'auto'           : true, //是否自动开始     
            'multi'          : false, //是否支持多文件上传
            fileDataName   : 'file',
            fileQueue     :  'fileQueue',
 	        onComplete:onComplete,
 	        onError: function(event, queueID, fileObj) {     
 	               alert("文件:" + fileObj.name + "上传失败");     
 	            }
	};
	$("#fjfile").uploadify(param);
	});

function onComplete(event, queueId, fileObj, response, data){
var obj = eval( "(" + response + ")" );
if($("#fjval").length>0){
	deleteFile($("#fjval").val());
}
var html = "<div id='fj_"+obj.id+"' ><input type='hidden' name='fjid' id='fjval' value='" + obj.id +"'fjid' />";
html += "<a class='btnAttach' title='请点击另存为'></a><a title='请点击另存为' target='_blank' href='<%=basePath%>Main/attachment/downloadFJ/";
html += obj.id + "' >" + obj.name +"</a>（" + obj.size + "）<a href='javascript:deleteFile(" + obj.id +");'><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a></div>";
$("#filebox").html(html);
}

function deleteFile(fjid){
$("#filebox").load("<%=basePath%>Main/attachment/delete/" + fjid);
$("#fj_"+fjid).remove();

}
  </script>

<form id="macapEdit" method="post"
	action="<%=basePath%>Main/materialcap/save" style="width:100%;">
	<table id="table" class="sp-table" width="100%" cellpadding="0"
		cellspacing="0">
		<input type="hidden" name="t_Bus_Materialcap.cap_id" value="${model.cap_id }" />
		<tr>
			<td class="sp-td1">产品名称：</td>
			<td><input name="t_Bus_Materialcap.proname" type="text"
				class="easyui-textbox" value="${model.proname}"
				data-options="prompt:'请输入要素标题',required:true,icons:iconClear"
				style="width:180px;" /></td>

			<td class="sp-td1">产品类型：</td>
			<td><input name="t_Bus_Materialcap.protype" type="text"
				class="easyui-textbox" value="${model.protype}"
				data-options="icons:iconClear" style="width:180px;" /></td>
		</tr>

		<tr>
			<td class="sp-td1">日生产量：</td>
			<td><input name="t_Bus_Materialcap.dayproamount" type="text" value="${model.dayproamount }"
				data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
				class="easyui-numberbox" style="width:180px;" /></td>

			<td class="sp-td1">计量单位：</td>
			<td><select class="easyui-combobox"
				name="t_Bus_Materialcap.measureunit" panelHeight="auto"
				code="MAUNIT" style="width: 180px;" data-options="editable:false,value:'${model.measureunit}'"></select></td>
		</tr>

		<tr>
			<td class="sp-td1">最近更新：</td>
			<td><input type="text" name="t_Bus_Materialcap.updatetime"
				class="easyui-datetimebox" style="width: 180px;" 
				data-options="disabled:true,editable:false,value:'${model.updatetime}'" /></td>
		</tr>

		<tr>
			<td class="sp-td1">备注：</td>
			<td colspan="3"><textarea name="t_Bus_Materialcap.remark"
					class="textarea" data-options="validType:'length[0,500]'"
					style="width: 560px;height: 50px;">${model.remark}</textarea></td>
		</tr>
	</table>
</form>
