<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<style>
</style>
	<script>

	</script>
	
	<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="font-weight:bold;height:30px;padding:15px; background:#A4D3EE;">
		统计结果：${dltext}
	</div>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr style="background-color:#EDEDED;">
			<td rowspan="2" style="font-weight:bold;font-size:16px;">${ytext}</td>
			<td colspan="${xlist.size()}" style="font-weight:bold;font-size:16px;">${xtext}</td>
		</tr>
		<tr style="background-color:#EDEDED;font-weight:bold;">
			<c:forEach items="${xlist}" var="x">
			<td>${x.xy}</td>
			</c:forEach>
		</tr>
		<c:forEach items="${ylist}" var="y">
			<tr>
				<td>${y.xy}</td>
				<c:forEach items="${xlist}" var="x">
					<td>
						<c:forEach items="${list}" var="l">
							<c:if test="${l.yval == y.xy && l.xval == x.xy}">
									${l.total}
							</c:if>
						</c:forEach>
					</td>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
	</div>

		

