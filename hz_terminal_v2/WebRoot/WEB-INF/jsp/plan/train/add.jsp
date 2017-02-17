<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
//打开地图
function DTplanTrainClick(){
	$.lauvan.openGisDialog($("#planev_longitude").val(),$("#planev_latitude").val(),function(lng,lat){
		$("#planev_longitude").textbox('setValue',lng);
		$("#planev_latitude").textbox('setValue',lat);
	});
}
</script>	 
	 <form id="planTrainform" method="post" action="<%=basePath %>Main/planyl/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">当前预案：</td>
		    	<td colspan="3">
		    	<input type="hidden" name="t_Bus_PreschTrainEvent.preschid" value="${pinfo.id}"/>
		    	${pinfo.preschname}
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">演练事件名称：</td>
		    	<td >
		    		<input type="text" name="t_Bus_PreschTrainEvent.ev_name" data-options="prompt:'请输入演练事件名称',icons:iconClear,required:true" 
		    	class="easyui-textbox" style="width: 180px;"/>
		    	</td>
		    	<td class="sp-td1">演练事发时间：</td>
		    	<td >
		    		<input type="text" name="t_Bus_PreschTrainEvent.ev_date" class="easyui-datetimebox"   style="width: 180px;"  
		    		data-options="editable:false,required:true,icons:iconClear,value:'${nowdate}'"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">演练事件类型：</td>
		    	<td >
		    	<input class="easyui-combotree" name="t_Bus_PreschTrainEvent.ev_type" 
		    	data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,required:true,icons:iconClear" style="width:180px;">
		  		</td>
		  		<td class="sp-td1">演练事件级别：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_PreschTrainEvent.ev_level"  panelHeight="auto" code="EVLV" style="width: 180px;" 
		    	data-options="editable:false,required:true,icons:iconClear" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td  class="sp-td1" >经度：</td>
		    	<td >
		    	<input id="planev_longitude" name="t_Bus_PreschTrainEvent.ev_longitude"  type="text" class="easyui-textbox"  style="width: 180px;" data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTplanTrainClick}]"/>
		    	</td>
		    	<td  class="sp-td1" >纬度：</td>
		    	<td >
		    	<input id="planev_latitude" name="t_Bus_PreschTrainEvent.ev_latitude"  type="text" class="easyui-textbox lock-on"  style="width: 180px;" data-options="readonly:true"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">演练事发地点：</td>
		    	<td colspan="3">
		    	<input class="easyui-combotree" name="t_Bus_PreschTrainEvent.occurarea" data-options="url:'<%=basePath%>Main/event/getoccurAreaTree',method:'get',editable:false,required:true,icons:iconClear" style="width:180px;">
		    	（镇/街道）
		    	<input type="text" name="t_Bus_PreschTrainEvent.ev_address" data-options="prompt:'请输入事发地点',required:true,icons:iconClear" class="easyui-textbox" style="width: 328px;"/>
		    	</td>
		    	
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">演练事件描述：</td>
		    	<td colspan="3">
		    	<textarea name="t_Bus_PreschTrainEvent.ev_cause" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 573px;height: 40px;" ></textarea>
		    	</td>
		    	
		    	</tr>
	
	    </table>
    </form>