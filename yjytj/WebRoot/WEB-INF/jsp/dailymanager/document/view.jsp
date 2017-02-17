<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">

</script>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		<tr>
		    <td class="sp-td1">公文编号：</td>
		    <td>
		    ${rdc.code }</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">公文标题：</td>
		    <td>
		    ${rdc.name}</td>
		    </tr>
		    <tr>
		    <td class="sp-td1">发送人：</td>
		    <td>
		    ${rdc.user_name}
		    </td>
		    </tr>
		    <tr>
		    <td class="sp-td1">接收人：</td>
		    <td>
		    ${rdc.receivename}
		    </td>
		    </tr>
		    <tr>
			<td class="sp-td1">公文内容：</td>
			<td>${rdc.content}</td>
		    </tr>
		    <tr>
			<td class="sp-td1">备注：</td>
			<td>${rdc.note}</td>
		    </tr>
		<tr>
		    	<td class="sp-td1">附件：</td>
		    	<td>
		    	<div style="clear: both;"></div>
		    	<c:set var="fileList" value="${fileList}"/>
		    	<div id="fileQueue"> 
					
	                <c:if test="${!empty fileList}">	           
			    <c:forEach items="${fileList}" var="list">
				<div id="file_${list.id}" style="height:25px;font-size:12px;line-height:25px;">
					<span style="display:none"><input type="checkbox" name="fjid" value="${list.id}" checked/></span>
					<c:choose> 
					<c:when test="${list.m_type=='xls'||list.m_type=='xlsx'||list.m_type=='doc'||list.m_type=='docx'||list.m_type=='ppt'||list.m_type=='pptx'}">
					<a class="btnAttach" title="请点击打开"></a><a title="请点击打开" target="_blank" href="<%=basePath%>Main/document/getfileview/${list.id}-${list.m_type}">${list.name}<a/> （${list.m_size}）
					</c:when>
					<c:when test="${list.m_type=='pdf'}">
					<a class="btnAttach" title="请点击打开"></a><a title="请点击打开" target="_blank" href="<%=basePath%>Main/document/getpdfview?id=${list.id}&title=${list.name}">${list.name}<a/> （${list.m_size}）
					</c:when>
					<c:when test="${list.m_type=='jpg'||list.m_type=='gif'||list.m_type=='png' }">
					<a class="btnAttach" title="请点击打开"></a><a title="请点击打开" target="_blank" href="<%=basePath%>Main/document/getjpgview?id=${list.id}">${list.name}<a/> （${list.m_size}）
					</c:when>
					<c:otherwise>
					<a class="btnAttach" title="请点击另存为"></a><a title="请点击另存为" target="_blank" href="<%=basePath%>Main/attachment/downloadFJ/${list.id}">${list.name}<a/> （${list.m_size}）
					</c:otherwise>
					</c:choose>					
				</div>
			    </c:forEach>
           
	            </c:if>
                 <div id="fileList" style="width: 450px;"></div>
					</div>
		    	</td>
		    	</tr>
		</table>    	
