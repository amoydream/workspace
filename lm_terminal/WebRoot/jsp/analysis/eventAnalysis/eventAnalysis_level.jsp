<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String path = request.getContextPath();
   String basePath = request.getScheme() + "://" + request.getServerName() + ":"
         + request.getServerPort() + path + "/";
%>    
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
<script src="js/echarts-all.js"></script>
</head>
<body>   
<div id="main" style="height:500px;"></div>
<script type="text/javascript">
//基于准备好的dom，初始化echarts图表
var myChart = echarts.init(document.getElementById('main')); 
myChart.clear();
myChart.showLoading({  
    text : "图表数据正在努力加载..."
});
option = {
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
myChart.setOption(option);
getChartData();//aja后台交互

function getChartData() {  
    //获得图表的options对象  
    var options = myChart.getOption();  
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
                myChart.hideLoading();  
                myChart.setOption(options);  
            }  
        },  
        error : function(errorMsg) {  
            alert("图表请求数据失败啦!");  
            myChart.hideLoading();  
        }  
    });  
}
</script>
</body>
</html>