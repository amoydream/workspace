<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script src="<%=basePath %>plugins/gis/plugins/flowplayer/flowplayer.min.js"></script>
<script type="text/javascript">
$(function(){
	var path="${path}",type="${type}";
	var defaultPoint=new BMap.Point(${lng},${lat}),zoomLevel=${zoom};
	var map = new BMap.Map("map");    // 创建Map实例
	map.centerAndZoom(defaultPoint,zoomLevel);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

	var marker = new BMap.Marker(defaultPoint); 
	marker.addEventListener("click",function(e){
		var content="";
		if(type=='0'){
			content="<div style='margin:5px 10px;'>";
			content+="<img src='<%=basePath%>Main/geographic/common/download?path="+path+"'/></div>";
		}else{
			content="<div style='margin:5px 10px;height:97%;overflow:hidden;'>";
			content+="<a href='<%=basePath%>Main/geographic/common/download?path="+path+"' style='display:block;width:100%;height:96%' id='player'></a></div>";
			content+="<script>(function(){flowplayer('player', '<%=basePath%>plugins/gis/plugins/flowplayer/flowplayer-3.2.5.swf');})();<\/script>";
		}

			$.lauvan.openCustomDialog("mediaDlg",{
				title:'详细情况',
				width: 800,
			    height: 540,
			    iconCls:'icon-applicationform',
				content:content,
				buttons:[{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						parent.$("#mediaDlg").dialog('close');
					}
				}]
			},null,null);
	});
	map.addOverlay(marker);    //增加点

});


</script>
<div id="map" style="width:100%;height:100%;"></div>