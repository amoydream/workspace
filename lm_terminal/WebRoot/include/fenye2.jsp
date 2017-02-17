<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav>
	<ul class="pagination">
		<c:choose>
			<c:when test="${pageView.currentpage > 1}">
				<li><a href="javascript:topage(1)">首页</a></li>
				<li><a href="javascript:topage('${pageView.currentpage -1}')">上一页</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:topage(1)">首页</a></li>
			</c:otherwise>
		</c:choose>
		<c:forEach begin="${pageView.pageindex.startindex }" end="${pageView.pageindex.endindex }" var="wp">
			<c:choose>
				<c:when test="${pageView.currentpage == wp}">
					<li class="active"><a href="javascript:topage('${wp }')">${wp }</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="javascript:topage('${wp }')">${wp }</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:choose>
			<c:when test="${pageView.currentpage < pageView.totalpage}">
				<li><a href="javascript:topage('${pageView.currentpage +1}')">下一页</a></li>
				<li><a href="javascript:topage('${pageView.totalpage }')">末页</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:topage('${pageView.totalpage }')">末页</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</nav>