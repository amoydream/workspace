<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script src="js/echarts-all.js"></script>
<style>
</style>
<script>
	var nowPieChart = null;
	var lastPieChart = null;
	var haYearMonth = null;
	//圆饼公用参数
	var haPieOption = {
			noDataLoadingOption:{ 
				effect:{n:0}
			},
			tooltip:{
				show: true,
				formatter: "{a} <br/> {b} ： {c}（{d}%）"
			},
		//	color:['#CDCD00','#0580b9'],
			series:[{
				selectedMode: 'single',
				name:'发生概率',
				type: 'pie',
				radius: '70%',
				center: ['55%', '50%']
			}]

		};
	function eventHappenSrh(){ //根据指定日期查询
			//修改图表tab路径
			var tab = $("#content");
			var href = tab.panel('options').href;
			var index = href.indexOf('?'); //参数拼接位置
			href = href.substring(0, index);
			var param = "?sdate="+ $("#ratestartdate").datebox('getValue') 
						+ "&edate="+$("#rateenddate").datebox('getValue'); //拼接新路径
			tab.panel('options').href = href + param; //替换路径
			//修改列表tab路径
			tab =  $("#typecontent");
			href = tab.panel('options').href;
			index = href.indexOf('?');
			href = href.substring(0, index);
			tab.panel('options').href = href + param;
			
			
		$("#content").panel('refresh');
		$("#typecontent").panel('refresh');
	
	 }


	 var haFlag = true;
	 var chartORlist = 0;
	 function showchartORlist(flag){
		if(flag == 0){
			$("#happentab").show();
			$("#eventlist").hide();
		}else{
			$("#eventlist").show();
			if(haFlag){
				$("#typecontent").panel('refresh');
				haFlag = false;
			}
			$("#happentab").hide();
		}
		chartORlist = flag;
	 } 
	 
	 

		 
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="height:50px;padding:15px; background: #f7f7f7;">
		<span>起始时间：</span>
			<input type="text" name="startdate" id="ratestartdate" value="${sdate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<span>结束时间：</span>
			<input type="text" name="enddate" id="rateenddate" value="${edate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventHappenSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			<span style="padding-left:75px;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="showchartORlist(0)" data-options="iconCls:'icon-chartbar',plain:true">柱状图</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="showchartORlist(1)" data-options="iconCls:'icon-applicationviewlist',plain:true">事件列表</a>
			</span>
	</div>
	<div data-options="region:'west', split:true" style="width:55%;">
		<div id="happentab" class="easyui-tabs" style="width:100%;" data-options="fit:true,headerWidth:90">
		   <div id="content" title="事件发生频率" data-options="href:'<%=basePath%>Main/happenrate/getHappenChart?sdate=${sdate}&edate=${edate}'">
		   </div>
		</div>
		<div id="eventlist" class="easyui-tabs" style="width:100%;display:none;" data-options="fit:true,headerWidth:90">
		   <div id="typecontent" title="事件列表" data-options="href:'<%=basePath%>Main/happenrate/getHappenList?sdate=${sdate}&edate=${edate}'">
		   </div>
		</div> 
	</div>
	<div data-options="region:'center', split:true" style="width:45%;">
	<div style="height:48%">
	    <div style="padding-left:40px;background-color:#A4D3EE;font-size:15px;"><span id="nowpieinfo">当前</span></div>
		<div id="happenPie_now" style="width:100%;height:90%;margin:0 auto;"  ></div>
	</div>
	<div style="height:48%">
		<div style="padding-left:40px;background-color:#A4D3EE;font-size:15px;"><span id="lastpieinfo">上年同期</span></div>
		<div id="happenPie_last" style="width:100%;height:90%;margin:0 auto;"  ></div>
	</div>
</div>

		

