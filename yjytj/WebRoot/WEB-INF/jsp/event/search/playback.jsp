<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<link href="<%=basePath%>css/timeline.css" rel="stylesheet" type="text/css" media="screen" />
<script src="<%=basePath %>js/timeline.js"></script>
	<script>
	var basePath = '<%=basePath%>';
	
	</script>
 
<div >
		<div class="head-warp">
			<div class="head">
				<div class="nav-box">
					<ul>
						<li class="cur" style="text-align: center; font-size: 24px;">事件过程回顾</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="main" >
			<div class="history" >
				<div class="history-date">
					<ul>
						<h2 class="first" ><a href="#nogo">${evdate}年</a></h2>
						<li class="green">
							<h3>${evtime}<span>${evday}</span></h3>
							<dl>
								<dt>
									事件名称：<b>${e.ev_name}</b>
								</dt>
								<dt>
									<span>事发地点：${e.ev_address}</span>
								</dt>
								<dt>
									<span>
										接报方式：${reporttype} <b>
										<c:if test="${e.ev_reportmode=='0001'}"><a href="javascript:void(0);"  style="color:red">通话录音</a></c:if>
										<c:if test="${e.ev_reportmode=='0002'}"><a href="javascript:void(0);">传真</a></c:if>
										<c:if test="${e.ev_reportmode=='0005'}"><a href="javascript:void(0);">视频</a></c:if>
									</span>
								</dt>
								<c:if test="${!empty content}">
								<dt>
									<span>
										${content}
									</span>
								</dt>
								</c:if>
							</dl>
						</li>
						<c:forEach var="vo" items="${eventProcessList}">
							<li class="green">
								<h3>${vo.ep_time}<span>${vo.ep_day}</span></h3>
								<dl>
									<dt>
										<span>${vo.eptname}</span>
									</dt>
									<c:if test="${!empty vo.backtype}">
									<dt>
										<span>
											方式：${vo.backtype} <b>
											<c:if test="${vo.backtype==0}"><a href="#">通话录音</a></c:if>
											<c:if test="${vo.backtype==1}"><a href="#" title="发送人：${vo.ep_user}  接收人：${vo.callname}" class="easyui-tooltip">短信</a></c:if>
										</span>
									</dt>
									</c:if>
									<c:if test="${!empty vo.ep_content}">
									<dt>
										<span>内容/反馈：${vo.ep_content}</span>
									</dt>
									</c:if>
								</dl>
							</li>
						</c:forEach>
						<c:choose>
							<c:when test="${e.ev_status!='00D'}">
								<li>
								<h3>
									<span>&nbsp;</span>
								</h3>
								<dl>
									<dt>&nbsp;</dt>
								</dl>
							</li>
							</c:when>
							<c:otherwise>
							<li>
							<h3>${evtime_fin}<span>${evday_fin}</span></h3>
					          <dl>
					            <dt>事件办结
								 <span>
								 ${content_fin}
								 </span>
								</dt>
								<br><br><br><br><br><br>
					          </dl>
					        </li>
							</c:otherwise>
						</c:choose>
						
					</ul>
				</div>
			</div>
		</div>
</div>

