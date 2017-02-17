<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
	function topage(page) {
		var form = document.forms[0];
		form.page.value = page;
		form.submit();
	}
</script>
</head>

<body>

	<div style="margin: 10px;">
		<form class="form-inline" action="resource/team/list" method="post">
			<input type="hidden" name="query" value="true" />
			<div class="form-group">
				<label for="te_Name">名称</label> <input type="text" name="te_Name"
					class="form-control" id="te_Name" placeholder="输入队伍名称">
			</div>
			<button type="submit" class="btn btn-default">搜索</button>
		</form>
	</div>

	<!-- 队伍信息表格 -->
	<form id="teamForm" action="resource/team/list" method="post">
		<input type="hidden" name="page" /> <input type="hidden" name="query" />
		<table class="table table-bordered">
			<tr>
				<th style="text-align:center"></th>
				<th style="text-align:center">队伍名称</th>
				<th style="text-align:center">所属单位</th>
				<th style="text-align:center">队伍分类</th>
			</tr>

			<c:forEach items="${pageView.records}" var="entry">
				<tr>
					<td style="text-align:center"><input type="checkbox" name="selectTeams" value="${entry.te_Id},${entry.te_Name},${entry.te_Remark}"/></td>
					<td style="text-align:center">${entry.te_Name}</td>
					<td style="text-align:center">${entry.te_Deptid.or_name}</td>
					<td style="text-align:center">${entry.te_Type}</td>
				</tr>
			</c:forEach>
			<tr>
				<th scope="col" colspan="9"><%@ include
						file="/include/fenye2.jsp"%></th>
			</tr>
		</table>
	</form>
<script type="text/javascript">
function select_Teams(index, window,pi_id,ids){
	var spps = $("input[name='selectTeams']:checked");
	var str = '',te_Ids=[],flag = false,m=0;
	for(var i=0;i<spps.length;i++){
		var vv = spps[i].value;
		var vs = vv.split(",");
		for(var j=0,h1=ids.length;j<h1;j++){
			if(vs[0] == ids[j].value){
				flag = true;
				break;
			}
		}
		if(flag){
			flag = false;
			continue;
		}
		str += "<tr id='emeTeam"+vs[0]+"'>";
		str += "<td>"+vs[1]+"</td>";
		str += "<td>"+vs[2]+"</td>";
		str += "<td><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='emeTeam_delete("+vs[0]+")'>删除</a></td>";
		
		str += "</tr>";
		te_Ids[m]=vs[0];
		m++;
	}
	if(te_Ids.length>0){
		$.post('emeplan/planTeam/add', {pi_id:pi_id,te_Ids:te_Ids.join(',')}, function(j) {
			if(j.success){
				window.$("#selected_teams").append(str);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.layer.close(index);
		});
	}else{
		parent.layer.close(index);
	}
	
}
</script>
</body>
</html>