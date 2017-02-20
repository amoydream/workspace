<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="">
<%@ include file="/include/softphone.jsp"%> 
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/phone1.css"></link>
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/icon/css/button-fonts.css"></link>
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/left1.css"></link>	
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/right1.css"></link>	
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/show.css"></link>		
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/right-button.css"></link>	
</head>
<body>
<div id="phone-main">
	<div class="main-content">
		<div class="phone">
			<div class="number">
				<div id="the-phone">
					<div id="the-display">
						<form name="calculator">
							<input id="total" type="text"  onkeydown="keyEvents();"></input>
							<!-- <span id="total"></span>  -->
						</form>
					</div>
					<div id="the-buttons">

						<div class="button-row clearfix">
							<button class="dial_int minbutton" value="1">1</button>
							<button class="dial_int minbutton" value="2">2</button>
							<button class="dial_int minbutton" value="3">3</button>
							<button id="phone_sms" class="dial_op maxbutton" value="">短消息</button>
						</div>
						<div class="button-row clearfix">
							<button class="dial_int minbutton" value="4">4</button>
							<button class="dial_int minbutton" value="5">5</button>
							<button class="dial_int minbutton" value="6">6</button>
							<button id="phone_books" class="dial_op maxbutton" value="">通讯录</button>
						</div>
						<div class="button-row clearfix">
							<button class="dial_int minbutton" value="7">7</button>
							<button class="dial_int minbutton" value="8">8</button>
							<button class="dial_int minbutton" value="9">9</button>
							<button id="phone_back" class="dial_op maxbutton" value="backspace">
								<span class="glyphicon glyphicon-arrow-left"></span>退格
							</button>
						</div>
						<div class="button-row clearfix">
							<button class="dial_int minbutton" value="*">*</button>
							<button class="dial_int minbutton" value="0">0</button>
							<button class="dial_int minbutton" value="#">#</button>
							<button id="phone_clear" value="delete">
								<span class="glyphicon  glyphicon-remove"></span>清除
							</button>
						</div>
						<div class="button-row clearfix">
							<button id="phone_record" class="dial_op minbutton" value="">
								<span class="glyphicon  glyphicon-book"></span>通讯历史
							</button>
							<button id="speed_dial" class="dial_op mmaxbutton" value="">
								<span class="glyphicon glyphicon-list-alt"></span>一键拨号
							</button>
						</div>

						<div class="button-row clearfix">
							<button id="phone_hangup" class="mmaxbutton" value="">
								<span class="glyphicon glyphicon-phone-alt"></span>挂机
							</button>
							<button id="phone_dial" class="mmaxbutton" value="=">
								<span class="glyphicon glyphicon-earphone"></span>拨打
							</button>
						</div>
						
						<div id="extra-buttons" class="button-row clearfix">
							<button id="phone_tran" value="" class="dial_op mmaxbutton">
								<span class="glyphicon glyphicon-transfer"></span>转接
							</button>
							<button id="phone_voice" class="dial_op mmaxbutton" value="">
								<span class="glyphicon glyphicon-record"></span>录音
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
        </div>
</div>
<div id="_smsNumberDialog"></div>
	<script type="text/javascript" src="<%=basePath%>plugins/softphone/js/phone1.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugins/softphone/js/left1.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugins/softphone/js/right1.js"></script>
	<script type="text/javascript">
     $(function(){
    	 
    	 $("#phone-main").parent().css("background","url('<%=basePath%>plugins/softphone/images/gaussian-blur-01.jpg')");
    	 
     });
   </script>
  </body> 