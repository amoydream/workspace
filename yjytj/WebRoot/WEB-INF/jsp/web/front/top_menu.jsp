<style type="text/css">

.nav123{width:1048px; height:45px; margin:0 auto; background:url(<%=basePath %>images/web/nav.jpg) no-repeat; }
.nav123 a{ color:#FFFFFF; display:block; font-size:12px; float:left; line-height:40px; margin-left:34px; }

</style>

<div style="width:100%; height:45px; background:url(<%=basePath %>images/web/navbg.jpg) repeat-x;">
<div class="nav123">


<%--<a href="<%=basePath %>index" target="_self">网站首页</a>
<a href="<%=basePath %>VContentA/zhengwuList" target="_self">政务公开</a>
<a href="<%=basePath %>VContentA/viewJigou" target="_self">机构设置</a>
<a href="<%=basePath %>VContentA/viewYingji" target="_self">应急组织</a>
<a href="<%=basePath %>Eventinfo/list" target="_self">&nbsp;安全动态</a>
<a href="<%=basePath %>Chemistryinfo/list" target="_self">危化品信息</a>
<a href="<%=basePath %>Succorlaw/list" target="_self">政策法规</a>
<a href="<%=basePath %>Expert/list" target="_self">安全专家</a>
<a href="<%=basePath %>Emsperson/list">应急人员</a>
<a href="<%=basePath %>VContentA/zhishiList" target="_self">安全知识</a>
<a href="<%=basePath %>VContentA/viewRexian" target="_self">热线电话</a>
<a href="<%=basePath %>VContentA/viewLianxi" target="_self">联系方式</a>
--%>
<a href="<%=basePath%>">网站首页</a>
<c:forEach items="${webFn:channels(0)}" var = "chae" >
	<a href="<%=basePath%>${chae.channelpath}">${chae.channelname}</a>
</c:forEach>

</div>
</div>