<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script>
var myChart;
$.getJSON("<%=basePath%>Main/geology/getWyData", {'sdate' : '${sdate}','edate' : '${edate}'},
			function(json) {
				
	var WYoption = {
			addDataAnimation:true,
		    title : {
		        text: '位移传感器',
		        subtext: '纯属虚构'
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['位移']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : true,
		            data : (function (){
		                var now = new Date();
		                var res = [];
		                var len = 10;
		                while (len--) {
		                    res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
		                    now = new Date(now - 2000);
		                }
		                return res;
		            })()
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            scale: true,
		            name : '价格',
		        }
		    ],
		    series : [
              {
                  name:'最新成交价',
                  type:'line',
                  data:(function (){
                      var res = [];
                      var len = 10;
                      while (len--) {
                          res.push((Math.random()*10 + 5).toFixed(1) - 0);
                      }
                      return res;
                  })()
              }
		    ]
		};
	myChart = echarts.init(document.getElementById("gchart"));
	myChart.setOption(WYoption);
	});
			
var lastData;
var axisData;
var timeTicket;
clearInterval(timeTicket);
timeTicket = setInterval(function (){
	$.post('<%=basePath%>Main/geology/getWyData',function(data){
	      lastData=data;	
	});
	console.info(lastData);
    axisData = (new Date()).toLocaleTimeString().replace(/^\D*/,'');
    
    // 动态数据接口 addData
    myChart.addData([
        [
           0,        // 系列索引
           lastData, // 新增数据
           false,    // 新增数据是否从队列头部插入
           false,    // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
           axisData  // 坐标轴标签
        ]
    ]);
}, 2100);

</script>

<div id="gchart" style="width:100%;height:90%;"></div>