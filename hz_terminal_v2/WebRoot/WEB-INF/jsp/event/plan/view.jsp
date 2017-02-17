<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'center',border:false">
		
			<table  class="easyui-datagrid" cellspacing="0" cellpadding="0" 
			data-options="url:'<%=basePath%>Main/eventPlan/getPlanViewData?instid=${instid}',fit:true,fitColumns:true,singleSelect:true"> 
			    <thead> 
			        <tr> 
			            <th field="PHASENAME1" width="150">行动阶段</th>
			            <th field="PHASENAME2" width="150" >行动流程</th> 
			            <th field="ACTNAME" width="150" >行动名称</th>
			            <th field="ACTCONT" width="200" >行动内容</th>
			            <th field="ISTEMPACT" width="100" >是否临时行动</th>
			            <th field="ACTSTATUS" width="100" >执行状态</th>
			            <th field="ACTDETAIL" width="200" >行动说明</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
		
	</div>


