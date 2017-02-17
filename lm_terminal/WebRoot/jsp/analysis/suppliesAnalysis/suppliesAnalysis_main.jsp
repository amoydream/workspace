<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrap.min.css">
    <!-- Morris charts -->
    <link rel="stylesheet" href="lauvanUI/plugins/morris/morris.css">
        <!-- Ionicons -->
    <!-- Theme style -->
    <link rel="stylesheet" href="lauvanUI/dist/css/AdminLTE.min.css">
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=LEcDcElRR6zFXoaG6jtANQYW"></script>
</head>

<body>
          <div class="container-fluid" style="margin-top: 25px;">
          <div class="row-fluid">
            <div class="col-md-6">
              <!-- AREA CHART -->
              <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">物资统计</h3>
                </div>
                <div class="box-body chart-responsive">
                  		<table class="table table-bordered">
			<tr>
				<th>物资名称</th>
				<th>型号</th>
				<th>规格</th>
				<th>数量</th>
			</tr>
			<tbody>
			  <tr><td>应急灯</td><td>LED</td><td>XL</td><td>192</td></tr>
			  <tr><td>蚊帐</td><td>白色</td><td>XX</td><td>355</td></tr>
			  <tr><td>棉被</td><td>灰/黑</td><td>SS</td><td>370</td></tr>
			  <tr><td>毛衣被</td><td>灰</td><td>2*2</td><td>430</td></tr>
			  <tr><td>漂白粉</td><td>立白</td><td>500g</td><td>744</td></tr>
			  <tr><td>过氧乙酸</td><td>98%</td><td>1000ml</td><td>123</td></tr>
			  <tr><td>烟气黑度计</td><td>银色</td><td>xl</td><td>69</td></tr>
			  <tr><td>衬衫</td><td>白/灰</td><td>LL</td><td>682</td></tr>
			</tbody>
		</table>
                </div><!-- /.box-body -->
              </div><!-- /.box -->


            </div><!-- /.col (LEFT) -->
            <div class="col-md-6">
              <!-- LINE CHART -->
              <div class="box box-info">
                <div class="box-header with-border">
                  <h3 class="box-title">物资分布图</h3>
                </div>
                <div class="box-body chart-responsive">
                  <div id="supplies_map" style="height: 350px;"></div>
                </div><!-- /.box-body -->
              </div><!-- /.box -->


            </div><!-- /.col (RIGHT) -->
          </div><!-- /.row -->
          </div>
<jsp:include page="/include/pub-js.jsp"></jsp:include>          
<script type="text/javascript" src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>          
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("supplies_map");
	map.centerAndZoom(new BMap.Point(114.404, 23.267), 9);
	map.enableScrollWheelZoom();

	var MAX = 50;
	var markers = [];
	var pt = null;
	
	for (var i = 0; i < MAX; i++) {
	   pt = new BMap.Point(Math.random() + 114, Math.random() + 23);
	   markers.push(new BMap.Marker(pt));
	}
	//最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
	var markerClusterer = new BMapLib.MarkerClusterer(map, {markers:markers});
</script>
          
</body>
</html>