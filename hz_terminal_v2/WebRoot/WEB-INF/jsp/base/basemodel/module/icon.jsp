<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script type="text/javascript" src="<%=basePath %>plugins/easyui/customicon/icon.js"></script>

<div>
	<div id="icon_panel" class="icon_panel" style="width: 540px; height: 260px" align="center">
		Loading...
	</div>
	<div class="easyui-panel" style="text-align: center;padding-top: 5px;" data-options="border:false">
		<a id="btmPreviousPage" href="javascript:void(0);" onclick="previousIconPage();" class="easyui-linkbutton" data-options="iconCls:'resultsetprevious'">上一页</a>
		<span id="pageInfo"></span>
		<a id="btmNextPage" href="javascript:void(0);" onclick="nextIconPage();" class="easyui-linkbutton" data-options="iconCls:'resultsetnext'">下一页</a>
	</div>
</div>
<input id="icon" type="hidden">
<input id="parentDialog" type="hidden"/>
<script type="text/javascript">
	
	var iconPage = 0; // 页面号
	var iconSize = $.eovaIconData.length; // 图标总数
	console.log(iconSize);
	var columnSize = 20; // 图标列数
	var rowSize = 10; // 图标行数
	var iconPageSize = rowSize * columnSize; // 每页图标数
	var iconPageCount = parseInt(iconSize / iconPageSize) + 1; // 页面大小
	
	function refreshIconPanel(pageIndex){
		// 显示页号
		$("#pageInfo").html("&nbsp;" + (pageIndex + 1) + " / " + iconPageCount + "&nbsp;");
		var iconPanel = $("#icon_panel"); // 图标面板

		// 计算图标数组坐标偏移量
		var start = pageIndex * iconPageSize;
		var end = start + iconPageSize;
		// 如果结束位置大于图标数，则结束位置等于图标数
		if(end > iconSize) end = iconSize;
		// 清除图标面板
		iconPanel.empty();
		// 增加图标
		for(var i = start;i < end; i++){
			var iconName = $.eovaIconData[i];
			var btn = $('<a iconname="' + iconName + '" href="#" title="' + iconName + '"class="easyui-linkbutton"></a>');
			btn.linkbutton({iconCls: "" + iconName +""}).appendTo(iconPanel);
		}
		$(".icon_panel a").click(function(){
			$('#icon').val($(this).attr("iconname"));
			iconCallbacks.fire();
			iconCallbacks.empty();
		});
	}
	
	// 显示下一页图标
	function nextIconPage(){
		if((iconPage + 1) == iconPageCount) return;
		iconPage++;
		if(iconPage == (iconPageCount - 1)){
			$('#btmNextPage').linkbutton('disable');
		} else {
			$('#btmNextPage').linkbutton('enable');
		}
		$('#btmPreviousPage').linkbutton('enable');
		refreshIconPanel(iconPage);
	}
	
	// 显示上一页图标
	function previousIconPage(){
		if((iconPage - 1) < 0) return;
		iconPage--;
		if(iconPage == 0){
			$('#btmPreviousPage').linkbutton('disable');
		} else {
			$('#btmPreviousPage').linkbutton('enable');
		}
		$('#btmNextPage').linkbutton('enable');
		refreshIconPanel(iconPage);
	}

	window.setTimeout(function(){
		$('#btmPreviousPage').linkbutton('disable');
		refreshIconPanel(iconPage);
	},10);
	/*
	// 初始显示第一页图标
	$(document).ready(function(){
		$('#btmPreviousPage').linkbutton('disable');
		refreshIconPanel(iconPage);
	});
	*/
	// ****************************************
	// Thanks,The Author By HuGao
	// ****************************************
	
	var iconCallbacks = $.Callbacks();
	var selectIcon = function($dialog, $linkbutton) {
		var imgUrl = $('#icon').val();
		
		//sp.removeClass();
		sp.linkbutton({iconCls:imgUrl});
		//sp.addClass("combo-arrow").addClass(imgUrl);
		
		//$input.val(imgUrl);
		$dialog.dialog('close');
	};
	
</script>