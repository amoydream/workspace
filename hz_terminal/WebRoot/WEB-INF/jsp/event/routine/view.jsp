<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
function eventPBack_r(){
	$(document.body).append("<div id='ePalyBackDialog'></div>");
	$("#ePalyBackDialog").dialog({
		title:'备忘录',
		width: 800,
		height: 500,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: basePath+"Main/eventSearch/processView/${t.id}"
	});
}
</script>
 <div class="easyui-layout"  data-options="fit:true">
		 <c:if test="${tflag=='search'}">
		 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventPBack_r()" data-options="iconCls:'icon-tip',plain:true">事件回放</a>
		</div>
		</c:if>
		<div data-options="region:'center',border:false">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">事件名称：</td>
		    	<td >
		    	${t.ev_name}</td>
		    	<td class="sp-td1">事发单位：</td>
		    	<td >
		    		${organ}
		    	</td>
		  		
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">事件类型：</td>
		    	<td >
		    	${str:translate(t.ev_type,'EVTP')}
		  		</td>
		  		<td class="sp-td1">接报方式：</td>
		    	<td >
		    	${str:translate(t.ev_reportmode,'EVRP')}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">事发时间：</td>
		    	<td >
		    	${t.ev_date}
		    	</td>
		    	<td class="sp-td1">接报时间：</td>
		    	<td >
		    	${t.ev_reportdate}
		    	</td>
		    	</tr>
		    	
		    	
		    	<tr>
		  		<td class="sp-td1">报告人姓名：</td>
		    	<td >
		    		${t.ev_reporter}
		    	</td>
		    	<td class="sp-td1">报告人电话：</td>
		    	<td >
		    		${t.ev_reporttel}
		    		<c:if test="${!empty t.ev_reporttel}">
		    		<a href="javascript:void(0);" onclick="callout('${t.ev_reporttel}','${t.id}') " class="easyui-linkbutton"  data-options="iconCls:'icon-phonereceived'"></a>
		    		<a href="javascript:void(0);" onclick="tel_addWN('${t.ev_reporttel}','${t.ev_reporter}') " class="easyui-linkbutton"  data-options="iconCls:'icon-reportedit'"></a>
		    		</c:if>
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">使用情况：</td>
		    	<td >
		    		${str:translate(t.ev_usestatus,'EVUS')}
		    	</td>
		    	<td class="sp-td1">报送时效：</td>
		    	<td >
		    		${str:translate(t.ev_bssx,'EVSX')}
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">现场图片</td>
			    	<td colspan="3">
			    		<a title="请点击打开" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${t.ev_img}">${imgfj.name}<a/>
			    	</td>
		    	</tr>
		    	
		    	<tr>
		  		
		    	<td class="sp-td1">事发地点：</td>
		    	<td colspan="3">
		    	${str:translate(t.occurarea,'EVQY')}&nbsp;&nbsp;&nbsp; ${t.ev_address}</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">事件基本情况</td>
		    	<td colspan="3">
		    		${t.ev_basicsituation}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">国家领导批示</td>
		    	<td colspan="3">
		    		${t.ev_guops}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">省领导批示</td>
		    	<td colspan="3">
		    		${t.ev_shengps}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">市领导批示</td>
		    	<td colspan="3">
		    		${ships}
		    	</td>
		    	</tr>
	    </table>
   </div>
   </div>
