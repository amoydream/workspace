<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script src="<%=basePath %>plugins/gis/plugins/flowplayer/flowplayer.min.js"></script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
<c:if test="${ftype=='media'}">
<div style="margin:5px 10px;height:97%;overflow:hidden;">
<a href="<%=basePath%>Main/mobileuser/getTaskFjView/${fjid}-${fjtype}" style="display:block;width:100%;height:96%;" id="etaskplayer"></a></div>
<script>(function(){flowplayer('etaskplayer', '<%=basePath%>plugins/gis/plugins/flowplayer/flowplayer-3.2.5.swf');})();</script>
</c:if>
<c:if test="${ftype!='media'}">
<div style="margin:5px 10px;height:97%">
<img  src="${furl}" width="100%" height="100%" />
</div>
</c:if>
</div>
</div>