<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script>
var treeData=${treeData };
$(document).ready(function(){
	addMenuClick();
	<c:if test="${empty AIOFLAG}">
		if($("#menu").accordion("panels").length==1 && treeData.length==1 && !treeData.children){
			try{
				$(".easyui-layout").layout("collapse","west");
			}catch(e){}
			addTab(treeData[0]);
		}else if($(".easyui-layout").layout("panel","west").panel("options").collapsed){
			try{
				$(".easyui-layout").layout("expand","west");
			}catch(e){}
		}
	</c:if>
});
</script>
<ul class="easyui-tree" data-options="lines:true,animate:true,data:treeData" >
	
</ul>


