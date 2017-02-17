<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>事件统计</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrap.min.css">
<script src="js/jquery.min.js"></script>
<script src="lauvanUI/bootstrap/js/bootstrap.min.js"></script>
<script src="js/echarts-all.js"></script>
</head>

<body>
<ul class="nav nav-tabs">
   <li class="active"><a href="#eventinfo1" data-toggle="tab">按年统计</a></li>
   <li><a a href="#eventinfo2" data-toggle="tab">按级别统计</a></li>
   <li><a a href="#eventinfo3" data-toggle="tab">按月统计</a></li>
</ul>
<div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="eventinfo1" >
         <div id="eventinfo_year" style="height:400px;"></div>
<script type="text/javascript">
//基于准备好的dom，初始化echarts图表
var myChart_year = echarts.init(document.getElementById('eventinfo_year')); 
myChart_year.clear();
myChart_year.showLoading({  
    text : "图表数据正在努力加载..."  
});
var option_year = {
    tooltip: {
        show: true
    },
    legend: {
        data:['事件年度事故数统计']
    },
    xAxis : [
        {
            type : 'category',
            data : ["11"]
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            "name":"事件年度事故数统计",
            "type":"bar",
            "data":[0]
        }
    ]
};

// 为echarts对象加载数据 
myChart_year.setOption(option_year);
//myChart.hideLoading();
getChartDataYear();//aja后台交互

function getChartDataYear() {  
    //获得图表的options对象  
    var options = myChart_year.getOption();  
    //通过Ajax获取数据  
    $.ajax({  
        type : "post",  
        async : false, //同步执行  
        url : "analysis/eventAnalysis/listYear",  
        data : {},  
        dataType : "json", //返回数据形式为json  
        success : function(result) {  
            if (result) {  
                options.legend.data = result.legend;  
                options.xAxis[0].data = result.category;  
                options.series[0].data = result.series[0].data;  
                myChart_year.hideLoading();  
                myChart_year.setOption(options);  
            }  
        },  
        error : function(errorMsg) {  
            alert("图表请求数据失败啦!");  
            myChart_year.hideLoading();  
        }  
    });  
}
</script>
      </div>
      <div class="tab-pane fade" id="eventinfo2" >
         <div id="eventinfo_level" style="height:500px;width: 900px;"></div>
<script type="text/javascript">
//基于准备好的dom，初始化echarts图表
var myChart_level = echarts.init(document.getElementById('eventinfo_level')); 
myChart_level.clear();
myChart_level.showLoading({  
    text : "图表数据正在努力加载..."  
});
var option_level = {
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['Ⅰ级事件(特别重大)','Ⅱ级事件(重大)','Ⅲ级事件(较大)','Ⅳ级事件(一般)','Ⅳ级以下事件']
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    toolbox: {
	        feature: {
	            saveAsImage: {}
	        }
	    },
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['2015']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : []
	};


// 为echarts对象加载数据 
myChart_level.setOption(option_level);
getChartDataLevel();//aja后台交互

function getChartDataLevel() {  
    //获得图表的options对象  
    var options = myChart_level.getOption();  
    //通过Ajax获取数据  
    $.ajax({  
        type : "post",  
        async : false, //同步执行  
        url : "analysis/eventAnalysis/listLevel",  
        data : {},  
        dataType : "json", //返回数据形式为json  
        success : function(result) {  
            if (result) {  
                options.legend.data = result.legend;  
                options.xAxis[0].data = result.category;  
                options.series = result.series;  
                myChart_level.hideLoading();  
                myChart_level.setOption(options);  
            }  
        },  
        error : function(errorMsg) {  
            alert("图表请求数据失败啦!");  
            myChart_level.hideLoading();  
        }  
    });  
}
</script>
      </div>
<div class="tab-pane fade" id="eventinfo3" >
      <div id="eventinfo_month" style="height:400px;"></div>
<script type="text/javascript">
//基于准备好的dom，初始化echarts图表
var myChart_month = echarts.init(document.getElementById('eventinfo_month'));
myChart_month.clear();
myChart_month.showLoading({
    text : "图表数据正在努力加载..."
});
var option_month = {
	    tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    legend: {
	        data:['0']
	    },
	    toolbox: {
	        show : true
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            data : ['11']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'',
	            type:'bar',
	            stack:'',
	            data:[0]
	        },
	        {
	            name:'',
	            type:'bar',
	            stack:'',
	            data:[0]
	        },
	        {
	            name:'',
	            type:'bar',
	            stack:'',
	            data:[0]
	        }
	    ]
	};
	
// 为echarts对象加载数据 
myChart_month.setOption(option_month);
getChartDataMonth();//aja后台交互

function getChartDataMonth() {
    //获得图表的options对象  
    var options = myChart_month.getOption();
    //通过Ajax获取数据  
    $.ajax({
        type : "post",
        async : false, //同步执行  
        url : "analysis/eventAnalysis/listMonth",
        data : {},
        dataType : "json", //返回数据形式为json  
        success : function(result) {
            if (result) {
                options.legend.data = result.legend;
                options.xAxis[0].data = result.category;
                options.series = result.series;
                myChart_month.hideLoading();
                myChart_month.setOption(options);
            }
        },
        error : function(errorMsg) {
            alert("图表请求数据失败啦!");
            myChart_month.hideLoading();
        }
    });
}
</script>
</div>
   </div>
</body>
</html>