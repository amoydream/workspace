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
			if($("#phoid").length>0){
				delFile($("#phoid").val());
			}
			var photohtml =  "<div id='photobox_"+obj.id+"'><input type='hidden' id='phoid' name='t_Civisuccordep.photo' value='"+obj.id+"' /><img src='" + obj.url + "' style='width:135px;height:85px;float:left;' />";
			photohtml += "<a href='javascript:delFile("+obj.id+");' ><img src='"+basePath+"plugins/uploadify/cancel.png' height='13' align='middle'  /></a></div>";
			$("#civilphoto").append(photohtml);
		}

});
  	function delFile(id){
		//$("#civilphoto").load(basePath+"Main/attachment/delete/"+id);
		$.post("<%=basePath%>Main/attachment/delete/"  +id, null ,null);
		$("#photobox_"+id).remove();
	}
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/civisuccordep/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1">组织名称</td>
			    	<td >
			    		<input type="hidden" name="t_Civisuccordep.deptid" value="${civi.deptid }"/>
			    		<input type="text"  name="t_Civisuccordep.deptname" value="${civi.deptname}" data-options="required:true" class="easyui-textbox" style="width: 200px;" />
			    	</td>
			    	<td class="sp-td1" rowspan="4">照片</td>
			   		<td rowspan="3">
			   			<div id="civilphoto" style="padding-left:30px;">
			   				<c:if test="${! empty civi.url}">
			   					<div id="photobox_${civi.photo}">
			   						<input type="hidden" id="phoid" name="t_Civisuccordep.photo" value="${civi.photo}" />
				   					<img src="${civi.url}" style="width:135px;height:85px;float:left;" />
				   					<a href="javascript:delFile(${civi.photo});"><img src="<%=basePath%>plugins/uploadify/cancel.png" height="13" align="middle"/></a>
				   				</div>
				   			</c:if>
			   			</div>
			   		</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">级别</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orglevelid" value="${civi.orglevelid}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">徽标描述</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.icon" value="${civi.icon}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">类别</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgsortid" value="${civi.orgsortid}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td >
			    		<input type="file" name="file" id="photo" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">责任人</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutyname" value="${civi.orgdutyname}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">责任人电话</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutytel" value="${civi.orgdutytel}" data-options="validType:'phone'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">责任人手机</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutymob" value="${civi.orgdutymob}" data-options="validType:'mobile'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">责任人传真</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutyfax" value="${civi.orgdutyfax}" data-options="validType:'faxno'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	
		    	<tr>
		    		<td class="sp-td1">责任人邮箱</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgdutymail" value="${civi.orgdutymail}" data-options="validType:'email'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">地址</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgaddr" value="${civi.orgaddr}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">邮编</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgzipcode" value="${civi.orgzipcode}" data-options="validType:'zip'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">电话</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgtel" value="${civi.orgtel}" data-options="validType:'phone'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">传真</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgfax" value="${civi.orgfax}" data-options="validType:'faxno'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<td class="sp-td1">机构</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgcompose" value="${civi.orgcompose}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">人员</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgperson" value="${civi.orgperson}" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">设备</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.orgequip" value="${civi.orgequip }" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">记录人</td>
			    	<td >
			    		<input type="hidden" name="t_Civisuccordep.recid" value="${civi.recid}"/>
			    		<input type="text"  name="recname" value="${civi.username}" data-options="readonly:true" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">记录时间</td>
			    	<td >
			    		<input type="text"  name="t_Civisuccordep.rectime" value="${civi.rectime}" data-options="readonly:true" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">宗旨</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Civisuccordep.orgfunc" value="${civi.orgfunc}" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">任务</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Civisuccordep.duty" value="${civi.duty}" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Civisuccordep.note" value="${civi.note}" data-options="multiline:true" class="easyui-textbox" style="width: 585px;height:60px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">描述</td>
		    		<td colspan="5">
			    		<input type="text"  name="t_Civisuccordep.orgnote" value="${civi.orgnote}" data-options="multiline:true" class="easyui-textbox" style="width:585px;height:60px;"/>
			    	</td>
		    	</tr>
	    </table>
    </form>
