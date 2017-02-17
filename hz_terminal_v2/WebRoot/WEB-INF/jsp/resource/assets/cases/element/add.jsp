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
            fileQueue     :  'ELEfileQueue',
 	        onComplete:onComplete,
 	        onError: function(event, queueID, fileObj) {     
 	               alert("文件:" + fileObj.name + "上传失败");     
 	            }
	};
	$("#ELEfjfile").uploadify(param);
	});

function onComplete(event, queueId, fileObj, response, data){
var obj = eval( "(" + response + ")" );
if($("#ELEfjval").length>0){
	deleteFile($("#ELEfjval").val());
}
var html = "<div id='ELEfj_"+obj.id+"' ><input type='hidden' name='fjid' id='ELEfjval' value='" + obj.id +"'fjid' />";
html += "<a class='btnAttach' title='请点击另存为'></a><a title='请点击另存为' target='_blank' href='<%=basePath%>Main/attachment/downloadFJ/";
html += obj.id + "' >" + obj.name +"</a>（" + obj.size + "）<a href='javascript:deleteFile(" + obj.id +");'><img src='<%=basePath%>plugins/uploadify/cancel.png' height='13' align='middle'/></a></div>";
$("#ELEfilebox").html(html);
}

function deleteFile(fjid){
$("#ELEfilebox").load("<%=basePath%>Main/attachment/delete/" + fjid);
$("#ELEfj_"+fjid).remove();

}

  </script>

<form id="elementForm" method="post"
	action="<%=basePath%>Main/caseselement/save/${casId}"
	style="width:100%;">
	<table id="table" class="sp-table" width="100%" cellpadding="0"
		cellspacing="0">
		<tr>
		<td class="sp-td1">编号：</td>
		<td><input name="t_Bus_Cases_Element.code" type="text"
			data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
			class="easyui-numberbox" style="width:180px;" /></td>

		<td class="sp-td1">要素标题：</td>
		<td><input name="t_Bus_Cases_Element.content" type="text"
			class="easyui-textbox" data-options="prompt:'请输入要素标题',required:true,icons:iconClear"
			style="width:180px;" /></td>
        
        </tr>
        <tr>
		<td class="sp-td1">数据来源单位：</td>
		<td><input class="easyui-combotree"
			name="t_Bus_Cases_Element.sourcedept"
			data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get'"
			style="width:180px;"></td>

		<td class="sp-td1">最近更新：</td>
		<td><input type="text" name="t_Bus_Cases_Element.updatetime"
			class="easyui-datetimebox" style="width: 180px;"
			data-options="editable:false,disabled:true,value:'${nowdate}'" /></td>

        </tr>
        <tr>
		<td class="sp-td1">内容描述：</td>
		<td colspan="3"><textarea name="t_Bus_Cases_Element.elementdesc"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 560px;height: 50px;"></textarea></td>
		
		</tr>
        <tr>
		<td class="sp-td1">备注：</td>
		<td colspan="3"><textarea name="t_Bus_Cases_Element.remark"
				class="textarea" data-options="validType:'length[0,500]'"
				style="width: 560px;height: 50px;"></textarea></td>
        </tr>
		<tr>
		    		<td class="sp-td1">附件</td>
		    		<td colspan="5">
		    			<div>
		    				<input type="file" name="file" id="ELEfjfile"/>
		    				<div id="ELEfileQueue">
		    					<div id="ELEfilebox" style="width:450px;"></div>
		    				</div>
		    			</div>
		    		
		    		</td>
		    	</tr>
	</table>
</form>
