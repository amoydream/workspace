<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
<a href="<%=basePath%>Main/archive/getFileview/${aid}-${atype}-media" style="display:block;width:100%;height:96%;" id="etaskplayer"></a></div>
<script>(function(){flowplayer('etaskplayer', '<%=basePath%>plugins/gis/plugins/flowplayer/flowplayer-3.2.5.swf');})();</script>
</c:if>
<c:if test="${ftype=='jpg'}">
<div style="margin:5px 10px;height:97%">
<img  src="${furl}"  />
</div>
</c:if>

<c:if test="${ftype=='media_gd'}">
<div style="margin:5px 10px;height:97%;overflow:hidden;">
<a href="<%=basePath%>Main/archive/getView/${aid}-media_gd" style="display:block;width:100%;height:96%;" id="etaskplayer"></a></div>
<script>(function(){flowplayer('etaskplayer', '<%=basePath%>plugins/gis/plugins/flowplayer/flowplayer-3.2.5.swf');})();</script>
</c:if>

</div>
</div>