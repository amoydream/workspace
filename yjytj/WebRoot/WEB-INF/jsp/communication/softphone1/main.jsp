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
<title>政府综合应急平台</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="">
<%@ include file="/include/header.jsp"%>
<%@ include file="/include/ccms.jsp"%> 
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
		<!--<div id="the-left">
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
			</div> -->
			<!--  <ul id="results_list"><li id="result_default">Memory is Empty</li></ul>
     <a id="result_clear" href="#">Wipe</a> 
		</div>-->

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
			<!-- <iframe src="https://hi.dearb.me/build" frameborder="0" scrolling="no"></iframe> -->
		</div>
		<!-- <div id="the-right" class="from-below" style="visibility: hidden;">
             <div >
				<span id="right_close" style="right:-96%;" class="glyphicon glyphicon-remove-circle"></span>
			</div>
			<div id="right-data">
			<div class="right-speed-div">
			<div class="right-speed-btn-div">
			<button class="button white">测试员1 15018885666</button>
			<button class="button white">测试员2 18890999122</button>
			</div>
			</div>
			 <div style="margin:6px 2px;">
			   <button type="button" class="btn btn-info" onclick="editSpeedDial();">编辑</button>
			  </div>
			</div>
			<div>
			 <div class="right-number-book">
			  <span style="font-weight: bold;">通讯录</span>
			  <span id="right-book" class="glyphicon glyphicon-book"> </span>
			 <a class="a-text" href="javascript:;">号码总数<span id="mobilecounts" class="span-badge">0</span></a>
			 </div>
			 <div class="right-number-area">
				 <ul id="results_number"> 
				 </ul>
			 </div>
			 <div style="margin:6px 2px;">
			  <input id="rightsms-input-add" class="input-text" type="text" placeholder="添加发送号码..."></input>
			  <button type="button" class="btn btn-success" onclick="addNumber();">添加</button>
			 </div>
			  <div style="margin:6px 2px;">
			  <button id="rightsms-btn-delete" class="btn btn-warming" onclick="deleteSelect();">删除选定</button>
			  <button class="btn btn-danger" onclick="clearAllNumber();">清空</button>
			  </div>
			</div>
			  <div>
			   <textarea id="rightsms-textarea" class="textarea-text" rows="10"></textarea>
			   <div style="margin:6px 2px;">
			   <button class="btn btn-warming" onclick="clearMsg();">清空</button> 
			   <button type="button" class="btn btn-success" onclick="sendSms();">发送</button>
			   </div>
			  </div> 
			</div>-->
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