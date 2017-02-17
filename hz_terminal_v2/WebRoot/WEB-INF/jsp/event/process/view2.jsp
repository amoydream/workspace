<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
function etaskFjClick(id){
	$(document.body).append("<div id='etaskFjDialog'></div>");
	$("#etaskFjDialog").dialog({
		title:'事件任务反馈附件详情',
		width: 500,
		height: 400,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: "<%=basePath%>Main/eventProcess/getTaskFj/"+id
	});
}
</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">处置人：</td>
		    	<td >
		    	${ep.ep_user}</td>
		    	
		  		<td class="sp-td1">处置时间：</td>
		    	<td >
		    	${ep.ep_date}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">处置类型：</td>
		    	<td >
		    	${str:translate(ep.ep_type,'EVPY')}
		  		</td>
		  		<td class="sp-td1">处置单位：</td>
		    	<td >
		    	${ep.ep_organ}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">处置内容(任务描述):</td>
		    	<td colspan="3">
		    		${ep.ep_content}
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1" colspan="4" style="text-align: left;">任务下达情况</td>
		    	</tr>
		    	<c:forEach items="${alist}" var="alist">
		    		<tr>
			  		<td class="sp-td1">任务接收人：</td>
			    	<td >
			    	${alist.realname}
			    	</td>
			    	<td class="sp-td1">推送状态：</td>
			    	<td >
			    	<c:if test="${alist.sendstatus=='-1'}">失败</c:if>
			    	<c:if test="${alist.sendstatus=='0'}">推送中</c:if>
			    	<c:if test="${alist.sendstatus=='1'}">成功</c:if>
			    	</td>
			    	</tr>
		    	</c:forEach>
		    	<c:if test="${!empty flist}">
		    	<tr>
		  		<td class="sp-td1" colspan="4" style="text-align: left;">任务反馈信息</td>
		    	</tr>
		    	<c:forEach items="${flist}" var="flist">
		    		<tr>
			  		<td class="sp-td1">用户名称：</td>
			    	<td >
			    	${flist.name}
			    	</td>
			    	<td class="sp-td1">反馈时间：</td>
			    	<td >
			    	${flist.backtime}
			    	</td>
			    	</tr>
			    	<tr>
			    	<td class="sp-td1">反馈内容：</td>
			    	<td colspan="3">
			    	${flist.backcontent}
			    	</td>
			    	</tr>
			    	<c:if test="${!empty flist.attid}">
			    	<tr>
			    	<td class="sp-td1">附件：</td>
			  		<td  colspan="3" >
			  			<c:forEach items="${flist.fjlist}" var="fjlist">
			  			<div>
			  				<a title="请点击打开"  href="javascript:void(0);" onclick="etaskFjClick('${fjlist.id}')" >${fjlist.name}</a>
			  			</div>
			  			</c:forEach>
			  		</td>
			    	</tr>
		    	</c:if>
		    	</c:forEach>
		    	</c:if>
		    	
	    </table>
   </div>
   </div>