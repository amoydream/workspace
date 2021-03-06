<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={ 
			fitColumns : true,
			idField:'ID',
			url:basePath+"Main/eventPlan/getPlanGZ?eventid=${einfo.id}"
		};
		$.lauvan.dataGrid("eventPlanGrid",attrArray);
		var attrArray2 ={ 
				fitColumns : true,
				idField:'ID',
				queryParams:{"eptype":'${einfo.ev_type}',"eplevel":'${einfo.ev_level}'},
				url:basePath+"Main/eventPlan/getPlanData"
			};
		$.lauvan.dataGrid("planSearchGrid",attrArray2);
	});

	function EPactionFN(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=ePlanView('"+row.ID+"','"+row.PLAN_ID+"','"+row.EVENT_ID+"') >预案跟踪</a></li>"
			+"<li class=\"s_b_3\"><a  href=\"javascript:void(0);\" onclick=delPlanInst('"+row.ID+"') >删除</a></li>"
			+"</ul>";
		return act;
	}
	function ePlanView(instid){
		$(document.body).append("<div id='ePlanViewDialog'></div>");
		$("#ePalyBackDialog").dialog({
			title:'预案行动清单列表',
			width: 800,
			height: 500,
			modal: true,
			cache: false,
			onClose:function(){
				$(this).dialog('destroy');
			},
			href: basePath+"Main/eventPlan/getPlanView/"+instid
		});
	}
	function PlanActionFN(value,row,index){	
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=plViewClick('"+row.ID+"') >查看</a></li>"
			+"<li class=\"s_b_3\"><a  href=\"javascript:void(0);\" onclick=startPlan('"+row.ID+"') >启动</a></li>"
			+"</ul>";
		return act;
	}
	function eplan_doSearch(){
		var epradio = $("input[name=\"epradio\"]:checked").val();
		//var url = $('#planSearchGrid').datagrid("options").queryParams;
		if("000001"==epradio){
			$('#planSearchGrid').datagrid({
				queryParams:{
				'prename': $('#prename').val(),
				'pretype': $('#pretype').combotree('getValue')}
				});
			
		}else{
			$('#planSearchGrid').datagrid({
				queryParams:{
				'prename': $('#prename').val(),
				'pretype': $('#pretype').combotree('getValue'),
				'eptype': $("#eptype").combotree('getValue'),
				'eplevel':$("#eplevel").combobox('getValue')}
			});
		}
		
	}
	function epradioClick(value){
		$('#eplevel').combobox('setValue',value);
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		 <div data-options="region:'north',title:'事件已启动预案信息列表',border:false" style="height: 150px;">
			 	<table id="eventPlanGrid" cellspacing="0" cellpadding="0"> 
				    <thead> 
				        <tr> 
				            <th field="PLANAME" width="150">预案名称</th> 
				            <th field="START_TIME" width="100"  >启动时间</th>
				            <th field="START_MAN" width="100" >启动人</th>
				            <th field="START_MEMO" width="150"  >启动说明</th>
				            <th field="EPACTION" width="100" formatter="EPactionFN" >操作</th>
				        </tr> 
				    </thead> 
				</table>
		 </div>
		<div data-options="region:'center',title:'启动预案操作指引',border:false" style="padding: 5px;background: white;">
			<table  id="table" class="sp-table" width="100%" cellpadding="0" cellspacing="0">
				<tr>
		    	<td class="sp-td1" >事件名称：</td>
		    	<td ><input  type="text" class="easyui-textbox" data-options="disabled:true" value="${einfo.ev_name}" style="width: 180px;" >
		    	</td>
		    	
		    	<td class="sp-td1" >事件类型：</td>
		    	<td>
		    	<input class="easyui-combotree" id="eptype" style="width:180px;"
		    	data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,icons:iconClear,value:'${einfo.ev_type}'" >
		    	</td>
		    	<td class="sp-td1" >事件级别：</td>
		    	<td>
		    	<select class="easyui-combobox" id="eplevel"  panelHeight="auto" code="EVLV" style="width: 180px;" 
		    	data-options="editable:false,icons:iconClear,value:'${einfo.ev_level}'" ></select>
		    	</td>
		    	</tr>
		    	<%--<tr>
		    	<td  class="sp-td1" >死亡（失踪）人数：</td>
		    	<td >
		    		<input type="text" id="deathToll" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear,value:'${einfo.ev_deathToll}'" class="easyui-numberbox" style="width: 180px;"/>
		    	</td>
		    	
		  		<td  class="sp-td1" >受灾面积（m²）：</td>
		    	<td >
		    		<input type="text" id="affectedarea" data-options="prompt:'小数点保留2位',precision:2,icons:iconClear,value:'${einfo.ev_affectedarea}'" class="easyui-numberbox" style="width: 180px;"/>
		    	</td>
		  		
		    	
		    	<td  class="sp-td1" >中毒（重伤）人数：</td>
		    	<td >
		    		<input type="text" id="injuredPeople" data-options="prompt:'正整数',precision:0,min:0,icons:iconClear,value:'${einfo.ev_injuredPeople}'" class="easyui-numberbox" style="width: 180px;"/>
		    	</td>
		    	</tr>
		    	--%>
		    	<tr>
		    	<td class="sp-td1" >预案名称：</td>
		    	<td ><input id="prename" type="text" class="easyui-textbox"   style="width:180px;">
		    	</td>
		    	<td class="sp-td1" >预案类型：</td>
		    	<td ><input class="easyui-combotree" id="pretype" 
		    	data-options="url:'<%=basePath%>Main/busParam/getTypeTree/YAFL-0-1',method:'get',editable:false" style="width:180px;">
		    	</td>
		    	<td colspan="2">
		    	<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eplan_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		    	</td>
		    	</tr>
		    	
		    	<tr>
		  		<%--<td  class="sp-td1" >经济损失（万元）：</td>
		    	<td >
		    		<input type="text" id="economicLoss" data-options="prompt:'小数点保留2位',precision:2,icons:iconClear,value:'${einfo.ev_economicLoss}'" class="easyui-numberbox" style="width: 180px;"/>
		    	</td>
		    	
		    		--%><td colspan="6">
		    			<input type="radio" name="epradio" value="000004" onclick="epradioClick(this.value)" <c:if test="${einfo.ev_level=='000004'}"> checked="checked"</c:if> style="width: 20px;"/>IV级 : 中毒人数30人以上，100人以下并无死亡人数</br>
		    			<input type="radio" name="epradio" value="000003" onclick="epradioClick(this.value)" <c:if test="${einfo.ev_level=='000003'}"> checked="checked"</c:if> style="width: 20px;"/>III级 :中毒人数大于100人并无死亡人数；或者死亡人数小于10人</br>
		    			<input type="radio" name="epradio" value="000002" onclick="epradioClick(this.value)" <c:if test="${einfo.ev_level=='000002'}"> checked="checked"</c:if> style="width: 20px;"/>II级 : 中毒人数大于等于100人，并死亡人数小于10人；或者死亡大于10人</br>
		    			<input type="radio" name="epradio" value="000001" onclick="epradioClick(this.value)" <c:if test="${einfo.ev_level=='000001'}"> checked="checked"</c:if> style="width: 20px;"/>I级 : 无相关判断条件</br>
		    		</td>
		    	</tr>
		    	
			</table>
			
		</div>
		<div data-options="region:'south',title:'匹配预案信息列表',border:false" style="height: 150px;">
			<table id="planSearchGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="PRESCHNAME" width="150">预案名称</th> 
			            <th field="PRESCHTYPE" width="100" CODE="YAFL" >预案类型</th>
			            <th field="PRESCHPUBDATE" width="100" >发布时间</th>
			            <th field="PRESCHACT" width="150" formatter="PlanActionFN" >操作</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

