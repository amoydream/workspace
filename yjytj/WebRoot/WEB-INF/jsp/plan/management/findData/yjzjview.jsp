<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>

	  <div data-options="region:'north',border:false" style="height:130px;">
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">姓名：</td>
		    	<td>${model.name }</td>
		  		
		  		<td class="sp-td1">专家类型：</td>
		    	<td >${typename}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">性别：</td>
		  		<td >${str:translate(model.sex,'SEX')}</td>
		  		<td class="sp-td1">出生年月：</td>
		  		<td >${model.borndate}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">籍贯：</td>
		    	<td>${model.nativeplace}</td>
		  		
		  		<td class="sp-td1">民族：</td>
		  		<td >${str:translate(model.nationality,'MZ')}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">身份证号：</td>
		    	<td>${model.idcard}</td>
		  		
		  		<td class="sp-td1">政治面貌：</td>
		  		<td >${str:translate(model.politicalstatus,'ZZMM')}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">毕业学校：</td>
		    	<td>${model.graduateschool}</td>
		  		
		  		<td class="sp-td1">毕业时间：</td>
		  		<td >${model.graduatedate}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">毕业专业：</td>
		    	<td >${str:translate(model.professional,'BYZY')}</td>
		  		
		  		<td class="sp-td1">最后学历：</td>
		  		<td >${str:translate(model.degree,'XUEL')}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">工作时间：</td>
		    	<td>${model.worktime}</td>
		  		
		  		<td class="sp-td1">掌握外语：</td>
		  		<td >${str:translate(model.foreignlanguage,'LANG')}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">婚姻：</td>
		    	<td >${str:translate(model.ifmarried,'MARR')}</td>
		  		
		  		<td class="sp-td1">健康：</td>
		    	<td >${model.heathstatus}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">所在单位：</td>
		    	<td >${organ}</td>
		  		
		  		<td class="sp-td1">单位性质：</td>
		  		<td >${str:translate(model.organtype,'ORGA')}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">从事职业：</td>
		    	<td >${str:translate(model.job,'JOB')}</td>
		  		
		  		<td class="sp-td1">职称：</td>
		  		<td >${str:translate(model.jobtitle,'TECHPOSE')}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">职务：</td>
		    	<td >${str:translate(model.position,'POS')}</td>
		  		
		  		<td class="sp-td1">电子邮件：</td>
		    	<td >${model.email}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">通信地址：</td>
		    	<td>${model.linkaddress}</td>
		  		
		  		<td class="sp-td1">邮政编码：</td>
		    	<td >${model.postcode}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">户口所在地：</td>
		    	<td>${model.registeplace}</td>
		  		
		  		<td class="sp-td1">经度：</td>
		    	<td >${model.longitude}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">纬度：</td>
		    	<td colspan="3">${model.latitude}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">家庭地址</td>
		    	<td colspan="3">${model.familyaddress}</td>
		    	</tr>             
		    	
		    	<tr>
		    	<td class="sp-td1">奖惩情况：</td>
		    	<td colspan="3">${model.rewardpunish}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">技术专长：</td>
		    	<td colspan="3">${model.speciality}</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">其他备注：</td>
		    	<td colspan="3">${model.remark}</td>
		    	</tr>
		    	
	    </table>
	    </div>
    </form>
