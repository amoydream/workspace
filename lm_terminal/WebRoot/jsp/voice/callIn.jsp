<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<style type="text/css">
/* CSS Document */
*{ margin:0; padding:0; font-family:"Arial","Microsoft YaHei","微软雅黑","宋体"; }
ul,ol,li{ list-style:none;}
h1,h2 {font-weight:normal;}
a{ text-decoration:none; color:#333;}
a:hover{ text-decoration:none; color:#09f;}
.clear {clear:both;}
img{border:none;}
body {font-size:12px;}

/*内容*/
.contact{height:200px; margin:1px auto; background:url(images/icon/callbg.jpg) no-repeat; border:1px solid #dfdfdf; overflow:hidden; position:relative;}
.top{ width:400px; height:30px;background:#58bbde; border-bottom:1px solid #cbe0e7;}
.top li{text-align:center; line-height:30px; font-size:12px; color:#FFF; font-weight:700;}
.callicon{ width:300px; height:80px; margin:20px auto 0;}
.callicon img{  height:80px;}
.span{ text-align:center; font-size:14px;font-weight:700; color:#607375;}
.bottom{ width:400px; height:40px;background:#2b8eb1; position:absolute; bottom:0; left:0;}
.bottom li{ line-height:40px; text-align:center; font-size:16px;font-weight:700; color:#dbebfe; letter-spacing: 1px;}

</style>
<div class="contact">
<div class="top"><li>来电</li></div>
<div class="callicon"><img src="images/icon/callicon.gif" /></div>
<div class="span">姓名：${name }|部门：${dep }</div>
<div class="bottom"><li>${CCID }</li></div>
</div>
<audio id="telRing" autoplay="true" loop="loop" hidden="hidden" src="upload/telRing.mp3"/>
</body>
</html>