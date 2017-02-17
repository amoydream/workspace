<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script>
	function showHaPie(param){
		//异步查询，根据事件发生地区分组
		haYearMonth =  param['name'];
		$.getJSON("<%=basePath%>Main/happenrate/getPieData", 
				{"haYearMonth": param['name']}, 
				function(json){
					var data = [];
					var temp = json.nowdata;
					if(temp.length>0){
						for(var i=0; i<temp.length; i++){
							data.push({'name': temp[i].NAME, 'value' :temp[i].VALUE});
						}
						haPieOption.series[0].data=data;
					}else{
						pieOption.series[0].data = ['-'];
					}
						
						if(nowPieChart == null){
						nowPieChart = echarts.init(document.getElementById("happenPie_now")).setOption(haPieOption);
						nowPieChart.on("click", function(param){
							//点击饼图查看列表信息
							var name = param['name'];
							//修改事件列表的路径
							var href = $("#nowlist").datagrid("options").url;
							var index = href.indexOf('?');
							href = href.substring(0, index);
							href += "?haYearMonth="+haYearMonth +"&evtype="+name;
							
							
							
							//showchartORlist(1);
							$("#nowlist").datagrid({url: encodeURI(href)});
							$("#eventlist").show();
							$("#happentab").hide();
							 
							$("#nowlist").datagrid("resize");
							$("#lastlist").datagrid("resize");
						});
				}else{
						nowPieChart.clear();
						nowPieChart.setOption(haPieOption);
				}
				temp = json.lastdata;
				if(temp.length>0){
					data = [];
					for(var i=0; i<temp.length; i++){
						data.push({'name': temp[i].NAME, 'value' :temp[i].VALUE});
					}

					haPieOption.series[0].data = data;
				}else{
					haPieOption.series[0].data  = ['-'];
				}
					if(lastPieChart == null){
					lastPieChart = echarts.init(document.getElementById("happenPie_last")).setOption(haPieOption);
					lastPieChart.on("click", function(param){
						//点击饼图查看列表信息
						var name = param['name'];
						//修改事件列表的路径
						var href = $("#lastlist").datagrid("options").url;
						var index = href.indexOf('?');
						href = href.substring(0, index);
						var ym = haYearMonth.substring(0,4)-1; //上年同期
						ym = ym+ haYearMonth.substring(4);
						href += "?haYearMonth="+ym +"&evtype="+name;
						
						
						
						//showchartORlist(1);
						$("#lastlist").datagrid({url: encodeURI(href)});
						$("#eventlist").show();
						$("#happentab").hide();
						
						$("#nowlist").datagrid("resize");
						$("#lastlist").datagrid("resize");
						
					});
				}else{
					lastPieChart.clear();
					lastPieChart.setOption(haPieOption);
					}
				}
	);
}
	
	$.getJSON("<%=basePath%>Main/happenrate/getRateData", {'sdate' : '${sdate}','edate' : '${edate}'},
			function(json) {
				var data = json.lastdata;
				for (var i = 0; i < data.length; i++) {
					if (data[i] == null) {
						data[i] = 0;
					}
				}
				var option = {
					tooltip : {
						show : true,
						formatter : function(params, ticket, callback) {
							return params[0] + "（" + params[1] + "）<br/>共："
									+ params[2];

						}
					},
					legend : {
						data : [ '本期', '上年同期' ]
					},
					xAxis : [ {
						type : 'category',
						data : json.months

					} ],
					yAxis : [ {
						type : 'value'
					} ],
					series : [
							{
								"name" : "本期",
								"type" : "bar",
								"data" : json.nowdata
							},
							{
								"name" : "上年同期",
								"type" : "bar",
								"data" : data,
								"tooltip" : {
									trigger : 'item',
									formatter : function(params, ticket,
											callback) {
										var date = params[1];
										date = date.substring(0, 4) - 1
												+ date.substring(4);
										return params[0] + "（" + date
												+ "）<br/>共：" + params[2];
									}
								}
							} ]

				};
				echarts.init(document.getElementById("happenChart")).setOption(
						option).on(echarts.config.EVENT.CLICK, showHaPie);
			});
</script>

<div id="happenChart" style="width:100%;height:100%;"></div>



