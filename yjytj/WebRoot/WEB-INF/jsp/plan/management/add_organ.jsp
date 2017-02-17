<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
//打开选择机构/人员页面
function _planOrganClick(){
	$(document.body).append("<div id='_planOrgperDialog'></div>");
	$("#_planOrgperDialog").dialog({
		title:'应急机构/人员列表',
		width: 800,
		height: 400,
		href: basePath+"Main/planMg/getOrganTree",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var orgper = $("#orgperSelect").datalist("getData");
				var rows = orgper.rows;
				if(rows){
					var orgperid="";
					var orgpername="";
					for(var i=0;i<rows.length;i++){
						if(i==0){
							orgperid=rows[i].ID;
							orgpername=rows[i].SMSNAME;
						}else{
							orgperid=orgperid+","+rows[i].ID;
							orgpername=orgpername+","+rows[i].SMSNAME;
						}
					}
		    		$("#_planorganid").val(orgperid);
		    		$("#_planorganname").textbox('setValue',orgpername);
		    		$("#_planOrgperDialog").dialog('close');
	    		}else{
		    		alert("请选择应急机构/人员！");
	    		}
			}}]
		});
}
</script>
	 <form id="planMgform" method="post" action="<%=basePath %>Main/planMg/save" style="width:100%;">
	    <input type="hidden" name="act" value="add_organ"/>
	     <input type="hidden" name="t_Bus_PlanItem.pid" value="${empty p.id?0:p.id}"/>
	     <input type="hidden" name="t_Bus_PlanItem.preschid" value="${preschid}"/>
	      <input type="hidden" name="t_Bus_PlanItem.planitemcode" value="2000"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    		<tr>
		    	<td class="sp-td1">父级分组：</td>
		    	<td><input   type="text" class="easyui-textbox" data-options="disabled:true" value="${empty p.itemname?'应急机构':p.itemname}"  style="width: 300px;"/>  </td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">分组名称：</td>
		    	<td><input  name="t_Bus_PlanItem.itemname" type="text" class="easyui-textbox" data-options="required:true"  style="width: 180px;"/>  </td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">机构/人员：</td>
		    	<td >
		    	<input type="hidden" name="organid" id="_planorganid"/>
		    	<input id="_planorganname" name="organname"  type="text" class="easyui-searchbox"  style="width: 180px;" 
		    	data-options="searcher:_planOrganClick,editable:false,icons:iconClear"/>    
				</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		    	<td >
		    		<textarea name="t_Bus_PlanItem.itemcontent" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;"></textarea> 
		    	</td>
		    	</tr>
	    </table>
    </form>