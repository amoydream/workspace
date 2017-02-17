<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
var basePath = '<%=basePath %>';
$(function(){		
	$("#eventTXfile").uploadify({
		buttonText: "上传", //按钮上的文字 
        uploader: basePath+"plugins/uploadify/scripts/uploadify.swf",
        script:  basePath+"Main/attachment/save/eventTxFile-${loginModel.userAccount}-${loginModel.userId}",
        cancelImg: basePath+"plugins/uploadify/cancel.png",
        auto: true, //是否自动开始     
        multi: true, //是否支持多文件上传
        fileDataName:'file',
        fileQueue:'fileQueue',
        fileDesc:'*.jpg;*.png;*.gif;',
        fileExt:'**.jpg;*.png;*.gif;',
        onComplete:_eventTXonComplete
        });
});

function _eventTXonComplete(event, queueId, fileObj, response, data){	
var obj = eval( "(" + response + ")" );//转换后的JSON对象
var htmlBody="";
htmlBody+="<div id='evTxfile_"+obj.id+"' style='height:25px;line-height:25px;font-size:12px;'>";
htmlBody+="<span style='display:none'><input type='checkbox' name='ectxid' value='"+obj.id+"' checked/></span>";
htmlBody+="<a title='请点击另存为' target='_blank' href='"+basePath+"Main/attachment/downloadFJ/"+obj.id+"'>"+obj.name+"<a/> （"
			+obj.size+"）<a href='javascript:deletetxFile("+obj.id+");'><img src='"+basePath+"plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
htmlBody+="</div>";
$("#eventTXfileList").html(htmlBody);
}
//删除文件ajax请求
function deletetxFile(id){
$("#evTxfile_"+id).load(basePath+"Main/attachment/delete/"+id);
$("#evTxfile_"+id).remove();
}
</script>
	 
	 <form id="routineform" method="post" action="<%=basePath %>Main/eventRoutine/save" style="width:100%;">
	 	<input type="hidden" name="callId" value="${callId}"/>
	    <input type="hidden" name="act" value="add"/>
	    <input type="hidden" name="t_Bus_EventInfo.occurcity" value="441303"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">事件名称：</td>
		    	<td >
		    	<input type="text" name="t_Bus_EventInfo.ev_name" data-options="prompt:'请输入事件名称',required:true,icons:iconClear" class="easyui-textbox" style="width: 180px;"/></td>
		    	
		    	<td class="sp-td1">事发单位：</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Bus_EventInfo.organid" data-options="url:'<%=basePath%>Main/department/getComboTree',method:'get'" style="width:180px;">
		    	</td>
		    	
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">事件类型：</td>
		    	<td >
		    	<input class="easyui-combotree" name="t_Bus_EventInfo.ev_type" data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,required:true" style="width:180px;">
		  		</td>
		  		<td class="sp-td1">接报方式：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_EventInfo.ev_reportmode"  panelHeight="auto" code="EVRP" style="width: 180px;" data-options="editable:false,required:true" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">事发时间：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_EventInfo.ev_date"  class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,required:true,icons:iconClear,value:'${nowdate}'"/>
		    	</td>
		    	<td class="sp-td1">接报时间：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_EventInfo.ev_reportdate"  class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,required:true,icons:iconClear,value:'${nowdate}'"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">报告人姓名：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_reporter" data-options="prompt:'请输入报告人姓名',required:true,icons:iconClear" class="easyui-textbox" style="width: 180px;"/></td>
		    	</td>
		    	<td class="sp-td1">报告人电话：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_reporttel" data-options="prompt:'请输入报告人电话',required:true,icons:iconClear,value:'${ev_reporttel}'" class="easyui-textbox" style="width: 180px;"/></td>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">事发地点：</td>
		    	<td colspan="3">
		    	<input class="easyui-combotree" name="t_Bus_EventInfo.occurarea" data-options="url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get',editable:false,required:true" style="width:180px;">
		    	（镇/街道）
		    	<input type="text" name="t_Bus_EventInfo.ev_address" data-options="prompt:'请输入事发地点',required:true,icons:iconClear" class="easyui-textbox" style="width: 328px;"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td  class="sp-td1" >使用情况：</td>
		    	<td >
		    		<select class="easyui-combobox" name="t_Bus_EventInfo.ev_usestatus"  panelHeight="auto" code="EVUS" style="width: 180px;" data-options="editable:false,required:true,icons:iconClear" ></select>
		    	</td>
		    	<td  class="sp-td1" >报送时效：</td>
		    	<td >
		    		<select class="easyui-combobox" name="t_Bus_EventInfo.ev_bssx"  panelHeight="auto" code="EVSX" style="width: 180px;" data-options="editable:false,required:true,icons:iconClear" ></select>
		    	</td>
		    	</tr>
		    	<tr>
		    	<td  class="sp-td1">现场图片：</td>
		    	<td  colspan="3">
		    	<input  id="eventTXfile"  type="file" name="file"/>
		    	<div id="eventTXfileList" style="width: 270px;"></div>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">事件基本情况</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventInfo.ev_basicSituation" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 573px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td  class="sp-td1" >国家领导批示：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventInfo.ev_guops" class="textarea" 
		    		data-options="validType:'length[0,1000]'"  style="width: 573px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td  class="sp-td1" >省领导批示：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventInfo.ev_shengps" class="textarea" 
		    		data-options="validType:'length[0,1000]'"  style="width: 573px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td  class="sp-td1" >市领导批示：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventInfo.ev_ships" class="textarea" 
		    		data-options="validType:'length[0,1000]'"  style="width: 573px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	
	    </table>
    </form>
