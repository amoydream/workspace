<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script>
$.getJSON("<%=basePath%>Main/weather/getData", {'sdate' : '${sdate}','edate' : '${edate}'},
			function(json) {
				var tmpData = json.tmpdata;
				//console.info(tmpData);
				var windvData = json.windvdata;
				var windxData = json.windxdata;
				var wetData = json.wetdata;
				var pmData = json.pmdata;
				
				
				var tmpLast;
				
				var chartOption = {
						//backgroundColor:'rgba(0,0,0,0.2)',
					    tooltip : {
					        trigger: 'item',
					        formatter : function (params) {
					            var date = new Date(params.value[0]);
					            data = date.getFullYear() + '-'
					                   + (date.getMonth() + 1) + '-'
					                   + date.getDate() + ' '
					                   + date.getHours() + ':'
					                   + date.getMinutes();
					            return data + '<br/>'
					                   + params.value[1];
					        }
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    dataZoom: {
					        show: true,
					        start : 60,
					        backgroundColor:"#F5DEB3",
					        fillerColor: "#FF9912",
					        handleSize:20
					    }, 
					    legend : {
					        data : ['温度','风速','风向','湿度','PM2.5']	,
					        //selected:{'风速':false,'风向':false,'湿度':false,'PM2.5':false},
					        itemGap:15,
					        itemHeight:30,
					        textStyle:{fontSize:20}
					    },
					    grid: {
					        y2: 80
					    },
					    xAxis : [
					        {
					            type : 'time',
					            splitNumber:10
					        }
					    ],
					    yAxis : [
					        {
					            type : 'value'
					        }
					    ],
					    series : [
					        {
					            name: '温度',
					            type: 'line',
					            showAllSymbol: true,
					            symbolSize:5,
					            data: (function () {
					            	var tmp = [];
					                for( var i=0 ;i<tmpData.length; i++){
					                	tmp.push([
					                	        new Date(Date.parse(tmpData[i].TIME.replace(/-/g, "/"))),
					                	        tmpData[i].VALUE])
					                }
					                tmpLast = tmp[tmp.length-1][1];
					                return tmp; 
					            })()
					        },
					        {
					            name: '风速',
					            type: 'line',
					            showAllSymbol: true,
					            symbolSize: 5,
					            data: (function () {
					            	var wv = [];
					                for( var i=0 ;i<windvData.length; i++){
					                	wv.push([
					                	        new Date(Date.parse(windvData[i].TIME.replace(/-/g, "/"))),
					                	        windvData[i].VALUE])
					                }
					                return wv; 
					              })()
					        },
					        {
					            name: '风向',
					            type: 'line',
					            showAllSymbol: true,
					            symbolSize: 5,
					            data: (function () {
					            	var wx = [];
					                for( var i=0 ;i<windxData.length; i++){
					                	wx.push([
					                	        new Date(Date.parse(windxData[i].TIME.replace(/-/g, "/"))),
					                	        windxData[i].VALUE])
					                }
					                return wx; 
					              })()
					        },
					        {
					            name: '湿度',
					            type: 'line',
					            showAllSymbol: true,
					            symbolSize: 5,
					            data: (function () {
					            	var wt = [];
					                for( var i=0 ;i<wetData.length; i++){
					                	wt.push([
					                	        new Date(Date.parse(wetData[i].TIME.replace(/-/g, "/"))),
					                	        wetData[i].VALUE])
					                }
					                return wt; 
					              })()
					        },
					        {
					            name: 'PM2.5',
					            type: 'line',
					            showAllSymbol: true,
					            symbolSize: 5,
					            data: (function () {
					            	var pm = [];
					                for( var i=0 ;i<pmData.length; i++){
					                	pm.push([
					                	        new Date(Date.parse(pmData[i].TIME.replace(/-/g, "/"))),
					                	        pmData[i].VALUE])
					                }
					                return pm; 
					              })()
					        }
					    ]
					};
					                    
				echarts.init(document.getElementById("chart")).setOption(
						chartOption).on(echarts.config.EVENT.CLICK, show);
				document.gauges.forEach(function(gauge) {
					gauge.update();
					gauge.value = tmpLast;
				});
			});
			
function show(param) {
	switch (param.seriesIndex) {
		case 0:
			$(".container").hide();
			$("#temp").show();
			$("#yibiao").html("温度(℃)");
			document.gauges.forEach(function(gauge) {
				gauge.update();
				gauge.value = param.value[1];
			});
			break;
		case 1:
			$(".container").hide();
			$("#windv").show();
			$("#yibiao").html("风速(m/s)");
			document.gauges.forEach(function(gauge) {
				gauge.update();
				gauge.value = param.value[1];
			});
			break;
		case 2:
			$(".container").hide();
			$("#windx").show();
			$("#yibiao").html("风向( °)");
			document.gauges.forEach(function(gauge) {
				gauge.update();
				gauge.value = param.value[1];
			});
			break;
		case 3:
			$(".container").hide();
			$("#wet").show();
			$("#yibiao").html("湿度( %)");
			document.gauges.forEach(function(gauge) {
				gauge.update();
				gauge.value = param.value[1];
			});
			break;
		case 4:
			$(".container").hide();
			$("#pm").show();
			$("#yibiao").html("PM2.5(ug/m³)");
			document.gauges.forEach(function(gauge) {
				gauge.update();
				gauge.value = param.value[1];
			});
			break;
		}
	}
	

</script>

<div id="chart" style="width:100%;height:90%;"></div>