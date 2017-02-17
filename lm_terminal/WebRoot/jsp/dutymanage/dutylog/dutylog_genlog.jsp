<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="margin-bottom: 15px;">
	<h2>值班日志记录</h2>
	<div style="text-align: right;">
		<button id="btn-print" class="btn btn-success" onclick="">打印</button>
		&nbsp;&nbsp;
		<button id="btn-export" class="btn btn-primary" onclick="">导出</button>
	</div>
</div>
<p>
<table class="table table-bordered">
	<tr>
		<th>姓名</th>
		<th>部门</th>
		<th>电话号码</th>
		<th>值班日期</th>
		<th>事件</th>
	</tr>
	<tbody id="sms_data">
		<c:forEach var="vo" items="${pageView.records}">
			<tr>
				<td>${vo.pe_name}</td>
				<td>${vo.or_name}</td>
				<td>${vo.pe_mobilephone}</td>
				<td>${vo.duty_date_str}</td>
				<td>${vo.ev_name}</td>
			</tr>
		</c:forEach>
	</tbody>
	<tr>
		<th scope="col" colspan="6"><jsp:include page="/include/fenye2.jsp" /></th>
	</tr>
</table>
</p>
<form class="form-inline" action="dutymanage/dutylog/genlog" method="post">
	<input type="hidden" name="page" value="${dutyLogVo.page}" />
</form>