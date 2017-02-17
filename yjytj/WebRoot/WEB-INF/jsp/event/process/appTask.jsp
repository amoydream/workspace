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
	$.lauvan.openGisDialog($("#_app_ev_longitude").val(),$("#_app_ev_latitude").val(),function(lng,lat){
		$("#_app_ev_longitude").textbox('setValue',lng);
		$("#_app_ev_latitude").textbox('setValue',lat);
	});
}
function zhdClick(){
	//打开法规页面
	$("#_zhduserDialog").dialog({
		title:'事件移动任务接收人列表',
		width: 600,
		height: 400,
		href: basePath+"Main/eventProcess/getZhDuser",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var zhd = $("#zhdSelect").datalist("getData");
				var rows = zhd.rows;
				if(rows){
					var zhdid="";
					var zhdname="";
					for(var i=0;i<rows.length;i++){
						if(i==0){
							zhdid=rows[i].ID;
							zhdname=rows[i].REALNAME;
						}else{
							zhdid=zhdid+","+rows[i].ID;
							zhdname=zhdname+","+rows[i].REALNAME;
						}
					}
		    		$("#zhdid").val(zhdid);
		    		$("#zhdname").textbox('setValue',zhdname);
		    		$("#_zhduserDialog").dialog('close');
	    		}else{
		    		alert("请选择任务接收人！");
	    		}
			}}]
		});
}
</script>
<div class="easyui-layout"  data-options="fit:true">

<div data-options="region:'center',border:false">
	 <form id="eventProcessform" method="post" action="<%=basePath %>Main/eventProcess/appTaskSave" style="width:100%;padding: 0px;margin: 0px;">
	    <table  class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		  		<td class="sp-td1" style="width:100px;" >事件名称：</td>
		    	<td colspan="3">
		    		<input type="hidden"  name="eventid" value="${e.id}" />
		    		${e.ev_name}
		    	</td>
		    	</tr>
				<tr>
		  		<td class="sp-td1" style="width:100px;" >事发地点：</td>
		    	<td colspan="3">
		    		${str:translate(e.occurarea,'EVQY')}&nbsp;&nbsp;&nbsp; ${e.ev_address}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">经度：</td>
		    	<td >
		    	<input id="_app_ev_longitude" name="ev_longitude" type="text" class="easyui-textbox" 
		    	 style="width: 180px;" data-options="required:true,editable:false,icons:[{iconCls:'icon-world',handler:app_DTClick}],value:'${e.ev_longitude}'"
		    	 />
		    	</td>
		    	<td class="sp-td1">纬度：</td>
		    	<td >
		    	<input id="_app_ev_latitude" name="ev_latitude" type="text" class="easyui-textbox"  
		    	style="width: 180px;" data-options="required:true,readonly:true" value="${e.ev_latitude}"/>
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1" style="width:100px;" >任务接收人：</td>
		    	<td colspan="3">
		    		<input type="hidden" name="zhdid" id="zhdid"/>
			    	<input id="zhdname" name="zhdname"  type="text" class="easyui-searchbox"  style="width: 525px;" 
			    	data-options="searcher:zhdClick,editable:false,icons:iconClear"/> 
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1" style="width:100px;" >任务描述：</td>
		    	<td colspan="3">
		    		<textarea name="content" class="textarea" 
		    		data-options="required:true,validType:'length[0,500]'"  style="width: 525px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
	    </table>
    </form>
</div>

</div>	
	<div id="_zhduserDialog"></div>
	 
	
