<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>预案基本信息管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>

<body>
<div class="container-fluid" style="margin-top:15px;padding-left: 0px;">
<div class="row-fluid">
		<table class="table table-bordered">
			<tbody>
			<tr>
						<th>预案名称</th>
						<td>${planInfo.pi_name }</td>
						<th>发布日期</th>
						<td colspan="3">${planInfo.pi_createDate }</td>
					</tr>
			<tr>
						<th>所属机构</th>
						<td>${planInfo.pi_subOrgan }</td>
						<th>发布机构</th>
						<td>${planInfo.pi_issOrgan }</td>
						<th>编制机构</th>
						<td>${planInfo.pi_estOrgan }</td>
					</tr>
			<tr>
						<th>审批机构</th>
						<td>${planInfo.pi_appOrgan }</td>
						<th>版本号</th>
						<td>${planInfo.pi_no }</td>
						<th>层级</th>
						<td>
						<c:if test="${planInfo.pi_level=='1' }">省</c:if>
						<c:if test="${planInfo.pi_level=='2' }">地市</c:if>
						<c:if test="${planInfo.pi_level=='3' }">区县</c:if>
						<c:if test="${planInfo.pi_level=='4' }">部门</c:if>
						<c:if test="${planInfo.pi_level=='5' }">企业</c:if>
						</td>
					</tr>
					<tr>
						<th>说明</th>
						<td colspan="5">${planInfo.pi_note }</td>
					</tr>
					<tr>
						<th>描述</th>
						<td colspan="5">${planInfo.pi_desc }</td>
					</tr>
					<tr>
						<th>适用范围</th>
						<td colspan="5">${planInfo.pi_scope }</td>
					</tr>
					<tr>
						<th>备注</th>
						<td colspan="5">${planInfo.pi_remark }</td>
					</tr>
			</tbody>
		</table>
		<table class="table table-bordered">
			<tr>
				<th>法律法规</th>
				<th>操作</th>
			</tr>
			<tbody id="planinfo_legals">
			<c:forEach items="${planLegalVos }" var="entry">
			<input type="hidden" name="le_ids" value="${entry.le_id}"/>
              <tr>
               <td>${entry.le_Name}</td>
               <td><a href='javascript:void(0);' class='btn btn-warning btn-xs' onclick="planLagal_viewdoc(${entry.le_id})">查看</a></td>
              </tr>
            </c:forEach>
			</tbody>
		</table>
		<table class="table table-bordered">
			<tr>
				<th>预案原文</th>
				<th>操作</th>
			</tr>
			<tbody id="planinfo_docs">
			<c:forEach items="${plandocs }" var="entry">
			<input type="hidden" name="pdoc_ids" value="${entry.pdoc_id}"/>
              <tr>
               <td>${entry.pdoc_name}</td>
               <td><a href='javascript:void(0);' class='btn btn-warning btn-xs' onclick="plandoc_report('${entry.pdoc_name}')">查看</a></td>
              </tr>
            </c:forEach>
			</tbody>
		</table>
</div>
</div>
<script type="text/javascript">
function plandoc_report(docName){
	window.open("emeplan/plandoc/view?docName="+docName);
}
function planLagal_viewdoc(le_Id){
	window.open("<%=basePath%>resource/legal/viewdoc?leId="+le_Id);			
}
</script>
</body>
</html>