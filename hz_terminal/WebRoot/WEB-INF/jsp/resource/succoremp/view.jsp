<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
  </script>
  		<div id="succoremptabs" class="easyui-tabs" style="width:100%" data-options="fit:true">
  		<div title="人员信息详情" style="padding:20px;">
	    <table id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  	<td class="sp-td1">人员类别</td>
			    	<td >
			    	${str:translate(s.personsortid, 'ZYRYFL')}
			    	</td>
			    	<td class="sp-td1" >人员姓名</td>
			   		<td >
			   			${s.personname}
			   		</td>
			    	<td class="sp-td1">性别</td>
			    	<td >
			    		${str:translate(s.personsex, 'SEX')}
			    	</td>
		    	</tr>
		    	
		    	<tr>
			    	<td class="sp-td1">民族</td>
			    	<td>
			    		${str:translate(s.personnationid , 'MZ')}
			    	</td>
		    		<td class="sp-td1">出生年月</td>
			    	<td >
			    		${s.personbirthday}
			    	</td>
			    	<td class="sp-td1">籍贯</td>
			    	<td >
			    		${s.nativeplaceid}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">身份证号码</td>
			    	<td >
			    	${s.personidcard}
			    	</td>
			    	<td class="sp-td1">婚姻情况</td>
			    	<td>
			    		${str:translate(s.personmarriage,"MARR")}
			    	</td>
			    	<td class="sp-td1">政治面貌</td>
		    		<td>${str:translate(s.polipartyid, "ZZMM")}</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">毕业学校</td>
		    		<td>${s.graduatuniv}</td>
		    		<td class="sp-td1">毕业专业</td>
		    		<td>${str:translate(s.graduatspecid, "BYZY")}</td>
		    		<td class="sp-td1">毕业时间</td>
		    		<td>${s.graduattime}</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最后学历</td>
			    	<td >
			    		${str:translate(s.educatlevid,"XUEL")}
			    	</td>
			    	<td class="sp-td1">参加工作时间</td>
			    	<td >
			    		${s.worktime}
			    	</td>
			    	<td class="sp-td1">健康状况</td>
			    	<td >
			    		${str:translate(s.personhealth, "HEASTAT")}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">所在单位</td>
			    	<td >
			    		${s.persondept}
			    	</td>
			    	<td class="sp-td1">单位性质</td>
			    	<td >
			    		${str:translate(s.deptkindid, "ORGA")}
			    	</td>
			    	<td class="sp-td1">从事职业</td>
			    	<td >
			    		${str:translate(s.occuoationid, "JOB")}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">职称</td>
			    	<td >
			    		${str:translate(s.techpostid, "TECHPOSE")}
			    	</td>
			    	<td class="sp-td1">职务</td>
			    	<td >
			    		${str:translate(s.personduty, "POS")}
			    	</td>
			    	<td class="sp-td1">电子邮件</td>
			    	<td >
			    		${s.personemail}
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">通信地址</td>
			    	<td >
			    		${s.personcommaddr}
			    	</td>
			    	<td class="sp-td1">邮政编码</td>
			    	<td >
			    		${s.personzipcode}
			    	</td>
			    	<td class="sp-td1">户口所在地</td>
			    	<td >
			    		${s.residentaddr}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">家庭住址</td>
			    	<td >
			    		${s.familyaddr}
			    	</td>
			    	<td class="sp-td1">记录人</td>
			    	<td >
			    		${s.username}
			    	</td>
			    	<td class="sp-td1">记录时间</td>
			    	<td >
			    		${s.rectime}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">个人描述</td>
			    	<td colspan="5">
			    		${s.personnote}
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
			    	<td colspan="5">
			    		${s.note}
			    	</td>
		    	</tr>
	    </table>
	   	</div>
	   	<div title="个人简历" style="padding:0px;">
	 		<c:import url="../succorempd/main.jsp"></c:import>
	 	</div>
	 	<div title="通讯录" style="padding:0px;">
	 		<c:import url="../address/main.jsp"></c:import>
	 	</div>
	  </div>
