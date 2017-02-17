<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
//打开地图
function DTClick(){
	$.lauvan.openGisDialog($("#longitude").val(),$("#latitude").val(),function(lng,lat){
		$("#longitude").textbox('setValue',lng);
		$("#latitude").textbox('setValue',lat);
	});
}

</script>
	  <form id="expertEdit" method="post" action="<%=basePath%>Main/expert/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	  <input type="hidden" name="act" value="edit"/>
	  <input type="hidden" name="t_Bus_Expert.ex_id" value="${model.ex_id}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">姓名：</td>
		    	<td><input name="t_Bus_Expert.name" type="text" class="easyui-textbox" 
		    	data-options="prompt:'请输入专家姓名',icons:iconClear,required:true"  style="width:180px;" value="${model.name }"/>  </td>
		  		
		  		<td class="sp-td1">专家类型：</td>
		    	<td >
		    	<input class="easyui-combotree" name="t_Bus_Expert.typeid" 
		    	data-options="required:true,url:'<%=basePath%>Main/expert/getComboTree',method:'get',editable:false,value:'${model.typeid}'" style="width:180px;">
		  		</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">性别：</td>
		  		<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.sex"  panelHeight="auto" code="SEX" 
		    	style="width: 180px;" data-options="required:true,editable:false,value:'${model.sex}'" ></select>
		    	</td>
		  		<td class="sp-td1">出生年月：</td>
		  		<td >
		    	<input type="text"  name="t_Bus_Expert.borndate"  class="easyui-datebox"   
		    	style="width: 180px;"  data-options="editable:false,value:'${model.borndate}'"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">籍贯：</td>
		    	<td><input name="t_Bus_Expert.nativeplace" data-options="prompt:'请输入籍贯',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;" value="${model.nativeplace}"/>  </td>
		  		
		  		<td class="sp-td1">民族：</td>
		  		<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.nationality"  panelHeight="auto" code="MZ" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.nationality}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">身份证号：</td>
		    	<td><input name="t_Bus_Expert.idcard" data-options="prompt:'请输入身份证号',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;" value="${model.idcard}"/>  </td>
		  		
		  		<td class="sp-td1">政治面貌：</td>
		  		<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.politicalstatus"  panelHeight="auto" code="ZZMM" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.politicalstatus}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">毕业学校：</td>
		    	<td><input name="t_Bus_Expert.graduateschool" data-options="prompt:'请输入毕业学校',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;" value="${model.graduateschool}"/>  </td>
		  		
		  		<td class="sp-td1">毕业时间：</td>
		  		<td >
		    	<input type="text"  name="t_Bus_Expert.graduatedate"  class="easyui-datetimebox"   
		    	style="width: 180px;"  data-options="editable:false,value:'${model.graduatedate}'"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">毕业专业：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.professional"  panelHeight="auto" code="BYZY" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.professional}'" ></select>
		    	</td>
		  		
		  		<td class="sp-td1">最后学历：</td>
		  		<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.degree"  panelHeight="auto" code="XUEL" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.degree}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">工作时间(年)：</td>
		    	<td><input name="t_Bus_Expert.worktime" data-options="prompt:'参加工作多少年',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;" value="${model.worktime}"/>  </td>
		  		
		  		<td class="sp-td1">掌握外语：</td>
		  		<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.foreignlanguage"  panelHeight="auto" code="LANG" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.foreignlanguage}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">婚姻：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.ifmarried"  panelHeight="auto" code="MARR" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.ifmarried}'" ></select>
		    	</td>
		  		
		  		<td class="sp-td1">健康：</td>
		    	<td ><input name="t_Bus_Expert.healthstatus" data-options="prompt:'请输入健康状态',icons:iconClear"  type="text" class="easyui-textbox" 
		    	 style="width:180px;" value="${model.healthstatus}"/>    </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">所在单位：</td>
		    	<td >
		    		<input class="easyui-combotree" name="t_Bus_Expert.organid"
		    		 data-options="url:'<%=basePath%>Main/organcontact/getComboTree',method:'get',value:'${model.organid}'" style="width:180px;">
		    	</td>
		  		
		  		<td class="sp-td1">单位性质：</td>
		  		<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.organtype"  panelHeight="auto" code="ORGA" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.organtype}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">从事职业：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.job"  panelHeight="200px" code="JOB" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.job}'" ></select>
		    	</td>
		  		
		  		<td class="sp-td1">职称：</td>
		  		<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.jobtitle"  panelHeight="200px" code="TECHPOSE" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.jobtitle}'" ></select>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">职务：</td>
		    	<td >
		    	<select class="easyui-combobox" name="t_Bus_Expert.position"  panelHeight="200px" code="POS" 
		    	style="width: 180px;" data-options="editable:false,value:'${model.position}'" ></select>
		    	</td>
		  		
		  		<td class="sp-td1">电子邮件：</td>
		    	<td ><input name="t_Bus_Expert.email" data-options="validType:'email',icons:iconClear"  type="text" class="easyui-textbox" 
		    	 style="width:180px;" value="${model.email}"/>    </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">通信地址：</td>
		    	<td><input name="t_Bus_Expert.linkaddress" data-options="prompt:'请输入通信地址',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;" value="${model.linkaddress}"/>  </td>
		  		
		  		<td class="sp-td1">邮政编码：</td>
		    	<td ><input name="t_Bus_Expert.postcode" data-options="validType:'zip',icons:iconClear"  type="text" class="easyui-textbox" 
		    	 style="width:180px;" value="${model.postcode}"/>    </td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">户口所在地：</td>
		    	<td><input name="t_Bus_Expert.registeplace" data-options="prompt:'请输入户口所在地',icons:iconClear" type="text" class="easyui-textbox"
		    	  style="width:180px;" value="${model.registeplace}"/>  </td>
		  		
		  		<td class="sp-td1">经度：</td>
		    	<td >
		    	<input id="longitude" name="t_Bus_Expert.longitude" value="${model.longitude}" type="text" class="easyui-textbox"  style="width: 180px;" data-options="editable:false,icons:[{iconCls:'icon-world',handler:DTClick}]"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">纬度：</td>
		    	<td >
		    	<input id="latitude" name="t_Bus_Expert.latitude" type="text" class="easyui-textbox"  
		    	style="width: 180px;" data-options="readonly:true" value="${model.latitude}"/>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">家庭地址：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Expert.familyaddress" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 560px;height: 50px;" >${model.familyaddress}</textarea>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">奖惩情况：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Expert.rewardpunish" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 400px;height: 50px;" >${model.rewardpunish}</textarea>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">技术专长：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Expert.speciality" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 400px;height: 50px;" >${model.speciality}</textarea>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">其他备注：</td>
		    	<td colspan="3">
		    		<textarea name="t_Bus_Expert.remark" class="textarea" 
		    		data-options="validType:'length[0,500]'"  style="width: 400px;height: 50px;" >${model.remark}</textarea>
		    	</td>
		    	</tr>
		    	
	    </table>
	    </div>
    </form>
