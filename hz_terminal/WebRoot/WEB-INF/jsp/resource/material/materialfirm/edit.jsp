<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
//打开地图
function DTClick(){
	$.lauvan.openGisDialog($("#longitude").val(),$("#latitude").val(),function(lng,lat){
		$("#longitude").textbox('setValue',lng);
		$("#latitude").textbox('setValue',lat);
	});
}

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
<form id="mafirmEdit" method="post" action="<%=basePath%>Main/materialfirm/save"
	style="width:100%;margin: 0 auto;padding: 0;">
	<div data-options="region:'north',border:false" style="height:130px;">
		<input type="hidden" name="act" value="update" /> <input type="hidden"
			name="t_Bus_Materialfirm.mf_id" value="${model.mf_id }" />
		<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td class="sp-td1">企业名称：</td>
				<td><input name="t_Bus_Materialfirm.mf_name" type="text"
					class="easyui-textbox" value="${model.mf_name }"
					data-options="prompt:'请输入企业名称',required:true,icons:iconClear"
					style="width:180px;" /></td>

				<td class="sp-td1">企业类型：</td>
				<td><select class="easyui-combobox"
					name="t_Bus_Materialfirm.mftype" panelHeight="auto" code="ORGA"
					style="width: 180px;" data-options="editable:false,value:'${model.mftype}'"></select></td>
			</tr>

			<tr>
				<td class="sp-td1">所属单位：</td>
				<td><input class="easyui-combotree"
					name="t_Bus_Materialfirm.organid"
					data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get',value:'${model.organid}'"
					style="width:180px;"></td>

				<td class="sp-td1">值班电话：</td>
				<td><input name="t_Bus_Materialfirm.dutytel" value="${model.dutytel }" type="text"
					class="easyui-textbox" data-options="validType:'phone'"
					style="width:180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">经度：</td>
				<td><input id="longitude" name="t_Bus_Materialfirm.longitude" value="${model.longitude }"
					type="text" class="easyui-textbox" style="width: 180px;"
					data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}]" />
				</td>
				<td class="sp-td1">纬度：</td>
				<td><input id="latitude" name="t_Bus_Materialfirm.latitude" value="${model.latitude }"
					type="text" class="easyui-textbox lock-on" style="width: 180px;"
					data-options="readonly:true" /></td>
			</tr>

			<tr>
				<td class="sp-td1">传真：</td>
				<td><input name="t_Bus_Materialfirm.fax" type="text" value="${model.fax }"
					class="easyui-textbox" data-options="validType:'faxno',icons:iconClear"
					style="width:180px;" /></td>

				<td class="sp-td1">负责人</td>
				<td><input type="text" name="t_Bus_Materialfirm.master" value="${model.master }"
					data-options="" class="easyui-textbox" style="width: 180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">负责人电话</td>
				<td><input type="text" name="t_Bus_Materialfirm.mastertel" value="${model.mastertel }"
					data-options="validType:'phone'" class="easyui-textbox"
					style="width: 180px;" /></td>

				<td class="sp-td1">负责人手机</td>
				<td><input type="text" name="t_Bus_Materialfirm.masterphone" value="${model.masterphone }"
					data-options="validType:'mobile'" class="easyui-textbox"
					style="width: 180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">联系人</td>
				<td><input type="text" name="t_Bus_Materialfirm.linkman" value="${model.linkman }"
					data-options="" class="easyui-textbox" style="width: 180px;" /></td>

				<td class="sp-td1">联系人电话</td>
				<td><input type="text" name="t_Bus_Materialfirm.linkmantel" value="${model.linkmantel }"
					data-options="validType:'phone'" class="easyui-textbox"
					style="width: 180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">联系人手机</td>
				<td><input type="text" name="t_Bus_Materialfirm.linkmanphone" value="${model.linkmanphone }"
					data-options="validType:'mobile'" class="easyui-textbox"
					style="width: 180px;" /></td>

				<td class="sp-td1">最近更新时间</td>
				<td><input type="text" name="t_Bus_Materialfirm.updatetime"
					data-options="disabled:true,readonly:true" class="easyui-textbox"
					style="width: 180px;" value="${model.updatetime}" /></td>
			</tr>
			<tr>
				<td class="sp-td1">地址</td>
				<td colspan="3"><input type="text" value="${model.address}"
					name="t_Bus_Materialfirm.address" data-options=""
					class="easyui-textbox" style="width: 570px;" /></td>
			</tr>
			<tr>
				<td class="sp-td1">生产物资</td>
				<td colspan="3"><textarea
						name="t_Bus_Materialfirm.materialdesc" class="textarea"
						data-options="validType:'length[0,500]'"
						style="width: 570px;height: 50px;">${model.materialdesc}</textarea></td>
			</tr>
			<tr>
				<td class="sp-td1">生产能力</td>
				<td colspan="3"><textarea name="t_Bus_Materialfirm.procap"
						class="textarea" data-options="validType:'length[0,500]'"
						style="width: 570px;height: 50px;">${model.procap}</textarea></td>
			</tr>
			<tr>
				<td class="sp-td1">备注</td>
				<td colspan="3"><textarea name="t_Bus_Materialfirm.remark"
						class="textarea" data-options="validType:'length[0,500]'"
						style="width: 570px;height: 50px;">${model.remark}</textarea></td>
			</tr>
			<tr>
				<td class="sp-td1">附件</td>
				<td colspan="5">
					<div>
						<input type="file" name="file" id="fjfile" />
						<div id="fileQueue">
							<div id="filebox" style="width:450px;">
								<c:if test="${! empty model.fjname}">
									<div id="fj_${model.fjid}">
										<input type="hidden" value="${model.fjid}" name="fjid" /> <a
											class="btnAttach" title="请点击另存为"></a><a title="请点击另存为"
											target="_blank"
											href="<%=basePath%>Main/attachment/downloadFJ/${model.fjid}">${model.fjname}</a>（${model.m_size}）
										<a href="javascript:deleteFile(${model.fjid})"><img
											src="<%=basePath%>plugins/uploadify/cancel.png" height="13"
											align="middle" /></a>
									</div>
								</c:if>
							</div>
						</div>
					</div>

				</td>
			</tr>
		</table>
	</div>
</form>
