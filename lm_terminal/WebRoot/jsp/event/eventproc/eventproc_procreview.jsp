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
<title>过程回顾</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/plugins/jQueryUI/timeline/css/timeline.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/plugins/jQueryUI/timeline/js/timeline.js"></script>
<script type="text/javascript">
	function promptViewForm(pr_id) {
	    parent.layer.open({
	        type : 2,
	        title : '查看短信',
	        area : ['600px', '480px'],
	        scrollbar : false,
	        content : ['event/eventproc/viewsms/' + pr_id, 'no'],
	        btn : ['关闭'],
	        yes : function(index, layero) {
		        parent.layer.close(index);
	        }
	    });
    }
</script>
</head>
<body>
	<div style="padding-left: 10px; padding-top: 10px;">
		<div class="head-warp">
			<div class="head">
				<div class="nav-box">
					<ul>
						<li class="cur" style="text-align: center; font-size: 24px;">事件过程回顾</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="main">
			<div class="history">
				<div class="history-date">
					<ul>
						<h2 class="first">${eventInfoVo.ev_date_str}</h2>
						<li class="green">
							<h3>${eventInfoVo.ev_date_str}</h3>
							<dl>
								<dt>
									事件名称：<b>${eventInfoVo.ev_name}</b>
								</dt>
								<dt>
									<span>事件地点：${eventInfoVo.ev_address}</span>
								</dt>
							</dl>
						</li>
						<c:forEach var="vo" items="${eventProcessList}">
							<li class="green">
								<h3>${vo.pr_date_str}</h3>
								<dl>
									<dt>
										<span>处置人：${vo.us_Name}</span>
									</dt>
									<dt>
										<span>
											联系电话：${vo.us_Mophone} <b><a href="#">通话录音</a><a href="#"
												onclick="promptViewForm('${vo.pr_id}');">短信</a>
										</span>
									</dt>
									<dt>
										<span>处置内容：${vo.pr_content}</span>
									</dt>
								</dl>
							</li>
						</c:forEach>
						<li>
							<h3>
								<span>&nbsp;</span>
							</h3>
							<dl>
								<dt>&nbsp;</dt>
							</dl>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>