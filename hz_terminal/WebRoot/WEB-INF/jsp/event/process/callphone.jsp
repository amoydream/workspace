<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	//拨打号码
	function eventPhoneCallFN(flag){
		var eid = $("#_calleventid").val();
		if(flag==1){
			var phone = $("#_callphone").val();
			if(phone==null || phone=='' || phone == undefined){
				alert("请输入手机号码！");
			}else{
				callout(phone, eid);
				$('#eCallphoneDialog').dialog('close');
			}
		}else if(flag==2){
			var worknum = $("#_callworkphone").val();
			if(worknum==null || worknum=='' || worknum == undefined){
				alert("请输入办公号码！");
			}else{
				callout(worknum, eid);
				$('#eCallphoneDialog').dialog('close');
			}
		}
	}
	
</script>
<div class="easyui-layout"  data-options="fit:true">

<div data-options="region:'center',border:false" >
<input type="hidden" id="_calleventid" name="_calleventid" value="${eid}"/>
	<table class="sp-table" width="100%" cellpadding="0" cellspacing="0"> 
			<tr>
		  		<td class="sp-td1" style="width:100px;" >手机号码：</td>
		    	<td >
		    		
		    		<input type="text" id="_callphone" name="_callphone" data-options="icons:iconClear" 
		    		class="easyui-textbox" style="width: 200px;" value="${phone}"/>
		    		
		    	</td>
		    	<td >
		    		<ul class="specil_button"><li class="s_b_1">
					<a  href="javascript:void(0);" onclick="eventPhoneCallFN(1);" ><span class="sphone"></span>拨打</a></li>
					</ul>
		    	</td>
		    </tr>
		    <tr>
		  		<td class="sp-td1" style="width:100px;" >办公号码：</td>
		    	<td >
		    		<input type="text" id="_callworkphone" name="_callworkphone" data-options="icons:iconClear" 
		    		class="easyui-textbox" style="width: 200px;" value="${worknum}"/>
		    	</td>
		    	<td >
		    		<ul class="specil_button"><li class="s_b_1">
					<a  href="javascript:void(0);" onclick="eventPhoneCallFN(2);" ><span class="sphone"></span>拨打</a></li>
					</ul>
		    	</td>
		    </tr>
		           
	</table>
</div>

</div>	
	
	 
	
