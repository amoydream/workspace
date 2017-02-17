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
<title>用户管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
function topage(page){
	var form = document.forms[1];
	form.page.value=page;
	form.submit();
}
function user_addUI(){
	parent.layer.open({
	    type: 2,
	    title:'添加用户',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['system/userinfo/addip','no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 var iframeWin = layero.find('iframe')[0].contentWindow.userAdd_submitForm(index,window);
	    }
	});
}
function user_editUI(id){
	parent.layer.open({
	    type: 2,
	    title:'修改用户',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['system/userinfo/editip?id='+id,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 var iframeWin = layero.find('iframe')[0].contentWindow.userEdit_submitForm(index,window);
	    }
	});
}
function user_roles(id){
	parent.layer.open({
	    type: 2,
	    title:'用户授权',
	    area:['800px','500px'],
	    scrollbar: false,
	    content: ['system/roleinfo/listAll?userid='+id,'yes'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	parent.layer.load(2);
	    	var iframeWin = layero.find('iframe')[0].contentWindow.select_roles(index,window,id);
	    }
	});
}
function user_pwd(id,code){
	parent.layer.open({
	    type: 2,
	    title:'修改密码',
	    area:['500px','300px'],
	    scrollbar: false,
	    content: ['jsp/system/userinfo/userinfo_pwd.jsp?userid='+id+'&userCode='+code,'no'],
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	//parent.layer.load(2);
	    	var iframeWin = layero.find('iframe')[0].contentWindow.userPwd_submitForm(index,window);
	    }
	});
}
function user_delete(id){
	parent.layer.confirm('您确定要删除么？', function(index){
		$.post('system/userinfo/delete',{id:id}, function(j) {
			if(j.success){
				$("#remove_user"+id).remove();
				parent.layer.close(index);
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	});
}
function user_enable(id,f,m){
	parent.layer.confirm('您确定要'+m+'么？', function(index){
		$.post('system/userinfo/enable',{id:id,state:f}, function(j) {
			if(j.success){
				parent.layer.close(index);
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	});
}
</script>
</head>
<body style="background-color: #E0EEE0;">
<div style="margin-top: 15px;">
<div style="margin-bottom: 10px;background-color: #D1EEEE;">
<form class="form-inline" action="system/userinfo/list" method="post">
<input type="hidden" name="query" value="true"/>
  <div class="form-group">
    <label for="us_Name">姓名</label>
    <input type="text" name="us_Name" class="form-control" id="us_Name" value="${userInfoVo.us_Name }" placeholder="输入姓名">
  </div>
  <div class="form-group">
    <label for="us_Mophone">手机</label>
    <input type="email" name="us_Mophone" class="form-control" id="us_Mophone" value="${userInfoVo.us_Mophone }" placeholder="输入手机号">
  </div>
  <button type="submit" class="btn btn-default"><i class="icon-search"></i>搜索</button>
  
  <lauvanpt:permission privilege="userAddip">
  <button type="button" class="btn btn-primary" onclick="user_addUI();">添加</button>
  </lauvanpt:permission>
</form>
</div>
<form id="eventsForm" action="system/userinfo/list" method="post">
<input type="hidden" name="page" value="${page }"/>
<input type="hidden" name="query" value="${query }"/>
<input type="hidden" name="us_Name" value="${userInfoVo.us_Name }"/>
<input type="hidden" name="us_Mophone" value="${userInfoVo.us_Mophone }"/>
		<table class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
				<th style="text-align:center">用户名</th>
				<th style="text-align:center">姓名</th>
				<th style="text-align:center">性别</th>
				<th style="text-align:center">坐席</th>
				<th style="text-align:center">备注</th>
				<th style="text-align:center">状态</th>
				<th style="text-align:center">操作</th>
			</tr>

			<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
			<c:choose>
			<c:when test="${statu.index % 2 ==0}">
			<tr style="background-color: #ebf8ff;"  id="remove_user${entry.us_Id}">
					<td style="text-align:center">${entry.us_Code}</td>
					<td style="text-align:center">${entry.us_Name}</td>
					<td style="text-align:center">
					<c:if test="${entry.us_Sex=='M' }">男</c:if>
					<c:if test="${entry.us_Sex=='F' }">女</c:if>
					</td>
					<td style="text-align:center">${entry.voice}</td>
					<td style="text-align:center">${entry.us_Remark}</td>
					<td style="text-align:center">
					<lauvanpt:permission privilege="userEnable">
					<c:if test="${entry.us_State=='1' }">
					<a href="javascript:void(0);" onclick="user_enable(${entry.us_Id},'0','停用');" title="点击关闭用户">启用</a>
					</c:if>
					<c:if test="${entry.us_State=='0' }"><a href="javascript:void(0);" onclick="user_enable(${entry.us_Id},'1','启用');">停用</a></c:if>
					</lauvanpt:permission>
					</td>
					<td style="text-align:center">
					<lauvanpt:permission privilege="userEditip">
					<button type="button" class="btn btn-primary btn-sm" onclick="user_editUI(${entry.us_Id});">编辑</button>
					</lauvanpt:permission><lauvanpt:permission privilege="userRoleip">
					<button type="button" class="btn btn-warning btn-sm" onclick="user_roles(${entry.us_Id});">授权</button>
					</lauvanpt:permission><lauvanpt:permission privilege="userEditpwd">
					<button type="button" class="btn btn-warning btn-sm" onclick="user_pwd(${entry.us_Id},'${entry.us_Code}');">密码</button>
					</lauvanpt:permission></td>
				</tr>
			</c:when>
			<c:otherwise>
			<tr id="remove_user${entry.us_Id}">
					<td style="text-align:center">${entry.us_Code}</td>
					<td style="text-align:center">${entry.us_Name}</td>
					<td style="text-align:center">
					<c:if test="${entry.us_Sex=='M' }">男</c:if>
					<c:if test="${entry.us_Sex=='F' }">女</c:if>
					</td>
					<td style="text-align:center">${entry.voice}</td>
					<td style="text-align:center">${entry.us_Remark}</td>
					<td style="text-align:center"><lauvanpt:permission privilege="userEnable">
					<c:if test="${entry.us_State=='1' }">
					<a href="javascript:void(0);" onclick="user_enable(${entry.us_Id},'0','停用');">启用</a>
					</c:if>
					<c:if test="${entry.us_State=='0' }"><a href="javascript:void(0);" onclick="user_enable(${entry.us_Id},'1','启用');">停用</a></c:if>
					</lauvanpt:permission></td>
					<td style="text-align:center">
					<lauvanpt:permission privilege="userEditip">
					<button type="button" class="btn btn-primary btn-sm" onclick="user_editUI(${entry.us_Id});">编辑</button>
					</lauvanpt:permission><lauvanpt:permission privilege="userRoleip">
					<button type="button" class="btn btn-warning btn-sm" onclick="user_roles(${entry.us_Id});">授权</button>
					</lauvanpt:permission><lauvanpt:permission privilege="userEditpwd">
					<button type="button" class="btn btn-warning btn-sm" onclick="user_pwd(${entry.us_Id},'${entry.us_Code}');">密码</button>
					</lauvanpt:permission></td></td>
				</tr>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			<tr><th scope="col" colspan="7">
    	<%@ include file="/include/fenye2.jsp" %>
   </th></tr>
		</table>
	</form>
</div>
</body>
</html>