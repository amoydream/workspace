<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  </script>
	 
	<div id="civitabs" class="easyui-tabs" style="width:100%;" data-options="fit:true">
		<div title="组织详情" style="padding:20px;" >
		    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
			    	<tr>
				  		<td class="sp-td1">组织名称</td>
				    	<td >
				    		<input type="hidden" name="t_Civisuccordep.deptid" value="${civi.deptid }"/>
				    		${civi.deptname}
				    	</td>
				    	<td class="sp-td1">级别</td>
				    	<td >
				    		${civi.orglevelid}
				    	</td>
				    	<td class="sp-td1" rowspan="3">照片</td>
				   		<td rowspan="3">
				   			<div id="civilphoto" style="padding-left:30px;">
				   				<c:if test="${! empty civi.url}">
					   				<input type="hidden" id="photoid" name="t_Civisuccordep.photo" value="${civi.photo}" />
					   				<img src="<%=basePath%>${civi.url}" style="width:135px;height:85px;float:left;" />
					   			</c:if>
				   			</div>
				   		</td>
			    	</tr>
			    	<tr>
			    		<td class="sp-td1">徽标描述</td>
				    	<td >
				    		${civi.icon}
				    	</td>
				    	<td class="sp-td1">类别</td>
				    	<td >
				    		${civi.orgsortid}
				    	</td>
				    	
			    	</tr>
			    	<tr>
			    		<td class="sp-td1">责任人</td>
				    	<td >
				    		${civi.orgdutyname}
				    	</td>
				    	<td class="sp-td1">责任人电话</td>
				    	<td >
				    		${civi.orgdutytel}
				    	</td>
			    	<tr>
			    		<td class="sp-td1">责任人手机</td>
				    	<td >
				    		${civi.orgdutymob}
				    	</td>
			    		<td class="sp-td1">责任人传真</td>
				    	<td >
				    		${civi.orgdutyfax}
				    	</td>
				    	<td class="sp-td1">责任人邮箱</td>
				    	<td >
				    		${civi.orgdutymail}
				    	</td>
				    	
			    	</tr>
			    	<tr>
			    		<td class="sp-td1">地址</td>
				    	<td >
				    		${civi.orgaddr}
				    	</td>
			    		<td class="sp-td1">邮编</td>
				    	<td >
				    		${civi.orgzipcode}
				    	</td>
				    	<td class="sp-td1">电话</td>
				    	<td >
				    		${civi.orgtel}
				    	</td>
				    	
			    	</tr>
			    	<tr>
			    		<td class="sp-td1">传真</td>
				    	<td >
				    		${civi.orgfax}
				    	</td>
			    		<td class="sp-td1">机构</td>
				    	<td >
				    		${civi.orgcompose}
				    	</td>
				    	<td class="sp-td1">人员</td>
				    	<td >
				    		${civi.orgperson}
				    	</td>
				    	
			    	</tr>
			    	<tr>
			    		<td class="sp-td1">设备</td>
				    	<td >
				    		${civi.orgequip }
				    	</td>
			    		<td class="sp-td1">记录人</td>
				    	<td >
				    		${civi.username}
				    	</td>
				    	<td class="sp-td1">记录时间</td>
				    	<td >
				    		${civi.rectime}
				    	</td>
			    	</tr>
			    	<tr>
			    		<td class="sp-td1">宗旨</td>
			    		<td colspan="5">
				    		${civi.orgfunc}
				    	</td>
			    	</tr>
			    	<tr>
			    		<td class="sp-td1">任务</td>
			    		<td colspan="5">
				    		${civi.duty}
				    	</td>
			    	</tr>
			    	<tr>
			    		<td class="sp-td1">备注</td>
			    		<td colspan="5">
				    		${civi.note}
				    	</td>
			    	</tr>
			    	<tr>
			    		<td class="sp-td1">描述</td>
			    		<td colspan="5">
				    		${civi.orgnote}
				    	</td>
			    	</tr>
		    </table>
		    </div>
		    <div title="人员信息" data-options="" style="padding:0px;">
				<c:import url="../emsperson/main.jsp"></c:import>
		    </div>
		    
		    <div title="装备信息" data-options="" style="padding:0px;">
				<c:import url="../emsequinfo/main.jsp"></c:import>
		    </div>
		    
   </div>
