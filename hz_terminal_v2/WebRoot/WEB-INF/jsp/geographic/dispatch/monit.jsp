<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<c:choose>
		<c:when test="${flag == 'qx'}">
		<iframe src="http://flash.weather.com.cn/wmaps/index.swf?url1=http:%2F%2Fwww.weather.com.cn%2Fweather%2F&url2=.shtml&id=guangdong"  style="height:390px;width:620px;">
		
		</iframe>
		</c:when>
		<c:when test="${flag =='qxyj'}">
			<iframe src="http://flash.weather.com.cn/guangdong/zhyj/guangdonggzw.htm" style="height:490px;width:705px;"></iframe>
		</c:when>
		<c:when test="${flag =='qxyt'}">
			<iframe src="http://www.gdsw.gov.cn/live/yuntu/index.html" style="height:490px;width:705px;"></iframe>
		</c:when>
		<c:when test="${flag =='jsqwt'}">
			<iframe src="http://www.mzqx.net/qxdata/rain_img.htm" style="height:490px;width:705px;"></iframe>
		</c:when>
		<c:when test="${flag =='fxskt'}">
			<iframe src="http://www.mzqx.net/test/data.htm" width="100%" height="100%"></iframe>
		</c:when>
		<c:when test="${flag =='tf'}">
			<iframe src="http://typhoon.weather.com.cn/gis/typhoon_p.shtml" style="height:390px;width:620px;"></iframe>
		</c:when>
		<c:otherwise>
		<img style="height:460px;width:720px;" src="<%=basePath%>images/${flag}.jpg">
		</c:otherwise>
	</c:choose>
