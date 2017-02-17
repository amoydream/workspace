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
	//var flagArr = [true, true, true, true, true]; //图表用
	var tabArr = ['ev_economicloss', 'ev_injuredpeople', 'ev_deathtoll', 'ev_affectedarea', 'ev_participationnumber'];
	var textArr = ['经济损失', '受伤人员', '死亡人数', '受灾面积', '受灾人口'];
	var tabIndex = 0;
	var now_pieChart = null;
	var last_pieChart = null;
	var yearMonth = null;
	var nowselectpie = null; //饼图选中值
	var lastselectpie = null;
	//圆饼公用参数
	var pieOption = {
			noDataLoadingOption:{ 
				effect:{n:0}
			},
			tooltip:{
				show: true,
				enterable :false,
				formatter: "{a} <br/> {b} ： {c}（{d}%）",
				position: function(p){
					return [p[0]+10, p[1]-40];
				}
			},
		//	color:['#CDCD00','#0580b9'],
			series:[{
				selectedMode: 'single',
				name:textArr[tabIndex],
				type: 'pie',
				radius: '70%',
				center: ['55%', '50%']
			}]

		};

	function eventLostSrh(){ //根据指定日期查询
		for(var i=0; i<5; i++){
			//修改图表tab路径
			var tab = $("#losttab").tabs("getTab", i);
			var href = tab.panel('options').href;
			var index = href.indexOf('&'); //参数拼接位置
			href = href.substring(0, index);
			var param = "&sdate="+ $("#loststartdate").datebox('getValue') 
						+ "&edate="+$("#lostenddate").datebox('getValue'); //拼接新路径
			href += param;
			$("#losttab").tabs('update', {
					tab: tab,
					options: {href: href}
	
				});
			
			
		}
		$("#losttab").tabs('getSelected').panel('refresh');
		showChartOrList(0); //切换到柱状图
	
	 }

	 function refreshPie(json){
		var data = [];
		//更新本期圆饼图
		var temp = json.nowdata;
		if(temp.length >0){
			for(var i=0; i<temp.length; i++){
				if(temp[i].NAME == nowselectpie){
					data.push({'name' : temp[i].NAME, 'value' : temp[i].VALUE, 'selected': true});
				}else{
					data.push({'name' : temp[i].NAME, 'value' : temp[i].VALUE, 'selected': false});
				}
			}
			pieOption.series[0].name = textArr[tabIndex];
			pieOption.series[0].data=data;
		}else{
			pieOption.series[0].data= ['-'];
		}
		last_pieChart.clear();
		now_pieChart.setOption(pieOption);
		//更新上年同期圆饼图
		temp = json.lastdata;
		data=[];
		if(temp.length >0){
			for(var i=0; i<temp.length; i++){
				if(temp[i].NAME == lastselectpie){
					data.push({'name' : temp[i].NAME, 'value' : temp[i].VALUE, 'selected': true});
				}else{
					data.push({'name' : temp[i].NAME, 'value' : temp[i].VALUE, 'selected': false});
				}
			}
			pieOption.series[0].data=data;
		}else{
			pieOption.series[0].data = ['-'];
		}
		last_pieChart.clear();
		last_pieChart.setOption(pieOption);
	 }

	 function refreshInfo(){
		//修改样式
		var info = "当前（"+yearMonth +" " +textArr[tabIndex]+"）";
		$("#nowpieinfo").text(info);
	 }
	 $("#losttab").tabs({ //修改选中tab事件
			onSelect: function(title, index){
				tabIndex = index;
				//更改圆饼显示数据
				if(yearMonth != null){
					$.getJSON("<%=basePath%>Main/lostAnls/getPieData",
							{"yearMonth" : yearMonth, "sumColumn":tabArr[index]},
							function(json){
								refreshPie(json); //更新圆饼图
							}
					);
					refreshInfo();
				}
	 		}
	
		});

	 
	 $("#eventlisttab").tabs({ //修改选中tab事件
			onSelect: function(title, index){
				tabIndex = index;
				//更改圆饼显示数据
				if(yearMonth != null){
					$.getJSON("<%=basePath%>Main/lostAnls/getPieData",
							{"yearMonth" : yearMonth, "sumColumn":tabArr[index]},
							function(json){
								refreshPie(json); //更新圆饼图
							}
					);
					refreshInfo();
				}
	 		}
	
		});

	//0-图表	 1-事件列表
	 var firstFlag = true;
	 function showChartOrList(flag){
		if(flag == 0){
			$("#losttab").show();
			$("#eventlisttab").hide();
		}else{
			$("#losttab").hide();
			$("#eventlisttab").show();
			if(firstFlag && tabIndex==0){ //解决：首次点击列表第一个tab，表头隐藏
				var tab = tabArr[0].toUpperCase();
				$("#now_"+tab).datagrid("resize");
				$("#last_"+tab).datagrid("resize");
				firstFlag = false;
			}
			if(tabIndex !=0 ){
				$("#eventlisttab").tabs('select', tabIndex);

			}
		}
	 }
	 

	$(function(){

		$("#ev_economicloss").load("<%=basePath%>Main/lostAnls/getLostList?column=ev_economicloss");
		$("#ev_injuredpeople").load("<%=basePath%>Main/lostAnls/getLostList?column=ev_injuredpeople");
		$("#ev_deathtoll").load("<%=basePath%>Main/lostAnls/getLostList?column=ev_deathtoll");
		$("#ev_affectedarea").load("<%=basePath%>Main/lostAnls/getLostList?column=ev_affectedarea");
		$("#ev_participationnumber").load("<%=basePath%>Main/lostAnls/getLostList?column=ev_participationnumber");
		
	});

	window.onresize = function(){
		if(now_pieChart != null){
			now_pieChart.resize();
		}
		if(last_pieChart != null){
			last_pieChart.resize();
		}

	};

