<style type="text/css">
ul,li {
	border: 0PX;
	margin: 0px;
	padding: 0px;
	list-style-type: none;
}

* {
	padding: 0;
	margin: 0
}

img {
	border: 0
}

.login123denglu ul {
	margin-top: 16px;
	margin-left: 75px;
}

.login123denglu ul li {
	margin-top: 10px;
}

.zhengce {
	margin-top: 5px
}

.zhengcebt {
	width: 194px;
	height: 33px;
	background: url(<%=basePath %>images/web/shortbt.jpg) bottom no-repeat;
}

.zhengcebt li {
	color: #FFFFFF;
	line-height: 30px;
	height: 30px;
	text-indent: 15px;
	text-align: left;
	font-size: 12px;
}

.zhengcebox {
	width: 192px;
	height: 141px;
	border-bottom: 1px solid #0063be;
	border-right: 1px solid #0063be;
	border-left: 1px solid #0063be;
	margin-top: -1px;
}

.zhengcebox ul li {
	text-align: left;
	line-height: 22px;
	text-indent: 5px;
}
</style>
<!---check mail begin-->
<SCRIPT language=JavaScript>
function checkuser(form){
  var username,password;
  username=form.userID.value;
  password=form.pwd.value;
  if(!form.userID.value){
    form.userID.focus();
	alert("用户名不能为空！");
    return false;
  }
  if(!form.pwd.value){
    form.pwd.focus();
	alert("登陆密码不能为空！");
	return false;
  }

}
</SCRIPT>
<%--<div class="chanelbox">
	<div><li>${c.channelname}</li></div>
	<div >
		<ul>
			<c:forEach items="${webFn:channels(chaNodeList[0].channelid)}" var="node">
				<li><a href="./${node.channelpath}">${node.channelname}</a></li>
			</c:forEach>
		</ul>
	</div>
</div>


--%>
<div class="login123">
	<div class="login123head"
		style="width:194px; height:30px; background:url(<%=basePath %>images/logintop.jpg) no-repeat;">
	</div>
	<div class="login123center"
		style="width:194px; height:117px; background:url(<%=basePath %>images/loginbg.jpg) repeat-y;">

		<form name="myform" onsubmit="return checkuser(this);"
			action="<%=ip %>/hzyj/sysindex.jsp" method="post" target="_self">
			<input type="hidden" name="login" value="y">
			<div class="login123denglu"
				style="width:194px; height:67px; background:url(<%=basePath %>images/logincenter.jpg) no-repeat bottom; padding-top:10px;">
				<ul>
					<li><input name="userID" type="text" class="small" id="userID"
						size="12" maxlength="12" value="" />
					</li>
					<li><input name="pwd" type="password" class="small" id="pwd"
						size="14" maxlength="14" value="" />
					</li>
				</ul>
			</div>
			<!--login123denglu-->

			<div class="login123denglu2"
				style="height:31px;width:180px; margin:5px auto;">
				<ul>
					<li
						style="float:left;width:80px; height:31px; text-align:center;line-height:31px;"><a
						href="#" target="_self" class="hei">忘了密码？</a>
					</li>
					<li><INPUT id=btnLogin
						style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; WIDTH: 82px; HEIGHT: 31px; BORDER-RIGHT-WIDTH: 0px"
						type=image alt=登陆 src="<%=basePath %>images/input.jpg" border=0
						name=btnLogin>
					</li>
				</ul>
			</div>
		</FORM>
	</div>
	<!--login123center-->
	<div class="login123bottom"
		style="width:194px; height:13px; background:url(<%=basePath %>images/loginbottom.jpg) no-repeat;">
	</div>
	<!--login123bottom-->
</div>
<!--login123-->
<div class="zhengce">
	<div class="zhengcebt">
		<li>政策法规</li>
	</div>
	<!--zhengcebt-->

	<div class="zhengcebox">
		<ul>
		<c:forEach items="${session['succorlawList']}" var="succorlawList" varStatus="status">
			<li><a href="<%=basePath %>Succorlaw/viewSuccorlaw/${succorlawList.lawid}" target="_blank" class="hei">${status.index + 1}. ${succorlawList.lawtitle }</a></li>
		</c:forEach>
		</ul>
	</div>
	<!--zhengcebox-->
</div>
<!--zhengce-->
<div class="zhengce">
	<div class="zhengcebt">
		<li>应急人员</li>
	</div>
	<!--zhengcebt-->

	<div class="zhengcebox">
		<ul>
		<c:forEach items="${session['emspersonList']}" var="emspersonList" varStatus="status">
			<li><a href="<%=basePath %>Emsperson/viewEmsperson/${emspersonList.id }" target="_blank" class="hei">${status.index + 1}. [${emspersonList.deptname }] ${emspersonList.persname }</a></li>
		</c:forEach>
		</ul>
	</div>
	<!--zhengcebox-->
</div>
<!--zhengce-->
