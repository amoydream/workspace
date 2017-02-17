<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
var basePath = '<%=basePath%>';
//打开地图
function app_DTClick(){
	$.lauvan.openGisDialog($("#_appnews_ev_longitude").val(),$("#_appnews_ev_latitude").val(),function(lng,lat){
		$("#_appnews_ev_longitude").textbox('setValue',lng);
		$("#_appnews_ev_latitude").textbox('setValue',lat);
	});
}

</script>
<div class="easyui-layout"  data-options="fit:true">

<div data-options="region:'center',border:false">
	 <form id="evenAppNewsjform" method="post" action="<%=basePath %>Main/event/appNewsSave" style="width:100%;padding: 0px;margin: 0px;">
	    <table  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		  		<td class="sp-td1" style="width:100px;" >事件名称：</td>
		    	<td colspan="3">
		    		<input type="hidden"  name="t_Bus_EventAppNews.eventid" value="${e.id}" />
		    		<input type="hidden"  name="t_Bus_EventAppNews.evname" value="${e.ev_name}" />
		    		${e.ev_name}
		    	</td>
		    	</tr>
				<tr>
		  		<td class="sp-td1" style="width:100px;" >事发地点：</td>
		    	<td colspan="3">
		    		<input type="hidden"  name="t_Bus_EventAppNews.evaddress" value="${str:translate(e.occurarea,'EVQY')}  ${e.ev_address}" />
		    		${str:translate(e.occurarea,'EVQY')}&nbsp;&nbsp;&nbsp;${e.ev_address}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">经度：</td>
		    	<td >
		    	<input id="_appnews_ev_longitude" name="t_Bus_EventAppNews.pointx" type="text" class="easyui-textbox" 
		    	 style="width: 180px;" data-options="required:true,editable:false,icons:[{iconCls:'icon-world',handler:app_DTClick}],value:'${e.ev_longitude}'"
		    	 />
		    	</td>
		    	<td class="sp-td1">纬度：</td>
		    	<td >
		    	<input id="_appnews_ev_latitude" name="t_Bus_EventAppNews.pointy" type="text" class="easyui-textbox"  
		    	style="width: 180px;" data-options="required:true,readonly:true" value="${e.ev_latitude}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1" style="width:100px;" >快报内容：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_EventAppNews.content" class="textarea" 
		    		data-options="required:true,validType:'length[0,500]'"  style="width: 525px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
	    </table>
    </form>
</div>

</div>	
	<div id="_zhduserDialog"></div>
	 
	
