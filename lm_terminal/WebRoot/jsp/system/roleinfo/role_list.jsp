<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>用户授权</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>

<body>

	<table
		class="table table-bordered table-striped table-hover table-condensed">
		<tr class="info">
			<th style="text-align:center">角色编码</th>
			<th style="text-align:center">名称</th>
			<th style="text-align:center">备注</th>
			<th style="text-align:center">操作</th>
		</tr>

		<c:forEach items="${roles}" var="entry" varStatus="statu">
			<c:choose>
				<c:when test="${statu.index % 2 ==0}">
					<tr id="remove_role${entry.ro_Id}"
						style="background-color: #ebf8ff;">
						<td style="text-align:center">${entry.ro_Code}</td>
						<td style="text-align:center">${entry.ro_Name}</td>
						<td style="text-align:center">${entry.ro_Remark }</td>
						<td style="text-align:center"><input type="checkbox"
							name="select_roles" value="${entry.ro_Id}" /></td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr id="remove_role${entry.ro_Id}">
						<td style="text-align:center">${entry.ro_Code}</td>
						<td style="text-align:center">${entry.ro_Name}</td>
						<td style="text-align:center">${entry.ro_Remark }</td>
						<td style="text-align:center"><input type="checkbox"
							name="select_roles" value="${entry.ro_Id}" /></td>
					</tr>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</table>
	<script type="text/javascript">

$(function(){
	$.post('system/userinfo/roleip', {id:${userid}}, function(j) {
		
		if(j!=''){
			var spps = $("input[name='select_roles']");
			for(var i=0;i<spps.length;i++){
				for(m=0;m<j.length;m++){
					if(spps[i].value==j[m].id.roId){
						spps[i].checked=true;
					}
				}
			}
			
		}
	});
});

function select_roles(index, window,id){
	var spps = $("input[name='select_roles']:checked");
	var ro_Ids=[];
	for(var i=0;i<spps.length;i++){
		ro_Ids[i]=spps[i].value;
	}
	$.post('system/userinfo/role', {id:id,roleids:ro_Ids.join(',')}, function(j) {
		if(j.success){
			parent.layer.closeAll();
		}
		parent.layer.msg(j.msg, {
		    offset: 0,
		    shift: 6
		});
	});
}
</script>
</body>
</html>