<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>政府综合应急平台</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="">
<%@ include file="/include/header.jsp"%>
<%@ include file="/include/ccms.jsp"%>
<style type="text/css">
.tree-node {
	height: 28px;
}

.tree-node span {
	margin: 5px auto;
}

#skinlist {
	display: block; height: 20px; margin: 0px; padding: 0px; overflow: hidden; list-style: none;
}

#skinlist li {
	cursor: pointer; float: left; height: 14px; width: 14px; border-radius: 5px; border: 2px solid #dfdfdf;
	margin-right: 5px;
}

#skinlist li:hover {
	border: 2px solid #FF3;
}

#s1 {
	background: #09F;
}

#s2 {
	background: #666;
}

#s3 {
	background: #F33;
}

#s4 {
	background: #C60;
}
</style>
<script>
<c:if test="${empty AIOFLAG}">
var GIS_CHILD_WINDOW_OBJ=null;
</c:if>
<c:if test="${!empty AIOFLAG}">
var GIS_CHILD_WINDOW_OBJ= $("#GISMap_aio",parent.document)[0].children.overviewgis.contentWindow;
</c:if>
function openGlobalGISWindow(){
	if(GIS_CHILD_WINDOW_OBJ==null){
		var url="<%=basePath%>Main/geographic/overall/main";
		GIS_CHILD_WINDOW_OBJ=window.open(url,'GISMap','height=700,width=1010,top=0,left=0,toolbar=no,titlebar=no,menubar=no,scrollbars=no,resizable=yes,location=no, status=yes');
	}
	//window.setTimeout(drawGISPic,2000);
}

function destroyGISWindowHandler(){
	GIS_CHILD_WINDOW_OBJ=null;
}

/**在全景地图画点
 * pointList:[{"lng":114.234,"lat":23.43435,"url":""}]
 */
