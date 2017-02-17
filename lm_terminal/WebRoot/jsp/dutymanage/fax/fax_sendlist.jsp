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
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css" type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script src="js/bootstrap-tabs.js"></script>
<script type="text/javascript">
	function topage(page) {
		var form = document.forms[1];
		form.page.value = page;
		form.submit();
	}
</script>
</head>
<body>
	<div class="row" style="margin: 25px 10px 0 25px;">
		<div class="row" style="margin-bottom: 10px;">
			<form id="faxSearchForm" class="form-inline" method="post">
				<input type="hidden" name="query" value="true" />
				<div class="form-group">
					<label for="fs_Faxnum">号码</label>
					<input type="text" name="fs_Faxnum" class="form-control" id="fs_Faxnum" placeholder="输入传真号码">
				</div>
				<button type="button" class="btn btn-default" onclick="searchFax()">
					<i class="icon-search"></i>搜索
				</button>
				<lauvanpt:permission privilege="sFaxAdd">
					<button type="button" class="btn btn-primary" onclick="sendAdd();">新建传真</button>
				</lauvanpt:permission>
			</form>
		</div>
		<div class="row">
			<form id="listForm" action="dutymanage/fax/sendlist" method="post">
				<input type="hidden" name="page" />
				<input type="hidden" name="query" />
				<div style="overflow: scroll; height: 600px; OVERFLOW-X: hidden;">
					<table class="table table-bordered table-striped table-hover table-condensed">
						<tr class="info">
							<th style="text-align: center">标题</th>
							<th style="text-align: center">传真号码</th>
							<th style="text-align: center">处理人</th>
							<th style="text-align: center">文件</th>
							<th style="text-align: center">最近操作时间</th>
							<th style="text-align: center">状态</th>
							<th style="text-align: center">操作</th>
						</tr>
						<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
							<c:choose>
								<c:when test="${statu.index % 2 ==0}">
									<tr style="background-color: #ebf8ff;">
										<td style="text-align: center">${entry.fs_Title}</td>
										<td style="text-align: center">${entry.fs_Faxnum}</td>
										<td style="text-align: center">${entry.fs_Dealman}</td>
										<td style="text-align: center">${entry.fs_Filename}</td>
										<td style="text-align: center">
											<fmt:formatDate value="${entry.fs_Time}" pattern="yyyy-MM-dd HH:mm:ss" />
										</td>
										<c:if test="${entry.fs_Status==0}">
											<td style="text-align: center">未发送</td>
										</c:if>
										<c:if test="${entry.fs_Status==1}">
											<td style="text-align: center">已发送</td>
										</c:if>
										<c:if test="${entry.fs_Status==2}">
											<td style="text-align: center">已发送</td>
										</c:if>
										<td style="text-align: center">
											<a href="javascript:void(0);" class="btn btn-primary btn-xs"
												onclick="callSend(${entry.fs_Id},${entry.fs_Faxnum},'${entry.fs_Filename}')">呼叫</a> <a
												href="javascript:void(0);" class="btn btn-warning btn-xs"
												onclick="faxSend(${entry.fs_Id},${entry.fs_Faxnum},'${entry.fs_Filename}')">直发</a>
											<lauvanpt:permission privilege="sFaxEditip">
												<a href="javascript:void(0);" class="btn btn-primary btn-xs" onclick="sEdit(${entry.fs_Id})">编辑</a>
											</lauvanpt:permission>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td style="text-align: center">${entry.fs_Title}</td>
										<td style="text-align: center">${entry.fs_Faxnum}</td>
										<td style="text-align: center">${entry.fs_Dealman}</td>
										<td style="text-align: center">${entry.fs_Filename}</td>
										<td style="text-align: center">
											<fmt:formatDate value="${entry.fs_Time}" pattern="yyyy-MM-dd HH:mm:ss" />
										</td>
										<c:if test="${entry.fs_Status==0}">
											<td style="text-align: center">未发送</td>
										</c:if>
										<c:if test="${entry.fs_Status==1}">
											<td style="text-align: center">已发送</td>
										</c:if>
										<c:if test="${entry.fs_Status==2}">
											<td style="text-align: center">已发送</td>
										</c:if>
										<td style="text-align: center">
											<a href="javascript:void(0);" class="btn btn-primary btn-xs"
												onclick="callSend(${entry.fs_Id},${entry.fs_Faxnum},'${entry.fs_Filename}')">呼叫</a> <a
												href="javascript:void(0);" class="btn btn-warning btn-xs"
												onclick="faxSend(${entry.fs_Id},${entry.fs_Faxnum},'${entry.fs_Filename}')">直发</a>
											<lauvanpt:permission privilege="sFaxEditip">
												<a href="javascript:void(0);" class="btn btn-primary btn-xs" onclick="sEdit(${entry.fs_Id})">编辑</a>
											</lauvanpt:permission>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<tr>
							<th scope="col" colspan="9"><%@ include file="/include/fenye2.jsp"%></th>
						</tr>
					</table>
				</div>
		</div>
	</div>
	<script>

		function sendAdd() {
			parent.parent.layer.open({
				type : 2,
				title : '新建传真',
				area : [ '770px', '300px' ],
				scrollbar : false,
				content : [ 'jsp/dutymanage/fax/fax_sendadd.jsp' ],
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.sAddSubmitForm(
							index, window);
				}
			});
		}

		function faxSend(id, faxNum, fileName) {
					var retVal = parent.parent.CtiCallSendFax("99"+faxNum, fileName);
					if(retVal > 0){
						$.post('dutymanage/fax/sendstatus', {
							fsId : id, channelNo:retVal
						}, function(j) {
							if (j.success) {
								parent.layer.msg("传真发送通道开启成功");
							} else {
								parent.layer.msg("传真发送通道开启失败");
							}
						}, 'json'); 
					}else{
						parent.layer.msg("发送传真操作失败");
					}
		}

		function sEdit(fsId) {
			parent.parent.layer.open({
				type : 2,
				title : '编辑传真',
				area : [ '800px', '500px' ],
				scrollbar : false,
				content : 'dutymanage/fax/seditip?fsId=' + fsId,
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.sEditSubmitForm(
							index, window);
				}
			});
		}
		
		function callSend(id, faxNum, fileName){
			var me = parent.parent.callOutSend("99"+faxNum);
			parent.parent.layer.confirm('请电话里听到传真哔声信号后再点击确认！', function(index) {
				parent.parent.cti.CtiSeatGotoIVR(me,"11",fileName);
				parent.parent.layer.close(index);
				$.post('dutymanage/fax/sendstatus2', {
					fsId : id
				}); 
			});
		}

	</script>
</body>
</html>