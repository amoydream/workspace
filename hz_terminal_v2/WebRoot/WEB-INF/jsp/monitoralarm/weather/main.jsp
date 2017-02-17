<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script src="js/echarts-all.js"></script>
<link rel="stylesheet" type="text/css" href="css/normalize.css" />
<link rel="stylesheet" type="text/css" href="css/zzsc-demo.css">
<style>
</style>
<script src="js/gauge.min.js"></script>
<script>
function eventHappenSrh(){ //根据指定日期查询
	//修改图表tab路径
	var tab = $("#content");
	var href = tab.panel('options').href;
	var index = href.indexOf('?'); //参数拼接位置
	href = href.substring(0, index);
	var param = "?sdate="+ $("#ratestartdate").datebox('getValue') 
				+ "&edate="+$("#rateenddate").datebox('getValue'); //拼接新路径
	tab.panel('options').href = href + param; //替换路径
	
$("#content").panel('refresh');

}

</script>
	
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="height:50px;padding:15px; background: #f7f7f7;">
		<span>起始时间：</span>
			<input type="text" name="startdate" id="ratestartdate" value="${sdate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<span>结束时间：</span>
			<input type="text" name="enddate" id="rateenddate" value="${edate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventHappenSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div id="happentab" class="easyui-tabs" data-options="region:'west', split:true" style="width:80%;">
		 <div id="content" title="监测" data-options="href:'<%=basePath%>Main/weather/getChart?sdate=${sdate}&edate=${edate}'"></div>
	</div>
	<div data-options="region:'center', split:true" style="width:20%;">
	    <div style="padding-left:40px;background-color:#A4D3EE;font-size:20px;"><span id="yibiao">温度(℃)</span></div>
		<div id = "temp" class="container" >
	    <canvas style="position:relative;top: 50px;left:25%" data-type="linear-gauge"
				data-width="160"
				data-height="600"
				data-border-radius="0"
				data-borders=0
				data-bar-stroke-width="20"
				data-minor-ticks="10"
				data-major-ticks="0,10,20,30,40,50,60,70,80,90,100"
				data-color-numbers="red,green,blue,transparent,#ccc,#ccc,#ccc,#ccc,#ccc,#ccc,#ccc"
				data-color-major-ticks="red,green,blue,transparent,#ccc,#ccc,#ccc,#ccc,#ccc,#ccc,#ccc"
				data-color-bar-stroke="#444"
				data-value="22.3"
				data-units="°C"
				data-tick-side="left"
				data-number-side="left"
				data-needle-side="left"
				data-animate-on-init="true"
				data-color-plate="transparent"
		></canvas>
		</div>
		<div id = "windx" class="container" style="display: none">
		    <canvas style="position:relative;top: 170px;left:8%" data-type="radial-gauge"
					data-width="300"
					data-height="300"
					data-min-value="0"
					data-max-value="360"
					data-major-ticks="N,NE,E,SE,S,SW,W,NW,N"
					data-minor-ticks="22"
					data-ticks-angle="360"
					data-start-angle="180"
					data-stroke-ticks="false"
					data-highlights="false"
					data-color-plate="#33a"
					data-color-major-ticks="#f5f5f5"
					data-color-minor-ticks="#ddd"
					data-color-numbers="#ccc"
					data-color-needle="rgba(240, 128, 128, 1)"
					data-color-needle-end="rgba(255, 160, 122, .9)"
					data-value-box="false"
					data-value-text-shadow="false"
					data-color-circle-inner="#fff"
					data-color-needle-circle-outer="#ccc"
					data-needle-circle-size="15"
					data-needle-circle-outer="false"
					data-animation-rule="linear"
					data-needle-type="line"
					data-needle-start="75"
					data-needle-end="99"
					data-needle-width="3"
					data-borders="true"
					data-border-inner-width="0"
					data-border-middle-width="0"
					data-border-outer-width="10"
					data-color-border-outer="#ccc"
					data-color-border-outer-end="#ccc"
					data-color-needle-shadow-down="#222"
					data-border-shadow-width="0"
					data-animation-target="plate"
					data-units="ᵍ"
					data-title="指南针"
					data-font-title-size="19"
					data-color-title="#f5f5f5"
					data-animation-duration="1500"
					data-value="45"
					data-animate-on-init="true"
			></canvas>
			</div>
			<div id = "windv" class="container" style="display: none">
			<canvas style="position:relative;top: 170px;left:8%" data-type="radial-gauge"
			    data-type="radial-gauge" 
				data-width="300"
				data-height="300"
				data-units="m/s"
				data-title="false"
				data-value="33.77"
				data-animate-on-init="true"
				data-animated-value="true"
				data-min-value="0"
				data-max-value="55"
				data-major-ticks="0,5,10,15,20,25,30,35,40,45,50,55"
				data-minor-ticks="2"
				data-stroke-ticks="false"
				data-highlights='[
					{ "from": 0,  "to": 10, "color": "rgba(0,255,0,.15)" },
					{ "from": 10, "to": 20, "color": "rgba(255,255,0,.15)" },
					{ "from": 20, "to": 30, "color": "rgba(255,30,0,.25)" },
					{ "from": 30, "to": 40, "color": "rgba(255,0,225,.25)" },
					{ "from": 40, "to": 55, "color": "rgba(0,0,255,.25)" }
				]'
				data-color-plate='#222'
				data-color-major-ticks="#f5f5f5"
				data-color-minor-ticks="#ddd"
				data-color-title="#fff"
				data-color-units="#ccc"
				data-color-numbers="#eee"
				data-color-needle-start="rgba(240, 128, 128, 1)"
				data-color-needle-end="rgba(255, 160, 122, .9)"
				data-value-box="true"
				data-animation-rule="bounce"
				data-animation-duration="500"
				data-font-value="Led"
				data-font-numbers="Led"
				data-border-outer-width="3"
				data-border-middle-width="3"
				data-border-inner-width="3"
		></canvas>
		</div>
		<div id = "pm" class="container" style="display: none">
			<canvas style="position:relative;top: 170px;left:8%" data-type="radial-gauge"
			    data-type="radial-gauge" 
				data-width="300"
				data-height="300"
				data-units="微克/立方米"
				data-title="false"
				data-value="0"
				data-animate-on-init="true"
				data-animated-value="true"
				data-min-value="0"
				data-max-value="200"
				data-major-ticks="0,20,40,60,80,100,120,140,160,180,200"
				data-minor-ticks="2"
				data-stroke-ticks="false"
				data-highlights='[
					{ "from": 0,  "to": 40, "color": "rgba(0,255,0,.55)" },
					{ "from": 40, "to": 80, "color": "rgba(255,255,0,.55)" },
					{ "from": 80, "to": 120, "color": "rgba(255,30,0,.65)" },
					{ "from": 120, "to": 160, "color": "rgba(255,0,225,.65)" },
					{ "from": 160, "to": 200, "color": "rgba(0,0,255,.65)" }
				]'
				data-color-plate="#eee"
				data-color-major-ticks="#f5f5f5"
				data-color-minor-ticks="#ddd"
				data-color-title="#fff"
				data-color-units="#0F0F0F"
				data-color-numbers="#0F0F0F"
				data-color-needle-start="rgba(240, 128, 128, 1)"
				data-color-needle-end="rgba(255, 160, 122, .9)"
				data-value-box="true"
				data-animation-rule="bounce"
				data-animation-duration="500"
				data-font-value="Led"
				data-font-numbers="Led"
				data-border-outer-width="3"
				data-border-middle-width="3"
				data-border-inner-width="3"
		></canvas>
		</div>
		<div id = "wet" class="container" style="display: none">
			<canvas style="position:relative;top: 170px;left:8%" data-type="radial-gauge"
			    data-type="radial-gauge"
				data-width="300"
				data-height="300"
				data-units="%"
				data-title="false"
				data-min-value="0"
				data-max-value="100"
				data-value="0"
				data-animate-on-init="true"
				data-major-ticks="0,20,40,60,80,100"
				data-highlights='[
					{ "from": 0,  "to": 20, "color": "#FFFFFF" },
					{ "from": 20, "to": 40, "color": "#EEFFFF" },
					{ "from": 40, "to": 60, "color": "#DDFFFF" },
					{ "from": 60, "to": 80, "color": "#CCFFFF" },
					{ "from": 80, "to": 100, "color": "#AAFFFF" }
				]'
				data-minor-ticks="10"
				data-stroke-ticks="true"
				data-color-plate="#FFFFFF"
				data-color-major-ticks="#000000"
				data-color-minor-ticks="#000000"
				data-color-title="#fff"
				data-color-units="#000000"
				data-color-numbers="#000000"
				data-color-needle-start="rgba(240, 128, 128, 1)"
				data-color-needle-end="rgba(255, 160, 122, .9)"
				data-value-box="true"
				data-font-value="Led"
				data-font-numbers="Led"
				data-animated-value="true"
				data-borders="true"
				data-border-shadow-width="0"
				data-needle-type="arrow"
				data-needle-width="2"
				data-needle-circle-size="7"
				data-needle-circle-outer="true"
				data-needle-circle-inner="false"
				data-animation-duration="1500"
				data-animation-rule="linear"
				data-ticks-angle="250"
				data-start-angle="55"
				data-color-needle-shadow-down="#333"
				data-value-box-width="45"
		></canvas>
		</div>
			
		
		</div>
    </div>