function drawGISPic(pointList){
	if(GIS_CHILD_WINDOW_OBJ){
		var picPath="<%=basePath%>plugins/gis/css/img/donghua.gif";
		
		GIS_CHILD_WINDOW_OBJ.drawGisPic(pointList,"globalLayer");
	}
}


	$(document).ready(function(){
		if('${sysmlayout}'=='1'){
			$('.new_nav li a').bind('click',function(){  
				$(".new_nav li").find("a").removeClass("selected");
				$(this).addClass("selected");
			});
			<c:if test="${ not empty rootMenu}">
			$("#menu_${rootMenu.id}").trigger("click");
			</c:if>
			<c:if test="${empty rootMenu}">
			$(".new_nav ul li:first a").trigger("click");
			</c:if>
		}else{
			addAccordion();
			addMenuClick();
		}
		changeThemeFun('${syscolor}');
		//默认打开
		if('${clickflag}'=='defopen'){
			if(${jsonNode}.ID!=337)
				addTab(${jsonNode});
		}

		//判断导航条按钮是否显示
		if(GetObj('List1_1').scrollWidth>=(GetObj('blk_navDIV').scrollWidth-20)){
			$("#blk_18_rightDIV").show();
		}
	});

	function addAccordion(){
		<c:if test="${empty fmenuList}">
		$.post('<%=basePath%>Main/getMenu/0', null,
				function (data, textStatus){
					for(var i in data){
						$("#menu").accordion('add',{title:data[i].NAME,selected: i==0,href:'<%=basePath%>Main/menu/'+data[i].ID});
					}
					
				}, "json");
		</c:if>
		<c:if test="${!empty fmenuList && !empty sysmlayout}">
		<c:forEach items="${fmenuList}" var="fmenu">
        <c:if test="${pert:hasperti(fmenu.id, loginModel.limit)}">
		$.post('<%=basePath%>Main/getMenu/${fmenu.id}', null,
				function (data, textStatus){
					for(var i in data){
						$("#menu").accordion('add',{title:data[i].NAME,selected: i==0,href:'<%=basePath%>Main/menu/'+data[i].ID});
					}
					
				}, "json");
		</c:if>
		</c:forEach>
		</c:if>
		<c:if test="${!empty fmenuList && empty sysmlayout}">
		$.post('<%=basePath%>Main/getMenu/0', null,
				function (data, textStatus){
					for(var i in data){
						$("#menu").accordion('add',{title:data[i].NAME,selected: i==0,href:'<%=basePath%>Main/menu/'+data[i].ID});
					}
					
				}, "json");
		</c:if>
	}

	function addMenuClick(){
		$(".easyui-accordion .easyui-tree").each(function(index,element){
			$(this).tree({
				onClick:function(node){
					if(node.children){
						$(this).tree('expand', node.target);
					}
					else
						addTab(node);
				}
				/*,loadFilter:function( data,node){
					var dlen = data.length;
					for(var i=0;i<dlen;i++){
						var attributes = {};
						attributes['onlytext'] = data[i].onlytext;
						data[i]['attributes'] = attributes;
					}
					return data;
				}*/
			});
		});
	}

	function addTab(node){
		var mainTab=$("#mainTab");
		var ntext = node.text;
		if('${tabflag}'!=null && '${tabflag}'!=''){
			ntext = 0;
			var otext = node.onlytext.split(",");
			var notext = "";
			for(var i=(otext.length-1);i>=0;i--){
				if(notext==""){
					notext = otext[i];
				}else{
					notext = notext+">>"+otext[i];
				}
			}
			node.text = notext;
		}
	    if (mainTab.tabs('exists', ntext)){
	    	mainTab.tabs('select', ntext);
	    	// 调用 'refresh' 方法更新选项卡面板的内容
	    	var tab = mainTab.tabs('getSelected');  // 获取选择的面板
	    	if('${tabflag}'!=null && '${tabflag}'!=''){
	    	mainTab.tabs('update', {
	    		tab: tab,
	    		options: {
	    			//content:'<iframe scrolling="auto" frameborder="0"  src="'+node.url+'" style="width:100%;height:100%;"></iframe>'
	    			title:node.text,
	    			iconCls:node.iconCls
	    		}
	    	});
	    	}
	    	tab.panel('refresh', node.url);
	    } else {
		    if(node.url){
		        //var content = '<iframe scrolling="auto" frameborder="0"  src="'+node.url+'" style="width:100%;height:100%;"></iframe>';
		        mainTab.tabs('add',{
		            title:node.text,
		           // content:content,
		           href:node.url,
		            iconCls:node.iconCls,
		            closable:true
		        });
		    }
	    }
	}

	function setPassword(){
		var attrArray={
				title:"修改密码",
				href: '<%=basePath%>Main/pwordset',
				height:200
		};
		$.lauvan.openCustomDialog("pwdDialog",attrArray,null,'pwd_form');
	}
	function setSystem(){
		var attrArray={
				title:"系统设置",
				href: '<%=basePath%>Main/systemSet',
				height:600,
				width :600
		};
		$.lauvan.openCustomDialog("sysSetDialog",attrArray,sysSetSubmit);
	}
	function sysSetSubmit(){
		$('#sysSet_form').form('submit',{
  			onSubmit:function(){
  				var fboolean = $(this).form('enableValidation').form('validate');
  				if(!fboolean){
  					$.messager.alert('警告','请按要求填写信息！');
  				}
				return fboolean;
			},
			success:function(result){
				var obj=$.parseJSON(result);
				if(obj.success){
					$("#sysSetDialog").dialog('close');
					var defaults={title:'提示',msg:"设置成功！",timeout:1000,showType:'slide',style:{right:'',bottom:''}};
					$.messager.show(defaults);
					window.location.reload();
				}
			}
		});
	}
	var _tabCurrent_index=0;
	var _tabtitle="";
	function tabsMenu(e, title,index){
		e.preventDefault();
		_tabCurrent_index = index;
		_tabtitle = title;
		$("#tabmenus").menu('show', {    
			left: e.pageX,
            top: e.pageY  
			});  
	}
	function tabMenuClick(item){
		var mainTab = $("#mainTab");
		var name = item.name;
		var MainTabs = mainTab.tabs('tabs');;
		if('current'==name){
			mainTab.tabs('close',_tabtitle);
		}else if('all'==name){
			var tabs = [];
			for(var j=0;j<MainTabs.length;j++){
				tabs.push(MainTabs[j]);
			}
			for(var i=0;i<tabs.length;i++){
				mainTab.tabs('close',0);
			}
		}else if('clOth'==name){
			var tabs = [];
			for(var j=0;j<MainTabs.length;j++){
				tabs.push(MainTabs[j]);
			}
			for(var i=0;i<tabs.length;i++){
				var tabtitle = tabs[i].panel('options').title;
				if(tabtitle!=_tabtitle){
					mainTab.tabs('close',tabtitle);
				}
			}
		}else if('clRight'==name){
			var tabs = [];
			for(var j=0;j<MainTabs.length;j++){
				tabs.push(MainTabs[j]);
			}
			for(var i=_tabCurrent_index;i<tabs.length;i++){
				mainTab.tabs('close',_tabCurrent_index+1);
			}
		}else{
			var tabs = [];
			for(var j=0;j<MainTabs.length;j++){
				tabs.push(MainTabs[j]);
			}
			for(var i=0;i<_tabCurrent_index;i++){
				mainTab.tabs('close',0);
			}
		}
		
		
	}

	//一级菜单
	function firstMenuClick(menuid){
		//清空
		var panels = $('#menu').accordion('panels');
		var rleng = panels.length;
		for(var j=0;j<rleng;j++){
			$('#menu').accordion('remove',0);
		}
		$.post('<%=basePath%>Main/getMenu/'+menuid, null,
				function (data, textStatus){
					for(var i in data){
						$("#menu").accordion('add',{title:data[i].NAME,selected: i==0,href:'<%=basePath%>Main/menu/'+data[i].ID});
					}
					
		}, "json");
		
	}

	//一体机退出方法
	function aioLogOut(){
		parent.location.href = "<%=basePath%>AIOLogin/logout";
	}

	//统一修改事件链接入口（eventid：事件id，estate:事件性质）
	function _eventEditFN(eventid, estate, ename, onclose) {
		if(typeof(eventid) == 'undefined' || eventid == null) {
			return '';
		}
		var vn = typeof(ename) == 'undefined' || ename == null? '' : ename;
		return "<a class=\"event_link\" href=\"javascript:void(0);\" onclick=\"_eventOpenEdit('"+estate+"',"+eventid+",'" + onclose + "')\" >" + vn + "</a>";
		
	}
	function _eventOpenEdit(flag, eid, onclose){
		if(flag=='00X'){
			var dialogDef={
	  				title:'编辑突发事件',
					width:950,
					height:600,
					href: "Main/event/edit/"+eid,
					onClose : function() {
						$('#eventDialog').dialog('destroy');
						$('#eventDialog').remove();
						if(onclose){
							eval(onclose);
			    		}
					}
			};
			$.lauvan.openCustomDialog('eventDialog',dialogDef,null,'emerganceform');
		}else{
			var attrArray={
					title:'编辑日常事件',
					height: 550,
					width:800,
					href: 'Main/eventRoutine/edit/'+eid,
					onClose : function() {
						$('#eventDialog').dialog('destroy');
						$('#eventDialog').remove();
						if(onclose){
							eval(onclose);
			    		}
						//eval(onclose);
					}
			};
			
			$.lauvan.openCustomDialog("eventDialog",attrArray,null,'routineform');
		}
	}
	
	//添加电话 信息都工作联络网
	function tel_addWN(tel,pname){
		$.ajax({
        	url:'<%=basePath%>Main/personcontact/getEPersonAdd',
        	type:'post',
        	dataType:'json',
        	traditional:true,
        	data:{'phone':tel,'flag':'check'},
        	success:function(data){
        		if(data.success){
        			var phone,worknum,fax;
        			var reg = /^1\d{10}$/;
        			var reg2 = /^0?1[3|4|5|8][0-9]\d{8}$/;
        			if(reg.test(tel) && reg2.test(tel)) {
        				//手机
        				phone = tel;
        			}else{
        				//电话
        				worknum = tel;
        			}
        			var attrArray={
        					title:'新增日常机构联系人',
        					height: 450,
        					width:500,
        					href: '<%=basePath%>Main/personcontact/getEPersonAdd',
        					queryParams:{'phone':phone,'phname':pname,'worknum':worknum,'fax':fax},
        					onClose : function() {
        						$('#_epersonAddDialog').dialog('destroy');
        						$('#_epersonAddDialog').remove();
        					}
        			};
        			
        			$.lauvan.openCustomDialog("_epersonAddDialog",attrArray,null,'_epersonform');
        		}
        		else{
        			$.messager.alert('错误',data.msg,data.errorcode);
        		}
        	}
        });
		
	}
	
	$(function() {
		$userAgent = '${userAgent}';
		if($userAgent == 'IE' && window.opener == null) {
			var width = window.screen.width - 20;
			var height = window.screen.height - 80;
	    	var newwin = window.open('Main', '', 'toolbar=0,location=0,directies=0,status=0,menubar=0,scrollbars=no,resizable=1,left=0,top=0,width=' + width + ',height=' + height);
	    	window.opener= null;
			window.open('', '_self');
			window.close();
		}
	});

	</script>
