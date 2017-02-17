<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  	$(function(){
		var param = {
			uploader: 'plugins/uploadify/scripts/uploadify.swf',
			cancelImg: 'plugins/uploadify/cancel.png',
			buttonText: '上传',
			script:'Main/attachment/save/civilphoto--${loginModel.userId}',
			fileQueue: 'fileQueue',
			onComplete: onComplete,
			fileDataName: 'file',
			auto:true,
			fileExt:'*.jpg;*.png;',
			fileDesc:'*.jpg;*.png;'
		};
		$("#emspersonphoto").uploadify(param);  
		function onComplete(event, queueId, fileObj, response, data){
			var obj = eval( "(" + response + ")" );
			var html = "<input type='hidden' name='t_Emsperson.persphoto' value='"+obj.id+"'/><img src='"+basePath+obj.url+"' style='width:135px;height:85px;float:left;' />";
			html += "<a href='javascript:delFile("+obj.id+");'><img src='"+basePath+"plugins/uploadify/cancel.png' height='13' align='middle'/></a>";
			$("#emsphoto").append(html);
		}
  	});

  	function delFile(id){
  		$("#emsphoto").load(basePath+"Main/attachment/delete/"+id);
		$("#emsphoto").empty();
  	}
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/emsperson/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<%--<td class="sp-td1">人员编号</td>
			    	<td >
			    		<input type="text"  name="t_Emsperson.persid" data-options="required:true" class="easyui-textbox" style="width: 200px;" value="${person.persid}"/>
			    	</td>
			    	--%><td class="sp-td1" >人员姓名</td>
			   		<td >
			   			<%--<input type="hidden" name="t_Emsperson.opid" value="${person.opid}" />
			   			--%><input type="hidden" name="t_Emsperson.id" value="${person.id}"/>
			   			<input type="text"  name="t_Emsperson.persname" data-options="required:true,validType:'length[0,20]'" class="easyui-textbox" style="width: 200px;" value="${person.persname}"/>
			   		</td>
			    	<td class="sp-td1">性别</td>
			    	<td >
			    		<select name="t_Emsperson.perssex" code="SEX" class="easyui-combobox" style="width:200px;" data-options="panelHeight:50,required:true,editable:false,value:'${person.perssex}'">
			    		</select>
			    	</td>
		    	</tr>
		    	<%--<tr style="height:90px;">
		    		<td class="sp-td1" >照片</td>
		    		<td >
		    			<div id="emsphoto" style="padding-left:25px;">
		    				<c:if test="${! empty person.url}">
		    					<input type="hidden" id="photoid" name="t_Emsperson.persphoto" value="${person.persphoto}" />
		    					<img src="<%=basePath%>${person.url}" style="width:135px; height:85px; float:left;" />
		    					<a href="javascript:delFile(${person.persphoto});"><img src="<%=basePath%>plugins/uploadify/cancel.png" height="13" align="middle"/></a>
		    				</c:if>
		    			</div>
		    		</td>
		    		<td colspan="2">
		    			<input type="file" name="file" id="emspersonphoto" />
		    		</td>
		    	</tr>
		    	--%><tr>
			    	<td class="sp-td1">民族</td>
			    	<td>
			    		<select  name="t_Emsperson.persnationid" class="easyui-combobox" data-options="editable:false,value:'${person.persnationid}'" style="width: 200px;">
			    			<c:forEach items="${mzList}" var="mz">
			    				<option value="${mz.p_acode }">${mz.p_name}</option>
			    			</c:forEach>
			    		</select>
			    	</td>
			    	<td class="sp-td1">手机号码</td>
			    	<td >
			    		<input type="text"  name="t_Emsperson.tel_num" value="${person.tel_num}" data-options="validType:'mobile'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    		<%--<td class="sp-td1">所属单位名称</td>
			    	<td >
			    		<input type="hidden" name="t_Emsperson.deptno" id="equdeptid" value="${person.deptno}"/>
			    		<input type="text"  name="t_Emsperson.deptname" id="equdeptname" data-options="required:true,readonly:true" class="easyui-textbox" style="width: 170px;" value="${person.deptname}"/>
			    		<a id="btn" onclick="findbusorg()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			    	</td>
		    	--%></tr>
		    	<%--<tr>
		    		<td class="sp-td1">所属单位编号</td>
			    	<td >
			    		<input type="text"  name="t_Emsperson.deptno" id="equteamno" data-options="readonly:true" class="easyui-textbox" style="width: 200px;" value="${person.equteamno}"/>
			    	</td>
			    	<td class="sp-td1">身份证号码</td>
			    	<td >
			    		<input type="text"  name="t_Emsperson.persidcard" data-options="validType:'idcard'" class="easyui-textbox" style="width: 200px;" value="${person.persidcard}" />
			    	</td>
			    	<td class="sp-td1">出生年月</td>
			    	<td >
			    		<input type="text"  name="t_Emsperson.persbirthd" data-options="validType:'date'" class="easyui-datebox" style="width: 200px;" value="${person.persbirthd}"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	
			    	<td class="sp-td1">籍贯</td>
			    	<td >
			    		<input type="text"  name="t_Emsperson.nativeplaceid" data-options="" class="easyui-textbox" style="width: 200px;" value="${person.nativeplaceid}"/>
			    	</td>
			    	<td class="sp-td1">工作时间</td>
			    	<td >
			    		<input type="text"  name="t_Emsperson.worktime" data-options="validType:'date'" class="easyui-datebox" style="width: 200px;" value="${person.worktime}"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">职务</td>
			    	<td >
			    		<select  name="t_Emsperson.persduty" data-options="editable:false,value:'${person.persduty}'" class="easyui-combobox"  style="width: 200px;">
			    			<c:forEach items="${zwList}" var="zw">
			    				<option value="${zw.p_acode }">${zw.p_name}</option>
			    			</c:forEach>
			    		</select>
			    	</td>
			    	<td class="sp-td1">职称</td>
			    	<td >
			    		<select  name="t_Emsperson.techpostid" data-options="editable:false,value:'${person.techpostid}'" class="easyui-combobox" style="width: 200px;"> 
			    			<c:forEach items="${zcList}" var="zc">
			    				<option value="${zc.p_acode }">${zc.p_name}</option>
			    			</c:forEach>
			    		</select>
			    	</td>
		    	</tr>
		    	--%>
		    	<tr>
		    		<td class="sp-td1">人员特长</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Emsperson.persspecid"  data-options="validType:'length[0,60]'" class="easyui-textbox" style="width: 540px;" value="${person.persspecid}" />
			    	</td>
		    	</tr>
		    	<%--<tr>
		    		<td class="sp-td1">户口所在地</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Emsperson.residentaddr" data-options="" class="easyui-textbox" style="width: 540px;" value="${person.residentaddr}"/>
			    	</td>
		    	</tr>
		    	--%><tr>
		    		<td class="sp-td1">家庭住址</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Emsperson.familyaddr" data-options="validType:'length[0,80]'" class="easyui-textbox" style="width: 540px;" value="${person.familyaddr}" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Emsperson.note" data-options="multiline:true,validType:'length[0,100]'" class="easyui-textbox" style="width: 540px;height:80px;" value="${person.note}" />
			    	</td>
		    	</tr>
	    </table>
    </form>
