<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
var flagUserAdd=false;
	window.setTimeout(function(){
  		$("#mbusername").next("span").children("input").eq(0).bind("blur",judgeAccount);
	  	},1000);
function judgeAccount(){
		$.post("<%=basePath%>Main/mobileuser/ifExistUsername", {username:$('#mbusername').val().trim()},
			function (data, textStatus){
				if(!data.success){
					$("#mbusername").next("span").tooltip('destroy');
					$("#mbusername").next("span").children("input").eq(0).removeClass("custombox-invalid");
					flagUserAdd=true;
				}
				else{
					$("#mbusername").next("span").tooltip({
						position:'right',
						content:'登录帐号已存在',
						onShow: function(){
						$(this).tooltip('tip').css({
							backgroundColor: 'rgb(255, 255, 204)',
							borderColor: ' rgb(204, 153, 51)'
						});
				    }
					});
					$("#mbusername").next("span").addClass("textbox-invalid");
					$("#mbusername").next("span").children("input").eq(0).addClass("custombox-invalid");
					flagUserAdd=false;
				}
			}, "json");
	}
</script>
<form id="mobileuser_form" method="post" action="<%=basePath%>Main/mobileuser/save"
	style="width: 100%;">
 	<input type="hidden" name="act" value="add"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	        <tr>
		    <td class="sp-td1">姓名：</td>
		    <td>
		    <input id="mbrealname"  name="t_MobileUser.realname" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/>
		    </td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">用户名：</td>
		    <td><input id="mbusername" name="t_MobileUser.username" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/></td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">密码：</td>
		    <td><input id="mbpassword" name="t_MobileUser.password" type="password" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/></td>
		    </tr>
		    <tr>		    
		    <td class="sp-td1">职位：</td>
		    <td><input name="t_MobileUser.depposname" type="text" class="easyui-textbox"  style="width: 300px;"/></td>
		    </tr>
    </table>
</form>
