<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
<meta name="content-type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="lauvanUI/Font-Awesome-master/css/font-awesome.min.css">
<link rel="stylesheet" href="lauvanUI/plugins/ionicons/css/ionicons.min.css">
<link rel="stylesheet" href="lauvanUI/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="lauvanUI/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" href="lauvanUI/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="js/messenger/messenger.css">
<link rel="stylesheet" href="js/messenger/messenger-theme-ice.css">
<title>龙门应急值守系统</title>
</head>
<body class="hold-transition skin-blue sidebar-mini" onload="init();" onunload="uninit();">
	<div class="wrapper">
		<header class="main-header">
			<a class="logo"> <span class="logo-mini">
					<b>应急</b>
				</span> <span class="logo-lg">
					<b>龙门应急值守系统</b>
				</span>
			</a>
			<nav class="navbar navbar-static-top" role="navigation">
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button"> <span
						class="sr-only">Toggle navigation</span>
				</a>
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- <li class="dropdown messages-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-envelope-o"></i>
                  <span class="label label-success">4</span>
                </a>
              </li>
              <li class="dropdown notifications-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-bell-o"></i>
                  <span class="label label-warning">10</span>
                </a>
                <ul class="dropdown-menu">

                </ul>
              </li>
              <li class="dropdown tasks-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-flag-o"></i>
                  <span class="label label-danger">9</span>
                </a>
                <ul class="dropdown-menu">

                </ul>
              </li> -->
						<li class="dropdown user user-menu"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"> <img src="lauvanUI/dist/img/user2-160x160.jpg" class="user-image"
								alt="User Image"> <input type="hidden" id="main_vo_Code" value="${userVo.voice }" />
								<span class="hidden-xs">${userVo.us_Name }</span>
						</a>
							<ul class="dropdown-menu">
								<li class="user-header"><img src="lauvanUI/dist/img/user2-160x160.jpg"
									class="img-circle" alt="User Image">
									<p>
										${userVo.us_Name } <small>工作电话：${userVo.us_Offphone }</small>
									</p></li>
								<li class="user-footer">
									<!-- <div class="pull-left">
                      <a href="#" class="btn btn-default btn-flat">Profile</a>
                    </div> -->
									<div class="pull-right">
										<a href="javascript:void(0);" class="btn btn-default btn-flat" onclick="main_logout();">注销</a>
									</div>
								</li>
							</ul></li>
						<!-- <li>
                <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
              </li> -->
					</ul>
				</div>
			</nav>
		</header>
		<aside class="main-sidebar">
			<section class="sidebar">
				<div class="user-panel">
					<div class="pull-left image">
						<img src="lauvanUI/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
					</div>
					<div class="pull-left info">
						<p>${userVo.us_Name }</p>
					</div>
				</div>
				<ul class="sidebar-menu">
					<c:forEach items="${moduleInfo }" var="menu">
						<li class="treeview"><a href="#"
							onclick="select_second_menu(${menu.mo_Id},'${menu.mo_Name }')"> <i
								class="fa fa-dashboard"></i> <span>${menu.mo_Name }</span> <i
								class="fa fa-angle-left pull-right"></i>
						</a>
							<ul class="treeview-menu">
							</ul></li>
					</c:forEach>
				</ul>
			</section>
		</aside>
		<div class="content-wrapper" id="content-wrapper">
			<div class="row content-tabs" style="background-color: #A4D3EE;">
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active" id="tab_home"><a id="main_home" href="#home"
						aria-controls="home" role="tab" data-toggle="tab">首页</a></li>
				</ul>
			</div>
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="home">
					<!-- <input type="button" onclick="aaa()"> -->
					<div id="main-content">
						<div style="margin: 15px;" class="container-fluid">
							<div class="row-fluid">
								<div class="col-sm-4">
									<div class="row-fluid">
										<div class="col-sm-10 col-sm-offset-1 md module3" style="margin-top: 10px;">
											<a href="javascript:void(0);" addtabs="suppliestype" url="resource/suppliestype/main"
												title="物资分类"> <span class="icon fa fa-book"></span>
												<div class="ca-content">
													<h2 class="ca-main">物资分类</h2>
													<h3 class="ca-sub">物资分类</h3>
												</div></a>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="row-fluid">
										<div class="col-sm-10 col-sm-offset-1 md module2" style="margin-top: 10px;">
											<a href="javascript:void(0);" addtabs="supplies" url="resource/supplies/main"
												title="物资信息"> <span class="icon fa fa-book"></span>
												<div class="ca-content">
													<h2 class="ca-main">物资信息</h2>
													<h3 class="ca-sub">物资信息</h3>
												</div></a>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="row-fluid">
										<div class="col-sm-10 col-sm-offset-1 md module1" style="margin-top: 10px;">
											<a href="javascript:void(0);" addtabs="suppliesstore" url="resource/suppliesstore/main"
												title="物资存储"> <span class="icon fa fa-book"></span>
												<div class="ca-content">
													<h2 class="ca-main">物资存储</h2>
													<h3 class="ca-sub">物资存储</h3>
												</div></a>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="row-fluid">
										<div class="col-sm-10 col-sm-offset-1 md module1" style="margin-top: 10px;">
											<a href="javascript:void(0);" addtabs="assets" url="resource/assets/main" title="应急资源">
												<span class="icon fa fa-sitemap"></span>
												<div class="ca-content">
													<h2 class="ca-main">应急资源</h2>
													<h3 class="ca-sub">应急资源</h3>
												</div>
											</a>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="row-fluid">
										<div class="col-sm-10 col-sm-offset-1 md module3" style="margin-top: 10px;">
											<a href="javascript:void(0);" addtabs="danger" url="resource/danger/main" title="危险隐患">
												<span class="icon fa fa-book"></span>
												<div class="ca-content">
													<h2 class="ca-main">危险隐患</h2>
													<h3 class="ca-sub">危险隐患</h3>
												</div>
											</a>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="row-fluid">
										<div class="col-sm-10 col-sm-offset-1 md module5" style="margin-top: 10px;">
											<a href="javascript:void(0);" addtabs="team" url="resource/team/main" title="应急队伍"> <span
													class="icon fa fa-book"></span>
												<div class="ca-content">
													<h2 class="ca-main">应急队伍</h2>
													<h3 class="ca-sub">应急队伍</h3>
												</div></a>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="row-fluid">
										<div class="col-sm-10 col-sm-offset-1 md module2" style="margin-top: 10px;">
											<a href="javascript:void(0);" addtabs="legal" url="resource/legal/main" title="法律法规">
												<span class="icon fa fa-book"></span>
												<div class="ca-content">
													<h2 class="ca-main">法律法规</h2>
													<h3 class="ca-sub">法律法规</h3>
												</div>
											</a>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="row-fluid">
										<div class="col-sm-10 col-sm-offset-1 md module1" style="margin-top: 10px;">
											<a href="javascript:void(0);" addtabs="experttype" url="resource/experttype/main"
												title="专家分类"> <span class="icon fa fa-book"></span>
												<div class="ca-content">
													<h2 class="ca-main">专家分类</h2>
													<h3 class="ca-sub">专家分类</h3>
												</div></a>
										</div>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="row-fluid">
										<div class="col-sm-10 col-sm-offset-1 md module4" style="margin-top: 10px;">
											<a href="javascript:void(0);" addtabs="expert" url="resource/expert/main" title="专家信息">
												<span class="icon fa fa-book"></span>
												<div class="ca-content">
													<h2 class="ca-main">专家信息</h2>
													<h3 class="ca-sub">专家信息</h3>
												</div>
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 语音控件 -->
	<div style="display: none">
		<object id="callCenter" classid="CLSID:2FE52D49-D1E2-44C4-AE30-D35BAB691F21" />
		<input type="text" id="cti1IP" value="192.168.1.106">
		<input type="text" id="cti1Pswd" value="">
		<input type="text" id="cti1AgentId" value="8802">
		<input type="text" id="cti2GroupNo" value="1">
		<input type="text" id="cti2OperateLevel" value="0">
		<!-- <input type="text" id="cti1IP" value="192.168.0.160">
        <input type="text" id="cti1Pswd" value="">
        <input type="text" id="cti1AgentId" value="8825">
        <input type="text" id="cti2GroupNo" value="1">
        <input type="text" id="cti2OperateLevel" value="0"> -->
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/bootstrap-tabs.js"></script>
	<script type="text/javascript" src="lauvanUI/dist/js/app.min.js"></script>
	<script type="text/javascript" src="lauvanUI/dist/js/demo.js"></script>
	<script type="text/javascript" src="jsp/voice/js/voice.js"></script>
	<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
	<script type="text/javascript" src="js/messenger/underscore-min.js"></script>
	<script type="text/javascript" src="js/messenger/backbone-min.js"></script>
	<script type="text/javascript" src="js/messenger/messenger.min.js"></script>
	<script type="text/javascript" src="js/messenger/messenger-extends.js"></script>
	<script type="text/javascript">
	function select_second_menu(id,name){
		$("#main_home").html(name);
		$("#main-content").empty();
		$.post('system/moduleinfo/findmenu', {pid:id}, function(j) {
			var str = '';
			str += "<div class='container-fluid' style='margin: 15px;'>";
			str += "<div class='row-fluid'>";
			for(var i=0;i<j.length;i++){
			   str += "<div class='col-sm-4'>";	
			   str += "<div class='row-fluid'>";
			   str += "<div class='col-sm-10 col-sm-offset-1 md "+j[i].mo_Class+"' style='margin-top:10px;'>";
			   str += "<a href='javascript:void(0);'addtabs='"+j[i].mo_Code+"' url='"+j[i].mo_Url+"' title='"+j[i].mo_Name+"'> ";
			   str += " <span class='icon fa "+j[i].mo_Icon+"'></span>";
			   str += "<div class='ca-content'> <h2 class='ca-main'>"+j[i].mo_Name+"</h2>";
			   str += " <h3 class='ca-sub'>"+j[i].mo_Name+"</h3></div></a></div></div></div>";
			}
			str += "</div></div>"; 
			$("#main-content").append(str);
			$("#test_input").val(str);
		    tabs_init();
		}, 'json').complete(function(XMLHttpRequest,textStatus) {
			var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); //通过XMLHttpRequest取得响应头，sessionstatus，  
            if(sessionstatus=="timeout"){
          	  $('#main-msg-show').html('您还没有登录或登录已超时，请重新登录！');
          	  $('#main_msgModal').modal('show');
          	  $('#main_msgModal').on('hide.bs.modal', function () {
          		  window.location.href="login.jsp";
          	  });
            }
         }
		);
		homeActive();  //激活home tab
	}

	//console.info(document.body.clientWidth);
	var heightMain = document.body.clientHeight;
	console.info(heightMain);
	function main_logout(){
		$.post('logout', {}, function(j) {
			window.location.href = '${pageContext.request.contextPath}/login.jsp';
		});
	}
	
	var latestUnreadMsgId = 0;
	function msgLitenser() {
		$.post('dutymanage/smsdisp/latest', {}, function(result) {
            if(result.success) {
            	if(result.obj.rece_id == 0){
           			latestUnreadMsgId = 0;
           			return;
           		}
            	if(result.obj.rece_id > latestUnreadMsgId) {
	           		if($.messenger.msg('message') === null) {
	           			$.messenger.post({
		   	                id: 'message',
		   	             	type: 'message',
		   	             	message: '<br><p>你有新短信消息</p>',
		   	                actions: {
		   	                    cancel: {
		   	                      label: '查看消息',
		   	                      action: function() {
		   	                    	  $.messenger.destroy('message');
		   	                    	  latestUnreadMsgId = result.obj.rece_id;
		   	                    	  parent.tabs_open2("smsdisp","短信调度","dutymanage/smsdisp/main");
		   	                      }
		   	                    }
		   	                  }
		               	});
	           		}
           		}
            }
        });
	}
	
	var timer = null;
	
	$(function() {
		Messenger.options = {
           extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
           id: "Only-one-message",
           theme: 'ice'
        };
		timer = window.setInterval('msgLitenser()', 5000);
	});
   </script>
	<div class="modal fade bs-example-modal-sm" id="main_msgModal" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="mySmallModalLabel">提示</h4>
				</div>
				<div class="modal-body" id="main-msg-show"></div>
			</div>
		</div>
	</div>
</body>
</html>