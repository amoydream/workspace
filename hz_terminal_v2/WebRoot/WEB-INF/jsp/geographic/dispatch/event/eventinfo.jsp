<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
	.pBtn3{
		width:60px;
		height:18px;
		display:block;
		background:#cfe2f3;
		text-align:center;
		border:1px solid white;
		border-radius:5px;
		color:black;
		line-height:18px;
		float:left;
	}
	.pBtn3:hover{
		cursor:pointer;
	}
	
	.call-td{ background:#F1F7FF; color:#FF5809;border-right:1px solid #B9CDE3;text-align:left;font-size:15px;}
</style>
<script>

	$(function(){
		$.lauvan.dataGrid("eventProcessGrid",{
				fitColumns : true,
				url:"<%=basePath%>Main/eventProcess/getDataGrid/${info.id}"
			});

		//$("#marchPlan").click(function(){
		//	var attr = {
		//			width:800,
		//			height:500,
				//	left:$("#commandmap").width()-600,
					//top:$("#commandmap").height()-400,
		//			modal:false,
		//			buttons:[],
		//			href:basePath+'Main/eventPlan/main?eventid='+curEventId
		//		};
		//	$.lauvan.openCustomDialog("marchplanDialog", attr, null, "marchplanfrom");
		//});

	});
</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="height:50%;" >
		<div style="background-color:#87CEFF;height:21px;line-height:21px;padding:0 0 0 20px;">
			<span style="float:left;">事件详情</span>
			<%--<div style="margin-left:100px;float:left">
				<a class="pBtn3" id="marchPlan">匹配预案</a>
				<span id="marchResult" style="margin-left:10px;"></span>
			</div>
		--%></div>
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			    	<td class="sp-td1">事件名称：</td>
			    	<td >
			    		${info.ev_name}
			    	</td>
			    	<td class="sp-td1">事发单位：</td>
			    	<td >
			    		${organ}
			    	</td>
		    	</tr>
		    	
		    	<tr>
		    		<td class="sp-td1">事件类型：</td>
			    	<td >
			    	${str:translate(info.ev_type,'EVTP')}
			  		</td>
			    	<td class="sp-td1">事件级别：</td>
			    	<td >
			    	${str:translate(info.ev_level,'EVLV')}
			  		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">事发时间：</td>
			    	<td >
			    	${info.ev_date}
			    	</td>
			    	<td class="sp-td1">重大危险源：</td>
			    	<td >
			    	${info.ev_dangid}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">经济损失（万元）：</td>
			    	<td >
			    	${info.ev_economicloss}
			    	</td>
			    	<td class="sp-td1">受灾面积（m²）：</td>
			    	<td >
			    	${info.ev_affectedarea}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">接报方式：</td>
			    	<td >
			    	${str:translate(info.ev_reportmode,'EVRP')}
			    	</td>
		    		<td class="sp-td1">接报时间：</td>
			    	<td >
			    	${info.ev_reportdate}
			    	</td>
		    	</tr>
		    	
		    	
		    	<tr>
		  		<td class="sp-td1">报告人姓名：</td>
		    	<td >
		    		${info.ev_reporter}
		    	</td>
		    	<td class="sp-td1">报告人电话：</td>		    	
		    	<td class="call-td">		    		
		        <ul class="specil_button">
		        <li><span>${info.ev_reporttel}</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="window.parent.callout(${info.ev_reporttel},null);"><span></span>拨打</a></li></ul>
		    	</td>	    	
		    	</tr>
		    	<tr>
		  		
		    	<td class="sp-td1">事发地点：</td>
		    	<td colspan="3">
		    	${str:translate(info.occurarea,'EVQY')}&nbsp;&nbsp;&nbsp; ${info.ev_address}</td>
		    	</tr>
		    	<%--<tr>
		  		<td class="sp-td1">事件基本情况</td>
		    	<td colspan="3">
		    		${info.ev_basicsituation}D
		    	</td>
		    	</tr>
		    	
	    --%></table>
	    </div>
	  
	  <div data-options="region:'center'"  style="width:100%;height:50%;">
	  			<div style="background-color:#87CEFF;height:21px;line-height:21px;padding:0 0 0 20px;">处置实时信息</div>
	  			<div  style="width:100%;height:90%;">
			    <table id="eventProcessGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="EP_DATE" width="100">处置时间</th> 
				            <th field="EP_TYPE" width="150" CODE="EVPY" >处置类型</th>
				            <th field="EP_USER" width="150"  >处置人</th>
				            <th field="EP_ORGAN" width="100"  >处置单位</th>
				            <th field="EP_CONTENT" width="200" >处置内容</th>
				        </tr> 
				    </thead> 
				</table>
				</div>
	  </div>
   </div>
