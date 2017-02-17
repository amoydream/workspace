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
<form id="repertoryEdit" method="post"
	action="<%=basePath%>Main/repertory/save"
	style="width:100%;margin: 0 auto;padding: 0;">
	<div data-options="region:'north',border:false" style="height:130px;">
		<input type="hidden" name="t_Bus_Repertory.rep_id"
			value="${model.rep_id }" />
		<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td class="sp-td1">编号：</td>
				<td><input name="t_Bus_Repertory.code" value="${model.code }"
					type="text"
					data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
					class="easyui-numberbox" style="width:180px;" /></td>

				<td class="sp-td1">名称：</td>
				<td><input name="t_Bus_Repertory.name" value="${model.name }"
					type="text" class="easyui-textbox"
					data-options="prompt:'请输入名称',required:true,icons:iconClear"
					style="width:180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">级别：</td>
				<td><select class="easyui-combobox"
					name="t_Bus_Repertory.levelcode" panelHeight="auto" code="MALEVE"
					style="width: 180px;"
					data-options="editable:false,value:'${model.levelcode}'"></select>
				</td>

				<td class="sp-td1">值班电话：</td>
				<td><input name="t_Bus_Repertory.dutytel"
					value="${model.dutytel }" type="text"
					data-options="validType:'phone',icons:iconClear"
					class="easyui-textbox" style="width:180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">地址：</td>
				<td colspan="3"><input name="t_Bus_Repertory.address"
					value="${model.address }" type="text" class="easyui-textbox"
					data-options="required:true,prompt:'请输入地址',icons:iconClear"
					style="width:564px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">传真：</td>
				<td><input name="t_Bus_Repertory.fax" value="${model.fax }"
					type="text" data-options="validType:'faxno',icons:iconClear"
					class="easyui-numberbox" style="width:180px;" /></td>

				<td class="sp-td1">负责人：</td>
				<td><input name="t_Bus_Repertory.master"
					value="${model.master }" type="text"
					data-options="prompt:'请输入负责人姓名',icons:iconClear"
					class="easyui-textbox" style="width:180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">负责人电话：</td>
				<td><input name="t_Bus_Repertory.mastertel"
					value="${model.mastertel }" type="text" class="easyui-textbox"
					data-options="validType:'phone',icons:iconClear"
					style="width:180px;" /></td>

				<td class="sp-td1">负责人手机：</td>
				<td><input name="t_Bus_Repertory.masterphone"
					value="${model.masterphone }" type="text" class="easyui-textbox"
					data-options="validType:'mobile',icons:iconClear"
					style="width:180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">联系人：</td>
				<td><input name="t_Bus_Repertory.linkman"
					value="${model.linkman }" type="text"
					data-options="prompt:'请输入负责人姓名',icons:iconClear"
					class="easyui-textbox" style="width:180px;" /></td>

				<td class="sp-td1">联系人电话：</td>
				<td><input name="t_Bus_Repertory.linkmantel"
					value="${model.linkmantel }" type="text" class="easyui-textbox"
					data-options="validType:'phone',icons:iconClear"
					style="width:180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">联系人手机：</td>
				<td><input name="t_Bus_Repertory.linkmanphone"
					value="${model.linkmanphone }" type="text" class="easyui-textbox"
					data-options="validType:'mobile',icons:iconClear"
					style="width:180px;" /></td>

				<td class="sp-td1">联系人Email：</td>
				<td><input name="t_Bus_Repertory.linkmanemail"
					value="${model.linkmanemail }" type="text" class="easyui-textbox"
					data-options="validType:'email',icons:iconClear"
					style="width:180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">所属单位：</td>
				<td><input class="easyui-combotree"
					name="t_Bus_Repertory.organid"
					data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get',value:'${model.organid}'"
					style="width:180px;"></td>

				<td class="sp-td1">经度：</td>
				<td><input id="longitude" name="t_Bus_Repertory.longitude"
					value="${model.longitude}" type="text" class="easyui-textbox"
					style="width: 180px;"
					data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}]" />
				</td>
			</tr>

			<tr>
				<td class="sp-td1">纬度：</td>
				<td><input id="latitude" name="t_Bus_Repertory.latitude"
					value="${model.latitude}" type="text"
					class="easyui-textbox lock-on" style="width: 180px;"
					data-options="readonly:true" /></td>

				<td class="sp-td1">面积：</td>
				<td><input name="t_Bus_Repertory.area" value="${model.area }"
					type="text"
					data-options="prompt:'正整数',precision:0,min:0,icons:iconClear"
					class="easyui-numberbox" style="width:180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">人数：</td>
				<td><input name="t_Bus_Repertory.personnum"
					value="${model.personnum }" type="text"
					data-options="prompt:'正整数',precision:0,min:0,icons:iconClear"
					class="easyui-numberbox" style="width:180px;" /></td>

				<td class="sp-td1">投入使用日期：</td>
				<td><input type="text" name="t_Bus_Repertory.inusedate"
					class="easyui-datebox" style="width: 180px;"
					data-options="editable:false,icons:iconClear,value:'${model.inusedate}'" /></td>
			</tr>

			<tr>
				<td class="sp-td1">设计使用年限：</td>
				<td><input name="t_Bus_Repertory.useyearnum"
					value="${model.useyearnum }" type="text"
					data-options="prompt:'正整数',precision:0,min:0,icons:iconClear"
					class="easyui-numberbox" style="width:180px;" /></td>

				<td class="sp-td1">防护等级：</td>
				<td><select class="easyui-combobox"
					name="t_Bus_Repertory.deflevelcode" panelHeight="auto"
					code="MADEFE" style="width: 180px;"
					data-options="editable:false,value:'${model.deflevelcode}'"></select>
				</td>
			</tr>

			<tr>
				<td class="sp-td1">可容纳人数：</td>
				<td><input name="t_Bus_Repertory.maxpersonnum"
					value="${model.maxpersonnum }" type="text"
					data-options="prompt:'正整数',precision:0,min:0,icons:iconClear"
					class="easyui-numberbox" style="width:180px;" /></td>

				<td class="sp-td1">库容：</td>
				<td><input name="t_Bus_Repertory.capacity"
					value="${model.capacity }" type="text"
					data-options="prompt:'正整数',precision:0,min:0,icons:iconClear"
					class="easyui-numberbox" style="width:180px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">监测方式：</td>
				<td><input name="t_Bus_Repertory.monitmode"
					value="${model.monitmode }" type="text" class="easyui-textbox"
					data-options="prompt:'请输入监测方式',icons:iconClear"
					style="width:180px;" /></td>

				<td class="sp-td1">最近更新日期：</td>
				<td><input type="text" name="t_Bus_Repertory.updatetime"
					class="easyui-datetimebox" style="width: 180px;"
					data-options="editable:false,disabled:true,value:'${model.updatetime}'" /></td>
			</tr>

			<tr>
				<td class="sp-td1">周边交通情况：</td>
				<td colspan="3"><input name="t_Bus_Repertory.traffic"
					value="${model.traffic }" type="text" class="easyui-textbox"
					data-options="prompt:'请输入周边交通情况',icons:iconClear"
					style="width:564px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">受灾形式：</td>
				<td colspan="3"><input name="t_Bus_Repertory.disasterform"
					value="${model.disasterform }" type="text" class="easyui-textbox"
					data-options="prompt:'请输入受灾形式',icons:iconClear"
					style="width:564px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">应急通讯方式：</td>
				<td colspan="3"><input name="t_Bus_Repertory.commtype"
					value="${model.commtype }" type="text" class="easyui-textbox"
					data-options="prompt:'请输入应急通讯方式',icons:iconClear"
					style="width:564px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">防护区域：</td>
				<td colspan="3"><input name="t_Bus_Repertory.defencearea"
					value="${model.defencearea }" type="text" class="easyui-textbox"
					data-options="prompt:'请输入防护区域',icons:iconClear"
					style="width:564px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">防护措施：</td>
				<td colspan="3"><input name="t_Bus_Repertory.defencestep"
					value="${model.defencestep }" type="text" class="easyui-textbox"
					data-options="prompt:'请输入防护措施',icons:iconClear"
					style="width:564px;" /></td>
			</tr>

			<tr>
				<td class="sp-td1">交通运输力量：</td>
				<td colspan="3"><input name="t_Bus_Repertory.trafficcap"
					value="${model.trafficcap }" type="text" class="easyui-textbox"
					data-options="prompt:'请输入交通运输力量',icons:iconClear"
					style="width:564px;" /></td>
			</tr>
			<tr>
				<td class="sp-td1">基本情况：</td>
				<td colspan="3"><textarea name="t_Bus_Repertory.description"
						class="textarea" data-options="validType:'length[0,500]'"
						style="width: 560px;height: 50px;">${model.description}</textarea>
				</td>
			</tr>

			<tr>
				<td class="sp-td1">储备物资：</td>
				<td colspan="3"><textarea name="t_Bus_Repertory.material"
						class="textarea" data-options="validType:'length[0,500]'"
						style="width: 560px;height: 50px;">${model.material}</textarea>
				</td>
			</tr>

			<tr>
				<td class="sp-td1">备注：</td>
				<td colspan="3"><textarea name="t_Bus_Repertory.remark"
						class="textarea" data-options="validType:'length[0,500]'"
						style="width: 560px;height: 50px;">${model.remark}</textarea>
				</td>
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
