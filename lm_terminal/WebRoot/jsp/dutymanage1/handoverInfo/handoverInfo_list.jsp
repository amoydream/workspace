<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="lauvanpt" uri="http://java.lauvan.com/lauvan/permission"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>交接班管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>

<body>
<div style="margin-top: 15px;">
<div style="margin-bottom: 10px; margin-left: 15px;">
<form class="form-inline" action="dutymanage/handoverInfo/list" method="post">
<input type="hidden" name="query" value="true"/>
<input type="hidden" name="hoType" value="${handoverInfoVo.hoType }"/>
  <div class="form-group">
    <label for="us_name">姓名</label>
    <input type="text" name="us_name" class="form-control" value="${handoverInfoVo.us_name }" placeholder="输入姓名">
  </div>
  <button type="submit" class="btn btn-default"><i class="icon-search"></i>搜索</button>
  <lauvanpt:permission privilege="handoverAdd">
  <button type="button" class="btn btn-primary" onclick="handover_addUI();">添加</button>
  </lauvanpt:permission>
  <button type="button" class="btn btn-info" onclick="handoverinfo_report();">日常报表</button>
</form>
</div>
<form id="eventsForm" action="dutymanage/handoverInfo/list" method="post">
<input type="hidden" name="page" value="${page }"/>
<input type="hidden" name="query" value="${query }"/>
<input type="hidden" name="hoType" value="${handoverInfoVo.hoType }"/>
<input type="hidden" name="us_name" value="${handoverInfoVo.us_name }"/>
<table class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
			<c:if test="${handoverInfoVo.hoType == '1'}"><th style="text-align:center">接班人</th></c:if>
			<c:if test="${handoverInfoVo.hoType == '2'}"><th style="text-align:center">交班人</th></c:if>
				<th style="text-align:center">交班时间</th>
				<th style="text-align:center">内容</th>
				<th style="text-align:center">状态</th>
				<th style="text-align:center">操作</th>
			</tr>

			<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
			<c:choose>
			<c:when test="${statu.index % 2 ==0}">
			<tr id="remove_handover${entry.ha_Id}" style="background-color: #ebf8ff;">
					
					<td style="text-align:center">
					<c:if test="${handoverInfoVo.hoType == '1'}">${entry.us_Overer.us_Name}</c:if>
					<c:if test="${handoverInfoVo.hoType == '2'}">${entry.us_Hander.us_Name}</c:if>
					</td>
					<td style="text-align:center"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${entry.ha_Date}" /></td>
					<td style="text-align:center">${entry.ha_Content}</td>
					<td style="text-align:center" id="remove_handover_finish${entry.ha_Id}">
					<c:if test="${entry.ha_state == '0'}">未完成</c:if>
					<c:if test="${entry.ha_state == '1'}">已完成</c:if>
					</td>
					<td style="text-align:center">
					<lauvanpt:permission privilege="handoverEditip">
					<button type="button" class="btn btn-primary btn-sm" onclick="handover_editUI(${entry.ha_Id});">编辑</button>
					</lauvanpt:permission>
					
					<c:if test="${entry.ha_state == '0'}">
					<lauvanpt:permission privilege="handoverFinish">
					<button id="remove_handover_finishbtn${entry.ha_Id}" type="button" class="btn btn-warning btn-sm" onclick="handover_finish(${entry.ha_Id},'1','完成');">未完成</button>
					</lauvanpt:permission>
					</c:if>
					<c:if test="${entry.ha_state == '1'}">
					<lauvanpt:permission privilege="handoverFinish">
					<button id="remove_handover_finishbtn${entry.ha_Id}" type="button" class="btn btn-warning btn-sm" onclick="handover_finish(${entry.ha_Id},'0','未完成');">已完成</button>
					</lauvanpt:permission>
					</c:if>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
			<tr id="remove_handover${entry.ha_Id}">
					<td style="text-align:center"><c:if test="${handoverInfoVo.hoType == '1'}">${entry.us_Overer.us_Name}</c:if>
					<c:if test="${handoverInfoVo.hoType == '2'}">${entry.us_Hander.us_Name}</c:if></td>
					<td style="text-align:center"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${entry.ha_Date}" /></td>
					<td style="text-align:center">${entry.ha_Content}</td>
					<td style="text-align:center" id="remove_handover_finish${entry.ha_Id}">
					<c:if test="${entry.ha_state == '0'}">未完成</c:if>
					<c:if test="${entry.ha_state == '1'}">已完成</c:if>
					</td>
					<td style="text-align:center">
					<lauvanpt:permission privilege="handoverEditip">
					<button type="button" class="btn btn-primary btn-sm" onclick="handover_editUI(${entry.ha_Id});">编辑</button>
					</lauvanpt:permission><lauvanpt:permission privilege="handoverDelete">
					<button type="button" class="btn btn-danger btn-sm" onclick="handover_delete(${entry.ha_Id});">删除</button></lauvanpt:permission>
					
					<c:if test="${entry.ha_state == '0'}">
					<lauvanpt:permission privilege="handoverFinish">
					<button id="remove_handover_finishbtn${entry.ha_Id}" type="button" class="btn btn-warning btn-sm" onclick="handover_finish(${entry.ha_Id},'1','完成');">未完成</button>
					</lauvanpt:permission>
					</c:if>
					<c:if test="${entry.ha_state == '1'}">
					<lauvanpt:permission privilege="handoverFinish">
					<button id="remove_handover_finishbtn${entry.ha_Id}" type="button" class="btn btn-warning btn-sm" onclick="handover_finish(${entry.ha_Id},'0','未完成');">已完成</button>
					</lauvanpt:permission>
					</c:if>
					</td>
				</tr>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			<tbody id="addHandOverInfo"></tbody>
			<tr>
			<th scope="col" colspan="5">
    	<%@ include file="/include/fenye2.jsp" %>
   </th></tr>
		</table>
