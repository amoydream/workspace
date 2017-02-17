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
<div class="container-fluid" style="margin-top: 15px;">
	<div class="row-fluid">
	<div id="main" style="height:400px;"></div>
	</div>
	</div>
<script type="text/javascript">
//基于准备好的dom，初始化echarts图表
var myChart = echarts.init(document.getElementById('main'));
myChart.clear();
/* myChart.showLoading({
    text : "图表数据正在努力加载..."
}); */
var option = {
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
myChart.setOption(option);
//myChart.hideLoading();
getChartData();//aja后台交互


function getChartData() {
    //获得图表的options对象  
    var options = myChart.getOption();
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