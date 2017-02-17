<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
//加载事件级别
function eupdradioClick(value){
	$('#eupdlevel').combobox('setValue',value);
}
</script>
<div class="easyui-layout"  data-options="fit:true">
 	<div data-options="region:'center'" style="border:none;">
 	<form id="actEventUpdForm" method="post" action="<%=basePath %>Main/geographic/dispatch/eventUpdSave" style="width:100%;">
 		<table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
			<tr>
			<td class="sp-td1" >事件名称：</td>
			<td >${info.ev_name}</td>
			<td class="sp-td1" >事件级别：</td>
			<td >
			<input type="hidden" name="eventid" value="${info.id}" />
			<input type="hidden" name="instid" value="${instid}" />
			<input type="hidden" name="planid" value="${planid}" />
			<input type="hidden" name="flag" value="${flag}" />
			<select class="easyui-combobox" id="eupdlevel" name="ev_level"  panelHeight="auto" code="EVLV" style="width: 180px;" 
				data-options="editable:false,icons:iconClear,value:'${info.ev_level}'" ></select></td>
			</tr>
			<tr>
				<td class="sp-td1" colspan="4" style="text-align: left;">事件严重程度及影响范围：</td>
			</tr>
			<tr>
			<td class="sp-td1" >死亡（失踪）人数：</td>
			<td ><input type="text" name="ev_deathToll" 
			data-options="prompt:'正整数',precision:0,min:0,icons:iconClear,value:'${info.ev_deathToll}'" class="easyui-numberbox" style="width: 180px;"/>
			</td>
			<td class="sp-td1" >受灾面积（m²）：</td>
			<td ><input type="text" name="ev_affectedarea" 
			data-options="prompt:'小数点保留2位',precision:2,icons:iconClear,value:'${info.ev_affectedarea}'" class="easyui-numberbox" style="width: 180px;"/>
			</td>
			</tr>
			<tr>
			<td class="sp-td1" >中毒（重伤）人数：</td>
			<td ><input type="text" name="ev_injuredPeople" 
			data-options="prompt:'正整数',precision:0,min:0,icons:iconClear,value:'${info.ev_injuredPeople}'" class="easyui-numberbox" style="width: 180px;"/>
			</td>
			<td class="sp-td1" >经济损失（万元）：</td>
			<td ><input type="text" name="ev_economicLoss" 
			data-options="prompt:'小数点保留2位',precision:2,icons:iconClear,value:'${info.ev_economicLoss}'" class="easyui-numberbox" style="width: 180px;"/>
			</td>
			</tr>
			<tr>
				<td colspan="4">
				<c:if test="${!empty ellist}">
					<c:forEach items="${ellist}" var="ellist">
						<input type="radio" name="eupdradio" value="${ellist.itemid}" onclick="eupdradioClick(this.value)" <c:if test="${ellist.ischecked==1}"> checked="checked"</c:if> style="width: 20px;"/>
						${ellist.name} : ${ellist.itemcontent}</br>
					</c:forEach>
				</c:if>
				</td>
			</tr>
		</table>
		</form>
 	</div>
 </div>