</form>
</div>
<script type="text/javascript">
function handover_addUI(){
	parent.parent.layer.open({
	    type: 2,
	    title:'添加交接班',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['jsp/dutymanage1/handoverInfo/handoverInfo_add.jsp','no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 var iframeWin = layero.find('iframe')[0].contentWindow.handoverAdd_submitForm(index,window);
	    }
	});
}
function handover_editUI(id){
	parent.parent.layer.open({
	    type: 2,
	    title:'修改交接班',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['dutymanage/handoverInfo/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 var iframeWin = layero.find('iframe')[0].contentWindow.handoverEdit_submitForm(index,window,id);
	    }
	});
}
function handover_finish(id,f,m){
	parent.parent.layer.confirm('您确定要设置为'+m+'么？', function(index){
		parent.parent.layer.close(index);
		$.post('dutymanage/handoverInfo/finish',{id:id,ha_state:f}, function(j) {
			if(j.success){
				$("#remove_handover_finish"+id).empty("");
				var str = "";
				if(f=='0'){
					str += '未完成';
					$("#remove_handover_finishbtn"+id).attr("onclick","handover_finish("+id+",'1','已完成');");
					$("#remove_handover_finish"+id).html("未完成");
				}else{
					str += '已完成';
					$("#remove_handover_finishbtn"+id).attr("onclick","handover_finish("+id+",'0','未完成');");
					$("#remove_handover_finish"+id).html("已完成");
				}
				$("#remove_handover_finish"+id).append(str);
			}else{
				parent.parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.parent.layer.close(index);
		}, 'json');
	});
}
function handover_delete(id){
	parent.parent.layer.confirm('您确定要删除么？', function(index){
		$.post('system/userinfo/delete',{id:id}, function(j) {
			if(j.success){
				$("#remove_handover"+id).remove();
			}else{
				parent.parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
			parent.parent.layer.close(index);
		}, 'json');
	});
}
function handoverinfo_report(docName){
	window.open("<%=basePath%>jsp/poffice/report.jsp");
}
</script>
</body>
</html>