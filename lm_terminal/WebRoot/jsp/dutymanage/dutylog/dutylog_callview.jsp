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
<title>通话记录</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
	function topage(page) {
	    var form = document.forms[0];
	    form.page.value = page;
	    form.action = 'dutymanage/dutylog/callview/' + pe_id + '/' + ev_id + '/' + call_date_str + "/" + page;
	    form.submit();
    }
</script>
</head>
<body>
	<div class="row"
		style="padding-left: 10px; padding-right: 15px; padding-top: 5px; margin-left: 0px; margin-right: 10px;">
		<div style="margin-bottom: 15px;">
			<form id="smsTmplForm">
				<input type="hidden" name="pe_id" value="${callHistoryVo.pe_id}">
				<input type="hidden" name="ev_id" value="${callHistoryVo.ev_id}">
				<input type="hidden" name="call_date_str" value="${callHistoryVo.call_date_str}">
				<input type="hidden" name="page" value="${callHistoryVo.page}">
			</form>
			<label>通话日期：</label>${callHistoryVo.call_date_str}
			<p>
			<table class="table table-bordered">
				<tr>
					<th>姓名</th>
					<th>部门</th>
					<th>手机号码</th>
					<th>操作</th>
				</tr>
				<tbody id="sms_data">
					<c:forEach var="vo" items="${pageView.records}">
						<tr>
							<td>${vo.pe_name}</td>
							<td>${vo.or_name}</td>
							<td>${vo.pe_mobilephone}</td>
							<td>
								<button type="button" class="btn btn-primary">拨号</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tr>
					<th scope="col" colspan="4"><jsp:include page="/include/fenye2.jsp" /></th>
				</tr>
			</table>
			</p>
		</div>
	</div>
</body>
</html>