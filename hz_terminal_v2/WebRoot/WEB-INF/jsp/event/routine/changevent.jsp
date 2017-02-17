<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
//打开地图
function DTClick(){
	$.lauvan.openGisDialog($("#ev_longitude").val(),$("#ev_latitude").val(),function(lng,lat){
		$("#ev_longitude").textbox('setValue',lng);
		$("#ev_latitude").textbox('setValue',lat);
	});
}
</script>
	 
	 <form id="emerganceform" method="post" action="<%=basePath %>Main/event/save" style="width:100%;">
	    <input type="hidden" name="act" value="change"/>
	    <input type="hidden" name="t_Bus_EventInfo.id" value="${t.id}"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">事件名称：</td>
		    	<td >
		    	<input type="text" name="t_Bus_EventInfo.ev_name" data-options="prompt:'请输入事件名称',required:true,icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;" value="${t.ev_name}"/></td>
		    	
		  		<td class="sp-td1">事发地点：</td>
		    	<td >
		    	<input type="text" name="t_Bus_EventInfo.ev_address" data-options="prompt:'请输入事发地点',required:true,icons:iconClear" 
		    	class="easyui-textbox" style="width: 180px;" value="${t.ev_address}"/></td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">事件类型：</td>
		    	<td >
		    	<input class="easyui-combotree" name="t_Bus_EventInfo.ev_type" 
		    	data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,required:true,value:'${t.ev_type}'" style="width:180px;">
		  		</td>
		  		<td class="sp-td1">事件级别：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_EventInfo.ev_level"  panelHeight="auto" code="EVLV" 
		    	style="width: 180px;" data-options="editable:false,required:true,value:'${t.ev_level}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">事发时间：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_EventInfo.ev_date"  class="easyui-datetimebox"   
		    	style="width: 180px;"  data-options="editable:false,required:true,value:'${t.ev_date}'"/>
		    	</td>
		    	<td class="sp-td1">接报时间：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_EventInfo.ev_reportdate"  class="easyui-datetimebox"   
		    	style="width: 180px;"  data-options="editable:false,required:true" value="${t.ev_reportdate}"/>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">事发单位：</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Bus_EventInfo.organid"
		    		 data-options="url:'<%=basePath%>Main/department/getComboTree',method:'get',value:'${t.organid}'" style="width:180px;">
		    	</td>
		    	<td class="sp-td1">接报方式：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_EventInfo.ev_reportmode"  panelHeight="auto" code="EVRP"
		    	 style="width: 180px;" data-options="editable:false,required:true,value:'${t.ev_reportmode}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">受灾面积（m²）：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_affectedarea" data-options="prompt:'小数点保留2位',precision:2,icons:iconClear" 
		    		class="easyui-numberbox" style="width: 180px;" value="${t.ev_affectedarea}"/>
		    	</td>
		    	<td class="sp-td1">参与（受灾）人数：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_participationnumber" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" 
		    		class="easyui-numberbox" style="width: 180px;" value="${t.ev_participationnumber}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">受伤人数：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_injuredpeople" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" 
		    		class="easyui-numberbox" style="width: 180px;"  value="${t.ev_injuredpeople}"/>
		    	</td>
		    	<td class="sp-td1">死亡人数：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_deathtoll" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" 
		    		class="easyui-numberbox" style="width: 180px;" value="${t.ev_deathtoll}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
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
		    	<input id="ev_longitude" name="t_Bus_EventInfo.ev_longitude" type="text" class="easyui-searchbox" 
		    	 style="width: 180px;" data-options="editable:false,searcher:DTClick,value:'${t.ev_longitude}'"
		    	 />
		    	</td>
		    	<td class="sp-td1">纬度：</td>
		    	<td >
		    	<input id="ev_latitude" name="t_Bus_EventInfo.ev_latitude" type="text" class="easyui-textbox"  
		    	style="width: 180px;" data-options="readonly:true" value="${t.ev_latitude}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">报告人姓名：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_reporter" data-options="prompt:'请输入报告人姓名',required:true,icons:iconClear" 
		    		class="easyui-textbox" style="width: 180px;" value="${t.ev_reporter}"/>
		    	</td>
		    	<td class="sp-td1">报告人电话：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventInfo.ev_reporttel" data-options="prompt:'请输入报告人电话',required:true,icons:iconClear" 
		    		class="easyui-textbox" style="width: 180px;" value="${t.ev_reporttel}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
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
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">事件起因、性质</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventInfo.ev_cause" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 400px;height: 50px;" >${t.ev_cause}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">影响范围、发展趋势</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventInfo.ev_influencescope" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 400px;height: 50px;" >${t.ev_influencescope}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">先期处置情况</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventInfo.ev_advanceddisposal" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 400px;height: 50px;" >${t.ev_advanceddisposal}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">事件基本情况</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventInfo.ev_basicsituation" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 400px;height: 50px;" >${t.ev_basicsituation}</textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">拟采取的措施和 下一步工作建议</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventInfo.ev_nextstep" class="textarea" 
		    		data-options="validType:'length[0,600]'"  style="width: 400px;height: 50px;" >${t.ev_nextstep}</textarea>
		    	</td>
		    	</tr>
	    </table>
    </form>
