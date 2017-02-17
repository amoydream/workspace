<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">

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
<form id="exgroupAdd" method="post" action="<%=basePath%>Main/expertgroup/save"
	style="width:100%;margin: 0 auto;padding: 0;">
	<div data-options="region:'north',border:false" style="height:130px;">
		<input type="hidden" name="act" value="add" />
		<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td class="sp-td1">专家组名称：</td>
				<td><input name="t_Bus_Expertgroup.eg_name" type="text"
					class="easyui-textbox"
					data-options="prompt:'请输入专家组名称',required:true,icons:iconClear"
					style="width:180px;" /></td>

				<td class="sp-td1">专家组类型：</td>
				<td><select class="easyui-combobox"
					name="t_Bus_Expertgroup.egtype" panelHeight="auto" code="EGTYPE"
					style="width: 180px;" data-options="editable:false"></select></td>
			</tr>
			    <td class="sp-td1">组建单位：</td>
				<td><input class="easyui-combotree"
					name="t_Bus_Expertgroup.buildorgan"
					data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get'"
					style="width:180px;"></td>
	
				<td class="sp-td1">人员数</td>
				<td><input type="text" name="t_Bus_Expertgroup.num"
					data-options="prompt:'正整数',precision:0,min:0,icons:iconClear"
					class="easyui-numberbox" style="width: 180px;" /></td>
			<tr>
				<td class="sp-td1">负责人</td>
				<td><input type="text" name="t_Bus_Expertgroup.master"
					data-options="" class="easyui-textbox" style="width: 180px;" /></td>

				<td class="sp-td1">负责人电话</td>
				<td><input type="text" name="t_Bus_Expertgroup.mastertel"
					data-options="validType:'phone'" class="easyui-textbox"
					style="width: 180px;" /></td>

			</tr>
			<tr>
				<td class="sp-td1">负责人手机</td>
				<td><input type="text" name="t_Bus_Expertgroup.masterphone"
					data-options="validType:'mobile'" class="easyui-textbox"
					style="width: 180px;" /></td>

				<td class="sp-td1">负责人邮箱</td>
				<td><input type="text" name="t_Bus_Expertgroup.masteremail"
					data-options="validType:'email'" class="easyui-textbox"
					style="width: 180px;" /></td>
		    </tr>
		    <tr>
				<td class="sp-td1">最近更新时间</td>
				<td><input type="text" name="t_Bus_Expertgroup.updatetime"
					data-options="disabled:true,readonly:true" class="easyui-textbox"
					style="width: 180px;" value="${nowdate}" /></td>

			</tr>
			<tr>
				<td class="sp-td1">职能描述</td>
				<td colspan="3"><textarea name="t_Bus_Expertgroup.egdesc"
						class="textarea" data-options="validType:'length[0,500]'"
						style="width: 570px;height: 50px;"></textarea></td>
			</tr>
			<tr>
				<td class="sp-td1">备注</td>
				<td colspan="3"><textarea name="t_Bus_Expertgroup.remark"
						class="textarea" data-options="validType:'length[0,500]'"
						style="width: 570px;height: 50px;"></textarea></td>
			</tr>
			<tr>
				<td class="sp-td1">附件</td>
				<td colspan="5">
					<div>
						<input type="file" name="file" id="fjfile" />
						<div id="fileQueue">
							<div id="filebox" style="width:450px;"></div>
						</div>
					</div>

				</td>
			</tr>

		</table>
	</div>
</form>
