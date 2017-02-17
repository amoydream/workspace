<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="css/login.css">
</head>
<body>
	<div class="container main-container">
		<div class="row">
			<div class="col-sm-9 container">
				<div class="row">
					<div class="col-sm-2 col-sm-offset-2 hidden-xs">
						<img class="img-responsive" src="images/login/bgimg.png">
					</div>
					<div class="col-sm-1 hidden-xs  arrow"></div>
					<form role="form" id="form_login" action="${pageContext.request.contextPath}/login" method="post"
						class="login-form">
						<div class="col-sm-6 form-box">
							<div class="form-top" id="form-top">
								<div class="row">
									<h2>龙门 应急值守终端</h2>
								</div>
							</div>
							<div class="form-bottom" id="form-bottom">
								<div class="has-feedback form-group">
									<div class="row">
										<div class="col-xs-10 col-xs-offset-1">
											<label class="sr-only" for="form-username">用户名</label>
											<span class="glyphicon glyphicon-user form-control-feedback"></span>
											<input type="text" name="username" placeholder="用户名" class="form-username form-control" id="form-username">
										</div>
									</div>
								</div>
								<div class="has-feedback form-group">
									<div class="row">
										<div class="col-xs-10 col-xs-offset-1">
											<label class="sr-only" for="form-password">密 码</label>
											<span class="glyphicon glyphicon-lock form-control-feedback"></span>
											<input type="password" name="pass" placeholder="密   码" class="form-password form-control" id="form-password">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-10 col-xs-offset-1">
										<button id="loginSubmit" type="submit" class="btn">登 录</button>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery.form.min.js"></script>
	<script src="lauvanUI/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
	        var h = document.documentElement.clientHeight;
	        $(".main-container").css('margin-top', h / 4);
	        $(".form-box").css('height', h / 2);
	        $(".form-top").css('padding', h / 40);
	        $("input").css('height', h / 20);
	        $("form-control-feedback").css('line-height', h / 20);
	        $("button").css('height', h / 20);

	        var toph = document.getElementById("form-top").offsetHeight;
	        var bottomh = document.getElementById("form-bottom").offsetHeight;
	        var chazhi = h / 2 - (toph + bottomh);
	        if(chazhi < 0) {
		        $(".form-box").css('height', h / 2 - chazhi + 30);
	        } else if(chazhi = 0) {
		        $(".form-box").css('height', h / 2 + 50);
	        } else {
		        $(".form-box").css('height', h / 2 + 20);
	        }
        })
        function login_submitForm() {
	        $.post('login', $('#login_form').serialize(), function(j) {
		        if(j.success) {
			        location.replace('index');
		        } else {
			        parent.layer.tips(j.msg, '.layui-layer-btn0', {
				        tips : 1
			        });
		        }
	        }, 'json');
        }
		
		$userAgent = 'ie';

	    $(function() {
	    	if(typeof (ActiveXObject) != "undefined") {
			    if(navigator.$userAgent.indexOf("MSIE 10") != -1) {
				    $userAgent = "ie";
			    } else {
				    $userAgent = "chrome";
			    }
		    } else {
			    if(navigator.$userAgent.indexOf("Trident/7") != -1 && navigator.$userAgent.indexOf("rv:11") != -1) {
				    $userAgent = "ie";
			    } else {
				    if(navigator.$userAgent.indexOf("Edge") != -1) {
					    $userAgent = "ie";
				    } else {
					    if(Object.prototype.toString.call(window.opera) == "[object Opera]") {
						    $userAgent = "opera";
					    } else {
						    if(navigator.vendor.indexOf("Apple") != -1) {
							    $userAgent = "safari";
							    if(navigator.$userAgent.indexOf("iPad") != -1 || navigator.$userAgent.indexOf("iPhone") != -1) {
								    $userAgent.ios = true;
							    }
						    } else {
							    if(navigator.vendor.indexOf("Google") != -1) {
								    if((navigator.$userAgent.indexOf("Android") != -1) && (navigator.$userAgent.indexOf("Chrome") == -1)) {
									    $userAgent = "android";
								    } else {
									    $userAgent = "chrome";
								    }
							    } else {
								    if(navigator.product == "Gecko" && window.find && !navigator.savePreferences) {
									    $userAgent = "firefox";
								    } else {
									    throw new Error("couldn't detect browser");
								    }
							    }
						    }
					    }
				    }
			    }
		    }
	    });
	    
	    function openMain() {
	    	if($userAgent === 'ie' && (typeof (window.opener) === 'undefined' || window.opener === null)) {
			    var width = window.screen.width - 20;
			    var height = window.screen.height - 80;
			    window.open('index', '_blank', 'toolbar=0,location=0,directies=0,status=0,menubar=0,scrollbars=no,resizable=1,left=0,top=0,width=' + width + ',height=' + height);
			    window.opener = null;
			    window.open('', '_self');
			    window.close();
		    }
	    }
		
        $('#form_login').ajaxForm({
            beforeSubmit : function(a, f, o) {
	            /* if($('#inputName').val().length == 0){
	            	$('#inputName').focus();
	            	$('#login_error_msg').html("请输入帐号");
	            	$('#login_error_msg').show();
	            	return false;
	            }
	            if($('#inputPwd').val().length == 0){
	            	$('#inputPwd').focus();
	            	$('#login_error_msg').html("请输入登录密码");
	            	$('#login_error_msg').show();
	            	return false;
	            }
	            $('#login_error_msg').html("");
	             */
	            $("#loginSubmit").html("正在提交中...");
	            $("#loginSubmit").attr("disabled", "disabled");
            },
            success : function(json) {
	            if(json.success) {
	            	//openMain();
		            window.location.href = '${pageContext.request.contextPath}/index';
	            } else {
		            $("#loginSubmit").html("登陆");
		            $("#loginSubmit").attr("disabled", false);
		            alert(json.msg);
	            }
            }
        });
	</script>
</body>
</html>
