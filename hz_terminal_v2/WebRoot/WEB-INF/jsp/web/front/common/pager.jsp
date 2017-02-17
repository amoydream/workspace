<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

共${page.totalRow}条&nbsp;
每页<font style="color: red; font-weight: bold;">${page.pageSize}</font>条
<input type="button" value=" 首 页" style="border:0px; height: 20px; width: 60px; font-size:12px;padding-top: 2px; background: url('${ctx}/images/web/first.gif'); color:white;" onclick="_gotoPage('1');"<c:if test="${page.pageNumber == 1}"> disabled="disabled"</c:if>/>&nbsp;
<input type="button" value=" 上一页" style="border:0px; height: 20px; width: 60px; font-size:12px;padding-top: 2px; background: url('${ctx}/images/web/pre.gif'); color:white;" onclick="_gotoPage('${page.pageNumber - 1}');"<c:if test="${page.pageNumber == 1}"> disabled="disabled"</c:if>/>&nbsp;
<input type="button" value="下一页 " style="border:0px; height: 20px; width: 60px; font-size:12px;padding-top: 2px; background: url('${ctx}/images/web/next.gif'); color:white;" onclick="_gotoPage('${page.pageNumber + 1}');"<c:if test="${page.pageNumber == page.totalPage}"> disabled="disabled"</c:if><c:if test="${page.totalPage == 0}"> disabled="disabled"</c:if>/>&nbsp;
<input type="button" value="尾 页 " style="border:0px; height: 20px; width: 60px; font-size:12px;padding-top: 2px; background: url('${ctx}/images/web/last.gif'); color:white;" onclick="_gotoPage('${page.totalPage}');"<c:if test="${ page.pageNumber == page.totalPage}"> disabled="disabled"</c:if><c:if test="${page.totalPage == 0}"> disabled="disabled"</c:if>/> &nbsp;
当前 ${page.pageNumber}/${page.totalPage} 页 


<%--<div class="pagesite">
<div>
	共${page.totalRow}条记录 ${page.pageNumber}/${page.totalPage}页
	<c:choose>
		<c:when test="${page.pageNumber==1}">
			<a disabled="disabled">首页</a>&nbsp;
			<a disabled="disabled">上一页</a>&nbsp;
		</c:when>
		<c:otherwise>
			<a href="${href}?pageNo=1">首页</a>&nbsp;
			<a href="${href}?pageNo=${page.pageNumber-1}">上一页</a>&nbsp;
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${page.pageNumber==page.totalPage}">
			<a disabled="disabled">下一页</a>&nbsp;
			<a disabled="disabled">尾页</a>&nbsp;
		</c:when>
		<c:otherwise>
			<a href="${href}?pageNo=${page.pageNumber+1}">下一页</a>&nbsp;
			<a href="${href}?pageNo=${page.totalPage}">尾页</a>&nbsp;
		</c:otherwise>
	</c:choose>
	第<select onchange="if(this.value==1){location.href='${href}'}else{location='${href}?pageNo=this.value'}">
		<c:forEach var="num" begin="1" end="${page.totalPage}" step="1">
			<option value="${num}">${num}</option>
		</c:forEach>
	</select>页
</div>
</div>--%>