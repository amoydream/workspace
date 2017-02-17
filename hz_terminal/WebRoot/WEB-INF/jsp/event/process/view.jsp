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
		    	<tr>
		    	<td class="sp-td1">处置人：</td>
		    	<td >
		    	${ep.ep_user}</td>
		    	
		  		<td class="sp-td1">处置时间：</td>
		    	<td >
		    	${ep.ep_date}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">处置类型：</td>
		    	<td >
		    	${str:translate(ep.ep_type,'EVPY')}
		  		</td>
		  		<td class="sp-td1">处置单位：</td>
		    	<td >
		    	${ep.ep_organ}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">报告人：</td>
		    	<td >
		    	${ep.ep_reporter}
		    	</td>
		    	<td class="sp-td1">报告时间：</td>
		    	<td >
		    	${ep.ep_reportdate}
		    	</td>
		    	</tr>
		    	<c:if test="${ep.ep_type!='0002'}">
		    	<tr>
		  		<td class="sp-td1">报告人单位：</td>
		    	<td >
		    		${ep.ep_reportunit}
		    	</td>
		    	<td class="sp-td1">报告人电话：</td>
		    	<td >
		    	${ep.ep_reporttel}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">受灾面积（m²）：</td>
		    	<td >
		    		${ep.ep_affectedarea}
		    	</td>
		    	<td class="sp-td1">参与（受灾）人数：</td>
		    	<td >
		    		${ep.ep_participationnumber}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">受伤人数：</td>
		    	<td >
		    		${ep.ep_injuredpeople}
		    	</td>
		    	<td class="sp-td1">死亡人数：</td>
		    	<td >
		    		${ep.ep_deathtoll}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<td class="sp-td1">经济损失（万元）：</td>
		    	<td >
		    		${ep.ep_economicloss}
		    	</td>
		    	<td class="sp-td1">记录人：</td>
		    	<td >
		    		${username}
		    	</td>
		    	</tr>
		    	</c:if>
		    	<tr>
		  		<td class="sp-td1">处置内容</td>
		    	<td colspan="3">
		    		${ep.ep_content}
		    	</td>
		    	</tr>
		    	<c:if test="${ep.ep_type!='0002'}">
		    	<tr>
		  		<td class="sp-td1">备注</td>
		    	<td colspan="3">
		    		${ep.remark}
		    	</td>
		    	</tr>
		    	</c:if>
	    </table>
   </div>
   </div>