</head>
<body class="easyui-layout">
	<c:choose>
		<c:when test="${!empty sysmlayout}">
			<div data-options="region:'north',border:false" class="head-line" style="height: 90px;">
		</c:when>
		<c:otherwise>
			<div data-options="region:'north',border:false" class="head-line" style="height: 60px;">
		</c:otherwise>
	</c:choose>
	<div style="height: 60px;">
		<!--4_29-->
		<div class="head-logo"
			style="text-align: left; float: left; height: 100%; width: 350px; font-size: xx-large; font-weight: 600;">
			<p class="logo-txt">
				<img src="images/logo.png"  style="float: left"/>
			</p>
		</div>
		<div style="float: right; margin-top: 4px; margin-left: 8px; margin-right: 8px;">
			<c:choose>
				<c:when test="${empty AIOFLAG}">
					<a href="<%=basePath%>Login/logout"> <strong>退出</strong></a>
				</c:when>
				<c:otherwise>
					<a href="javascript:void(0);" onclick="aioLogOut()"> <strong>退出</strong></a>
				</c:otherwise>
			</c:choose>
		</div>
		<div style="float: right; margin-top: 4px; margin-left: 8px;">
			<a href="javascript:void(0);" onclick="setPassword()"> <strong>密码修改 |</strong></a>
		</div>
		<div style="float: right; margin-top: 4px; margin-left: 8px;">
			<a href="javascript:void(0);" onclick="setSystem()"><strong>设置 |</strong></a>
		</div>
		<c:if test="${CCMSRole }">
		<div style="float: right; margin-top: 4px; margin-left: 8px;">
			<a href="javascript:void(0);" onclick="open_ccmsconsole();"><strong>呼叫中心 |</strong></a>
		</div>
		</c:if>
		<div class="zhanghuxinxi">
			<ul>
				<li>您好！${loginModel.userName}</li>
				<li>今天是： ${_zynowdate}</li>
			</ul>
		</div>
	</div>
	<!--4_29-->
	<c:if test="${!empty sysmlayout}">
		<div class="new_nav" id="blk_navDIV">
			<!--nav-->
			<DIV class="blk_18">
			<div id="blk_18_leftDIV" style="display: none;">
			<a onmouseup="ISL_StopUp_1()" class="LeftBotton" onmousedown="ISL_GoUp_1()" onmouseout="ISL_StopUp_1()" href="javascript:void(0);" target="_self">
			<img src="<%=basePath%>images/daohang/left.jpg" />
			</a>
			</div>
			<DIV class="pcont" id="ISL_Cont_1">
			<DIV class="ScrCont">
			<div id="List1_1"><!-- piclist begin -->
			<ul>
				<c:forEach items="${fmenuList}" var="fmenu">
					<c:if test="${pert:hasperti(fmenu.id,loginModel.limit)}">
						<li><a href="javascript:void(0);" id="menu_${fmenu.id}" onclick="firstMenuClick('${fmenu.id}')"><span>${fmenu.name}</span></a></li>
					</c:if>
				</c:forEach>
			</ul>
			</div>
			<div id="List2_1"></div><!--List2_1-->
			
			</div>
			</div>
			<div id="blk_18_rightDIV" style="display: none;">
			<a onmouseup="ISL_StopDown_1()" class="RightBotton" onmousedown="ISL_GoDown_1()" onmouseout="ISL_StopDown_1()" href="javascript:void(0);" target="_self">
			<img src="<%=basePath%>images/daohang/right.jpg" />
			</a>
			</div>
			</DIV>
		</div>
		<!--nav-->
	</c:if>
	</div>
	<div data-options="region:'west',split:true,title:'主菜单'" style="width: 200px;">
		<c:if test="${empty cebian || cebian=='1'}">
			<div id="menu" class="easyui-accordion" data-options="fit:true,border:false">
		</c:if>
		<c:if test="${!empty cebian && cebian=='2'}">
			<div id="menu" class="easyui-accordion cebian2" data-options="fit:true,border:false">
		</c:if>
		<c:if test="${!empty cebian && cebian=='3'}">
			<div id="menu" class="easyui-accordion cebian3" data-options="fit:true,border:false">
		</c:if>
		<c:if test="${!empty cebian && cebian=='4'}">
			<div id="menu" class="easyui-accordion cebian4" data-options="fit:true,border:false">
		</c:if>
	</div>
	</div>
	<div data-options="region:'south',border:false" class="foot-line accordion-header"
		style="height: 30px; padding: 5px; text-align: center;">
		Copyright @ 2016 <a href="http://www.lauvan.com" target="_blank">广东立沃信息股份有限公司</a>
	</div>
	<div data-options="region:'center'" style="border: none;">
		<div class="easyui-tabs" style="width: 100%;" data-options="fit:true,onContextMenu:tabsMenu" id="mainTab">
			<%--<div title="${tabNode.text}" data-options="iconCls:'${tabNode.iconCls}',closable:true" >
				This is the help content.
			</div>
		--%>
		</div>
	</div>
	<div id="tabmenus" class="easyui-menu" data-options="disabled:false,onClick:tabMenuClick" style="width: 120px;">
		<div data-options="name:'current'">关闭当前标签页</div>
		<div data-options="name:'all'">关闭所有标签页</div>
		<div data-options="name:'clOth'">关闭其他标签页</div>
		<div data-options="name:'clRight'">关闭右侧标签页</div>
		<div data-options="name:'clLeft'">关闭左侧标签页</div>
	</div>
	<iframe id="download_frame" style="display: none;"></iframe>
</body>
</html>
