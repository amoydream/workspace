<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script>
	$.getJSON("<%=basePath%>Main/plancount/getData", {'counttype' : '${counttype}'},
			function(json) {
		       var typelist=json.type;
		       var showtype=typelist[0];
		       if(showtype=="00A"){
				var data = json.nowdata;
				for (var i = 0; i < data.length; i++) {
					if (data[i] == null) {
						data[i] = 0;
					}
				}
				var option = {
					tooltip : {
						show : true,
						formatter : function(params, ticket, callback) {
							return params[1]+"<br/>共："
									+ params[2];

						}
					},
					xAxis : [ {
						type : 'category',
						data : json.hang,
						axisLabel :{  
							 interval:0,
	                         rotate:45,
	                         margin:2,
	                         textStyle:{
	                             color:"#222"
	                         } 
						}
					} ],
					grid: { // 控制图的大小，调整下面这些值就可以，
			             x: 40,
			             x2: 100,
			             y2: 150,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
			         },

					yAxis : [ {
						type : 'value'
					} ],
					series : [
							{
								"name" : json.hang,
								"type" : "bar",
								"data" : data
							}]

				};
				 var datapie = [];
					var temppie = json.piedata;
					if(temppie.length>0){
						for(var i=0; i<temppie.length; i++){
							datapie.push({'name': temppie[i].P_NAME, 'value' :temppie[i].COUNTNUM});
						}
						PieOption.series[0].data=datapie;
					}else{
						pieOption.series[0].data = ['-'];
					}
						
				if(PieChart == null){
						PieChart = echarts.init(document.getElementById("yaPie")).setOption(PieOption);
				}else{
						PieChart.clear();
						PieChart.setOption(PieOption);
				} 
                }else{
                	var deptsize = json.deptsize;
                	var myChart= echarts.init(document.getElementById("histogram"));
                	var option = {
        					tooltip : {
        						show : true,
        						formatter : function(params, ticket, callback) {
        							return params[0]+"<br/>共："
        									+ params[2];

        						}
        					},
        					 calculable : true,
        					xAxis : [ {
        						type : 'category',
        						data : json.hang,
        						axisLabel :{  
        							 interval:0,
        	                         rotate:45,
        	                         margin:2,
        	                         textStyle:{
        	                             color:"#222"
        	                         } 
        						}
        					} ],
        					grid: { // 控制图的大小，调整下面这些值就可以，
        			             x: 40,
        			             x2: 100,
        			             y2: 150,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
        			         },

        					yAxis : [ {
        						type : 'value'
        					} ]
        				}; 
                	var series=[];
                	var datalist=json.countdatalist;
                 	for(var k=0;k<deptsize.length;k++){
                 		var s = {};
                    	s.name=deptsize[k];
                    	s.type='bar';
                    	s.data =datalist[k];
                    	series.push(s);
                	} 
                	option.series=series;
                	myChart.clear();
                	var optionpie = {
                		    tooltip: {
                		        trigger: 'item',
                		        formatter: "{a} <br/>{b}: {c} ({d}%)"
                		    },
                		    series: [
                		        {
                		            name:'概率',
                		            type:'pie',
                		            selectedMode: 'single',
                		            radius: [0, '30%'],
                		            label: {
                		                normal: {
                		                	show: true,
                		                    position: 'inner'
                		                }
                		            }
                		        },
                		        {
                		            name:'概率',
                		            type:'pie',
                		            radius: ['40%', '55%'],
                		        }
                		    ]
                		};
                	var datapie = [];
                	var outdatapie=[];
					var temppie = json.piedata;
					var outpie=json.outpiedata;
					if(temppie.length>0){
						for(var i=0; i<temppie.length; i++){
							datapie.push({'name': temppie[i].P_NAME, 'value' :temppie[i].COUNTNUM});
						}
						optionpie.series[0].data=datapie;
					}else{
						optionpie.series[0].data = ['-'];
					}
					if(outpie.length>0){
						for(var i=0; i<outpie.length; i++){
							outdatapie.push({'name':outpie[i].DEPT+'('+outpie[i].P_NAME+')', 'value' :outpie[i].COUNTNUM});
						}
						optionpie.series[1].data=outdatapie;
					}else{
						optionpie.series[1].data = ['-'];
					}

                	if(PieChart == null){
						PieChart = echarts.init(document.getElementById("yaPie")).setOption(optionpie);
				}else{
						PieChart.clear();
						PieChart.setOption(optionpie);
				}
		       }
				echarts.init(document.getElementById("histogram")).setOption(
						option);
				 
	
	});
</script>

<div id="histogram" style="width:100%;height:100%;"></div>



