<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    <c:if test="${!empty t}">
	    		<c:if test="${!empty eventName}">
	    		<tr>
		  		<td class="sp-td1">关联事件：</td>
		    	<td colspan="5">
		    	${eventName}
		    	</td>
		    	</tr>
		    	</c:if>
		    	<tr>
		    	<td class="sp-td1">发送时间：</td>
		    	<td >
		    		${t.send_time}
		    	</td>
		    	
		    	<td class="sp-td1">接收号码：</td>
		    	<td >
		    	${rec.phone}</td>
		    	<td class="sp-td1">姓名：</td>
		    	<td >
		    		${rec.pname}
		    	</td>
		  		
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">短信内容：</td>
		    	<td colspan="5">
		    	${sendcontent}
		  		</td>
		    	</tr>
		  </c:if>  	
		    	<c:if test="${!empty recelist}">
		    	<tr>
		    	<td class="sp-td1" colspan="6" style="text-align: left;">回复内容</td>
		    	</tr>
			    	<c:forEach items="${recelist}" var="recelist">
				    	<tr>
				    	<td class="sp-td1">回复时间：</td>
				    	<td >
				    		${recelist.mo_time}
				    	</td>
				  		<td class="sp-td1">手机号码：</td>
				    	<td >
				    		${recelist.mobile}
				    	</td>
				    	<td class="sp-td1">姓名：</td>
				    	<td >
				    		${recelist.mobname}
				    	</td>
				    	</tr>
				    	<tr>
				    	<td class="sp-td1">短信内容：</td>
				    	<td colspan="5">
				    		${recelist.reccontent}
				  		</td>
				    	</tr>
			    	</c:forEach>
		    	</c:if>
	    </table>
   </div>
   </div>
