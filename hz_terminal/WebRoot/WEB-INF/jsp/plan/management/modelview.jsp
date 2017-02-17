<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

 <div class="easyui-layout"  data-options="fit:true">
 	<div data-options="region:'center'" style="border:none;">
		<div class="easyui-tabs" style="width:100%;" data-options="fit:true,tabPosition:'left',headerWidth:90"  >
			<div  title="预案基本信息"   data-options="href:'<%=basePath%>Main/planmodel/getView/${id}-${type }-${xgflag }'"  >
				
			</div>
			<div  title="预案应急机构"   data-options="href:'<%=basePath%>Main/planMg/getOrgan/${id}-${flag}-${xgflag }'"  >
			</div>
			<div  title="预案资源配置"   data-options="href:'<%=basePath%>Main/planMg/getResource/${id}-${flag}-${xgflag }'"  >
			</div>
			<div  title="事件分类分级"   data-options="href:'<%=basePath%>Main/planMg/getEventLevel/${id}-${flag}-${xgflag }'"  >
			</div>
			<div  title="预案应急处置"  data-options="href:'<%=basePath%>Main/planMg/getProcess/${id}-${flag}-${xgflag }'"  >
			</div>
			<div  title="预案信息发布"  data-options="href:'<%=basePath%>Main/planMg/getInformation/${id}-${flag}-${xgflag }'"   >
			</div>
		</div>
	</div>
 </div>