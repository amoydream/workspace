<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>

	.pBtn{
		width:145px;
		height:30px;
		line-height:28px;
		background:grey;
		display:block;
		text-align:center;
		border:1px solid white;
		border-radius:5px;
		color:white;
		text-decoration:none;
		margin-left:15px;
	}
	.pBtn:hover{
		background:#D6D6D6;
		color:black;
	}
	#actionTree li span{
		color:black;
	}
</style>

<script>
	var zTree = null;
	var settings = {
		data:{
			simpleData:{
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback:{ onClick: actionClick}
	};

	function actionClick(event, treeId, treeNode){
		var id = treeNode.id;
		var fid = treeNode.pid;
		var flag = treeNode.flag;
		if(fid&& flag=='005'){
			//事件升级
			var attrArry = {
					title: '事件升级',
					width:600,
					height:400,
					modal:false,
					href:'<%=basePath%>Main/geographic/dispatch/getEventUpd?eventid=${eventid}&instid=${instid}&flag=${trainflag}'
				};
				$.lauvan.openCustomDialog("actEventUpdDialog", attrArry, null, "actEventUpdForm");
		}else if(fid){
			var param = {
				width:600,
				height:400,
				left:$("#commandmap").width()-600,
				top:$("#commandmap").height()-400,
				modal:false,
				buttons:[]
			};
			
			var temp = null;
			if(flag == '001'){ //通知人员
				temp = $.extend({}, param, {title:'通知联系人', 
					href:'<%=basePath%>Main/geographic/dispatch/getActionDept?instid=${instid}&phaseid='+id + '&eventid=${eventid}&trainflag=${trainflag}'});
			}else if(flag == '003' || flag=='004' || flag=='006'){
				temp = $.extend({}, param, {title:'应急指挥调度',height:500,top:$("#commandmap").height()-500,width:630,left:$("#commandmap").width()-630,
					href:'<%=basePath%>Main/geographic/dispatch/handleAct?instid=${instid}&planid=${planid}&phaseid='+id +'&eventid=${eventid}&trainflag=${trainflag}'});
			}

			if($("#norDialog").length>0){
				$("#norDialog").dialog('destroy');
			}
			$.lauvan.openCustomDialog("norDialog", temp, null, "norform");
		}
		
		
	}
	function showAction(instid, phaseid){
		$("#hptabs").tabs('select', 1);
		$.get("<%=basePath%>Main/geographic/dispatch/getProcess", 
				{instid: instid,phaseid: phaseid}, 
				function(data){
					$.fn.zTree.init($("#actionTree"), settings, data);
					zTree = $.fn.zTree.getZTreeObj('actionTree');
					zTree.expandAll(true);
		});
	}

	function endEvent(){
		$.messager.confirm('警告', '确认结束应急指挥？', function(r){
			if(r){
				$.post("<%=basePath%>Main/geographic/dispatch/endEvent", {eventid: ${eventid}}, function(result){
					if(result.success){
						$.lauvan.MsgShow({msg:'操作成功！'});
						setTimeout(function(){
							//parent.$("#gisiframe").attr("src", "<%=basePath%>Main/geographic/dispatch");
							var tab = parent.$("#mainTab").tabs('getSelected');
							var url = "<%=basePath%>Main/geographic/dispatch";
							tab.panel('refresh', url);
						}, 2000);
					}else{
						$.lauvan.MsgShow({msg:result.msg});
					}
				});
			}
		});
	}

	function addCmdPos(){
		var param = {
				title:'成立现场指挥部', 
				width:680,
				height:500,
				left:$("#commandmap").width()-680,
				top:$("#commandmap").height()-500,
				modal:false,
				buttons:[],
				href:'<%=basePath%>Main/geographic/dispatch/addCmdPos/${planid}-${eventid}'
			};
		$.lauvan.openCustomDialog("cmdPosDialog", param, null, "cmdPosform");
	}
</script>
<div  id="hptabs" class="easyui-tabs" data-options="fit:true" style="width:100%;">

	<div title="处置阶段">
		<div id="pbox" style="text-align:center;padding-top:10px;">
			<a href="#" class="pBtn">启动预案</a>
			<img style="width:20px;heigth:30px;" src="<%=basePath%>images/jiantou.png"/>
			<c:forEach items="${pList}" var="p" varStatus="v">
				<c:choose>
					<c:when test="${p.flag == '002'}">
						<a href="javascript:addCmdPos();" class="pBtn">${p.phasename}</a>
					</c:when>
					<c:otherwise>
						<a href="javascript:showAction('${p.instid}','${p.phaseid}');" class="pBtn">${p.phasename}</a>
					</c:otherwise>
				</c:choose>
				<img style="width:20px;heigth:30px;" src="<%=basePath%>images/jiantou.png"/>
			</c:forEach>
			<a href="javascript:endEvent();" class="pBtn">应急结束</a>
		</div>
	</div>
	
	<div title="处置步骤">
		<ul id="actionTree" class="ztree"></ul>
	</div>

</div>