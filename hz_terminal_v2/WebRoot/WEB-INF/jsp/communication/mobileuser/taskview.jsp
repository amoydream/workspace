<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		width: 678,
		height:500,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: "<%=basePath%>Main/mobileuser/getTaskFj/"+id
	});
}
</script>
<div>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">任务标题：</td>
		    <td colspan="3">
		    ${task.title }
		    </td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">发送人：</td>
		    <td>${task.sname }</td>
		    <td class="sp-td1">接收人：</td>
		    <td>${task.aname }</td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">经度：</td>
		    <td>${task.pointx }</td>
		    <td class="sp-td1">纬度：</td>
		    <td>${task.pointy }</td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">发送时间：</td>
		    <td colspan="3">${task.time }</td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">任务内容：</td>
		    <td colspan="3">
		    <textarea rows="5" cols="100">${task.content }</textarea>
		    </td>
		    </tr>
		    <tr>
		    </tr>
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