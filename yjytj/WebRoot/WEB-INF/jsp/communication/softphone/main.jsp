<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>    
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/phone.css"></link>
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/icon/css/button-fonts.css"></link>
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/left.css"></link>	
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/right.css"></link>	
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/show.css"></link>		
<link rel="stylesheet" type="text/css" href="<%=basePath%>plugins/softphone/css/right-button.css"></link>	
<div id="phone-parentid" class="easyui-layout" data-options="fit:true">
<div id="phone-main">
	<div class="main-content">
		<div id="the-left" class="from-below" style="visibility: hidden;">
			<div>
				<span id="left_close" class="glyphicon glyphicon-remove-circle"></span>
			</div>
			<div id="left-data">
			 <div style="overflow:auto;">
			<div style="margin: 8px 13px;">
				<select id="input-select" class="input-select">
				</select>
				<button type="button" class="btn btn-success" onclick="sureNumber();">确定</button>
			</div>
			<div>
				<iframe src="Main/softphone/getBook" width="308" height="700"
					frameborder="0" scrolling="auto"></iframe>
			</div>
			</div>
			</div>
		</div>

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
						<!-- <div id="extra-buttons" class="button-row clearfix">
							<button id="calc_denom" value="1/x" class="middmaxbutton"><span class="denominator">摘机</span></button>
							<button id="calc_sqrt" value="&radic;" class="middmaxbutton">挂机</button>
							<button id="calc_square" class="middmaxbutton" value="x2" >转接</button>
						</div> -->
						<div id="extra-buttons" class="button-row clearfix">
							<button id="phone_tran" value="" class="dial_op mmaxbutton">
								<span class="glyphicon glyphicon-transfer"></span>转接
							</button>
							<button id="phone_voice" class="dial_op mmaxbutton" value="">
								<span class="glyphicon glyphicon-record"></span>录音
							</button>
						</div>
						<div class="button-row clearfix">
							<button id="phone_left_close" value="" class="dial_op mmaxbutton">
								<span class="glyphicon glyphicon-remove-circle"></span>左关闭
							</button>
							<button id="phone_right_close" class="dial_op mmaxbutton" value="">
								<span class="glyphicon glyphicon-remove-circle"></span>右关闭
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="the-right" class="from-below" style="visibility: hidden;">

			</div>
        </div>
</div>
<div id="_smsNumberDialog"></div>
</div>
	<script type="text/javascript" src="plugins/softphone/js/phone.js"></script>
	<script type="text/javascript" src="<%=basePath%>plugins/softphone/js/left.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugins/softphone/js/right.js"></script>
	<script type="text/javascript">
     $(function(){
    	 
    	 $("#phone-parentid").css("background","url('plugins/softphone/images/gaussian-blur-01.jpg')");
    	 
     });
   </script>