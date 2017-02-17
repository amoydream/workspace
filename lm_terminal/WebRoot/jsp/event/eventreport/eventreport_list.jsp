<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="lauvanpt" uri="http://java.lauvan.com/lauvan/permission"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>专报管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
function eventReport_addUI(id){
	parent.layer.open({
	    type: 2,
	    title:'添加专报',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/event/eventreport/eventreport_add.jsp?evId='+id,'no'],
	    //content: ['event/eventReport/addip?evId='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 var iframeWin = layero.find('iframe')[0].contentWindow.eventReportAdd_submitForm(index,window);
	    }
	});
}
function eventReport_editUI(id){
	parent.layer.open({
	    type: 2,
	    title:'修改专报',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['event/eventReport/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 var iframeWin = layero.find('iframe')[0].contentWindow.eventReportEdit_submitForm(index,window);
	    }
	});
}
function eventReport_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('event/eventReport/delete',{id:id}, function(j) {
			if(j.success){
				$("#remove_eventReport"+id).remove();
				parent.layer.close(index);
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	});
}
function eventReport_report(id){
	window.open('<%=basePath%>'+"event/eventReport/report?id="+id);
}
</script>
</head>
<body style="background-color: #E0EEE0;">
<div style="margin-top: 15px;">
<button type="button" class="btn btn-primary" onclick="eventReport_addUI(${evId});">添加</button>
<table class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
				<th style="text-align:center">编号</th>
				<th style="text-align:center">上报单位</th>
				<th style="text-align:center">报告时间</th>
				<th style="text-align:center">签发人</th>
				<th style="text-align:center">操作</th>
			</tr>

			<c:forEach items="${eventReports}" var="entry" varStatus="statu">
			<c:choose>
			<c:when test="${statu.index % 2 ==0}">
			<tr style="background-color: #ebf8ff;" id="remove_eventReport${entry.er_id}">
					<td style="text-align:center">[${entry.er_noyear}]${entry.er_no}号</td>
					<td style="text-align:center">${entry.er_reportUnit}</td>
					<td style="text-align:center">${entry.er_date}</td>
					<td style="text-align:center">${entry.er_issuer}</td>
					<td style="text-align:center">
					<button type="button" class="btn btn-primary btn-xs" onclick="eventReport_editUI(${entry.er_id});">编辑</button>
					<button type="button" class="btn btn-danger btn-xs" onclick="eventReport_delete(${entry.er_id});">删除</button>
					<button type="button" class="btn btn-warning btn-xs" onclick="eventReport_report(${entry.er_id});">专报</button>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
			<tr id="remove_eventReport${entry.er_id}">
					<td style="text-align:center">[${entry.er_noyear}]${entry.er_no}号</td>
					<td style="text-align:center">${entry.er_reportUnit}</td>
					<td style="text-align:center">${entry.er_date}</td>
					<td style="text-align:center">${entry.er_issuer}</td>
					<td style="text-align:center">
					<button type="button" class="btn btn-primary btn-xs" onclick="eventReport_editUI(${entry.er_id});">编辑</button>
					<button type="button" class="btn btn-danger btn-xs" onclick="eventReport_delete(${entry.er_id});">删除</button>
					<button type="button" class="btn btn-warning btn-xs" onclick="eventReport_report(${entry.er_id});">专报</button>
					</td>
				</tr>
			</c:otherwise>
			</c:choose>
			</c:forEach>
		</table>
</div>
</body>
</html>