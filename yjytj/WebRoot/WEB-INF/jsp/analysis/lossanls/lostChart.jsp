<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<style>
</style>
	<script>
	var href = "<%=basePath%>Main/lostAnls/getGridData";
	function showPie(param){
		//异步查询，根据事件发生地点分组
		yearMonth =  param['name'];
		var info = "当前（"+yearMonth +" " +textArr[tabIndex]+"）";
		$("#nowpieinfo").text(info);
		$.getJSON("<%=basePath%>Main/lostAnls/getPieData", 
				{"yearMonth": param['name'], "sumColumn": tabArr[tabIndex]}, 
				function(json){
					var data = [];
					var temp = json.nowdata;
					if(temp.length>0){
						for(var i=0; i<temp.length; i++){
							data.push({'name': temp[i].NAME, 'value' :temp[i].VALUE});
						}
						pieOption.series[0].data=data;
					}else{
						pieOption.series[0].data = ['-'];
						
					}
					if(now_pieChart == null){
						now_pieChart = echarts.init(document.getElementById("pieChart_now"), 'macarons').setOption(pieOption);
						now_pieChart.on(echarts.config.EVENT.PIE_SELECTED, function(param){
							//点击饼图查看列表信息
							var selected = param.selected[0];
							var name = param['target'];
							nowselectpie = null;
							for(var i=0; i<selected.length; i++){
								if(selected[i]){
									nowselectpie = name;
								}
							}
							//修改事件列表的路径
							showChartOrList(1);
							for(var i=0; i<5; i++){
								var tab = tabArr[i].toUpperCase();
								$("#now_"+tab).datagrid({url: href,queryParams:{yearMonth: yearMonth, occurarea: name}});
								$("#last_"+tab).datagrid("resize");
							}
						});
					}else{
						//now_pieChart.setSeries([{data:data,type:'pie'}]);
						//如果没有数据，则清空
						now_pieChart.clear();
						now_pieChart.setOption(pieOption);
						
					}
					temp = json.lastdata;
					if(temp.length>0){
						data = [];
						for(var i=0; i<temp.length; i++){
							data.push({'name': temp[i].NAME, 'value' :temp[i].VALUE});
						}

						pieOption.series[0].data = data;
					}else{
						pieOption.series[0].data  = ['-'];
					}
					if(last_pieChart == null){
						last_pieChart = echarts.init(document.getElementById("pieChart_last"), 'macarons').setOption(pieOption);
						last_pieChart.on(echarts.config.EVENT.PIE_SELECTED, function(param){
							//点击饼图查看列表信息
							var selected = param.selected[0];
							var name = param['target'];
							lastselectpie = null;
							for(var i=0; i<selected.length; i++){
								if(selected[i]){
									lastselectpie = name;
								}
							}
							//修改事件列表的路径
							var ym = yearMonth.substring(0,4)-1; //上年同期
							ym = ym+ yearMonth.substring(4);
							showChartOrList(1);
							for(var i=0; i<5; i++){
								var tab = tabArr[i].toUpperCase();
								$("#last_"+tab).datagrid({url: href,queryParams:{yearMonth: ym, occurarea: name}});
								$("#now_"+tab).datagrid("resize");
							}
						});
					}else{
						//如果没有数据，则清空
						last_pieChart.clear();
						last_pieChart.setOption(pieOption);
						//last_pieChart.setSeries([{data:data,type:'pie'}]);
					}
				}
		);

		
	}
	
	$.getJSON("<%=basePath%>Main/lostAnls/getLostData", 
			{'sdate':'${sdate}', 'edate':'${edate}', 'column': '${column}'}, 
			function(json){
				var data = json.lastdata;
				for(var i=0; i<data.length; i++){
					if(data[i] == null){
						data[i] = 0;
					}
				}
			var option = {
					tooltip:{ 
						show: true,
						formatter: function(params, ticket, callback){
							return params[0]+"（" + params[1] +"）<br/>共："+params[2];
			
						}
					},
					legend: {
						data:['本期', '上年同期']
					},
					xAxis: [
					        {
						        type : 'category',
						        data : json.months

							}
					],
					yAxis:[
					       {
							type: 'value'
					       }
					],
					series: [
					         {
									"name":"本期",
									"type":"bar",
									"data" : json.nowdata
						      },
					         {
									"name":"上年同期",
									"type":"bar",
									"data" : data,
									"tooltip" :{
										trigger: 'item',
						    	  		formatter: function(params, ticket, callback){
												var date = params[1];
												date = date.substring(0,4) -1 + date.substring(4);
												return params[0]+"（" + date +"）<br/>共："+params[2];
						      				}
									}
						       }
					]

				};
			echarts.init(document.getElementById("lostChart_${column}")).setOption(option).on(echarts.config.EVENT.CLICK, showPie);
			}
	);
	
	</script>
	
	<div id="lostChart_${column}" style="width:100%;height:100%;">
	</div>

		

