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
	margin-top: 5px;
}
.login123denglu ul li{ width:119px; height:22px;}
.login123denglu ul li input{float:left;}
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
	line-height: 25px;
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

<div class="login123">
	<div class="login123head"
		style="width:194px; height:30px; background:url(<%=basePath %>images/web/logintop.jpg) no-repeat;">
	</div>
	<div class="login123center"
		style="width:194px; height:117px; background:url(<%=basePath %>images/web/loginbg.jpg) repeat-y;">

		<form id="myform" name="myform" onsubmit="return checkuser(this);"
			action="<%=basePath %>Login/doLogin" method="post" target="_self">
			<input type="hidden" name="login" value="y">
			<div class="login123denglu"
				style="width:194px; height:70px; background:url(<%=basePath %>images/web/logincenter.jpg) no-repeat bottom; padding-top:10px;">
				<%-- <span style="color: red;font-weight: bold;font-size:12px;float:left;margin-left:20px;margin-top:-5px;">${msg}</span> --%>
				<ul>
					<li style="float:left;width:90px;height:20px;position:relative;">
					<input name="loginAccount" type="text" class="small" id="userID"
						 style="width:90px;height:18px;line-height:18px;position:absolute;left:0; top:0;" value="${loginAccount}" />
					</li>
					<li style="float:left;width:90px;height:20px;position:relative;"><input name="loginPwd" type="password" class="small" id="pwd"
						 style="width:90px;height:18px;line-height:18px;position:absolute;left:0; top:0;" value="${loginPwd}" />
					</li>
				</ul>
			</div>
			<!--login123denglu-->

			<div class="login123denglu2"
				style="height:31px;width:180px; margin:5px auto;">
				<ul>
					<li
						style="float:left;width:80px; height:31px; text-align:center;line-height:31px;">
						<input id="forceLogin" name="forceLogin" type="checkbox" value="N" onclick="this.value=(this.checked?'Y':'N')"/><span style="font-size: 13px;"> 强行登录</span>
					</li>
					<li><INPUT id=btnLogin
						style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; WIDTH: 82px; HEIGHT: 31px; BORDER-RIGHT-WIDTH: 0px"
						type=image alt=登录 src="<%=basePath %>images/web/input.jpg" border=0
						name=btnLogin>
					</li>
				</ul>
			</div>
		</FORM>
	</div>
	<!--login123center-->
	<div class="login123bottom"
		style="width:194px; height:13px; background:url(<%=basePath %>images/web/loginbottom.jpg) no-repeat;">
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
		<c:forEach items="${webFn:contents(5, 1, 'zcfg', '').getList()}" var="law" varStatus="status">
			<li><a href="<%=basePath %>zcfg/${law.contentid}" target="_blank" class="hei">
			${status.index + 1}. 
			<c:choose>
						<c:when test="${fn:length(law.caption) > 10}">
							${fn:substring(law.caption, 0, 10)}...
						</c:when>
						<c:otherwise>
							${law.caption}]
				</c:otherwise>
				</c:choose>
			</a></li>
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

	<div class="zhengcebox" style="height:142px;">
		<ul>
		<c:forEach items="${webFn:contents(5,1, 'yjry', '').getList()}" var="emspersonList" varStatus="status">
			<li><a href="<%=basePath %>yjry/${emspersonList.contentid }" target="_blank" class="hei">
				${status.index + 1}. 
				<c:choose>
						<c:when test="${fn:length(emspersonList.caption) > 10}">
							${fn:substring(emspersonList.caption, 0, 10)}...
						</c:when>
						<c:otherwise>
							${emspersonList.caption}
				</c:otherwise>
				</c:choose>
			</a></li>
		</c:forEach>
		</ul>
	</div>
	<!--zhengcebox-->
</div>
<!--zhengce-->
<script type="text/javascript">
	function msg() {
	    if("${msg}") {
		    alert("${msg}");
	    }
    }

    window.onload = msg();
</script>