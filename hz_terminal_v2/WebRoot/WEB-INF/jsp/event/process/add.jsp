<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
	 
	 <form id="eventProcessform" method="post" action="<%=basePath %>Main/eventProcess/save" style="width:100%;">
	    <input type="hidden" name="act" value="add"/>
	    <input type="hidden" name="t_Bus_EventProcess.eventid" value="${eventid}"/>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">处置人：</td>
		    	<td >
		    	<input type="text" name="t_Bus_EventProcess.ep_user" data-options="prompt:'请输入处置人名称',required:true,icons:iconClear" class="easyui-textbox" style="width: 180px;"/>
		    	</td>
		    	
		  		<td class="sp-td1">处置时间：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_EventProcess.ep_date"  class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,required:true,icons:iconClear,value:'${nowdate}'"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">处置类型：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_EventProcess.ep_type"  panelHeight="auto" code="EVPY" style="width: 180px;" data-options="editable:false,required:true" ></select>
		  		</td>
		  		<td class="sp-td1">处置单位：</td>
		    	<td >
		    	<input type="text" name="t_Bus_EventProcess.ep_organ" data-options="prompt:'请输入处置单位',required:true,icons:iconClear" class="easyui-textbox" style="width: 180px;"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">报告人：</td>
		    	<td >
		    	<input type="text" name="t_Bus_EventProcess.ep_reporter" data-options="prompt:'请输入处置单位',required:true,icons:iconClear" class="easyui-textbox" style="width: 180px;"/>
		    	</td>
		    	<td class="sp-td1">报告时间：</td>
		    	<td >
		    	<input type="text"  name="t_Bus_EventProcess.ep_reportdate"  class="easyui-datetimebox"   style="width: 180px;"  data-options="editable:false,icons:iconClear"/>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">报告人单位：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventProcess.ep_reportunit" data-options="prompt:'请输入报告人单位',icons:iconClear" class="easyui-textbox" style="width: 180px;"/>
		    	</td>
		    	<td class="sp-td1">报告人电话：</td>
		    	<td >
		    	<input type="text" name="t_Bus_EventProcess.ep_reporttel" data-options="prompt:'请输入报告人电话',icons:iconClear" class="easyui-textbox" style="width: 180px;"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">受灾面积（m²）：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventProcess.ep_affectedarea" data-options="prompt:'小数点保留2位',precision:2,icons:iconClear" class="easyui-numberbox" style="width: 180px;"/>
		    	</td>
		    	<td class="sp-td1">参与（受灾）人数：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventProcess.ep_participationNumber" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" class="easyui-numberbox" style="width: 180px;"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">受伤人数：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventProcess.ep_injuredPeople" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" class="easyui-numberbox" style="width: 180px;"/>
		    	</td>
		    	<td class="sp-td1">死亡人数：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventProcess.ep_deathToll" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear" class="easyui-numberbox" style="width: 180px;"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">经济损失（万元）：</td>
		    	<td >
		    		<input type="text" name="t_Bus_EventProcess.ep_economicLoss" data-options="prompt:'小数点保留2位',precision:2,icons:iconClear" class="easyui-numberbox" style="width: 180px;"/>
		    	</td>
		    	<td class="sp-td1">记录人：</td>
		    	<td >
		    		<input type="text" name="username" data-options="readonly:true" class="easyui-textbox" value="${loginModel.userName}" style="width: 180px;"/>
		    	</td>
		    	</tr>

		    	<tr>
		  		<td class="sp-td1">处置内容</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventProcess.ep_content" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 560px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventProcess.remark" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 560px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
		    	
	    </table>
    </form>
