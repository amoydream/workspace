<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  	var basePath = '<%=basePath%>';
  	$(function(){
		var param={
			uploader:'plugins/uploadify/scripts/uploadify.swf',
   			cancelImg:'plugins/uploadify/cancel.png',
   			buttonText:'上传',
   			script:'Main/attachment/save/civilphoto--${loginModel.userId}',
   			fileQueue:'fileQueue',
   			onComplete:onComplete,
   			fileDataName:'file',
   			auto:true,
   			fileExt:'*.jpg;*.png;',
			fileDesc:'*.jpg;*.png;'

		};

		$("#photo").uploadify(param);

		function onComplete(event, queueId, fileObj, response, data){
			var obj = eval( "(" + response + ")" );
			var photohtml =  "<input type='hidden' name='t_Civisuccordep.photo' value='"+obj.id+"' /><img src='" + basePath+obj.url + "' style='width:135px;height:85px;float:left;' />";
			photohtml += "<a href='javascript:delFile("+obj.id+");' ><img src='"+basePath+"plugins/uploadify/cancel.png' height='13' align='middle'  /></a>";
			$("#civilphoto").append(photohtml);
		}

});
  	function delFile(id){
		$("#civilphoto").load(basePath+"Main/attachment/delete/"+id);
		$("#civilphoto").empty();
	}
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/civisuccordep/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">组织名称</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.deptname" data-options="required:true" class="easyui-textbox" style="width: 200px;" />
			    	</td>
			    	<td class="sp-td1" rowspan="4">照片</td>
			   		<td rowspan="3">
			   			<div id="civilphoto" style="padding-left:30px;"></div>
			   		</td>
			    
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">级别</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orglevelid" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">徽标描述</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.icon" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">类别</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgsortid" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td >
			    		<input type="file" name="file" id="photo" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">责任人</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutyname" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">责任人电话</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutytel" data-options="validType:'phone'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">责任人手机</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutymob" data-options="validType:'mobile'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">责任人传真</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutyfax" data-options="validType:'faxno'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">责任人邮箱</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutymail" data-options="validType:'email'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">地址</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgaddr" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">邮编</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgzipcode" data-options="validType:'zip'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">电话</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgtel" data-options="validType:'phone'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">传真</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgfax" data-options="validType:'faxno'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">机构</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgcompose" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">人员</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgperson" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">设备</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgequip" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">记录人</td>
			    	<td >
			    		<input type="hidden" name="t_Civisuccordep.recid" value="${loginModel.userId}"/>
			    		<input type="text"  name="recname" data-options="readonly:true" class="easyui-textbox" style="width: 200px;" value="${loginModel.userName}"/>
			    	</td>
			    	<td class="sp-td1">记录时间</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.rectime" data-options="readonly:true" class="easyui-textbox" style="width: 200px;" value="${nowdate}"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">宗旨</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Civisuccordep.orgfunc" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">任务</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Civisuccordep.duty" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Civisuccordep.note" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">描述</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Civisuccordep.orgnote" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
