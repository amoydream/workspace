<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
//打开地图
function DTClick(){
	$.lauvan.openGisDialog($("#cas_longitude").val(),$("#cas_latitude").val(),function(lng,lat){
		$("#cas_longitude").textbox('setValue',lng);
		$("#cas_latitude").textbox('setValue',lat);
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
<form id="casesForm" method="post" action="<%=basePath%>Main/cases/save"
	style="width:100%;margin: 0 auto;padding: 0;">
	<div data-options="region:'north',border:false" style="height:130px;">
		<input type="hidden" name="act" value="update" /> <input type="hidden"
			name="t_Bus_Cases.cas_id" value="${model.cas_id }" />
		<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
			<tr>
			    <td class="sp-td1">编号：</td>
				<td><input name="t_Bus_Cases.code" value="${model.code}"
					type="text"
					data-options="required:true,prompt:'正整数',precision:0,min:0,icons:iconClear"
					class="easyui-numberbox" style="width:180px;" /></td>
			    
				<td class="sp-td1">案例标题：</td>
				<td ><input name="t_Bus_Cases.title"
					value="${model.title}" type="text" class="easyui-textbox"
					data-options="prompt:'请输入案例标题',required:true,icons:iconClear"
					style="width:180px;" /></td>

			</tr>
			<tr>
				<td class="sp-td1">地址：</td>
				<td colspan="3"><input name="t_Bus_Cases.address"
					value="${model.address}" type="text" class="easyui-textbox"
					data-options="prompt:'请输入地址',required:true,icons:iconClear"
					style="width:574px;" /></td>
			</tr>
			<tr>
				<td class="sp-td1">主题词：</td>
				<td><input name="t_Bus_Cases.keyword" value="${model.keyword}"
					type="text" class="easyui-textbox"
					data-options="prompt:'请输入主题词',icons:iconClear"
					style="width:180px;" /></td>
					
				<td class="sp-td1">相关危险源：</td>
		    	<td >
			    		<input type="hidden" name="t_Bus_Cases.dangerid" id="dangerid" value="${model.dangerid}"/>
			    		<input type="text" id="dangername" value="${dangername}" data-options="readonly:true" class="easyui-textbox" style="width: 150px;"/>
			    		<a id="btn" onclick="findDanger()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			    	</td>
			</tr>
			<tr>
			    <td class="sp-td1">事件类型：</td>
		    	<td >
		    	<input class="easyui-combotree" name="t_Bus_Cases.type" 
		    	data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,required:true,value:'${model.type}',icons:iconClear" style="width:180px;">
		  		</td>

				<td class="sp-td1">事件等级：</td>
				<td><select class="easyui-combobox"
					name="t_Bus_Cases.eventlevelcode" panelHeight="auto" code="EVLV"
					style="width: 180px;"
					data-options="editable:false,value:'${model.eventlevelcode}'"></select></td>
            </tr>
			<tr>
				<td class="sp-td1">开始时间：</td>
				<td><input type="text" name="t_Bus_Cases.starttime"
					class="easyui-datetimebox" style="width: 180px;"
					data-options="editable:false,icons:iconClear,value:'${model.starttime}'" /></td>

				<td class="sp-td1">结束时间：</td>
				<td><input type="text" name="t_Bus_Cases.endtime"
					class="easyui-datetimebox" style="width: 180px;"
					data-options="editable:false,icons:iconClear,value:'${model.endtime}'" /></td>
            </tr>
            <tr>
		  		<td class="sp-td1">经度：</td>
		    	<td >
		    	<input id="cas_longitude" name="t_Bus_Cases.cas_longitude" type="text" class="easyui-textbox" 
		    	 style="width: 180px;" data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}],value:'${model.cas_longitude}'"
		    	 />
		    	</td>
		    	<td class="sp-td1">纬度：</td>
		    	<td >
		    	<input id="cas_latitude" name="t_Bus_Cases.cas_latitude" type="text" class="easyui-textbox"  
		    	style="width: 180px;" data-options="readonly:true" value="${model.cas_latitude}"/>
		    	</td>
		    </tr>
			<tr>
				<td class="sp-td1">数据来源单位：</td>
				<td><input class="easyui-combotree"
					name="t_Bus_Cases.sourcedept"
					data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get',value:'${model.sourcedept}'"
					style="width:180px;"></td>

				<td class="sp-td1">最近更新时间：</td>
				<td><input type="text" name="t_Bus_Cases.updatetime"
					class="easyui-datetimebox" style="width: 180px;"
					data-options="editable:false,disabled:true,value:'${model.updatetime}'" /></td>

			</tr>
			<tr>

				<td class="sp-td1">摘要</td>
				<td colspan="3"><textarea name="t_Bus_Cases.caseabstract"
						class="textarea" data-options="validType:'length[0,500]'"
						style="width: 570px;height: 50px;">${model.caseabstract}</textarea></td>

			</tr>
			<tr>

				<td class="sp-td1">备注</td>
				<td colspan="3"><textarea name="t_Bus_Cases.remark"
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
