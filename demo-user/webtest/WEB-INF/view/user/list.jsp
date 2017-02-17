<%@ include file="/include/include.jsp"%>
<ul>
	<c:forEach items="${userList}" var="u">
		<li>${u.name},${u.gender},${u.birthday},${u.address}, ${u.phone},
			${u.email} <a href="${ctx}/user/${u.id}/update"><spring:message
					code="message.common.update" /></a> <a
			href="${ctx}/user/${u.id}/delete"><spring:message
					code="message.common.delete" /></a>
		</li>
	</c:forEach>
</ul>