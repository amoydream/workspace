<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
  <script>
   
  </script>
	 
	 <form id="form1" method="post" action="<%=basePath%>Main/succoremp/save" style="width:100%;">
	    <table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
			  	<td class="sp-td1">人员类别</td>
			    	<td >
			    		<select name="t_Succoremp.personsortid" data-options="value:'${type}',required:true,panelHeight:'auto'" code="ZYRYFL" class="easyui-combobox" style="width: 200px;" ></select>
			    	</td>
			    	<td class="sp-td1" >人员姓名</td>
			   		<td >
			   			<input type="text"  name="t_Succoremp.personname" data-options="required:true" class="easyui-textbox" style="width: 200px;" />
			   		</td>
			    
		    	</tr>
		    	
		    	<tr>
		    		<td class="sp-td1">性别</td>
			    	<td >
			    		<select name="t_Succoremp.personsex" class="easyui-combobox" code="SEX" style="width:200px;" data-options="panelHeight:50,required:true,editable:false">
			    		</select>
			    	</td>
			    	<td class="sp-td1">民族</td>
			    	<td>
			    		<select  name="t_Succoremp.personnationid" class="easyui-combobox" code="MZ" data-options="" style="width: 200px;"></select>
			    	</td>
		    		
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">出生年月</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp.personbirthday" data-options="validType:'date'" class="easyui-datebox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">籍贯</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp.nativeplaceid" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
			    	<td class="sp-td1">身份证号码</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp.personidcard" data-options="validType:'idcard'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">婚姻情况</td>
			    	<td>
			    		<select name="t_Succoremp.personmarriage" code="MARR" data-options="panelHeight:80" class="easyui-combobox" style="width:200px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">政治面貌</td>
		    		<td><select class="easyui-combobox" name="t_Succoremp.polipartyid" style="width: 200px;" code="ZZMM"></select></td>
		    		<td class="sp-td1">毕业学校</td>
		    		<td><input type="text"  name="t_Succoremp.graduatuniv" data-options="" class="easyui-textbox" style="width: 200px;"/></td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">毕业专业</td>
		    		<td><select class="easyui-combobox" name="t_Succoremp.graduatspecid" data-options="panelHeight:70" code="BYZY" style="width: 200px;"></select></td>
		    		<td class="sp-td1">毕业时间</td>
		    		<td><input type="text"  name="t_Succoremp.graduattime" data-options="validType:'date'" class="easyui-datebox" style="width: 200px;"/></td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">最后学历</td>
			    	<td >
			    		<select class="easyui-combobox"  name="t_Succoremp.educatlevid" data-options="panelHeight:85" code="XUEL" style="width: 200px;"></select>
			    	</td>
			    	<td class="sp-td1">参加工作时间</td>
			    	<td >
			    		<input  name="t_Succoremp.worktime" data-options="validType:'date'" class="easyui-datebox"  style="width: 200px;"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">健康状况</td>
			    	<td >
			    		<select type="text"  name="t_Succoremp.personhealth" data-options="panelHeight:70" class="easyui-combobox" code="HEASTAT" style="width: 200px;"></select>
			    	</td>
			    	<td class="sp-td1">所在单位</td>
			    	<td >
			    		<input type="hidden" name="t_Succoremp.persondeptid" id="equdeptid"/>
			    		<input type="text"  name="t_Succoremp.persondept" id="equdeptname" data-options="readonly:true" class="easyui-textbox" style="width: 170px;"/>
			    		<a id="btn" onclick="findbusorg()" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">单位性质</td>
			    	<td >
			    		<select type="text"  name="t_Succoremp.deptkindid" data-options="panelHeight:85" class="easyui-combobox" code="ORGA" style="width: 200px;"></select>
			    	</td>
			    	<td class="sp-td1">从事职业</td>
			    	<td >
			    		<select  name="t_Succoremp.occuoationid" data-options="" class="easyui-combobox"  style="width: 200px;" code="JOB"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">职称</td>
			    	<td >
			    		<select type="text"  name="t_Succoremp.techpostid" data-options="" code="TECHPOSE" class="easyui-combobox" style="width: 200px;"></select>
			    	</td>
			    	<td class="sp-td1">职务</td>
			    	<td >
			    		<select  name="t_Succoremp.personduty" data-options="" class="easyui-combobox" code="POS" style="width: 200px;"></select>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">电子邮件</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp.personemail" data-options="validType:'email'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">通信地址</td>
			    	<td >
			    		<input  name="t_Succoremp.personcommaddr" data-options="" class="easyui-textbox"  style="width: 200px;" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">邮政编码</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp.personzipcode" data-options="validType:'zip'" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">户口所在地</td>
			    	<td >
			    		<input  name="t_Succoremp.residentaddr" data-options="" class="easyui-textbox"  style="width: 200px;" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">家庭住址</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp.familyaddr" data-options="" class="easyui-textbox" style="width: 200px;"/>
			    	</td>
			    	<td class="sp-td1">记录人</td>
			    	<td >
			    		<input type="hidden" name="t_Succoremp.recid" value="${loginModel.userId}"/>
			    		<input  data-options="readonly:true" class="easyui-textbox"  style="width: 200px;" value="${loginModel.userName}"/>
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">记录时间</td>
			    	<td >
			    		<input type="text"  name="t_Succoremp.rectime" data-options="readonly:true" class="easyui-textbox" style="width: 200px;" value="${nowdate}"/>
			    	</td>
			    	<td></td>
			    	<td></td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">个人描述</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Succoremp.personnote" data-options="multiline:true" class="easyui-textbox"  style="width: 585px;height:60px;" />
			    	</td>
		    	</tr>
		    	<tr>
		    		<td class="sp-td1">备注</td>
			    	<td colspan="3">
			    		<input type="text"  name="t_Succoremp.note" data-options="multiline:true" class="easyui-textbox"  style="width: 585px;height:60px;" />
			    	</td>
		    	</tr>
	    </table>
    </form>
