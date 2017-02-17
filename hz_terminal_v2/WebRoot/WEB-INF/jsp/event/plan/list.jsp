<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script type="text/javascript">
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
			url:basePath+"Main/eventPlan/getPlanData",
			onClickRow:function(rowIndex, rowData){
				var elevel = $('#eplevel').combobox('getValue');
				eplanLevelFN(rowData.ID,elevel);
			},
			onLoadSuccess:function(data){
				var rows = data.rows;
				if(rows.length>0){
					var prid = rows[0].ID;
					var elevel = $('#eplevel').combobox('getValue');
					eplanLevelFN(prid,elevel);
				}
			}
		};
	$.lauvan.dataGrid("planSearchGrid",attrArray2);
	
});

//加载事件级别
function eplanLevelFN(planid,elevel){
	$("#_eplanLevel").load(basePath+"Main/eventPlan/getEPlanLevel",{'elevel':elevel,'planid':planid},function(){});
}

function EPactionFN(value,row,index){
	var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
		+"<a  href=\"javascript:void(0);\" onclick=ePlanView('"+row.ID+"','"+row.PLAN_ID+"','"+row.EVENT_ID+"') >预案跟踪</a></li>"
		+"<li class=\"s_b_3\"><a  href=\"javascript:void(0);\" onclick=delPlanInst('"+row.ID+"') >删除</a></li>"
		+"</ul>";
	return act;
}
function delPlanInst(instid){
	$.messager.confirm("删除",'您确定删除选择的数据吗？',function(r){
	    if (r){
	       $.ajax({
            	url:basePath+"Main/eventPlan/delete",
            	type:'post',
            	dataType:'json',
            	traditional:true,
            	data:{'id':instid},
            	success:function(data){
            		if(data.success){
            			$.lauvan.MsgShow({msg:'数据删除成功'});
            			$("#eventPlanGrid").datagrid('clearSelections');
            			$("#eventPlanGrid").datagrid('clearChecked');
            			$("#eventPlanGrid").datagrid('reload');
            			var elist = $("#eventGrid");
        				if(elist!=null && elist!=undefined){
        					$("#eventGrid").datagrid('reload');
        				}
        				var eslist = $("#eventSearchGrid");
        				if(eslist!=null && eslist!=undefined){
        					$("#eventSearchGrid").datagrid('reload');
        				}
            		}
            		else{
            			$.messager.alert('错误',data.msg,data.errorcode);
            		}
            	}
            });
	    }
	});
}

function ePlanView(instid){
	$(document.body).append("<div id='ePlanViewDialog'></div>");
	$("#ePlanViewDialog").dialog({
		title:'预案行动清单列表',
		width: 900,
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
		+"<li class=\"s_b_3\"><a  href=\"javascript:void(0);\" onclick=startPlan('"+row.ID+"','${einfo.id}') >启动</a></li>"
		+"</ul>";
	return act;
}
function plViewClick(planid){
	$(document.body).append("<div id='ePlanViewDialog'></div>");
	$("#ePlanViewDialog").dialog({
		title:'预案详情',
		width: 900,
		height: 550,
		modal: true,
		cache: false,
		onClose:function(){
			$(this).dialog('destroy');
		},
		href: basePath+"Main/planMg/getView/"+planid+"-view"
	});
}
function startPlan(planid,eventid){
	var dialogDef={
			title:'启动预案',
			width:500,
			height:300,
			onClose:function(){
				$(this).dialog('destroy');
				$("ePalyBackDialog").remove();
				var elist = $("#eventGrid");
				if(elist!=null && elist!=undefined){
					$("#eventGrid").datagrid('reload');
				}
				var eslist = $("#eventSearchGrid");
				if(eslist!=null && eslist!=undefined){
					$("#eventSearchGrid").datagrid('reload');
				}
			},
			//演示用，指挥调度
			buttons:[{
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						$.lauvan.dialogSubmit('eventPlanform', 'ePalyBackDialog');
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#ePalyBackDialog").dialog('close');
					}
				}],
			href: basePath+"Main/eventPlan/startPlan?planid="+planid+"&eventid="+eventid
	};
	$.lauvan.openCustomDialog('ePalyBackDialog',dialogDef,null,'eventPlanform');
}
function eplan_doSearch(){
	var epradio = $("input[name=\"epradio\"]:checked").val();
	//var url = $('#planSearchGrid').datagrid("options").queryParams;
	if(""==epradio){
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
 	<div data-options="region:'center'" style="border:none;">
		<div class="easyui-tabs" style="width:100%;" data-options="fit:true"  >
			<div  title="预案"   >
				 <div class="easyui-layout"  data-options="fit:true">
				 	<div data-options="region:'north',title:'启动预案操作指引',border:false" style="background: white;height: 225px;">
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
					    	
					    		--%>
					    	<td colspan="3">
					    	<ul>
					    		<li style="list-style-type: square;margin-left: 70px;line-height: 15px;">死亡（失踪）人数：${einfo.ev_deathToll}</li>
					    		<li style="list-style-type: square;margin-left: 70px;line-height: 15px;">受灾面积（m²）：${einfo.ev_affectedarea}</li>
					    		<li style="list-style-type: square;margin-left: 70px;line-height: 15px;">中毒（重伤）人数：${einfo.ev_injuredPeople}</li>
					    		<li style="list-style-type: square;margin-left: 70px;line-height: 15px;">经济损失（万元）：${einfo.ev_economicLoss}</li>
					    	</ul>					    		
					    	</td>
					    		<td colspan="3">
					    		<div id="_eplanLevel"></div>
					    			<%-- <input type="radio" name="epradio" value="000004" onclick="epradioClick(this.value)" <c:if test="${einfo.ev_level=='000004'}"> checked="checked"</c:if> style="width: 20px;"/>IV级 : 中毒人数30人以上，100人以下并无死亡人数</br>
					    			<input type="radio" name="epradio" value="000003" onclick="epradioClick(this.value)" <c:if test="${einfo.ev_level=='000003'}"> checked="checked"</c:if> style="width: 20px;"/>III级 :中毒人数大于100人并无死亡人数；或者死亡人数小于10人</br>
					    			<input type="radio" name="epradio" value="000002" onclick="epradioClick(this.value)" <c:if test="${einfo.ev_level=='000002'}"> checked="checked"</c:if> style="width: 20px;"/>II级 : 中毒人数大于等于100人，并死亡人数小于10人；或者死亡大于10人</br>
					    			<input type="radio" name="epradio" value="000001" onclick="epradioClick(this.value)" <c:if test="${einfo.ev_level=='000001'}"> checked="checked"</c:if> style="width: 20px;"/>I级 : 无相关判断条件</br> --%>
					    		</td>
					    	</tr>
					    	
						</table>
						
					</div>
					<div data-options="region:'center',title:'匹配预案信息列表',border:false" >
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
			</div>
			
			<div  title="已启动预案"   >
				 <div class="easyui-layout"  data-options="fit:true">
					 <div data-options="region:'center',border:false" >
						 	<table id="eventPlanGrid" cellspacing="0" cellpadding="0"> 
							    <thead> 
							        <tr> 
							            <th field="PLANNAME" width="150">预案名称</th> 
							            <th field="START_TIME" width="100"  >启动时间</th>
							            <th field="START_MAN" width="100" >启动人</th>
							            <th field="START_MEMO" width="150"  >启动说明</th>
							            <th field="EPACTION" width="100" formatter="EPactionFN" >操作</th>
							        </tr> 
							    </thead> 
							</table>
					 </div>
				</div>
			</div>
		</div>
	</div>
 </div>