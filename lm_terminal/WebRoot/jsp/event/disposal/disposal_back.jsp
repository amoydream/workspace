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
<title>备忘录</title>
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
						<h2 class="first">${eventInfo.ev_reportDate}</h2>
						<li class="green">
							<h3>${eventInfo.ev_reportDate}</h3>
							<dl>
								<dt>
									事件名称：<b>${eventInfo.ev_name}</b>
								</dt>
								<dt>
									<span>事件地点：${eventInfo.ev_address}</span>
								</dt>
							</dl>
						</li>
						<c:forEach var="entity" items="${eventNoteVos}">
							<li class="green">
								<h3>${entity.en_date}</h3>
								<dl>
									<%-- <dt>
										<span>处置人：${vo.us_Name}</span>
									</dt> --%>
									<c:if test="${entity.en_type == '1' }">
									<dt>
										<span>
										<c:if test="${entity.wo.vo_actAs == 'W'}">
										联系电话：${entity.wo.vo_ceid}
										</c:if>
										<c:if test="${entity.wo.vo_actAs == 'C'}">
										联系电话：${entity.wo.vo_ccid}
										</c:if>
										<c:if test="${entity.wo.vo_state == '0'}">
										未接听
										</c:if>
										<c:if test="${entity.wo.vo_state == '1'}">
										<button class="icon-play" onclick="readVoicePlay('${userVo.voiceip}${entity.wo.vo_voicepath}');"></button>
										</c:if>
										
										</span>
									</dt>
									<%-- <dt>
										<span>处置内容：${entity.en_content}</span>
									</dt> --%>
									
									</c:if>
									
									<c:if test="${entity.en_type == '5' }">
									<dt>
										<span>反馈内容：${entity.en_content}</span>
									</dt>
									</c:if>
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
<script type="text/javascript">
function readVoicePlay(url){
	parent.parent.layer.open({
	    type: 2,
	    title:'播放语音',
	    area:['500px','300px'],
	    scrollbar: false,
	    content: ['jsp/dutymanage1/voiceRecord/voiceRecord_play.jsp?url='+url,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 var iframeWin = layero.find('iframe')[0].contentWindow.userAdd_submitForm(index,window);
	    }
	});
}
</script>
</body>
</html>