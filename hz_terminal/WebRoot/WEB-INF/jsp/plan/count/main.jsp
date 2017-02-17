<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script src="js/echarts-all.js"></script>
<style>
</style>
<script>
var PieChart = null;	
var PieOption = {
		noDataLoadingOption:{ 
			effect:{n:0}
		},
		tooltip:{
			show: true,
			formatter: "{a} <br/> {b} ： {c}（{d}%）"
		},
	//	color:['#CDCD00','#0580b9'],
		series:[{
			selectedMode: 'single',
			name:'概率',
			type: 'pie',
			radius: '70%',
			center: ['55%', '50%']
		}]

	};
function yaSrh(){ 
	var tab = $("#yacontent");
	var href = tab.panel('options').href;
	var index = href.indexOf('?'); //参数拼接位置
	href = href.substring(0, index);
	var param = "?counttype="+ $("#counttype").combobox('getValue'); //拼接新路径
	tab.panel('options').href = href + param; //替换路径
    $("#yacontent").panel('refresh');   
}
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="height:50px;padding:15px; background: #f7f7f7;">
	<span>统计方式：</span>
<select class="easyui-combobox" id="counttype" name="counttype"  panelHeight="auto" style="width: 180px;" data-options="editable:false" >
<option <c:if test="${count=='001'}">selected</c:if> value="001">按预案类别统计</option>
<option <c:if test="${count=='002'}">selected</c:if> value="002">按预案部门统计</option>
<option <c:if test="${count=='003'}">selected</c:if> value="003">按上报和审批统计</option>
<option <c:if test="${count=='004'}">selected</c:if> value="004">按预案部门和预案类别统计</option>
</select>
		
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="yaSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div data-options="region:'west', split:true" style="width:55%;">
		<div id="yatab" class="easyui-tabs" style="width:100%;" data-options="fit:true,headerWidth:90">
		   <div id="yacontent" title="数字化预案" data-options="href:'<%=basePath%>Main/plancount/gethistogram?counttype=${counttype }'">
		   </div>
		</div>
	</div>
	<div data-options="region:'center', split:true" style="width:45%;">
	<div style="height:100%">
	    <div style="padding-left:40px;background-color:#A4D3EE;font-size:15px;"><span id="yapieinfo">饼图</span></div>
		<div id=yaPie style="width:100%;height:90%;margin:0 auto;"  ></div>
	</div>
</div>

		

