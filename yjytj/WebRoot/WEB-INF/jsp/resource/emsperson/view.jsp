<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  
	 
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  		<td class="sp-td1" >人员姓名</td>
			   		<td >
			   			${person.persname}
			   		</td>
			    	<td class="sp-td1">性别</td>
			    	<td >
			    		${str:translate(person.perssex, 'SEX')}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">民族</td>
			    	<td>
			    		${str:translate(person.persnationid, 'MZ')}
			    	</td>
			    	<td class="sp-td1">手机号码</td>
			    	<td >
			    		${person.tel_num}
			    	</td>
		    		</tr>
		    	
		    	<tr>
		    		<td class="sp-td1">人员特长</td>
			    	<td colspan="3">
			    		${person.persspecid}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">家庭住址</td>
			    	<td colspan="3">
			    		${person.familyaddr}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
			    	<td colspan="3">
			    		${person.note}
			    	</td>
		    	</tr>
	    </table>
