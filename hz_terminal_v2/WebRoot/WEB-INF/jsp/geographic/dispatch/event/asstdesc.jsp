<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
#evttabs .ztree li span{color:black;}
#evttabs td{
	height:21px;
	padding:4px 2px;
}
</style>
<script>
</script>
<div class="easyui-layout"  data-options="fit:true">
	<div data-options="region:'north', border:false" style="height:120px;">
		 <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
			 	<tr>
			 		<td class="sp-td1">事件名称：</td>
			 		<td>${t.ev_name}</td>
			 		<td class="sp-td1">事发地点：</td>
			 		<td >${str:translate(t.occurarea,'EVQY')}&nbsp;&nbsp;&nbsp; ${t.ev_address}</td>
			 	</tr>
			 	<tr>
			 		<td class="sp-td1">事件类型：</td>
			 		<td>${str:translate(t.ev_type,'EVTP')}</td>
			 		<td class="sp-td1">事件级别：</td>
			 		<td>${str:translate(t.ev_level,'EVLV')}</td>
			 	</tr>
			 	<tr>
			 		<td class="sp-td1">辅助决策方案：</td>
			 		<td colspan="3"><a href="<%=basePath %>Main/geographic/dispatch/viewEventDoc/${t.id}"  target="_blank">${t.ev_name}</a></td>
			 	</tr>
		</table>	
	</div>
	
	<div data-options="region:'center', border:false">
		<div id="evttabs" class="easyui-tabs" data-options="fit:true,headerWidth:100">
			<div title="事件基本信息" >
					<table id="tables" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
					 	<tr>
			    	<td class="sp-td1">事件名称：</td>
			    	<td >
			    	${t.ev_name}</td>
			    	
			  		<td class="sp-td1">事发地点：</td>
			    	<td colspan="3">
			    	${str:translate(t.occurarea,'EVQY')}&nbsp;&nbsp;&nbsp; ${t.ev_address}</td>
			    	</tr>
			    	
			    	<tr>
			    	<td class="sp-td1">事件类型：</td>
			    	<td >
			    	${str:translate(t.ev_type,'EVTP')}
			  		</td>
			  		<td class="sp-td1">事件级别：</td>
			    	<td >
			    	${str:translate(t.ev_level,'EVLV')}
			    	</td>
			    	
			  		<td class="sp-td1">事发时间：</td>
			    	<td >
			    	${t.ev_date}
			    	</td>
			    	</tr>
			    	<tr>
			    	<td class="sp-td1">接报时间：</td>
			    	<td >
			    	${t.ev_reportdate}
			    	</td>
			    	
			  		<td class="sp-td1">事发单位：</td>
			    	<td >
			    		${organ}
			    	</td>
			    	<td class="sp-td1">接报方式：</td>
			    	<td >
			    	${str:translate(t.ev_reportmode,'EVRP')}
			    	</td>
			    	</tr>
			    	
			    	<tr>
			  		<td class="sp-td1">受灾面积（m²）：</td>
			    	<td >
			    		${t.ev_affectedarea}
			    	</td>
			    	<td class="sp-td1">受灾人数：</td>
			    	<td >
			    		${t.ev_participationnumber}
			    	</td>
			    	
			  		<td class="sp-td1">受伤人数：</td>
			    	<td >
			    		${t.ev_injuredpeople}
			    	</td>
			    	</tr>
			    	
			    	<tr>
			    	<td class="sp-td1">死亡人数：</td>
			    	<td >
			    		${t.ev_deathtoll}
			    	</td>
			    	
			  		<td class="sp-td1">经济损失（万元）：</td>
			    	<td >
			    		${t.ev_economicloss}
			    	</td>
			    	<td class="sp-td1">结束时间：</td>
			    	<td >
			    		${t.ev_enddate}
			    	</td>
			    	</tr>
			    	
			    	<tr>
			  		<td class="sp-td1">经度：</td>
			    	<td >
			    	${t.ev_longitude}
			    	</td>
			    	<td class="sp-td1">纬度：</td>
			    	<td >
			    	${t.ev_latitude}
			    	</td>
			    	
			  		<td class="sp-td1">报告人姓名：</td>
			    	<td >
			    		${t.ev_reporter}
			    	</td>
			    	</tr>
			    	
			    	<tr>
			    	<td class="sp-td1">报告人电话：</td>
			    	<td >
			    		${t.ev_reporttel}
			    	</td>
			    	
			  		<td class="sp-td1">报告人职务：</td>
			    	<td >
			    		${t.ev_reportpost}
			    	</td>
			    	<td class="sp-td1">报告人单位：</td>
			    	<td >
			    		${t.ev_reportunit}
			    	</td>
			    	</tr>
			    	
			    	<tr>
			  		<td class="sp-td1">报告人地址：</td>
			    	<td >
			    		${t.ev_reportaddress}
			    	</td>
			    	<td class="sp-td1">相关人员：</td>
			    	<td colspan="3">
			    		${t.ev_relatedpersonnel}
			    	</td>
			    	</tr>
			    	
			    	<tr>
			  		<td class="sp-td1">事件起因、性质</td>
			    	<td colspan="2">
			    		${t.ev_cause}
			    	</td>
			    	
			  		<td class="sp-td1">影响范围、发展趋势</td>
			    	<td colspan="2">
			    		${t.ev_influencescope}
			    	</td>
			    	</tr>
			    	<tr>
			  		<td class="sp-td1">先期处置情况</td>
			    	<td colspan="2">
			    		${t.ev_advanceddisposal}
			    	</td>
			    	
			    	<td class="sp-td1">拟采取的措施和 下一步工作建议</td>
			    	<td colspan="2">
			    		${t.ev_nextstep}
			    	</td>
			    	</tr>
			    	<tr>
			  			<td class="sp-td1">事件基本情况</td>
				    	<td colspan="5">
				    		${t.ev_basicsituation}
				    	</td>
			    	</tr>
					</table>	
			</div>
			<div title="应急指挥机构" data-options="href:'<%=basePath%>Main/planMg/getOrgan/${preschid}-no'">
			
			</div>
				<div title="应急处置步骤" data-options="href:'<%=basePath%>Main/geographic/dispatch/getEventProcess/${instid}'">
			
			</div>
			
			<div title="应急资源信息" data-options="href:'<%=basePath%>Main/geographic/dispatch/resource/${preschid}'" >
			</div>
			
			<div title="相关案例信息" data-options="href:'<%=basePath%>Main/geographic/dispatch/eventList'">
			
			</div>
			<div title="重点保护对象" data-options="href:'<%=basePath%>Main/geographic/dispatch/protectObj'">
			
			</div>
			<div title="重大危险源" data-options="href:'<%=basePath%>Main/geographic/dispatch/dangerList'">
			
			</div>
			<div title="周边居民" data-options="href:'<%=basePath%>Main/geographic/dispatch/residentsList'">
			
			</div>
		</div>
	</div>
</div>