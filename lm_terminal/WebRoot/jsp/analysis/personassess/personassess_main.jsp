<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String path = request.getContextPath();
   String basePath = request.getScheme() + "://" + request.getServerName() + ":"
         + request.getServerPort() + path + "/";
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="lauvanUI/dist/css/AdminLTE.min.css">
    
</head>
<body>   
          <div class="container-fluid" style="margin-top: 25px;">
          <div class="row-fluid">
              <!-- AREA CHART -->
              <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">值班人员考核</h3>
                </div>
                <div class="box-body chart-responsive">
                  		<table class="table table-bordered">
			<tr>
				<th>姓名</th>
				<th>值班次数</th>
				<th>处理事务/条</th>
				<th>拨打电话/次</th>
				<th>发送短信/条</th>
			</tr>
			<tbody>
			  <tr><td>管理员</td><td>14</td><td>102</td><td>45</td><td>145</td></tr>
			  <tr><td>张三疯</td><td>15</td><td>133</td><td>34</td><td>114</td></tr>
			  <tr><td>周志高</td><td>11</td><td>78</td><td>68</td><td>111</td></tr>
			  <tr><td>张三</td><td>14</td><td>108</td><td>122</td><td>95</td></tr>
			  <tr><td>陶嵩嵩</td><td>16</td><td>122</td><td>67</td><td>75</td></tr>
			  <tr><td>黄丽丽</td><td>12</td><td>98</td><td>80</td><td>105</td></tr>
			</tbody>
		</table>
                </div><!-- /.box-body -->
              </div><!-- /.box -->

          </div>
      </div>    
    <!-- jQuery 2.1.4 -->
    <script src="lauvanUI/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="lauvanUI/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>