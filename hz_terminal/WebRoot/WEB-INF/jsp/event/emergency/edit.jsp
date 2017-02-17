<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
var basePath = '<%=basePath %>';
//打开地图
function DTClick(){
	$.lauvan.openGisDialog($("#ev_longitude").val(),$("#ev_latitude").val(),function(lng,lat){
		$("#ev_longitude").textbox('setValue',lng);
		$("#ev_latitude").textbox('setValue',lat);
	});
}
function ephoneClickFN(){
	var phone = $("#_evphone").val();
	var eid = '${t.id}';
	if(phone==null || phone=='' || phone==undefined){
		alert("请输入电话号码进行拨打！");
		return;
	}
	callout(phone, eid);
}
function ephoneRECEClickFN(){
	var phone = $("#_evphoneRECE").val();
	var eid = '${t.id}';
	if(phone==null || phone=='' || phone==undefined){
		alert("请输入电话号码进行拨打！");
		return;
	}
	callout(phone, eid);
}
function ephoneAddClickFN(){
	var phone = $("#_evphone").val();
	var pname = $("#_evphname").val();
	if(phone==null || phone=='' || phone==undefined){
		alert("请输入电话号码进行添加通讯录到工作联络网！");
		return;
	}
	tel_addWN(phone, pname);
}
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
	 
	 <form id="emerganceform" method="post" action="<%=basePath %>Main/event/save" style="width:100%;">
	    <input type="hidden" name="act" value="upd"/>
	    <input type="hidden" name="t_Bus_EventInfo.id" value="${t.id}"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">事件名称：</td>
		    	<td colspan="5">
		    	<input type="text" name="t_Bus_EventInfo.ev_name" data-options="prompt:'请输入事件名称',required:true,icons:iconClear" 
		    	class="easyui-textbox" style="width: 800px;" value="${t.ev_name}"/></td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">事发地点：</td>
		    	<td colspan="5">
		    	<input class="easyui-combotree" name="t_Bus_EventInfo.occurarea" data-options="url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get',editable:false,required:true,value:'${t.occurarea}',icons:iconClear" style="width:180px;">
		    	（区/县）
		    	<input type="text" name="t_Bus_EventInfo.ev_address" data-options="prompt:'请输入事发地点',icons:iconClear" 
		    	class="easyui-textbox" style="width: 560px;" value="${t.ev_address}"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">事件类型：</td>
		    	<td >
		    	<input class="easyui-combotree" name="t_Bus_EventInfo.ev_type" 
		    	data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,required:true,value:'${t.ev_type}',icons:iconClear" style="width:180px;">
		  		</td>
		  		<td class="sp-td1">事件级别：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_EventInfo.ev_level"  panelHeight="auto" code="EVLV" 
		    	style="width: 180px;" data-options="editable:false,required:true,value:'${t.ev_level}',icons:iconClear" ></select>
		    	</td>
		    	
		  		<td class="sp-td1">事发时间：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_EventInfo.ev_date"  class="easyui-datetimebox"   
		    	style="width: 180px;"  data-options="editable:false,required:true,value:'${t.ev_date}',icons:iconClear"/>
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">接报时间：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_EventInfo.ev_reportdate"  class="easyui-datetimebox"   
		    	style="width: 180px;"  data-options="editable:false,required:true,icons:iconClear" value="${t.ev_reportdate}"/>
		    	</td>
		    	
		  		<td class="sp-td1">事发单位：</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Bus_EventInfo.organid"
		    		 data-options="url:'<%=basePath%>Main/event/getComboTree',method:'get',value:'${t.organid}',icons:iconClear" style="width:180px;">
		    	</td>
		    	<td class="sp-td1">接报方式：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_EventInfo.ev_reportmode"  panelHeight="auto" code="EVRP"
		    	 style="width: 180px;" data-options="editable:false,required:true,value:'${t.ev_reportmode}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    		<td class="sp-td1">接报人姓名：</td>
		    		<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_receername"  value="${t.ev_receername}"
		    		data-options="prompt:'请输入接报人姓名',icons:iconClear" class="easyui-textbox" style="width: 180px;"/></td>
		    		</td>
		    		
		    		<td  class="sp-td1" >接报人电话：</td>
			    	<td colspan="3">
			    		<input type="text" id="_evphoneRECE" name="t_Bus_EventInfo.ev_recetel"  value="${t.ev_recetel}"
			    		data-options="prompt:'请输入接报人电话',icons:[{iconCls:'icon-phonereceived',handler:ephoneRECEClickFN}]" class="easyui-textbox" style="width: 180px;"/></td>
			    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">受灾面积（m²）：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_affectedarea" data-options="prompt:'小数点保留2位',precision:2,icons:iconClear" 
		    		class="easyui-numberbox" style="width: 180px;" value="${t.ev_affectedarea}"/>
		    	</td>
		    	<td class="sp-td1">受灾人数：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_participationnumber" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" 
		    		class="easyui-numberbox" style="width: 180px;" value="${t.ev_participationnumber}"/>
		    	</td>
		    	
		  		<td class="sp-td1">受伤人数：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_injuredpeople" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" 
		    		class="easyui-numberbox" style="width: 180px;"  value="${t.ev_injuredpeople}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">死亡人数：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_deathtoll" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" 
		    		class="easyui-numberbox" style="width: 180px;" value="${t.ev_deathtoll}"/>
		    	</td>
		    	
		  		<td class="sp-td1">经济损失（万元）：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_economicloss" data-options="prompt:'小数点保留2位',precision:2,icons:iconClear" 
		    		class="easyui-numberbox" style="width: 180px;"  value="${t.ev_economicloss}"/>
		    	</td>
		    	<td class="sp-td1">结束时间：</td>
		    	<td >
		    		<input type="text"  name="t_Bus_EventInfo.ev_enddate"  class="easyui-datetimebox"   style="width: 180px;" 
		    		 data-options="editable:false" value="${t.ev_enddate}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">经度：</td>
		    	<td >
		    	<input id="ev_longitude" name="t_Bus_EventInfo.ev_longitude" type="text" class="easyui-textbox" 
		    	 style="width: 180px;" data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}],value:'${t.ev_longitude}'"
		    	 />
		    	</td>
		    	<td class="sp-td1">纬度：</td>
		    	<td >
		    	<input id="ev_latitude" name="t_Bus_EventInfo.ev_latitude" type="text" class="easyui-textbox"  
		    	style="width: 180px;" data-options="readonly:true" value="${t.ev_latitude}"/>
		    	</td>
		    	
		  		<td class="sp-td1">报告人姓名：</td>
		    	<td >
		    		<input type="text" id="_evphname" name="t_Bus_EventInfo.ev_reporter" data-options="prompt:'请输入报告人姓名',icons:iconClear" 
		    		class="easyui-textbox" style="width: 180px;" value="${t.ev_reporter}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">报告人电话：</td>
		    	<td >
		    		<input type="text" id="_evphone" name="t_Bus_EventInfo.ev_reporttel" 
		    		data-options="prompt:'请输入报告人电话',required:true,icons:[{iconCls:'icon-phonereceived',handler:ephoneClickFN},{iconCls:'icon-reportedit',handler:ephoneAddClickFN}]" 
		    		class="easyui-textbox" style="width: 180px;" value="${t.ev_reporttel}"/>
		    	</td>
		    	
		  		<td class="sp-td1">报告人职务：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_reportpost" data-options="icons:iconClear" 
		    		class="easyui-textbox" style="width: 180px;" value="${t.ev_reportpost}"/>
		    	</td>
		    	<td class="sp-td1">报告人单位：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_reportunit" data-options="icons:iconClear" 
		    		class="easyui-textbox" style="width: 180px;" value="${t.ev_reportunit}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">报告人地址：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_reportaddress" data-options="icons:iconClear" 
		    		class="easyui-textbox" style="width: 180px;" value="${t.ev_reportaddress}"/>
		    	</td>
		    	<td class="sp-td1">相关人员：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_relatedpersonnel" data-options="icons:iconClear" 
		    		class="easyui-textbox" style="width: 180px;" value="${t.ev_relatedpersonnel}"/>
		    	</td>
		    	<td  class="sp-td1" >使用情况：</td>
		    	<td >
		    		<select class="easyui-combobox" name="t_Bus_EventInfo.ev_usestatus"  panelHeight="auto" code="EVUS" style="width: 180px;" data-options="editable:false,required:true,icons:iconClear,value:'${t.ev_usestatus}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td  class="sp-td1" >报送时效：</td>
		    	<td >
		    		<select class="easyui-combobox" name="t_Bus_EventInfo.ev_bssx"  panelHeight="auto" code="EVSX" style="width: 180px;" data-options="editable:false,required:true,icons:iconClear,value:'${t.ev_bssx}'" ></select>
		    	</td>
		    	<td class="sp-td1">现场图片：</td>
		    	<td colspan="3">
		    	<input  id="eventTXfile"  type="file" name="file"/>
		    	<div id="eventTXfileList" style="width: 500px;">
		    	<c:if test="${!empty t.ev_img}">
		    	<div id='evTxfile_${t.ev_img}' style='height:25px;line-height:25px;font-size:12px;'>
		    	<a title="请点击打开" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${t.ev_img}">${imgfj.name}<a/> 
		    	</c:if>
		    	</div>
		    	</td>
		    	</tr>
		    	<tr>
		    	
		    	<td  class="sp-td1" >国家领导批示：</td>
		    	<td colspan="2">
		    		<textarea name="t_Bus_EventInfo.ev_guops" class="textarea" 
		    		data-options="validType:'length[0,1000]'"  style="width: 270px;height: 40px;" >${t.ev_guops}</textarea>
		    	</td>
		    	
		  		<td  class="sp-td1" >省领导批示：</td>
		    	<td colspan="2">
		    		<textarea name="t_Bus_EventInfo.ev_shengps" class="textarea" 
		    		data-options="validType:'length[0,1000]'"  style="width: 270px;height: 40px;" >${t.ev_shengps}</textarea>
		    	</td>
		    	
		  		
		    	</tr>
		    	
		    	<tr>
		    	<td  class="sp-td1" >市领导批示：</td>
		    	<td colspan="5">
		    		<textarea name="t_Bus_EventInfo.ev_ships" class="textarea" 
		    		data-options="validType:'length[0,1000]'"  style="width: 765px;height: 40px;" >${t.ev_ships}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">事件基本情况</td>
		    	<td colspan="5">
		    		<textarea name="t_Bus_EventInfo.ev_basicsituation" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 765px;height: 40px;" >${t.ev_basicsituation}</textarea>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">事件起因、性质</td>
		    	<td colspan="2">
		    		<textarea name="t_Bus_EventInfo.ev_cause" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 270px;height: 40px;" >${t.ev_cause}</textarea>
		    	</td>
		    	
		  		<td class="sp-td1">影响范围、发展趋势</td>
		    	<td colspan="2">
		    		<textarea name="t_Bus_EventInfo.ev_influencescope" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 270px;height: 40px;" >${t.ev_influencescope}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">先期处置情况</td>
		    	<td colspan="2">
		    		<textarea name="t_Bus_EventInfo.ev_advanceddisposal" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 270px;height: 40px;" >${t.ev_advanceddisposal}</textarea>
		    	</td>
		    	<td class="sp-td1">拟采取的措施和 下一步工作建议</td>
		    	<td colspan="2">
		    		<textarea name="t_Bus_EventInfo.ev_nextstep" class="textarea" 
		    		data-options="validType:'length[0,600]'"  style="width: 270px;height: 40px;"  >${t.ev_nextstep}</textarea>
		    	</td>
		    	</tr>
		    	
		    	
	    </table>
    </form>
