<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <!--The viewport meta tag is used to improve the presentation and behavior of the samples
    on iOS devices-->
  <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no">
  <title>地理信息</title>
 <link rel="stylesheet" href="${apiUrl }/dijit/themes/tundra/tundra.css"/>
 <link rel="stylesheet" href="${apiUrl }/esri/css/esri.css"/>
 <link rel="stylesheet" href="<%=basePath %>plugins/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
 <link rel="stylesheet" href="<%=basePath %>plugins/gis/css/base.css"/>
 <style>
 .ztree li span{color:white;}
 .ztree li a.curSelectedNode{background-color: #565147;}
 .ztree.legend li span{color:black;}
 .ztree.legend li a.curSelectedNode{background-color: #FFE6B0;}
 .esriPopup .actionsPane{display:none;}
 
 .esriPopup .contentPane table{border-left:1px solid black;border-top:1px solid black;margin-left:10px;}
 .esriPopup .contentPane td,.esriPopup .contentPane th{padding:2px 5px;border-right:1px solid black;border-bottom:1px solid black;}
 </style>
 <script src="${apiUrl }/init.js"></script>
 <script src="<%=basePath %>plugins/gis/core/jquery.js"></script>
 <script src="<%=basePath %>plugins/easyui/jquery.easyui.min.js"></script>
 <script src="<%=basePath %>plugins/ztree/js/jquery.ztree.all-3.5.min.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/bigcolorpicker.js"></script>
 <script src="<%=basePath %>plugins/gis/frame/base2.js"></script>
 
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/default/easyui.css"/>
 <script src="<%=basePath %>js/main.js"></script>


<script>
  	var gisPath="<%=basePath%>plugins/gis";
  	var gisUrl="${gisUrl}";
    var map;
    require(["<%=basePath%>plugins/gis/plugins/coordtransform.js",
      "esri/map","dojo/on","dojo/dom","esri/lang","esri/Color","esri/geometry/Point","esri/toolbars/draw", "esri/geometry/webMercatorUtils", "esri/layers/FeatureLayer","esri/layers/GraphicsLayer",
       "esri/dijit/Legend","esri/symbols/TextSymbol","esri/symbols/Font",
      "dojo/_base/array", "dojo/parser","esri/geometry/Extent","esri/layers/ArcGISDynamicMapServiceLayer","esri/layers/ArcGISTiledMapServiceLayer","esri/dijit/Measurement","esri/units",
	  "esri/symbols/SimpleMarkerSymbol","esri/symbols/SimpleLineSymbol","esri/symbols/SimpleFillSymbol","esri/symbols/PictureMarkerSymbol","esri/graphic", "esri/dijit/OverviewMap","esri/dijit/Scalebar",
	  "esri/toolbars/navigation", "esri/dijit/HomeButton","esri/SpatialReference","esri/dijit/Bookmarks","esri/dijit/BookmarkItem","esri/InfoTemplate","dijit/TooltipDialog", "dijit/popup",
	  "esri/tasks/FindTask", "esri/tasks/FindParameters","esri/geometry/Polyline",
      "dijit/layout/BorderContainer", "dijit/layout/ContentPane", 
      "dijit/layout/AccordionContainer", "dojo/domReady!"
    ], function(
    	coordtransform,Map,on,dom,lang,Color,Point,Draw,webMercatorUtils,FeatureLayer,GraphicsLayer, Legend,TextSymbol,Font,
      arrayUtils, parser,Extent,ArcGISDynamicMapServiceLayer,ArcGISTiledMapServiceLayer,Measurement,Units,SimpleMarkerSymbol,
	  SimpleLineSymbol,SimpleFillSymbol,PictureMarkerSymbol,Graphic,OverviewMap,Scalebar,Navigation,HomeButton,SpatialReference,Bookmarks,BookmarkItem,
	  InfoTemplate,TooltipDialog, dijitPopup,FindTask,FindParameters,Polyline
    ) {

	$('<div id="maskDiv" class="mask-loading">Loading...</div>').appendTo($(document.body));
	 //系数
	 var scaleWeight=0.4,zoomWeight=1,baseLayerName="baseLayer";	
	 var eventHandler={},
	 	 removeEventHandler=function(eventName){
		 	if(eventHandler[eventName])
				eventHandler[eventName].remove();
	 	 },
	 	 replaceEventHandler=function(eventName,fn){
	 		removeEventHandler(eventName);
		 	eventHandler[eventName]=fn;
		 };

	/*begin*************定义相关函数******************/
		var addGraphicLayer=function(mapObj,dialogObj,id){
			//添加标注图层
			var graphicLayer=new GraphicsLayer({id:id});
			mapObj.addLayer(graphicLayer);
			if(!dialogObj.graphicLayer)dialogObj.graphicLayer={};
			dialogObj.graphicLayer[id]=graphicLayer;
			dialogObj.addCloseEvent("layerHide_"+id,function(){graphicLayer.hide();});
			dialogObj.addOpenEvent("layerShow_"+id,function(){graphicLayer.show();});
			graphicLayer.on("visibility-change",function(obj){
				if(!obj.visible){
					for(var i=0,len=graphicLayer.graphics.length;i<len;i++)
						if(mapObj.infoWindow.getSelectedFeature()==graphicLayer.graphics[i]){
							mapObj.infoWindow.hide();
							break;
						}
				}
			});
			graphicLayer.on("graphic-remove",function(graphic){
				if(mapObj.infoWindow.getSelectedFeature()==graphic.graphic)
					mapObj.infoWindow.hide();
			});
			return graphicLayer;
		};
	/*end*************定义相关函数******************/
	
	//初始化相关操作
     map=new Map("map",{
			 center:[${lng},${lat}],
			 zoom:14,
			 logo:false,
			 slider:false
			 });
		//var layer = new ArcGISDynamicMapServiceLayer(gisUrl,{id:baseLayerName});
		var layer=new ArcGISTiledMapServiceLayer(gisUrl,{id:baseLayerName});
		map.addLayer(layer);
		
		
		var scaleBar=new Scalebar({map:map,scalebarUnit:"metric"});
		var overviewMap=null,navToolbar=null,homeButton=null,measurement,bookmarks;
		
		
		navToolbar=new Navigation(map);
		$("body").append($("<div id=\"homeDiv\" style=\"display:none;\">"));
		homeButton = new HomeButton({
		  map: map,
		  visible: false
		}, "homeDiv");
		homeButton.startup();

		$("body").append("<div id=\"measurementDiv\" style=\"display:none;\">");
		measurement=new Measurement({
			map: map,
			defaultAreaUnit: Units.SQUARE_MILES,
			defaultLengthUnit: Units.KILOMETERS
		 }, "measurementDiv");
		measurement.startup();
		measurement.hide();
		measurement.on("measure-end", function(evt){
			alert(evt.values.toFixed(4)+evt.unitName);
			measurement.setTool("distance", false);
		});
		
		$("body").append("<div id=\"bookmarks\" style=\"display:none;\">");
		bookmarks = new Bookmarks({
			map: map,
			editable:true
		  }, "bookmarks");
		 // bookmarks.startup();

		on(map,"load",function(){
			$(function(){
				var yingyanBtn,shuqianBtn,printBtn,narrowBtn,enlargeBtn,zoomOutBtn,zoomInBtn,gobalBtn,handBtn,findBtn,signBtn,
					blueglassBtn,targetBtn,resourceBtn,userBtn,trackBtn,systemBtn,helpBtn,aboutBtn,homeBtn,legendBtn,hideBtn;
				var yingyanDlg,shuqianDlg,signDlg,systemDlg,blueglassDlg,resourceDlg,findDlg,targetDlg,legendDlg,aboutDlg,userDlg;
				//工具栏对象
				var toolbar=$.fn.toolBar.init($("#toolbar"));
				//鹰眼按钮对象
				yingyanBtn=toolbar.addItem("yingyan","缩略图","earth");
				shuqianBtn=toolbar.addItem("shuqian","书签","book");
				printBtn=toolbar.addItem("print","打印","print");
				narrowBtn=toolbar.addItem("narrow","缩小","narrow");
				enlargeBtn=toolbar.addItem("enlarge","放大","enlarge");
				zoomOutBtn=toolbar.addItem("pullnarrow","拉框缩小","pullnarrow");
				zoomInBtn=toolbar.addItem("pullenlarge","拉框放大","pullenlarge");
				gobalBtn=toolbar.addItem("gobal","全地图","gobal");
				handBtn=toolbar.addItem("hand","漫游","hand");
				homeBtn=toolbar.addItem("home","默认范围","home");
				findBtn=toolbar.addItem("find","查找","magnifier");
				signBtn=toolbar.addItem("sign","标注","pen");
				blueglassBtn=toolbar.addItem("accidentfind","事故查询","blueglass");
				targetBtn=toolbar.addItem("targetfind","重大目标查询","redglass");
				resourceBtn=toolbar.addItem("resource","资源查询","money");
				userBtn=toolbar.addItem("personfind","终端用户","person_find");
				//trackBtn=toolbar.addItem("track","危化品运输车运行轨迹","truck");
				systemBtn=toolbar.addItem("system","监控管理系统","camera");
				legendBtn=toolbar.addItem("legend","图例图层","legend");
				//helpBtn=toolbar.addItem("help","帮助","help");
				aboutBtn=toolbar.addItem("about","关于","about");
				hideBtn=toolbar.addItem("change","隐藏显示","change");

				
				//设置地图默认放大级数
				if(map.getMaxZoom()!=-1)
					map.setZoom(Math.floor((map.getMaxZoom()-map.getMinZoom())/2));

				//鹰眼按钮对话框对象
				yingyanDlg=$.fn.customDialog.createDialog("yingyanDlg","缩略图","earth");
				
				yingyanBtn.onClick(function(){
					var mainFrame=yingyanDlg.getMainFrame();
					yingyanDlg.open();
					
					if(overviewMap==null){
						overviewMap = new OverviewMap({
							map: map,
							width:mainFrame.innerWidth(),
							height:mainFrame.innerHeight()
						},mainFrame[0]);
						overviewMap.startup();
					}
				});

				//书签按钮对话框对象
				shuqianDlg=$.fn.customDialog.createDialog("shuqianDlg","书签","book");
				shuqianDlg.appendToolBar("bookmarks_add","添加书签",function(){
					var addFrame=shuqianDlg.getFrame("bookmark_add");
					if(addFrame.length==0){
						var addFrame=$("<div>");
						var firstRow=$("<p style=\"font-weight:bold;display:inline-block;\">增加当前区域作为新书签，输入名称：</p>");
						var secondRow=$("<div style=\"margin:6px;\"></div>");
						var textInput=$("<input type=\"text\" style=\"width:270px;\"/>"),btn=$("<input type=\"button\" value=\"增加书签\"/>");
						var thirdRow=$("<div  style=\"margin:18px 0;text-align:center;\"></div>");
						
						btn.on("click",function(){
							var text=$.trim(textInput.val());
							if(text==""){
								alert("请输入书签名称！");
								return;
							}else{
								var curExtent=map.geographicExtent;
								var template=$("#template");
								var newObj=template.clone();
								newObj.find("span").text(text);
								newObj.attr("data-value",JSON.stringify(curExtent.toJson())).show();
								newObj.appendTo(shuqianDlg.getMainFrame().find("ul:eq(0)"));
								newObj.find(".del").on("click",function(){
									if(confirm("您确定要删除此书签吗？")){
										newObj.remove();
									}
									event.stopPropagation();
								});
								newObj.find(".modify").on("click",function(event){
									var txt=$(this).parent().find("span").text();
								
									shuqianDlg.getMainFrame().find("ul:eq(0)").hide();
									$("#renameFrame").data("renameObj",$(this).parent());
									$("#renameFrame").find("input[type=text]").val(txt);
									$("#renameFrame").show();
									event.stopPropagation();
								});
								newObj.on("click",function(){
									var value=$.parseJSON($(this).attr("data-value"));
									var extent=new Extent(value);
									map.setExtent(extent);
								});

								shuqianDlg.getMainFrame().show();
								addFrame.hide();
								textInput.val("");
							}
						});

						secondRow.append(textInput);
						thirdRow.append(btn);
						addFrame.append(firstRow).append(secondRow).append(thirdRow);
						shuqianDlg.appendFrame("bookmark_add",addFrame);
					}
					shuqianDlg.getAllFrame().hide();
					addFrame.show();
				});
				
				var shuqianListFun=function(){
					var mainFrame=shuqianDlg.getMainFrame();
					if(mainFrame.html()==""){
						var ul=$("<ul class=\"bookmarklist\">"),li=$("<li id=\"template\">"),img=$("<img src=\""+gisPath+"/css/icon/book.png\">"),span=$("<span>测试标签</span>"),
							iDel=$("<i>").addClass("del"),iModify=$("<i>").addClass("modify"),renameFrame=$("<div id=\"renameFrame\"style=\"margin-top:50px;display:inline-block;\"><input type=\"text\"/>&nbsp;<input type=\"button\" value=\"重命名\"/>&nbsp;<input type=\"button\" value=\"取消\"/></div>");
						li.hide();
						li.append(img).append(span).append(iDel).append(iModify).appendTo(ul);
						ul.appendTo(mainFrame);
						renameFrame.appendTo(mainFrame).hide();
						
						renameFrame.find("input[type=button]:eq(0)").on("click",function(){
							var txt=$.trim($(this).parent().children().eq(0).val());
							if(txt==""){
								alert("请输入书签名称！");
								return;
							}else{
								renameFrame.data("renameObj").find("span").text(txt);
								renameFrame.hide();
								mainFrame.children().eq(0).show();
							}						});
						renameFrame.find("input[type=button]:eq(1)").on("click",function(){
							renameFrame.hide();
							mainFrame.children().eq(0).show();
						});
					}
				};
				
				shuqianListFun();
				shuqianDlg.appendToolBar("toolbar_table","书签列表",function(){
					shuqianListFun();
					shuqianDlg.getAllFrame().hide();
					shuqianDlg.getMainFrame().show();
				});

				
				shuqianBtn.onClick(function(){
					shuqianDlg.open();
					var mainFrame=shuqianDlg.getMainFrame();
					var addFrame=$("<div>");
					if(mainFrame.html()==""){
						
					}
				});

				narrowBtn.onClick(function(){
					if(map.getMaxZoom()!=-1){
						var curZoom=map.getZoom();
						map.setZoom(curZoom-zoomWeight);
					}else{
						var curScale=map.getScale();
						map.setScale(curScale*(1+scaleWeight));
					}
				});
				
				enlargeBtn.onClick(function(){
					var curZoom,curScale;
					if(map.getMaxZoom()!=-1){
						curZoom=map.getZoom();
						map.setZoom(curZoom+zoomWeight);
					}else{
						curScale=map.getScale();
						map.setScale(curScale*(1-scaleWeight));
					}
				});

				zoomInBtn.onClick(function(){
					 navToolbar.activate(Navigation.ZOOM_IN);
				});

				zoomOutBtn.onClick(function(){
					navToolbar.activate(Navigation.ZOOM_OUT);
				});

				handBtn.onClick(function(){
					navToolbar.activate(Navigation.PAN);
				});

				homeBtn.onClick(function(){
					//homeButton.home();
					if(map.getMaxZoom()==-1)
						homeButton.home();
					else{
						point=new Point(${lng},${lat},map.spatialReference);
						if(map.spatialReference.isWebMercator()){
							point=webMercatorUtils.geographicToWebMercator(point);
						}
						map.centerAndZoom(point, Math.floor((map.getMaxZoom()-map.getMinZoom())/2));
					}
						
				});

				gobalBtn.onClick(function(){
					map.setExtent(map.getLayer(baseLayerName).fullExtent);
				});


				printBtn.onClick(function(){
					window.print();
				});

				findDlg=$.fn.customDialog.createDialog("findDlg","查找","magnifier");
				findBtn.onClick(function(){
					var mainFrame=findDlg.getMainFrame(),graphicLayer;
					if(mainFrame.html()==""){
						var i,len;
						var firstRow=$("<p style=\"font-weight:bold;display:inline-block;\">输入查找名称(支持模糊查询)：</p>");
						var secondRow=$("<div style=\"margin:6px;\"></div>");
						var textInput=$("<input type=\"text\" style=\"width:270px;\"/>"),findBtn=$("<input type=\"button\" value=\"查询\"/>"),clearBtn=$("<input style=\"margin-left:4px;\" type=\"button\" value=\"清空\"/>");
						var thirdRow=$("<div  style=\"margin:18px 0;text-align:center;\"></div>");

						secondRow.append(textInput);
						thirdRow.append(findBtn).append(clearBtn);
						mainFrame.append(firstRow).append(secondRow).append(thirdRow);

						graphicLayer=addGraphicLayer(map,findDlg,"findLayer");

						findBtn.on("click",function(){
							var text=$.trim(textInput.val());
							if(text==""){
								alert("请输入查找名称！");
								return;
							}
							findBtn.prop("disabled",true).val("加载中..");
							var find = new FindTask(layer.url);
							var params = new FindParameters();
							for(var i=0,list=[],len=layer.layerInfos.length;i<len;i++){
								list.push(layer.layerInfos[i].id);
							}
							  params.layerIds = list;
							  params.returnGeometry=true;
							  params.searchFields = ["NAME"];
							  params.searchText =text;
							  find.execute(params, function(results){
								  graphicLayer.clear();
								  var point,geometry,attr,infoTemplate,graphic,pictureSymbol;
								  for(var i=0,len=results.length;i<len;i++){
									geometry=results[i].feature.geometry;
								  	attr=results[i].feature.attributes;
									infoTemplate=new InfoTemplate("详情", "名称: \${NAME}");
									pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/icon/location.png", 20, 25);
									if(geometry.type=="polyline"){
										var pathIndex=Math.floor(geometry.paths.length/2),
											pointIndex=Math.floor(geometry.paths[pathIndex].length/2);
										point=geometry.getPoint(pathIndex,pointIndex);
										graphic=new Graphic(point,pictureSymbol,attr,infoTemplate);
									}else
										graphic=new Graphic(geometry,pictureSymbol,attr,infoTemplate);
									graphicLayer.add(graphic);
								  }
								  if(results.length!=0){
									geometry=results[0].feature.geometry;
									if(geometry.type=="polygon"){
										point=geometry.getCentroid();
									}else if(geometry.type=="polyline"){
										var pathIndex=Math.floor(geometry.paths.length/2),
											pointIndex=Math.floor(geometry.paths[pathIndex].length/2);
										point=geometry.getPoint(pathIndex,pointIndex);
									}else
										point=geometry;
									map.centerAt(point);
								  }
								  graphicLayer.show();
								  findBtn.prop("disabled",false).val("查找");
							  });
						});

						clearBtn.on("click",function(){
							graphicLayer.clear();
							textInput.val("");
						});
						
					}
					findDlg.open();
				});
				
				signDlg=$.fn.customDialog.createDialog("signDlg","标注","pen");
				$("#color_select").bigColorpicker(function(el,color){
					$(el).css("backgroundColor",color);
				});
				
				signDlg.appendToolBar("i_clear","清除标注",function(){
					if(confirm("您确定清除所有标注吗？")){
						signDlg.graphicLayer["signGraphicLayer"].clear();
						measurement.clearResult();
					}
				});


				signDlg.appendToolBar("i_block","框选清除标注",function(){
					var toolbar;

					function findTarget(evt){
						toolbar.deactivate();
						var type,geometry,extent,signList=[],delList=[],graphics=signDlg.graphicLayer["signGraphicLayer"].graphics;
						for(var i=0,len=graphics.length;i<len;i++){
							type=graphics[i].geometry.type;
							geometry=graphics[i].geometry;
							if(type!="point")
								extent=geometry.getExtent();
							else
								extent=geometry;
							if (evt.geometry.intersects(extent)){

								var markerSymbol=new SimpleMarkerSymbol(SimpleMarkerSymbol.STYLE_X,12
								,new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID,new Color([92,156,255,1]),4));

								if(type=="polyline")
									geometry=geometry.getPoint(0,1);
								var graphic=new Graphic(geometry,markerSymbol);
								signDlg.graphicLayer["signGraphicLayer"].add(graphic);
								signList.push(graphic);
								delList.push(graphics[i]);
							}
						}

						if(confirm("您确定清除选定的标注吗？")){
							for(var i=0;i<delList.length;i++)
								signDlg.graphicLayer["signGraphicLayer"].remove(delList[i]);
						}

						for(var i=0;i<signList.length;i++){
							signDlg.graphicLayer["signGraphicLayer"].remove(signList[i]);
						}


					}

					function createToolbar() {
						  toolbar = new Draw(map);
						  toolbar.on("draw-end", findTarget);
					};
					createToolbar();
					
					toolbar.activate(Draw.EXTENT);
				});

				signDlg.appendToolBar("i_measure","测量",function(){
					removeEventHandler("Map.click");
					measurement.setTool("distance",true);
				});

				signDlg.appendToolBar("i_image","图片标注",function(){
					function selChange(){
						var me=$(this),value=me.val(),option=me.find(":selected"),count=option.attr("count"),list=option.attr("listname").split(","),ul=frame.find("ul"),firstL=value.substring(0,1);
						ul.empty();
						count=count?count:list.length;
						for(var i=0,listlen=list.length;i<count;i++){
							ul.append($('<li><a href="#"><img src="'+gisPath+'/css/img/'+value+'/'+firstL+i+'.gif" title="'+(listlen==1?list[0]:list[i])+'" data-type="point"></a></li>'));
						}
						ul.find("li").on("click",function(){
							var src=$(this).find("img").attr("src");
							$(this).parent().find("a.select").removeClass("select");
							$(this).children().eq(0).addClass("select");
							var eventLis=map.on("click",function(event){
								var pictureSymbol= new PictureMarkerSymbol(src, 32, 32);
								var graphic=new Graphic(event.mapPoint,pictureSymbol);
								signDlg.graphicLayer["signGraphicLayer"].add(graphic);
							});
							replaceEventHandler("Map.click",eventLis);
						});
					}
					
					var frame=signDlg.getFrame("i_image");
					if(frame.length==0){
						frame=$("<div>");
						var rowContainer=$("<div>").addClass("rowcontainer"),left=$("<span style='width:100px;'></span>").addClass("left"),right=$("<div style='width:180px;'>").addClass("right"),sel=$("<select>"),option,
						data=[{"text":"车辆类","value":"car","listname":["工程车","轿车","警车","救护车","卡车","通讯车","消防车","巡逻船","指挥车","装甲车"]},
							  {"text":"人员类","value":"person","listname":["专家","医生","陆军","海军","空军","消防员","警察","指挥员","交警","城管"]},
							  {"text":"物资类","value":"resource","listname":["避难场所","粮食","石料","危险源","衣服","油料"]},
							  {"text":"场所类","value":"house","listname":["公园","求助站","体育馆","停车场","指挥部"]},
							  {"text":"建筑类","value":"build","listname":"围墙","count":5},
							  {"text":"箭头","value":"arrow","listname":"箭头","count":24}];
						rowContainer.append(left.text("请选择图片类型："));
						for(var i=0,len=data.length;i<len;i++){
							option=$("<option value='"+data[i].value+"' count="+(data[i].count?data[i].count:data[i].listname.length)+" listname="+(typeof data[i].listname=="array"? data[i].listname.join(","):data[i].listname)+">"+data[i].text+"</option>");
							sel.append(option);
						}
						rowContainer.append(right.append(sel));
						frame.append(rowContainer).append($("<ul class='horizon'></ul>"));
						frame.append($("<input type='hidden' id='imageHidden'/>"));
						sel.on("change",selChange);
						signDlg.appendFrame("i_image",frame);

						sel.trigger("change");
					}

					signDlg.getAllFrame().hide();
					frame.show();
					
					
				});

				signDlg.appendToolBar("i_text","文本标注",function(){
					var frame=signDlg.getFrame("i_text");
					if(frame.length==0){
						frame=$("<div>");
						var rowContainer=$("<div>").addClass("rowcontainer"),left=$("<span>").addClass("left"),right=$("<div>").addClass("right"),
						    data=[{"text":"文本：","content":"<input type=\"text\" id=\"sign_fontTxt\"/>"},
								  {"text":"颜色：","content":"<input id=\"sign_colorSel\" type=\"text\" class=\"input_bigpicker\" readonly=\"\" style=\"background-color: #660099;\">"},
								  {"text":"字体：","content":"<select id=\"sign_fontSel\"><option>宋体</option><option>华文细黑</option><option>华文楷体</option></select>"},
								  {"text":"大小：","content":"<input id=\"sign_fontSize\" type=\"text\" value=\"20\">"}];
						for(var i=0,len=data.length;i<len;i++){
							rowContainer=$("<div>").addClass("rowcontainer");
							rowContainer.append($("<span>").addClass("left").text(data[i].text));
							rowContainer.append($("<div>").addClass("right").html(data[i].content));
							frame.append(rowContainer);
						}
						frame.find("#sign_colorSel").bigColorpicker(function(el,color){
							$(el).css("backgroundColor",color);
						});
						signDlg.appendFrame("i_text",frame);
						
					}

					var eventLis=map.on("click",function(event){
						var txt=frame.find("#sign_fontTxt").val(),
						color=Color.fromString(frame.find("#sign_colorSel").css("backgroundColor")),
						fontFamily=frame.find("#sign_fontSel option:selected").text(),
						fontSize=frame.find("#sign_fontSize").val();
					
						var font=new Font(fontSize,Font.STYLE_NORMAL,Font.VARIANT_NORMAL,Font.WEIGHT_BOLD,fontFamily);
						var textSymbol=new TextSymbol(txt,font, color);
						
						var graphic=new Graphic(event.mapPoint,textSymbol);
						
						signDlg.graphicLayer["signGraphicLayer"].add(graphic);
					});
					replaceEventHandler("Map.click",eventLis);

					signDlg.getAllFrame().hide();
					frame.show();

				});

				signDlg.appendToolBar("i_draw","标注",function(){
					signDlg.getAllFrame().hide();
					signDlg.getMainFrame().show();
					removeEventHandler("Map.click");
				});

				

				signBtn.onClick(function(){
					if(signDlg.getMainFrame().html()==""){
						var picObj=[{"src":"/css/img/point.png","name":"画点","type":"point"},{"src":"/css/img/line.png","name":"画线","type":"polyline"},{"src":"/css/img/freeline.png","name":"画曲线","type":"freehand_polyline"},{"src":"/css/img/poly.png","name":"多边形","type":"POLYGON"},{"src":"/css/img/freepoly.png","name":"任意多边形","type":"freehand_polygon"}];
						var ul=$("<ul>").addClass("horizon"),li,div;
						for(var i=0;i<picObj.length;i++){
							li=$('<li><a href="#"><img src='+gisPath+picObj[i].src+'  title="'+picObj[i].name+'" data-type="'+picObj[i].type+'"></a></li>');
							ul.append(li);
						}
						div=$('<div style="clear:both;position:relative;height:30px;line-height:30px;"><span style="float:left;width:50px;text-align:right;">颜色：</span><div style="float:right;width:250px;"><input id="color1_select" type="text" class="input_bigpicker" readonly="" style="background-color:#660099;"></div></div>');
						div.find("#color1_select").bigColorpicker(function(el,color){
							$(el).css("backgroundColor",color);
						});
						
						signDlg.getMainFrame().append(ul).append(div);

						//添加标注图层
						var graphicLayer=addGraphicLayer(map,signDlg,"signGraphicLayer");

						var toolbar;
						 function createToolbar() {
						  toolbar = new Draw(map);
						  toolbar.on("draw-end", addToMap);
						};

						function addToMap(evt) {
						  var symbol;
						  toolbar.deactivate();
						  map.showZoomSlider();
						  var color=$("#color1_select").css("backgroundColor");
						  color=Color.fromString(color);
						  switch (evt.geometry.type) {
							case "point":
							case "multipoint":
							  symbol = new SimpleMarkerSymbol(SimpleMarkerSymbol.STYLE_CIRCLE, 13,new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID, color, 1),color);
							  break;
							case "polyline":
							  symbol = new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID, color,3);
							  break;
							default:
							  var color2=color;
							  color2.a=0.3;
							  symbol = new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID, new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID,color, 3),color2);
							  break;
						  }
						  var graphic = new Graphic(evt.geometry, symbol);
						  graphicLayer.add(graphic);
						}

						function activateTool() {
						  var tool = $(this).find("img").attr("data-type").toUpperCase();
						  toolbar.activate(Draw[tool]);
						}

						createToolbar();

						ul.find("li").on("click",activateTool);
					}
					signDlg.open();
				});

				resourceDlg=$.fn.customDialog.createDialog("resourceDlg","资源查询","money");

				resourceBtn.onClick(function(){
					var mainFrame=resourceDlg.getMainFrame(),graphicLayers={};

					if(mainFrame.html()==""){
						var ul=$("<ul class='ztree' id='resourceTree'>").appendTo(mainFrame);

						$.post("./getResource",null,function(data){
							var setting= {
								view: {selectedMulti: false,nameIsHTML: true},
								check: { enable: true,chkboxType: { "Y" : "ps", "N" : "ps" }},
								data: { simpleData: {enable: true}},
								callback: {onCheck: onCheck}
							};
						
							var loadedNodeList=[];//存储已绘画节点id
							function onCheck(event, treeId, treeNode){
								var nodes=tree.getChangeCheckedNodes(),i,j,k,lng,lat,len,count,klen,layers=[],flag=false,firstGra;
								var icon="",lngAttr,latAttr,dataList,pictureSymbol,point,attr,infoTemplate,graphic,graphics,storeList=[];

								for(i=0,len=nodes.length;i<len;i++){
									var nodeId=nodes[i].id,temp=nodeId.split("_"),layerId=temp[0],typeId=temp[1];
									//对应类型图层不存在需创建
									if(nodes[i].root && !graphicLayers[layerId]){
										graphicLayers[layerId]=addGraphicLayer(map,resourceDlg,layerId);
									}

									if(!nodes[i].root){
										
										if(loadedNodeList.indexOf(nodeId)==-1){
											switch(nodeId.split("_")[0].toLowerCase()){
												//应急队伍
												case "yjdw":
													icon="home.png";lngAttr="TEA_LONGITUDE";latAttr="TEA_LATITUDE";
													infoTemplate=new InfoTemplate("详细信息","<b>队伍名称: </b>\${NAME}<br>"
											                + "<b>队伍类型: </b>\${P_NAME}<br>"
											                + "<b>所属单位: </b>\${D_NAME}<br>"
											                + "<b>人员数: </b>\${MEMBERNUM}<br>"
											                + "<b>负责人: </b>\${MASTER}<br>"
											                + "<b>负责人电话: </b>\${MASTERPHONE}<br>");
													break;
												//应急专家
												case "yjzj":icon="expert.png";lngAttr="LONGITUDE";latAttr="LATITUDE";
													infoTemplate=new InfoTemplate("详细信息","<b>专家姓名: </b>\${NAME}<br>"
															+ "<b>专家类型: </b>\${P_NAME}<br>"
											                + "<b>学历: </b>\${DEGREE}<br>"
											                + "<b>毕业院校: </b>\${GRADUATESCHOOL}<br>"
											                + "<b>职业: </b>\${JOB}<br>"
											                + "<b>职称: </b>\${JOBTITLE}<br>"
											                + "<b>技术成果: </b>\${ACHIEVEMENT}<br>");
													break;
												//应急避难所
												case "shtype":icon="refuge.gif";lngAttr="LONGITUDE";latAttr="LATITUDE";
													infoTemplate=new InfoTemplate("详细信息","<b>场所名称: </b>\${NAME}<br>"
															+ "<b>类别: </b>\${P_NAME}<br>"
											                + "<b>所属单位: </b>\${D_NAME}<br>"
											                + "<b>面积: </b>\${AREA}<br>"
											                + "<b>容纳人数: </b>\${GALLERYFUL}<br>"
											                + "<b>联系人: </b>\${LINKMAN}<br>"
											                + "<b>联系人电话: </b>\${LINKMANTEL}<br>");
													break;
												//应急设备
												case "eqtype":icon="equiment.gif";lngAttr="LONGITUDE";latAttr="LATITUDE";
												infoTemplate=new InfoTemplate("详细信息","<b>装备名称: </b>\${EQN_NAME}<br>"
										                + "<b>所属单位: </b>\${DEPTNAME}<br>"
										                + "<b>数量: </b>\${EQUIPNUM}<br>"
										                + "<b>存放地址: </b>\${ADDRESS}");
													break;
												//应急案例
												case "evtp":icon="case.png";lngAttr="CAS_LONGITUDE";latAttr="CAS_LATITUDE";
													infoTemplate=new InfoTemplate("详细信息","<b>案例标题: </b>\${TITLE}<br>"
															+ "<b>事件类型: </b>\${P_NAME}<br>"
											                + "<b>事件等级: </b>\${EVENTLEVELNAME}<br>"
											                + "<b>数据来源单位: </b>\${D_NAME}<br>"
											                + "<b>开始时间: </b>\${STARTTIME}<br>"
											                + "<b>结束时间: </b>\${ENDTIME}<br>"
											                + "<b>地址: </b>\${ADDRESS}<br>");
													break;
												//物资仓库
												case "maleve":icon="house.png";lngAttr="LONGITUDE";latAttr="LATITUDE";
													infoTemplate=new InfoTemplate("详细信息","<b>名称: </b>\${NAME}<br>"
															+ "<b>级别: </b>\${JB_NAME}<br>"
											                + "<b>地址: </b>\${ADDRESS}<br>"
											                + "<b>负责人: </b>\${MASTER}<br>"
											                + "<b>负责人电话: </b>\${MASTERPHONE}<br>"
											                + "<b>防护等级: </b>\${DJ_NAME}<br>"
											                + "<b>监测方式: </b>\${MONITMODE}<br>");
													break;
											}
											dataList=nodes[i].data;
											for(j=0,count=dataList.length;j<count;j++){
												lng=dataList[j][lngAttr],lat=dataList[j][latAttr];
												if(lng && lat){
													pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/icon/"+icon, 25, 25),
														point=new Point(lng,lat,map.spatialReference);
													if(map.spatialReference.isWebMercator()){
														point=webMercatorUtils.geographicToWebMercator(point);
													}
													
													graphic=new Graphic(point,pictureSymbol,dataList[j],infoTemplate);
													graphicLayers[layerId].add(graphic);
													if(!firstGra)
														firstGra=graphic;
												}
											}
											loadedNodeList.push(nodeId);
											graphicLayers[layerId].show();
										}else{
											graphics=graphicLayers[layerId].graphics;
											for(j=0,count=graphics.length;j<count;j++){
												if(graphics[j].attributes.P_ID==typeId){
													nodes[i].checkedOld?graphics[j].hide():graphics[j].show();
													if(map.infoWindow.getSelectedFeature()==graphics[j])
														map.infoWindow.hide();
													if(!nodes[i].checkedOld && !firstGra)firstGra=graphics[j];
												}
											}
										}
										nodes[i].checkedOld=!nodes[i].checkedOld;
									}
								}
								if(firstGra)
									map.centerAt(firstGra.geometry);
							}
							var tree=$.fn.zTree.init(ul, setting, data);
						});
					}

					resourceDlg.open();
				});
				
				
				blueglassDlg=$.fn.customDialog.createDialog("blueglassDlg","事故查询","blueglass");

				blueglassDlg.appendToolBar("toolbar_table","查询结果",function(){
					blueglassDlg.getAllFrame().hide();
					blueglassDlg.getMainFrame().show();
				});
				
				blueglassDlg.appendToolBar("toolbar_find","查询",function(){
					blueglassDlg.getAllFrame().hide();
					blueglassDlg.getFrame("find").show();
				});
				
				blueglassBtn.onClick(function(){
					var mainFrame=blueglassDlg.getMainFrame(),graphicLayer;
					var ul=$("<ul class='accidentList'>"),li=$("<li id='accident_template'>"),em=$("<em  class='search'></em>"),span=$("<span>测试标签</span>"),
					iDel=$("<i class='del2' title='清除定位'></i>"),elocation=$("<i class='editlocation' title='定位事件发生地点'></i>"),location=$("<i class='location' title='定位事件发生地点'></i>");
					if(mainFrame.html()==""){
						li.hide();
						mainFrame.append("<div style='margin-bottom:5px;'>共查找到<label id='accidentCount'>0</label>条记录</div>");
						li.append(em).append(span).append(iDel).append(elocation).appendTo(ul);
						ul.appendTo(mainFrame);


						//添加标注图层
						graphicLayer=addGraphicLayer(map,blueglassDlg,"blueglassGraphicLayer");

						blueglassDlg.getAllFrame().hide();
						blueglassDlg.getFrame("find").show();
					}
					//添加查询界面元素
					var addFrame=blueglassDlg.getFrame("find");
					if(addFrame.length==0){
						var addFrame=$("<div>");
						var firstRow=$("<p style=\"font-weight:bold;display:inline-block;\">输入事故标题查询：</p>");
						var secondRow=$("<div style=\"margin:6px;\"></div>");
						var textInput=$("<input type=\"text\" style=\"width:270px;\"/>"),findBtn=$("<input type=\"button\" value=\"查询\"/>"),clearBtn=$("<input style=\"margin-left:4px;\" type=\"button\" value=\"清空\"/>");
						var thirdRow=$("<div  style=\"margin:18px 0;text-align:center;\"></div>");
						
						findBtn.on("click",function(){
							var text=$.trim(textInput.val());
							if(text==""){
								alert("请输入查询关键字！");
								return;
							}else{

								$.post("<%=basePath%>Main/eventSearch/getContent",{ename:text,flag:1},function(data){
									
									var i,len,eventName,address,newObj;
									ul.empty().append(li);
									
									for(i=0,len=data.length;i<len;i++){
										newObj=li.clone();
										eventName=data[i].EV_NAME,address=data[i].EVQY_ADDRESS+data[i].EV_ADDRESS;
										newObj.find("span")[0].outerHTML="<span title='"+eventName+"&#10;"+address+"'>"+eventName+"<br/>"+address+"</span>";
										newObj.attr("data-value",JSON.stringify(data[i])).show();
										newObj.appendTo(mainFrame.find("ul:eq(0)"));
										if(data[i].EV_LONGITUDE){
											newObj.find("em").hide();
										}
										newObj.find(".del2").on("click",function(){
											var me=$(this),parent=me.parent(),tempEm=parent.find(".search");
											if(!tempEm.is(":hidden")){
												alert("该事件尚未定位");
												return;
											}else{
												var value=$.parseJSON(parent.attr("data-value"));
												if(confirm("您确定删除定位吗？")){
													$.post("./updateEventLocation",{id:value.ID,flag:1},function(result){
														if(result.success){
															graphicLayer.clear();
															tempEm.show();
															value.EV_LATITUDE=null;
															value.EV_LONGITUDE=null;
															parent.attr("data-value",JSON.stringify(value));
														}else{
															alert(result.msg);
														}
													});
												}

											}
											event.stopPropagation();
										});
										newObj.find(".editlocation").on("click",function(event){
											var me=$(this), parent=me.parent(),tempEm=parent.find(".search"),
											value=$.parseJSON(parent.attr("data-value"));
											mainFrame.find(".location").removeClass("location").addClass("editlocation");
											me.removeClass("editlocation").addClass("location");
											graphicLayer.clear();
											replaceEventHandler("Map.click",map.on("click",function(evt){
												var pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/icon/w_location.png", 20,20),
													point=evt.mapPoint,
													graphic=new Graphic(evt.mapPoint,pictureSymbol);
												graphicLayer.add(graphic);
												removeEventHandler("Map.click");
												if(map.spatialReference.isWebMercator()){
													point=webMercatorUtils.webMercatorToGeographic(point);
												}
												$.post("./updateEventLocation",{id:value.ID,flag:0,lng:point.x,lat:point.y},function(result){
													if(result.success){
														tempEm.hide();
														me.removeClass("location").addClass("editlocation");
														value.EV_LATITUDE=point.y;
														value.EV_LONGITUDE=point.x;
														parent.attr("data-value",JSON.stringify(value));
														window.setTimeout(function(){graphicLayer.remove(graphic);},800);
													}else{
														alert(result.msg);
													}
												});
											}));
											
											event.stopPropagation();
										});
										newObj.on("click",function(){
											if(!$(this).find(".search").is(":hidden")){
												alert("该事件尚未定位！");
												return;
											}
											var value=$.parseJSON($(this).attr("data-value"));
											var pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/img/donghua.gif", 32, 32),
											point=new Point(value.EV_LONGITUDE,value.EV_LATITUDE,map.spatialReference);
											if(map.spatialReference.isWebMercator()){
												point=webMercatorUtils.geographicToWebMercator(point);
											}
											
											var infoTemplate=new InfoTemplate("详细信息","<b>事件名称: </b>\${EV_NAME}<br>"
								                + "<b>事件地点: </b>\${EVQY_ADDRESS}+\${EV_ADDRESS}<br>"
								                + "<b>事件类型: </b>\${EVTYPE_NAME}<br>"
								                + "<b>事件级别: </b>\${EVLEVEL_NAME}<br>"
								                + "<b>事发时间: </b>\${EV_DATE}<br>");

							                graphicLayer.clear();
											var graphic=new Graphic(point,pictureSymbol,value,infoTemplate);
											graphicLayer.add(graphic);
											map.centerAt(point);
										});
									}
									graphicLayer.clear();
									$("#accidentCount").text(data.length);
									blueglassDlg.getAllFrame().hide();
									mainFrame.show();
								});
							}		
						});

						clearBtn.on("click",function(){
							textInput.val("");
							graphicLayer.clear();
							ul.empty().append(li);
							$("#accidentCount").text("0");
						});

						secondRow.append(textInput);
						thirdRow.append(findBtn).append(clearBtn);
						addFrame.append(firstRow).append(secondRow).append(thirdRow);
						blueglassDlg.appendFrame("find",addFrame);
					}
					
					blueglassDlg.open();
				});

				targetDlg=$.fn.customDialog.createDialog("targetDlg","重大目标查询","redglass");
				targetDlg.appendToolBar("toolbar_table","查询结果",function(){
					targetDlg.getAllFrame().hide();
					targetDlg.getMainFrame().show();
				});

				targetDlg.appendToolBar("i_pinkarrow","危险源查询",function(){
					targetDlg.getAllFrame().hide();
					targetDlg.getFrame("pinkarrow").show();
				});
				targetDlg.appendToolBar("i_yellowarrow","隐患点查询",function(){
					targetDlg.getAllFrame().hide();
					targetDlg.getFrame("yellowarrow").show();
				});
				targetDlg.appendToolBar("i_redarrow","防护目标查询",function(){
					targetDlg.getAllFrame().hide();
					targetDlg.getFrame("redarrow").show();
				});
				
				targetBtn.onClick(function(){
					var mainFrame=targetDlg.getMainFrame();
					var protectObj,hiddenObj,dangerObj,targetLayer;
					/**创建小窗口方法
					* winDialog:主窗口对象
					* title:   内容显示
					* dlgId:   小窗口id
					* findFn:  查询函数
					* clearFn: 清空函数
					*/
					var createAppendDlg=function(winDialog,title,dlgId,findFn,clearFn){
						var frameObj=$("<div>");
						var firstRow=$("<p style=\"font-weight:bold;display:inline-block;\">"+title+"：</p>");
						var secondRow=$("<div style=\"margin:6px;\"></div>");
						var textInput=$("<input type=\"text\" style=\"width:270px;\"/>"),findBtn=$("<input type=\"button\" value=\"查询\"/>"),clearBtn=$("<input style=\"margin-left:4px;\" type=\"button\" value=\"清空\"/>");
						var thirdRow=$("<div  style=\"margin:18px 0;text-align:center;\"></div>");

						secondRow.append(textInput);
						thirdRow.append(findBtn).append(clearBtn);
						frameObj.append(firstRow).append(secondRow).append(thirdRow);
						winDialog.appendFrame(dlgId,frameObj);
						frameObj.hide();
						return {
								dlgObj:frameObj,
								txtObj:textInput,
								findObj:findBtn,
								clearObj:clearBtn
							};
					}
					
					if(mainFrame.html()==""){

						//添加图层
						targetLayer=addGraphicLayer(map,targetDlg,"targetGraphicLayer");
						//添加防护目标查询内容
						projectObj=createAppendDlg(targetDlg,"输入防护目标查询","redarrow");
						projectObj.findObj.on("click",function(){
							var text=projectObj.txtObj.val();
							if($.trim(text)==""){
								alert("查询内容不能为空！");
								return;
							}

							$.post("<%=basePath%>Main/protectobj/getContent",{pname:text},function(data){
								ul.empty();
								for(var i=0,len=data.length;i<len;i++){
									var li=$("<li>"),span=$("<span>").text(data[i].DEFOBJNAME),img=$("<img src=\""+gisPath+"/css/icon/book.png\">");
									li.attr("data-value",JSON.stringify(data[i])).append(img).append(span);
									ul.append(li);
									li.on("click",function(){
										var value=$.parseJSON($(this).attr("data-value"));
										if(!value.LONGITUDE || !value.LATITUDE){
											alert("未选取经纬度，无法在地图显示");
											return;
										}
										var pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/img/donghua.gif", 32, 32),
										point=new Point(value.LONGITUDE,value.LATITUDE,map.spatialReference);
										if(map.spatialReference.isWebMercator()){
											point=webMercatorUtils.geographicToWebMercator(point);
										}
										
										var infoTemplate=new InfoTemplate("详细信息","<b>名称: </b>\${DEFOBJNAME}<br>"
							                + "<b>地址: </b>\${DISTRICTCODE_NAME}\${ADDRESS}<br>"
							                + "<b>负责人: </b>\${RESPPER}<br>"
							                + "<b>负责人办公电话: </b>\${RESPOTEL}<br>"
							                + "<b>主管单位: </b>\${CHARGEDEPT}<br>"
							                + "<b>主管单位地址: </b>\${CDEPTADDRESS}<br>"
							                + "<b>面积: </b>\${AREA}<br>"
							                + "<b>人数: </b>\${PERSONNUM}<br>"
							                + "<b>应急通信方式: </b>\${COMMTYPE}<br>"
							                + "<b>监测方式: </b>\${MONITMODE}<br>"
							                + "<b>基本情况: </b>\${DESCRIPTION}");

							            targetLayer.clear();
										var graphic=new Graphic(point,pictureSymbol,value,infoTemplate);
										targetLayer.add(graphic);
										map.centerAt(point);
									});
								}
								$("#targetCount").text(len);
								targetDlg.getAllFrame().hide();
								mainFrame.show();
							});
						});
						projectObj.clearObj.on("click",function(){
							targetLayer.clear();
							projectObj.txtObj.val("");
							mainFrame.find("ul").empty();
							$("#targetCount").text("0");
						});
						hiddenObj=createAppendDlg(targetDlg,"输入隐患点查询","yellowarrow");
						hiddenObj.findObj.on("click",function(){
							var text=hiddenObj.txtObj.val();
							if($.trim(text)==""){
								alert("查询内容不能为空！");
								return;
							}

							$.post("<%=basePath%>Main/troubleinfo/getContent",{tname:text},function(data){
								ul.empty();
								for(var i=0,len=data.length;i<len;i++){
									var li=$("<li>"),span=$("<span>").text(data[i].HIDTRUBNAME),img=$("<img src=\""+gisPath+"/css/icon/book.png\">");
									li.attr("data-value",JSON.stringify(data[i])).append(img).append(span);
									mainFrame.find("ul").append(li);
									li.on("click",function(){
										var value=$.parseJSON($(this).attr("data-value"));
										if(!value.LONGITUDE || !value.LATITUDE){
											alert("未选取经纬度，无法在地图显示");
											return;
										}
										var pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/img/donghua.gif", 32, 32),
										point=new Point(value.LONGITUDE,value.LATITUDE,map.spatialReference);
										if(map.spatialReference.isWebMercator()){
											point=webMercatorUtils.geographicToWebMercator(point);
										}
										
										var infoTemplate=new InfoTemplate("详细信息","<b>名称: </b>\${HIDTRUBNAME}<br>"
							                + "<b>隐患点类别: </b>\${HIDTRUBTYPE_NAME}<br>"
							                + "<b>危险程度: </b>\${HIDTRUBCLASS}<br>"
							                + "<b>所属单位: </b>\${CHECKDEPT}<br>"
							                + "<b>隐患点地址: </b>\${HIDTRUBADDR}<br>"
							                + "<b>隐患点电话: </b>\${HIDTRUBTEL}<br>"
							                + "<b>隐患原因: </b>\${HIDTRUBDETAIL}<br>"
							                + "<b>情况说明: </b>\${HIDTRUBRESULT}");

							            targetLayer.clear();
										var graphic=new Graphic(point,pictureSymbol,value,infoTemplate);
										targetLayer.add(graphic);
										map.centerAt(point);
									});
								}
								$("#targetCount").text(len);
								targetDlg.getAllFrame().hide();
								mainFrame.show();
							});
						});
						hiddenObj.clearObj.on("click",function(){
							targetLayer.clear();
							projectObj.txtObj.val("");
							mainFrame.find("ul").empty();
							$("#targetCount").text("0");
						});
						dangerObj=createAppendDlg(targetDlg,"输入危险源查询","pinkarrow");
						dangerObj.findObj.on("click",function(){
							var text=dangerObj.txtObj.val();
							if($.trim(text)==""){
								alert("查询内容不能为空！");
								return;
							}

							$.post("<%=basePath%>Main/danger/getContent",{dname:text},function(data){
								ul.empty();
								for(var i=0,len=data.length;i<len;i++){
									var li=$("<li>"),span=$("<span>").text(data[i].DANGERNAME),img=$("<img src=\""+gisPath+"/css/icon/book.png\">");
									li.attr("data-value",JSON.stringify(data[i])).append(img).append(span);
									mainFrame.find("ul").append(li);
									li.on("click",function(){
										var value=$.parseJSON($(this).attr("data-value"));
										if(!value.LONGITUDE || !value.LATITUDE){
											alert("未选取经纬度，无法在地图显示");
											return;
										}
										var pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/img/donghua.gif", 32, 32),
										point=new Point(value.LONGITUDE,value.LATITUDE,map.spatialReference);
										if(map.spatialReference.isWebMercator()){
											point=webMercatorUtils.geographicToWebMercator(point);
										}
										
										var infoTemplate=new InfoTemplate("详细信息","<b>名称: </b>\${DANGERNAME}<br>"
							                + "<b>地址: </b>\${DISTRICTCODE_NAME}\${ADDRESS}<br>"
							                + "<b>负责人: </b>\${RESPPER}<br>"
							                + "<b>负责人办公电话: </b>\${RESPOTEL}<br>"
							                + "<b>主管单位: </b>\${CHARGEDEPT}<br>"
							                + "<b>主管单位地址: </b>\${CDEPTADDRESS}<br>"
							                + "<b>面积: </b>\${AREA}<br>"
							                + "<b>人数: </b>\${PERSONNUM}<br>"
							                + "<b>应急通信方式: </b>\${COMMTYPE}<br>"
							                + "<b>基本情况: </b>\${DESCRIPTION}");

							            targetLayer.clear();
										var graphic=new Graphic(point,pictureSymbol,value,infoTemplate);
										targetLayer.add(graphic);
										map.centerAt(point);
									});
								}
								$("#targetCount").text(len);
								targetDlg.getAllFrame().hide();
								mainFrame.show();
							});
						});
						dangerObj.clearObj.on("click",function(){
							targetLayer.clear();
							dangerObj.txtObj.val("");
							mainFrame.find("ul").empty();
							$("#targetCount").text("0");
						});

						var ul=$("<ul class=\"bookmarklist\">");
						mainFrame.append("<div style='margin-bottom:5px;'>共查找到<label id='targetCount'>0</label>条记录</div>");
						ul.appendTo(mainFrame);
					}
					targetDlg.open();
				});

				userDlg=$.fn.customDialog.createDialog("userDlg","终端用户","person_find");
				userBtn.onClick(function(){
					var mainFrame=userDlg.getMainFrame();
					if(mainFrame.html()==""){
						var ul=$("<ul class='ztree' id='userTree'>").appendTo(mainFrame),i,len,graphicLayer;
						graphicLayer=addGraphicLayer(map,userDlg,"userLayer");
						graphicLayer.on("click",function(evt){
							if(evt.graphic.geometry.type=="point"){
								var attr=evt.graphic.attributes,type=attr.FILETYPE,content;
								if(type=='0'){
									content="<div style='margin:5px 10px;'><h3>时间："+attr.TIME+"</h3>";
									content+="<img src='<%=basePath%>Main/geographic/common/download?path="+attr.PATH+"'/></div>";
								}else{
									content="<div style='margin:5px 10px;height:95%;'><h3>时间："+attr.TIME+"</h3>";
									content+="<a href='<%=basePath%>Main/geographic/common/download?path="+attr.PATH+"' style='display:block;width:100%;height:94%' id='player'></a></div>";
									content+="<script>(function(){flowplayer('player', '"+gisPath+"/plugins/flowplayer/flowplayer-3.2.5.swf');})();<\/script>";
								}
								parent.$.lauvan.openCustomDialog("mediaDlg",{
										title:'详细情况',
										width: 700,
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
							}
						});
						
						$.post("<%=basePath%>Main/mobileuser/getContent",null,function(data){
							var onCheck=function(event, treeId, treeNode){
								var nodes=tree.getChangeCheckedNodes();
								var uid=treeNode.id.split("_")[1];
								graphicLayer.clear();
								if(treeNode.checked){
									$.post("<%=basePath%>Main/gpsinfo/getContent",{uid:uid},function(data){
										var i,len,point,lat,lng,graphic,lineSymbol,textSymbol,polyline,pictureSymbol,ps2,paths=[],picGraphics=[];
										pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/icon/expert.png", 32, 32)
										lineSymbol=new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID, Color.fromString("red"),4);
										
										for(i=0,len=data.length;i<len;i++){

											var result=coordtransform.bd09togcj02(data[i].POSX,data[i].POSY);
											result=coordtransform.gcj02towgs84(result[0],result[1]);
											
											point=new Point(result[0],result[1],map.spatialReference);
											if(map.spatialReference.isWebMercator()){
												point=webMercatorUtils.geographicToWebMercator(point);
											}
											if(data[i].ISUPLOAD=="1" && data[i].PATH!=""){
												graphic=new Graphic(point,pictureSymbol);
												graphic.attributes=data[i];
												picGraphics.push(graphic);
											}
		
											if(i==0 || i==len-1){
											
												var font=new Font("14",Font.STYLE_NORMAL,Font.VARIANT_NORMAL,Font.WEIGHT_BOLD,"宋体");
												ps2= new PictureMarkerSymbol(gisPath+"/css/icon/"+(i==0?"start":"end")+".png", 25,40);
												ps2.setOffset(0, 20);
												graphic=new Graphic(point,ps2);
												graphicLayer.add(graphic);
											}
											paths.push([result[0],result[1]]);
											if(i==0)
												map.centerAt(point);
										}
	
										polyline=new Polyline(paths);
										graphic=new Graphic(polyline,lineSymbol);
										graphicLayer.add(graphic);

										for(i=0,len=picGraphics.length;i<len;i++)
											graphicLayer.add(picGraphics[i]);
		
									});
								}
							};
							var setting = {
									check: {
										enable: true,
										chkStyle: "radio",
										radioType: "level"
									},
									data: {
										simpleData: {
											enable: true
										}
									},
									callback: {
										  onCheck: onCheck
									}
								};
							var rootNode={id:1,pId:0,name:"终端用户",nocheck:true,open:true},nodes=[];
							nodes.push(rootNode);
							for(i=0,len=data.length;i<len;i++){
								nodes.push({
										id:"u_"+data[i].ID,
										pId:rootNode.id,
										name:data[i].REALNAME
									});
							}
							var tree=$.fn.zTree.init(ul, setting, nodes);												
						});
					}
					userDlg.open();
				});
				
				systemDlg=$.fn.customDialog.createDialog("systemDlg","监控管理系统","camera");
				systemBtn.onClick(function(){
					var mainFrame=systemDlg.getMainFrame();
					if(mainFrame.html()==""){
						var ul=$("<ul class='ztree' id='systemTree'>").appendTo(mainFrame),graphicLayer;

						graphicLayer=addGraphicLayer(map,systemDlg,"systemLayer");

						$.post("./getCommEqu",null,function(data){
							var setting= {
									view: {
							      selectedMulti: false,
							      nameIsHTML: true
							  },
								check: {
								   enable: true,
								   chkboxType: { "Y" : "ps", "N" : "ps" }
							    },
								data: {
								   simpleData: {
								   enable: true
								   }
								},
								callback: {
								  onCheck: onCheck
								}
							};

							var geoLayer=[];
							graphicLayer.on("graphic-remove",function(graphic){
								if(map.infoWindow.getSelectedFeature()==graphic.graphic)
									map.infoWindow.hide();
							});

						
							function onCheck(event, treeId, treeNode){
								var nodes=tree.getChangeCheckedNodes(),i,j,lng,lat,len,layers=[],flag=false,firstAddGra;

								for(i=0,len=nodes.length;i<len;i++){
									flag=false;
									for(j=0;j<geoLayer.length;j++){
										lng=geoLayer[j].geometry.x,lat=geoLayer[j].geometry.y;
										if(!nodes[i].isParent && lng==nodes[i].lng && lat==nodes[i].lat){
											layers=layers.concat(geoLayer.splice(j,1));
											flag=true;
											break;
										}
									}
									
									if(!nodes[i].root && !flag){
										var icon="",parentNode=nodes[i].getParentNode();
										switch(parentNode.id){
											case "0001":icon="camera.gif";break;
											case "0002":icon="infrared.gif";break;
											case "0003":icon="windspeed.gif";break;
											case "0004":icon="winddirection.gif";break;
											case "0005":icon="temperature.gif";break;
											case "0006":icon="humidity.gif";break;
											case "0007":icon="fire.gif";break;
											case "0008":icon="smoke.gif";break;
											case "0009":icon="urgent.gif";break;
											case "0010":icon="gas.gif";break;
											case "0011":icon="voice.gif";break;
										}
										var pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/icon/"+icon, 20, 20),
											point=new Point(nodes[i].lng,nodes[i].lat,map.spatialReference);
										if(map.spatialReference.isWebMercator()){
											point=webMercatorUtils.geographicToWebMercator(point);
										}
										var attr = {"name":nodes[i].name,"code":nodes[i].code,"address":nodes[i].address,"ip":nodes[i].ip,"port":nodes[i].port};
										var infoTemplate=new InfoTemplate("详细信息","<b>设备名称: </b>\${name}<br>"
							                + "<b>设备编码: </b>\${code}<br>"
							                + "<b>设备地址: </b>\${address}<br>"
							                + "<b>设备IP: </b>\${ip}<br>"
							                + "<b>设备端口: </b>\${port}<br>");
										var graphic=new Graphic(point,pictureSymbol,attr,infoTemplate);
										graphicLayer.add(graphic);
										layers.push(graphic);
										if(!firstAddGra)
											firstAddGra=graphic;
									}
								}

								for(i=0,len=geoLayer.length;i<len;i++)
									graphicLayer.remove(geoLayer[i]);
								geoLayer=layers;
								if(firstAddGra)
									map.centerAt(firstAddGra.geometry);
							}

							var tree=$.fn.zTree.init(ul, setting, data);
						});
									
					}
					systemDlg.open();
				});

				legendDlg=$.fn.customDialog.createDialog("legendDlg","图例图层","legend");
				legendBtn.onClick(function(){
					var mainFrame=legendDlg.getMainFrame();
					if(mainFrame.html()==""){
						var ul=$("<ul class='ztree legend' id='legendTree' style='background:#E5EFF7'>").appendTo(mainFrame),graphicLayer;

						$.post(gisUrl+"/legend?f=pjson",null,function(data){
							var onCheck=function(){
								var nodes=tree.getChangeCheckedNodes(),i,len,index,layerId,visibleLayers=layer.visibleLayers;
								for(i=0,len=nodes.length;i<len;i++){
									if(nodes[i].pId==0){
										layerId=parseInt(nodes[i].id.split("_")[1]);
										if(nodes[i].checkedOld){
											index=visibleLayers.indexOf(layerId);
											visibleLayers.splice(index,1);
										}else{
											visibleLayers.push(layerId);
										}
										nodes[i].checkedOld=!nodes[i].checkedOld;
									}
								}
								layer.setVisibleLayers(visibleLayers);
							};
							var setting = {
									//check: {enable: true,nocheckInherit: true},
									data: {simpleData: {enable: true,rootPId: 0}},
									callback: { onCheck: onCheck}
								},zNodes=[],node={};
							var i,j,len,count,layers=data.layers,legendD,visilble=false;
							for(i=0,len=layers.length;i<len;i++){
								
								legendD=layers[i].legend;
								node={
										id:"layer_"+layers[i].layerId,
									   pId:0,
								   checked:layer.visibleLayers.indexOf(layers[i].layerId)!=-1,
									  name:layers[i].layerName,
									  icon:gisUrl+"/"+layers[i].layerId+"/images/"+legendD[0].url
									};
								zNodes.push(node);
								if(legendD.length>1){
									for(j=0,count=legendD.length;j<count;j++){
										node={
													id:"layer_"+layers[i].layerId+"_"+j,
												   pId:"layer_"+layers[i].layerId,
												  name:legendD[j].label,
												  nocheck:true,
												  icon:gisUrl+"/"+layers[i].layerId+"/images/"+legendD[j].url
												};
										zNodes.push(node);
									}
								}
							}
							if(map.getMaxZoom()==-1)
								setting.check={enable: true,nocheckInherit: true};
							var tree=$.fn.zTree.init(ul, setting, zNodes);

						},"json");
					}
					legendDlg.open();
				});

				aboutDlg=$.fn.customDialog.createDialog("aboutDlg","关于","about");
				aboutBtn.onClick(function(){
					var mainFrame=aboutDlg.getMainFrame();
					if(mainFrame.html()==""){
						var h2=$("<h2>惠州市离线GIS模型</h2>"),h3=$("<h3 style='color:#1196EE;'>v1.0版本</h3>"),
							h4=$("<h4>@ Copyright 2016 广东立沃研发组. All rights reserved.</h4>");
						mainFrame.append(h2).append(h3).append(h4);
					}
					aboutDlg.open();
				});

				hideBtn.onClick(function(){
					 //$.messager.alert('My Title','Here is a message!');
					
					var me=$(".treeee2");
					if(me.is(":hidden"))
						me.show();
					else
						me.hide();

				});
			});
			
			$("#maskDiv").remove();
			window.onresize();
		});
    });
	
  </script>
</head>
  <body>
    <div id="map" style="width:100%;height:100%;position: absolute; left:0; top:0;">
	</div>
	<div id="toolbar">
		
	</div>
	<div class="treeee2">
	</div>
	
  </body>
</html>
