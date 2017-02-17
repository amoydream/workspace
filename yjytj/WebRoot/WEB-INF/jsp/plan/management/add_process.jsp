<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	 <form id="planMgform" method="post" action="<%=basePath %>Main/planMg/save" style="width:100%;">
	    <input type="hidden" name="act" value="add_pprocess"/>
	      <input type="hidden" name="codeflag" value="${codetype}"/>
	      <input type="hidden" name="supid" value="${supid}"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
	    	<c:if test="${codetype==0}">
	    		<tr>
		    	<td class="sp-td1">行动阶段名称：</td>
		    	<td>
		    		<input type="hidden" name="t_Bus_PreschPhase.preschid" value="${preschid}"/>
		    		<input type="hidden" name="t_Bus_PreschPhase.fatherid" value="0"/>
		    		<input  name="t_Bus_PreschPhase.phasename" type="text" class="easyui-textbox" data-options="required:true"  style="width: 180px;"/> 
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">执行序号：</td>
		    	<td >
			    	<input  name="t_Bus_PreschPhase.phaseorder" type="text" class="easyui-numberbox" data-options="required:true,min:0"  style="width: 180px;"/>     
				</td>
		    	</tr>
				<tr>
		  		<td class="sp-td1">展示类型：</td>
		    	<td >
			    <select name="t_Bus_PreschPhase.flag" code="YAZSXS" class="easyui-combobox" data-options="required:true,editable:false,icons:iconClear" panelHeight="auto" style="width: 180px;"></select>
				</td>
		    	</tr>
				<tr>
		  		<td class="sp-td1">任务说明：</td>
		    	<td >
		    		<textarea name="t_Bus_PreschPhase.phasedetail" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;"></textarea> 
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		    	<td >
		    		<textarea name="t_Bus_PreschPhase.note" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;"></textarea> 
		    	</td>
		    	</tr>
	    	</c:if>
	    	<c:if test="${codetype==1}">
	    		<tr>
	    		<td class="sp-td1">行动阶段：</td>
		    	<td><input   type="text" class="easyui-textbox" data-options="disabled:true" 
		    	value="${p.phasename}"  style="width: 300px;"/>  </td>
		    	</tr>
	    		
	    		<tr>
		    	<td class="sp-td1">行动流程名称：</td>
		    	<td>
		    		<input type="hidden" name="t_Bus_PreschPhase.preschid" value="${preschid}"/>
		    		<input type="hidden" name="t_Bus_PreschPhase.fatherid" value="${p.phaseid}"/>
		    		<input  name="t_Bus_PreschPhase.phasename" type="text" class="easyui-textbox" data-options="required:true"  style="width: 180px;"/> 
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">执行序号：</td>
		    	<td >
			    	<input  name="t_Bus_PreschPhase.phaseorder" type="text" class="easyui-numberbox" data-options="required:true,min:0"  style="width: 180px;"/>     
				</td>
		    	</tr>
				<tr>
		  		<td class="sp-td1">展示类型：</td>
		    	<td >
			    <select name="t_Bus_PreschPhase.flag" code="YAZSXS" class="easyui-combobox" data-options="required:true,editable:false,icons:iconClear" panelHeight="auto" style="width: 180px;"></select>
				</td>
		    	</tr>
				<tr>
		  		<td class="sp-td1">任务说明：</td>
		    	<td >
		    		<textarea name="t_Bus_PreschPhase.phasedetail" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;"></textarea> 
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">备注：</td>
		    	<td >
		    		<textarea name="t_Bus_PreschPhase.note" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;"></textarea> 
		    	</td>
		    	</tr>
		    </c:if>	
	    	<c:if test="${codetype==2}">
	    		<tr>
	    		<td class="sp-td1">行动流程：</td>
		    	<td><input   type="text" class="easyui-textbox" data-options="disabled:true" 
		    	value="${p.phasename}"  style="width: 300px;"/>  </td>
		    	</tr>
	    		<tr>
		    	<td class="sp-td1">行动名称：</td>
		    	<td>
		    		<input type="hidden" name="t_Bus_PreschAction.preschid" value="${preschid}"/>
		    		<input type="hidden" name="t_Bus_PreschAction.actphase" value="${p.phaseid}"/>
		    		<input  name="t_Bus_PreschAction.actname" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/> 
		    	</td>
		    	</tr>
		    	
		    	<tr>
		    	<td class="sp-td1">行动代号：</td>
		    	<td>
		    		<input  name="t_Bus_PreschAction.actcode" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/> 
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">执行序号：</td>
		    	<td >
			    	<input  name="t_Bus_PreschAction.actorder" type="text" class="easyui-numberbox" data-options="required:true,min:0"  style="width: 180px;"/>     
				</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">内容：</td>
		    	<td >
		    		<textarea name="t_Bus_PreschAction.actcont" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;"></textarea> 
		    	</td>
		    	</tr>
	    	</c:if>	
		    <c:if test="${codetype==3}">
		    	<tr>
	    		<td class="sp-td1">行动名称：</td>
		    	<td><input   type="text" class="easyui-textbox" data-options="disabled:true" 
		    	value="${p.actname}"  style="width: 300px;"/>  </td>
		    	</tr>
	    		<tr>
		    	<tr>
		    	<td class="sp-td1">执行部门：</td>
		    	<td>
		    		<input type="hidden" name="t_Bus_PreschActionDept.preschid" value="${preschid}"/>
		    		<input type="hidden" name="t_Bus_PreschActionDept.actid" value="${p.actid}"/>
		    		<input type="hidden" name="t_Bus_PreschActionDept.actphase" value="${actphase}"/>
		    		<input class="easyui-combotree" name="t_Bus_PreschActionDept.actdeptid" 
		    		data-options="url:'<%=basePath%>Main/plan/getDeptTree',method:'get',required:true" style="width:180px;">
	    
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">联系人：</td>
		    	<td>
		    		<input  name="t_Bus_PreschActionDept.actlinkerman" type="text" class="easyui-textbox" data-options="required:true"  style="width: 180px;"/> 
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">联系电话：</td>
		    	<td>
		    		<input  name="t_Bus_PreschActionDept.actlinkertel" type="text" class="easyui-textbox" data-options="required:true"  style="width: 180px;"/> 
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">任务说明：</td>
		    	<td >
		    		<textarea name="t_Bus_PreschActionDept.note" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width:300px;height: 50px;"></textarea> 
		    	</td>
		    	</tr>
		    	<tr>
		    </c:if>	
	    </table>
    </form>