</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false" style="height:50px;padding:15px; background: #f7f7f7;">
		<span>起始时间：</span>
			<input type="text" name="startdate" id="loststartdate" value="${sdate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<span>结束时间：</span>
			<input type="text" name="enddate" id="lostenddate" value="${edate}" class="easyui-datebox" data-options="editable:false" style="width:200px;"/>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="eventLostSrh()" data-options="iconCls:'icon-search',plain:true">查询</a>
			<span style="padding-left:75px;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="showChartOrList(0)" data-options="iconCls:'icon-chartbar',plain:true">柱状图</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="showChartOrList(1)" data-options="iconCls:'icon-applicationviewlist',plain:true">事件列表</a>
			</span>
	</div>
	<div data-options="region:'west', split:true" style="width:55%;">
		<div id="losttab" class="easyui-tabs" style="width:100%;" data-options="fit:true,headerWidth:90">
			<div title="经济损失" data-options="href:'<%=basePath%>Main/lostAnls/getLostChart?column=ev_economicloss&sdate=${sdate}&edate=${edate}'"></div>
			<div title="受伤人数" data-options="href:'<%=basePath%>Main/lostAnls/getLostChart?column=ev_injuredpeople&sdate=${sdate}&edate=${edate}'"></div>
			<div title="死亡人数" data-options="href:'<%=basePath%>Main/lostAnls/getLostChart?column=ev_deathtoll&sdate=${sdate}&edate=${edate}'"></div>
			<div title="受灾面积" data-options="href:'<%=basePath%>Main/lostAnls/getLostChart?column=ev_affectedarea&sdate=${sdate}&edate=${edate}'"></div>
			<div title="受灾人口" data-options="href:'<%=basePath%>Main/lostAnls/getLostChart?column=ev_participationnumber&sdate=${sdate}&edate=${edate}'"></div>
		</div>
		<div id="eventlisttab" class="easyui-tabs" style="width:100%;display:none;" data-options="fit:true,headerWidth:90">
			<%--<div title="经济损失" data-options="href:'<%=basePath%>Main/lostAnls/getLostList?column=ev_economicloss&sdate=${sdate}&edate=${edate}'"></div>
			<div title="受伤人数" data-options="href:'<%=basePath%>Main/lostAnls/getLostList?column=ev_injuredpeople&sdate=${sdate}&edate=${edate}'"></div>
			<div title="死亡人数" data-options="href:'<%=basePath%>Main/lostAnls/getLostList?column=ev_deathtoll&sdate=${sdate}&edate=${edate}'"></div>
			<div title="受灾面积" data-options="href:'<%=basePath%>Main/lostAnls/getLostList?column=ev_affectedarea&sdate=${sdate}&edate=${edate}'"></div>
			<div title="受灾人口" data-options="href:'<%=basePath%>Main/lostAnls/getLostList?column=ev_participationnumber&sdate=${sdate}&edate=${edate}'"></div>
		--%>
			<div title="经济损失" id="ev_economicloss"></div>
			<div title="受伤人数" id="ev_injuredpeople"></div>
			<div title="死亡人数" id="ev_deathtoll"></div>
			<div title="受灾面积" id="ev_affectedarea" ></div>
			<div title="受灾人口" id="ev_participationnumber"></div>
		</div>
	</div>
	<div data-options="region:'center', split:true" style="width:45%;">
		<div style="height:48%">
			<div style="padding-left:40px;background-color:#A4D3EE;font-size:15px;"><span id="nowpieinfo">当前</span></div>
		<div id="pieChart_now" style="width:100%;height:90%;margin:0 auto;" >
		</div>
		</div>
		<div style="height:48%">
			<div style="padding-left:40px;background-color:#A4D3EE;font-size:15px;"><span id="lastpieinfo">上年同期</span></div>
			<div id="pieChart_last" style="width:100%;height:90%;margin:0 auto;" >
			
			</div>
		</div>
	</div>
</div>

		

