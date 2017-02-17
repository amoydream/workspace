<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lauvanpt" uri="http://java.lauvan.com/lauvan/permission"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>语音管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
	function topage(page) {
	    var form = document.forms[1];
	    form.page.value = page;
	    form.submit();
    }
</script>
</head>
<body>
	<div style="margin-top: 10px; margin-left: 10px; margin-right: 10px;">
		<div style="margin-bottom: 10px;">
			<form class="form-inline" action="dutymanage/vVoiceRecord/list" method="post">
				<input type="hidden" name="query" value="true" />
				<input type="hidden" name="voiceType" value="${voiceType }" />
				<div class="form-group">
					<label for="peName">联系人</label>
					<input type="text" name="peName" class="form-control" id="peName"
						value="${voiceRecord.peName }" placeholder="输入姓名">
				</div>
				<div class="form-group">
					<label for="boNumber">联系电话</label>
					<input type="text" name="boNumber" class="form-control" id="boNumber"
						value="${voiceRecord.boNumber }" placeholder="输入手机号">
				</div>
				<button type="submit" style="margin-left: 5px;" class="btn btn-primary">
					<span class="glyphicon glyphicon-search"></span>
					搜索
				</button>
				<button style="float: right; margin-left: 5px;" type="button"
					class="btn btn-primary" onclick="music();">
					<span class="glyphicon glyphicon-music"></span> 设置铃声
				</button>
			</form>
		</div>
		<form id="voiceRecordForm" action="dutymanage/vVoiceRecord/list" method="post">
			<input type="hidden" name="page" value="${page }" />
			<input type="hidden" name="query" value="${query }" />
			<input type="hidden" name="voiceType" value="${voiceType }" />
			<input type="hidden" name="peName" value="${voiceRecord.peName }" />
			<input type="hidden" name="boNumber" value="${voiceRecord.boNumber }" />
			<table id="playlist-demo" class="table table-bordered table-striped table-hover table-condensed">
				<tr class="info">
					<th width="20%">联系人</th>
					<th width="20%">联系电话</th>
					<th width="20%">联系时间</th>
					<th width="30%">关联事件</th>
					<th width="10%">录音</th>
				</tr>
				<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
					<c:choose>
						<c:when test="${statu.index % 2 ==0}">
							<tr style="background-color: #ebf8ff;">
								<td>${entry.peName}</td>
								<td>
									<c:if test="${voiceType == '1'}">${entry.voCcid}</c:if>
									<c:if test="${voiceType == '2'}">${entry.voCeid}</c:if>
								</td>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${entry.voTime}" />
								</td>
								<td>
									<c:if test="${entry.beName != ''}">${entry.beName}<br>
									</c:if>
									<c:if test="${entry.evName != ''}">${entry.evName}</c:if>
								</td>
								<td style="text-align: center">
									<c:if test="${entry.voState == '0'}">未接听</c:if>
									<c:if test="${entry.voState == '1'}">
										<%-- <audio src="${userVo.voiceip}${entry.voVoicepath}" preload="auto" controls></audio> --%>
										<button class="btn btn-xs btn-primary"
											onclick="readVoicePlay('${userVo.voiceip}${entry.voVoicepath}');">
											<span class="glyphicon glyphicon-headphones"></span>
											播放
										</button>
									</c:if>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td>${entry.peName}</td>
								<td>
									<c:if test="${voiceType == '1'}">${entry.voCcid}</c:if>
									<c:if test="${voiceType == '2'}">${entry.voCeid}</c:if>
								</td>
								<td>
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${entry.voTime}" />
								</td>
								<td>
									<c:if test="${entry.beName != ''}">${entry.beName}</c:if>
									<c:if test="${entry.evName != ''}">${entry.evName}</c:if>
								</td>
								<td style="text-align: center">
									<c:if test="${entry.voState == '0'}">未接听</c:if>
									<c:if test="${entry.voState == '1'}">
										<button class="btn btn-xs btn-primary"
											onclick="readVoicePlay('${userVo.voiceip}${entry.voVoicepath}');">
											<span class="glyphicon glyphicon-headphones"></span>
											播放
										</button>
									</c:if>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<tr>
					<th scope="col" colspan="5"><%@ include file="/include/fenye2.jsp"%>
					</th>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		function readVoicePlay(url) {
	        parent.parent.layer.open({
	            type : 2,
	            title : '播放语音',
	            area : ['500px', '300px'],
	            scrollbar : false,
	            content : ['jsp/dutymanage1/voiceRecord/voiceRecord_play.jsp?url=' + url, 'no'],
	            btn : ['确认', '取消'],
	            yes : function(index, layero) {
		            var iframeWin = layero.find('iframe')[0].contentWindow.userAdd_submitForm(index, window);
	            }
	        });
        }
		
		function music() {
			parent.parent.layer.open({
				type : 2,
				title : '上传mp3文件并设为来电铃声',
				area : [ '500px', '250px' ],
				scrollbar : false,
				content : 'jsp/dutymanage1/voiceRecord/import.jsp',
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.fileUpload(index,
							window);
				}
			});
		}
	</script>
</body>
</html>