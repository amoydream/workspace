<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script src="<%=basePath %>plugins/gis/plugins/flowplayer/flowplayer.min.js"></script>
<script type="text/javascript">
var point={};
require(["<%=basePath%>plugins/gis/frame/arcgisFrame.js","dojo/on"],function(AGis,on){
	
	var lng=${lng},lat=${lat},apiUrl="${apiUrl}",gisUrl="${gisUrl}",path="${path}",type="${type}",zoom=${zoom};
	var map=new AGis("map",lng,lat,gisUrl,apiUrl,zoom);

	
	map.addEvent("load",function(){
		var mapPoint=map.getPoint(lng,lat);
		point.lng=lng;
		point.lat=lat;
		map.drawPicture("<%=basePath%>plugins/gis/css/img/donghua.gif",32,32,mapPoint);
		on(map.map.graphics,"click",function(evt){
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
	});
	

});
</script>
<div style="position:absolute;top:25px;left:0;z-index:9999;background:#EDF4FF; font-size:14px;color:red;line-height:20px;margin:5px 10px;padding:5px;">温馨提示：在地图上鼠标左键单击即可获取点坐标，滚动滚轮可放大缩小地图</div>
<div id="map" style="width:100%;height:98%;"></div>