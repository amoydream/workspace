<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/inc.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<script src="<%=basePath %>js/jquery-ui.custom.min.js"></script>
<script type="text/javascript">
	var nowdate = new Date();
	var nowd = nowdate.getDate();
	var nowm = nowdate.getMonth();
	var nowy = nowdate.getFullYear();
	var movetime;
	$(document).ready(function(){
			setScheduleTemplates();
		$("#calendarxx").fullCalendar( {
			header:{
				left: 'month, agendaWeek, agendaDay',
				//left:'month',
				center: 'title',
				right: 'prev, next'
			},
			<c:if test="${! empty type}" >
			defaultView:'${type}',
			</c:if>
			weekMode: 'liquid',
			editable : true,
			droppable : true,
			selectable : true,
	        selectHelper : true,
			theme : true,
			height : 400,
			weekends : true,
			//disableDragging : true,
			disableResizing : true,
			buttonText: {
				today: '今天',
				month: '月',
				week: '周',
				day: '日'
			},
			monthNames: ['一月','二月','三月','四月','五月','六月',
						'七月','八月','九月','十月','十一月','十二月'
						],
			monthNamesShort: ['一月','二月','三月','四月','五月','六月',
						'七月','八月','九月','十月','十一月','十二月'
						],
			dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
			dayNamesShort: ['日','一','二','三','四','五','六'],
			firstDay : 0,
		    timeFormat: {
				'': 'HH:mm TT'
			},
			
				/* <c:if test="${! empty calendars}">
				events:[
				<c:forEach items="${calendars}" var="c" varStatus="vs">
					{
					<c:if test="${1==c.cal_type}">
					color: 'red',
			        textColor: 'yellow',
			         </c:if>
						start: new Date('<fmt:formatDate value="${c.startdate}"  pattern="yyyy-MM-dd"/>'),
						end: new Date(Date.parse('<fmt:formatDate value="${c.enddate}" pattern="yyyy-MM-dd"/>')),
						allDay : true,
					id:'${c.id}',
         			title:'${c.leadername}'
					}<c:if test="${(vs.index+1)!=fn:length(calendars)}">,</c:if>
				</c:forEach>  
					],</c:if> */
			events:function(start, end, timezone,callback) {
				var view = $('#calendarxx').fullCalendar('getView');
				 $("#calendarxx").fullCalendar('removeEvents');
		        $.post("<%=basePath%>Main/onduty/getcalendars",{startDate:view.start.format("yyyy-MM-dd"),type:view.name}, function(data) {
		        	var result=data.calendars;
		        	if(result) {
				        for(var i = 0; i < result.length; i++) {
					        var vo = result[i],color='';
					        if(vo.DUTYPOST=='0001'){
					        	color="rgb(181,196,2)";
					        }else if(vo.DUTYPOST=='0002'){
					        	color="rgb(1,149,175)";
					        }else{
					        	color="rgb(4,172,92)";
					        }
					        var schedule={
					        		id : vo.ID,
						            title :vo.LEADERNAME,
						            start :vo.STARTDATE,
						            end:vo.ENDDATE,
						            allDay : true,
						            color:color
					        };
					        $("#calendarxx").fullCalendar('renderEvent',schedule,true);
				        }
			        }
		        });
	        },
		    eventClick: function(calEvent,jsEvent,view){
		    	var attrArray={
						title:'值班列表',
						height: 400,
						width:700,
						//data:{"time":calEvent.start.format("yyyy-MM-dd")},
						href: '<%=basePath%>Main/onduty/list/'+calEvent.start.format("yyyy-MM-dd"),
						buttons:[]
				};
				$.lauvan.openCustomDialog("ondutylistDialog",attrArray,null,null);
		    },
		    eventDrop:function( event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view ) { 
		    	$.ajax({
	            	url:'<%=basePath%>Main/onduty/ondutydrop?id='+event.id+'&time='+event.start.format("yyyy-MM-dd")+'&type=d',
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'移动成功！'});       			
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    },
		    drop: function(date, jsEvent, ui, resourceId) {
		    	var _eventObj = $(this).data('eventObject');
		    	var $eventClass = $(this).attr('data-class');
		        var eventObj = $.extend({}, _eventObj);
		    	$.ajax({
	            	url:'<%=basePath%>Main/onduty/ondutydrop?id='+eventObj.duty_id+'&time='+date.format("yyyy-MM-dd")+'&type=m',
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'新增成功！'});
	            			/* var view = $('#calendarxx').fullCalendar('getView');
	        				var mainTab=$("#mainTab");
	        				var tab = mainTab.tabs('getSelected');
	        				tab.panel('refresh','Main/onduty/index?startDate='+data.time+'&type='+view.name); */
	        				var view = $('#calendarxx').fullCalendar('getView');
	            			$.ajax({
	        	            	url:'<%=basePath%>Main/onduty/getcalendars?startDate='+view.start.format("yyyy-MM-dd")+'&type='+view.name,
	        	            	type:'post',
	        	            	traditional:true,
	        	            	success:function(data){
	        	            		$("#calendarxx").fullCalendar('removeEvents');
	        	            		var result=data.calendars;
	        			        	if(result) {
	        					        for(var i = 0; i < result.length; i++) {
	        						        var vo = result[i],color='';
	        						        if(vo.DUTYPOST=='0001'){
	        						        	color="rgb(181,196,2)";
	        						        }else if(vo.DUTYPOST=='0002'){
	        						        	color="rgb(1,149,175)";
	        						        }else{
	        						        	color="rgb(4,172,92)";
	        						        }
	        						        var schedule={
	        						        		id : vo.ID,
	        							            title :vo.LEADERNAME,
	        							            start :vo.STARTDATE,
	        							            end:vo.ENDDATE,
	        							            allDay : true,
	        							            color:color
	        						        };
	        						        $("#calendarxx").fullCalendar('renderEvent',schedule,true);
	        					        }
	        				        }	
	        	            	}
	        	            });
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            }); 
		    }
		});
		jQuery('.fc-button-prev').bind('click', cprev);
		jQuery('.fc-button-next').bind('click', cnext);
		$("#calendarxx").fullCalendar('gotoDate', 
						<fmt:formatDate value="${startDate}" pattern="yyyy"/>, 
						<fmt:formatDate value="${startDate}" pattern="MM"/>-1,
						<fmt:formatDate value="${startDate}" pattern="dd"/>
						)
	});
	
	function cprev(){
		 var view = $('#calendarxx').fullCalendar('getView');
		 /*$("#calendarxx").fullCalendar('removeEvents');		
		$.ajax({
        	url:'<%=basePath%>Main/onduty/getcalendars?startDate='+view.start.format("yyyy-MM-dd")+'&type='+view.name,
        	type:'post',
        	traditional:true,
        	success:function(data){
        		var result=data.calendars;
	        	if(result) {
			        for(var i = 0; i < result.length; i++) {
				        var vo = result[i];
				        var schedule={
				        		id : vo.ID,
					            title :vo.LEADERNAME,
					            start :vo.STARTDATE,
					            end:vo.ENDDATE,
					            allDay : true	
				        };
				        $("#calendarxx").fullCalendar('renderEvent',schedule,true);
			        }
		        }	
        	}
        }); */
		/* var mainTab=$("#mainTab");
		var tab = mainTab.tabs('getSelected');
		tab.panel('refresh','Main/onduty/index?startDate='+view.start.format("yyyy-MM-dd")+'&type='+view.name); */
		//navTab.reload("Main/onduty/"+view.start.format("yyyy-MM-dd")+"_"+view.name);
		$("#startDate").datebox('setValue',view.start.format("yyyy-MM-dd"));
	}
	function cnext(){		
		var view = $('#calendarxx').fullCalendar('getView');	
		/* $("#calendarxx").fullCalendar('removeEvents');
		$.ajax({
        	url:'<%=basePath%>Main/onduty/getcalendars?startDate='+view.start.format("yyyy-MM-dd")+'&type='+view.name,
        	type:'post',
        	traditional:true,
        	success:function(data){
        		var result=data.calendars;
	        	if(result) {
			        for(var i = 0; i < result.length; i++) {
				        var vo = result[i];
				        var schedule={
				        		id : vo.ID,
					            title :vo.LEADERNAME,
					            start :vo.STARTDATE,
					            end:vo.ENDDATE,
					            allDay : true	
				        };
				        $("#calendarxx").fullCalendar('renderEvent',schedule,true);
			        }
		        }	
        	}
        }); */
		/*var mainTab=$("#mainTab");
		var tab = mainTab.tabs('getSelected');
		tab.panel('refresh','Main/onduty/index?startDate='+view.start.format("yyyy-MM-dd")+'&type='+view.name); */
		//navTab.reload("Main/onduty/"+view.start.format("yyyy-MM-dd")+"_"+view.name);
		$("#startDate").datebox('setValue',view.start.format("yyyy-MM-dd"));
	}
	
	function cday(date, allday, jsEvent, view){
		if (allday) {
            alert('Clicked on the entire day: ' + date);
        } else{
            alert('Clicked on the slot: ' + date);
        }

        alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);

        alert('Current view: ' + view.name);
        $(this).css('background-color', 'red');
	}
	function addondyty(type,time){
		time=time.replace("-","t");
		time=time.replace("-","t");
		var attrArray={
				title:'新增值班',
				height: 400,
				href: '<%=basePath%>Main/onduty/ondutyadd/'+type+"-"+time,
		};
		
		$.lauvan.openCustomDialog("ondutyDialog",attrArray,onduty_dialogSubmit,'onduty_form');
		
	}
	function onduty_dialogSubmit(){
  		$('#onduty_form').form('submit',{
  			onSubmit:function(param){
  				var username=$('#username').textbox('getValue');
  				var dept=$('#dept').textbox('getValue');
  				var tel=$('#tel').textbox('getValue');
  				if(username==""||dept==""||tel==""){
  					$.messager.alert('错误','存在必填项未填，请检查！','error');
  	                return false;	
  				}
  				var regBox = { 
  						regMobile:/^0?1[3|4|5|8][0-9]\d{8}$/
  						    }
  				var tflag = regBox.regMobile.test(tel);
  				if(!tflag){
  					$.messager.alert('错误','电话格式输入有误！','error');
  	                return false;
  				}
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
				var view = $('#calendarxx').fullCalendar('getView');
				var mainTab=$("#mainTab");
				var startDate = $("#startDate").datebox('getValue');
				var tab = mainTab.tabs('getSelected');
				tab.panel('refresh','Main/onduty/index?startDate='+startDate+'&type='+view.name);
			}
		});
  	}
	function finduser(){
		var attrArray={
				title:'选择人员',
				width:600,
				height:500,
				href: '<%=basePath%>Main/onduty/getUsers',
				buttons:[
	{
		text:'确定',
		iconCls:'icon-save',
		handler:function(){
			var account="";
			var name="";
			var dept="";
			var tel="";
			var node = $("#usersGrid").datagrid('getSelected');
			account=node.USER_ACCOUNT;
			name=node.USER_NAME;
			dept=node.D_NAME;
			tel=node.BO_MOBILE;
			document.getElementById('useraccount').value=account;
			$("#username").textbox('setValue',name);
			$("#dept").textbox('setValue',dept);
			$("#tel").textbox('setValue',tel);
			$("#userDialog").dialog('close');
		}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#userDialog").dialog('close');
		}
	}
				         ]
		}; 
		$.lauvan.openCustomDialog("userDialog",attrArray,null,null);
	}
	
	function exportzb(){
		var startDate = $("#startDate").datebox('getValue');
		window.location.href("Main/onduty/dutyexp?startDate="+startDate);	
	}
	function setScheduleTemplates() {
	    $.post("Main/onduty/getmoudle", {}, function(data) {
	    	   var result=data.result;
		        if(result) {
			        var tmplHtml = '';
			        for(var i = 0; i < result.length; i++) {
				        var vo = result[i],prop="",color='',leader='';
				        if(vo.DUTYPOST=='0001'){
				        	prop = "带班领导";
				        	//color="241,253,28";
				        	color="181,196,2";
				        }else if(vo.DUTYPOST=='0002'){
				        	prop = "值班领导";
				        	//color="166,255,249";
				        	color="1,149,175";
				        }else{
				        	prop = "值班干部";
				        	//color="254,166,166";
				        	color="4,172,92";
				        }
				        	
				        tmplHtml += '<div style="border:1px #000 solid;border-top-right-radius:10px; border-top-left-radius:5px; border-bottom-left-radius:6px; border-bottom-right-radius:20px; width:50px; height:50px; background:#f60;background-color:rgb('+color+');width:100%;height:20px;line-height:20px; padding:5px 0;" id="tempDelete'+ vo.ID+ '" prop="'+ vo.ID+ '" class="external-event label-success" data-class="label-success"><span style="width:20px; height:20px;display:block;float:left;"><img src="<%=basePath %>images/flag.png" /></span> '
				                    + vo.LEADERNAME + ' (' + prop + ')'
				                    + ' <a href="javascript:void(0);" onclick="delmoudle('+vo.ID+')"><img src="<%=basePath %>images/del.png" style="border:0;float:right;" /></a></div><br>';
			        }
			        $("#external-events").html(tmplHtml);
			        $.parser.parse($("#external-events"));
			        $('#external-events .external-event').each(function(i, div) {
				        var ss = $(div).attr("prop");
				        var eventObject = {
				            title : $.trim($(this).text()),
				            duty_id : ss
				        };
				        $(this).data('eventObject', eventObject);
				        $(this).draggable({
				            zIndex : 999,
				            revert : true,
				            revertDuration : 0
				        });
			        });
		        }
	        });
    }
	function delmoudle(id){
		$.messager.confirm('删除','您确定删除此值班模板吗？',function(r){
		    if (r){
		       $.ajax({
	            	url:'<%=basePath%>Main/onduty/ondutydel?ids='+id,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#ondutyGrid").datagrid('clearSelections');
	            			$("#ondutyGrid").datagrid('clearChecked');
	            			$("#ondutyGrid").datagrid('reload');
	            			var view = $('#calendarxx').fullCalendar('getView');
	            			var mainTab=$("#mainTab");
	            			var startDate = $("#startDate").datebox('getValue');
	            			var tab = mainTab.tabs('getSelected');
	            			tab.panel('refresh','Main/onduty/index?startDate='+view.start.format("yyyy-MM-dd")+'&type='+view.name);
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function onduty_doSearch(){
		/* var view = $('#calendarxx').fullCalendar('getView');
		var mainTab=$("#mainTab");
		var startDate = $("#startDate").datebox('getValue');
		var tab = mainTab.tabs('getSelected');
		tab.panel('refresh','Main/onduty/index?startDate='+startDate+'&type='+view.name); */
		var startDate = $("#startDate").datebox('getValue');
		var month=parseInt(startDate.substring(5,7));
		 $("#calendarxx").fullCalendar('gotoDate', 
				startDate.substring(0,4), 
				month-1,
				startDate.substring(5,7)
				); 
	}
</script>

<div id="calendar_main">
<div class="pageHeader">
	<form id="searchform"  method="post">
	<!-- <div class="searchBar"> -->
	<div data-options="region:'north',border:false" style="padding: 0px;background:#f7f7f7;">
		<table class="searchContent">
			<tr>
				<td>
					日期：
				</td>
				<td>
					 <%-- <input type="text" name="startDate" class="date" id="startDate"
						value="<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>"/>
						<input type="text" value="${startDate}"> --%>
 					<input  type="text" class="easyui-datebox" id="startDate"  value="<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>" data-options="required:true" editable="false" style="width: 150px;"></input>
				</td>
				<td>
					<div class="subBar">
						<ul>
							<li>
								<div class="buttonActive">
									<div class="buttonContent">
									<table>
									<tr>
									<td>
										<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="onduty_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
										</td>
										<c:if test="${!pert:hasperti(applicationScope.ondutyadd, loginModel.xdlimit)}">
										<td><div class="datagrid-btn-separator"></div></td>
										<td><a href="javascript:void(0);" onclick="addondyty('c','')" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a> </td>
										</c:if>
										<c:if test="${!pert:hasperti(applicationScope.ondutyexp, loginModel.xdlimit)}">
										<td><div class="datagrid-btn-separator"></div></td>
										<td><a href="javascript:void(0);" onclick="exportzb()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">导出值班表</a></td>
										</c:if>
									</tr>
									</table>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
	</div>
	</form>
</div>
<div class="pageContent">
	 <!-- <div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="Main/onduty/addip" target="dialog" mask="true" drawable="false" 
				resizable="false" maxable="false" rel="useradd" title="日程信息添加" 
				width="600" height="360"><span>添加</span></a></li>
		</ul>
	</div> --> 
<!-- 滑动模块 -->
<div style="float:left;word-break:break-all;margin-top:36px; width:19%;padding: 5px;background:#f7f7f7;">
    <div id="external-events"></div>
   </div>
		<div style="height: 100%; width: 80%; position: relative; float:right;z-index:0">
			<div id="calendarxx" style="background: #fff;"></div>
		</div>
	</div>	
</div>