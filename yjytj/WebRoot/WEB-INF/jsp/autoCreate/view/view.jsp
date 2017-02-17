<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
  

 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'center'" style="border:none;">
		<div class="easyui-tabs" style="width:100%;" data-options="fit:true" id="mainTab">
			<c:if test="${!empty zytab}">
				<div title="主页"  style="padding:10px">
					 <div class="easyui-layout"  data-options="fit:true">
						${zytab}
					</div>
				</div>
			</c:if>
			<c:if test="${!empty xztab}">
				<div title="新增"  style="padding:10px">
					<div class="easyui-layout"  data-options="fit:true">
						${xztab}
					</div>
				</div>
			</c:if>
			<c:if test="${!empty xgtab}">
				<div title="修改"  style="padding:10px">
					<div class="easyui-layout"  data-options="fit:true">
						${xgtab}
					</div>
				</div>
			</c:if>
		</div>
	</div>
	</div>


