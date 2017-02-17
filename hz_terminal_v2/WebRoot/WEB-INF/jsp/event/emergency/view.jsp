<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
.call-td{ background:#F1F7FF; color:#FF5809;border-right:1px solid #B9CDE3;text-align:left;font-size:15px;}
</style>
<script type="text/javascript">
function eventReport(){
	$(document.body).append("<div id='eReportDialog'></div>");
	$("#eReportDialog").dialog({
		title:'信息专报',
		width: 800,
		height: 500,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: basePath+"Main/eventReport/index?eventid=${t.id}"
	});	
}
function eventProcess(){
	$(document.body).append("<div id='eReportDialog'></div>");
	$("#eReportDialog").dialog({
		title:'过程信息',
		width: 900,
		height: 500,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: basePath+"Main/eventProcess/index?eventid=${t.id}&estatus=${t.ev_status}"
	});
}
function eventFJ(){
	$(document.body).append("<div id='eReportDialog'></div>");
	$("#eReportDialog").dialog({
		title:'相关附件',
		width: 800,
		height: 500,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: basePath+"Main/event/fjmain/${t.id}"
	});
}
function eventPBack(){
	$(document.body).append("<div id='ePalyBackDialog'></div>");
	$("#ePalyBackDialog").dialog({
		title:'备忘录',
		width: 800,
		height: 500,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: basePath+"Main/eventSearch/processView/${t.id}"
	});
}
function eventOver(){
	$.messager.prompt("办结",'请输入事件办结说明：',function(r){
	    if (r){
	       $.ajax({
            	url:basePath+"Main/event/eventOver",
            	type:'post',
            	dataType:'json',
            	traditional:true,
            	data:{'eventid':'${t.id}','fincontent':r},
            	success:function(data){
            		if(data.success){
            			$.lauvan.MsgShow({msg:'事件处理完成！'});
            			$("#mainTab").tabs("close","事件详情");
            			$("#eventGrid").datagrid('clearSelections');
            			$("#eventGrid").datagrid('clearChecked');
            			$("#eventGrid").datagrid('reload');
            		}
            		else{
            			$.messager.alert('错误',data.msg,data.errorcode);
            		}
            	}
            });
	    }else{
		    if(r!=undefined){
	    		$.messager.alert('错误','请填写办结说明内容！','error');
		    }
	    }
	});
}
function eventPlan(){
	var mainTab=$("#mainTab");
	if (mainTab.tabs('exists', "启动预案")){
    	mainTab.tabs('select', "启动预案");
    	// 调用 'refresh' 方法更新选项卡面板的内容
    	var tab = mainTab.tabs('getSelected');  // 获取选择的面板
    	tab.panel('refresh', basePath+"Main/eventPlan/main?eventid=${t.id}");
    } else {
	    mainTab.tabs('add',{
	       title:"启动预案",
	       href:basePath+"Main/eventPlan/main?eventid=${t.id}",
	        closable:true
	    });
    }
}
function eventApp(){
	$(document.body).append("<div id='eAppNewsDialog'></div>");
	$("#eAppNewsDialog").dialog({
		title:'手机快报',
		width: 800,
		height: 500,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: basePath+"Main/event/appmain/${t.id}"
	});
}
function eventZHDD(){
	//打开演示页面
	var mainTab=$("#mainTab");
	if (mainTab.tabs('exists', "应急指挥")){
    	mainTab.tabs('select', "应急指挥");
    	// 调用 'refresh' 方法更新选项卡面板的内容
    	var tab = mainTab.tabs('getSelected');  // 获取选择的面板
    	tab.panel('refresh', basePath+"Main/geographic/dispatch/index?eventid=${t.id}");
    } else {
	    mainTab.tabs('add',{
	       title:"应急指挥",
	       href:basePath+"Main/geographic/dispatch/index?eventid=${t.id}",
	       iconCls:'icon-controlleradd',
	       closable:true
	    });
    }
}
</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventReport()" data-options="iconCls:'icon-search',plain:true">信息专报</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventProcess()" data-options="iconCls:'icon-pencil',plain:true">处置过程</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventPlan()" data-options="iconCls:'icon-redo',plain:true">启动预案</a>
			<c:if test="${t.ev_status=='00C'}">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventZHDD()" data-options="iconCls:'icon-controlleradd',plain:true">指挥调度</a>
			</c:if>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventFJ()" data-options="iconCls:'icon-tip',plain:true">相关附件</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventApp()" data-options="iconCls:'icon-phonesound',plain:true">手机快报</a>
			<c:if test="${t.ev_status!='00D'}">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventOver()" data-options="iconCls:'icon-ok',plain:true">办结</a>
			</c:if>
			<c:if test="${tflag=='search'}">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventPBack()" data-options="iconCls:'icon-tip',plain:true">事件回放</a>
			</c:if>
		</div>
		<div data-options="region:'center',border:false">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
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
		    	<td class="call-td">		    		
		        <ul class="specil_button">
		        <li><span>${t.ev_reporttel}</span></li>
		        <li class="s_b_1">
		        <a href="javascript:void(0);" onclick="callout(${t.ev_reporttel },null);"><span></span>拨打</a></li></ul>
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
		    	<td >
		    		${t.ev_relatedpersonnel}
		    	</td>
		    	<td class="sp-td1">使用情况：</td>
		    	<td >
		    		${str:translate(t.ev_usestatus,'EVUS')}
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    		<td class="sp-td1">报送时效：</td>
			    	<td >
			    		${str:translate(t.ev_bssx,'EVSX')}
			    	</td>
		    		<td class="sp-td1">现场图片</td>
			    	<td colspan="3">
			    		<a title="请点击打开" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${t.ev_img}">${imgfj.name}<a/>
			    	</td>
			    	
		  			
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">国家领导批示</td>
		    	<td colspan="2">
		    		${t.ev_guops}
		    	</td>
		  		<td class="sp-td1">省领导批示</td>
		    	<td colspan="2">
		    		${t.ev_shengps}
		    	</td>
		  		
		    	</tr>
		    	
		    	<tr>
		    		<td class="sp-td1">市领导批示</td>
			    	<td colspan="2">
			    		${t.ev_ships}
			    	</td>
		    		<td class="sp-td1">事件基本情况</td>
			    	<td colspan="2">
			    		${t.ev_basicsituation}
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
	    </table>
   </div>
   </div>