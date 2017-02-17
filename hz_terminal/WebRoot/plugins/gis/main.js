 var map;
    require([
      "esri/map","dojo/on","dojo/dom","esri/lang","esri/Color","esri/toolbars/draw", "esri/geometry/webMercatorUtils", "esri/layers/FeatureLayer", "esri/dijit/Legend","esri/symbols/TextSymbol","esri/symbols/Font",
      "dojo/_base/array", "dojo/parser","esri/geometry/Extent","esri/layers/ArcGISDynamicMapServiceLayer",
	  "esri/symbols/SimpleMarkerSymbol","esri/symbols/SimpleLineSymbol","esri/symbols/SimpleFillSymbol","esri/symbols/PictureMarkerSymbol","esri/graphic", "esri/dijit/OverviewMap","esri/dijit/Scalebar",
	  "esri/toolbars/navigation", "esri/dijit/HomeButton","esri/SpatialReference","esri/dijit/Bookmarks","esri/dijit/BookmarkItem",
      "dijit/layout/BorderContainer", "dijit/layout/ContentPane", 
      "dijit/layout/AccordionContainer", "dojo/domReady!"
    ], function(
      Map,on,dom,lang,Color,Draw,webMercatorUtils,FeatureLayer, Legend,TextSymbol,Font,
      arrayUtils, parser,Extent,ArcGISDynamicMapServiceLayer,SimpleMarkerSymbol,
	  SimpleLineSymbol,SimpleFillSymbol,PictureMarkerSymbol,Graphic,OverviewMap,Scalebar,Navigation,HomeButton,SpatialReference,Bookmarks,BookmarkItem
    ) {

	//全地图设置参数
	 var fullExtent=new Extent({xmin:113.45265157803748,ymin:22.585855345553064,xmax:113.67523091379587,ymax:22.8914332934256,spatialReference:{"wkid":4326}});
	 //系数
	 var scaleWeight=0.4,zoomWeight=1;	

     map=new Map("map",{
			 //basemap:'gray',
			 //extent: new Extent({xmin:113.45265157803748,ymin:22.585855345553064,xmax:113.67523091379587,ymax:22.8914332934256, "spatialReference":{"wkid":4326}}),
			 center:[113.54,22.81],
			 zoom:14,
			 logo:false,
			 slider:false
			 });
		var layer = new esri.layers.ArcGISDynamicMapServiceLayer("http://192.168.0.180:6080/arcgis/rest/services/NSXH/MapServer");
		map.addLayer(layer);

		var scaleBar=new Scalebar({map:map,scalebarUnit:"metric"});
		var overviewMap=null,navToolbar=null,homeButton=null,bookmarks;
		
		
		navToolbar=new Navigation(map);
		$("body").append($("<div id=\"homeDiv\" style=\"display:none;\">"));
		homeButton = new HomeButton({
		  map: map,
		  visible: false
		}, "homeDiv");
		homeButton.startup();
		
		$("body").append("<div id=\"bookmarks\" style=\"display:none;\">");
		bookmarks = new Bookmarks({
			map: map,
			editable:true
		  }, "bookmarks");
		 // bookmarks.startup();

		on(map,"load",function(){
			$(function(){
				var yingyanBtn,shuqianBtn,printBtn,narrowBtn,enlargeBtn,zoomOutBtn,zoomInBtn,gobalBtn,handBtn,findBtn,signBtn,
					blueglassBtn,conInfoBtn,resourceBtn,resQueryBtn,trackBtn,systemBtn,helpBtn,aboutBtn,homeBtn;
				var yingyanDlg,shuqianDlg,signDlg;
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
				conInfoBtn=toolbar.addItem("contactinfo","通讯录查询","person_find");
				resourceBtn=toolbar.addItem("resource","资源查询","money");
				resQueryBtn=toolbar.addItem("resquery","资源综合查询","safe");
				trackBtn=toolbar.addItem("track","危化品运输车运行轨迹","truck");
				systemBtn=toolbar.addItem("system","监控综合管理系统","camera");
				helpBtn=toolbar.addItem("help","帮助","help");
				aboutBtn=toolbar.addItem("about","关于","about");

				//鹰眼按钮对话框对象
				yingyanDlg=$.fn.dialog.createDialog("yingyanDlg","缩略图","earth");
				
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
				shuqianDlg=$.fn.dialog.createDialog("shuqianDlg","书签","book");
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
									alert(txt);
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
						var ul=$("<ul class=\"bookmarklist\">"),li=$("<li id=\"template\">"),img=$("<img src=\"./css/icon/book.png\">"),span=$("<span>测试标签</span>"),
							iDel=$("<i>").addClass("del"),iModify=$("<i>").addClass("modify"),renameFrame=$("<div id=\"renameFrame\"style=\"margin-top:50px;display:inline-block;\"><input type=\"text\"/>&nbsp;<input type=\"button\" value=\"重命名\"/>&nbsp;<input type=\"button\" value=\"取消\"/></div>");
						li.hide();
						li.append(img).append(span).append(iDel).append(iModify).appendTo(ul);
						ul.appendTo(mainFrame);
						renameFrame.appendTo(mainFrame).hide();
						
						renameFrame.find("input[type=button]:eq(0)").on("click",function(){
							var txt=$.trim($(this).parent().children().eq(0).val());
							alert(txt);
							if(txt==""){
								alert("请输入书签名称！");
								return;
							}else{
								renameFrame.data("renameObj").find("span").text(txt);
								renameFrame.hide();
								mainFrame.children().eq(0).show();
							}
						});
						renameFrame.find("input[type=button]:eq(1)").on("click",function(){
							renameFrame.hide();
							mainFrame.children().eq(0).show();
						});
					}
				};
				
				shuqianListFun();
				shuqianDlg.appendToolBar("bookmarks_add","书签列表",function(){
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
					if(map.getBasemap()){
						var curZoom=map.getZoom();
						map.setZoom(curZoom-zoomWeight);
					}else{
						var curScale=map.getScale();
						map.setScale(curScale*(1+scaleWeight));
					}
				});
				
				enlargeBtn.onClick(function(){
					var curZoom,curScale;
					if(map.getBasemap()){
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
					homeButton.home();
				});

				gobalBtn.onClick(function(){
					map.setExtent(fullExtent);
				});


				printBtn.onClick(function(){
					window.print();
				});
				
				signDlg=$.fn.dialog.createDialog("signDlg","标注","pen");
				$("#color_select").bigColorpicker(function(el,color){
					$(el).css("backgroundColor",color);
				});
				
				signDlg.appendToolBar("i_clear","清除标注",function(){
					if(confirm("您确定清除所有标注吗？")){
						map.graphics.clear();
					}
				});


				signDlg.appendToolBar("i_block","框选清除标注",function(){
					var toolbar

					function findTarget(evt){
						toolbar.deactivate();
						var type,geometry,extent,signList=[],delList=[],graphics=map.graphics.graphics;
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
								map.graphics.add(graphic);
								signList.push(graphic);
								delList.push(map.graphics.graphics[i]);
							}
						}

						if(confirm("您确定清除选定的标注吗？")){
							for(var i=0;i<delList.length;i++)
								map.graphics.remove(delList[i]);
						}

						for(var i=0;i<signList.length;i++){
							map.graphics.remove(signList[i]);
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
					
				});

				signDlg.appendToolBar("i_image","图片标注",function(){
					function selChange(){
						var me=$(this),value=me.val(),option=me.find(":selected"),count=option.attr("count"),list=option.attr("listname").split(","),ul=frame.find("ul"),firstL=value.substring(0,1);
						ul.empty();
						count=count?count:list.length;
						for(var i=0,listlen=list.length;i<count;i++){
							ul.append($('<li><a href="#"><img src="./css/img/'+value+'/'+firstL+i+'.gif" title="'+(listlen==1?list[0]:list[i])+'" data-type="point"></a></li>'));
						}
						ul.find("li").on("click",function(){
							var src=$(this).find("img").attr("src");
							$(this).parent().find("a.select").removeClass("select");
							$(this).children().eq(0).addClass("select");
							map.onClick=function(event){
								var pictureSymbol= new PictureMarkerSymbol(src, 32, 32);
								var graphic=new Graphic(event.mapPoint,pictureSymbol);
								map.graphics.add(graphic);
							}
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
							  {"text":"箭头","value":"arrow","listname":"箭头","count":24}];debugger;
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

						
					}

					signDlg.getAllFrame().hide();
					frame.show();
					sel.trigger("change");
					
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

					map.onClick=function(event){
						var txt=frame.find("#sign_fontTxt").val(),
							color=Color.fromString(frame.find("#sign_colorSel").css("backgroundColor")),
							fontFamily=frame.find("#sign_fontSel option:selected").text(),
							fontSize=frame.find("#sign_fontSize").val();
						
						var font=new Font(fontSize,Font.STYLE_NORMAL,Font.VARIANT_NORMAL,Font.WEIGHT_BOLD,fontFamily);
						var textSymbol=new TextSymbol(txt,font, color);
						
						var graphic=new Graphic(event.mapPoint,textSymbol);
						map.graphics.add(graphic);
					}
					
					signDlg.getAllFrame().hide();
					frame.show();

				});

				signDlg.appendToolBar("i_draw","标注",function(){
					signDlg.getAllFrame().hide();
					signDlg.getMainFrame().show();
					map.onClick=function(){
						
					}
				});

				

				signBtn.onClick(function(){
					if(signDlg.getMainFrame().html()==""){
						var picObj=[{"src":"./css/img/point.png","name":"画点","type":"point"},{"src":"./css/img/line.png","name":"画线","type":"polyline"},{"src":"./css/img/freeline.png","name":"画曲线","type":"freehand_polyline"},{"src":"./css/img/poly.png","name":"多边形","type":"POLYGON"},{"src":"./css/img/freepoly.png","name":"任意多边形","type":"freehand_polygon"}];
						var ul=$("<ul>").addClass("horizon"),li,div;
						for(var i=0;i<picObj.length;i++){
							li=$('<li><a href="#"><img src="'+picObj[i].src+'"  title="'+picObj[i].name+'" data-type="'+picObj[i].type+'"></a></li>');
							ul.append(li);
						}
						div=$('<div style="clear:both;position:relative;height:30px;line-height:30px;"><span style="float:left;width:50px;text-align:right;">颜色：</span><div style="float:right;width:250px;"><input id="color1_select" type="text" class="input_bigpicker" readonly="" style="background-color:#660099;"></div></div>');
						div.find("#color1_select").bigColorpicker(function(el,color){
							$(el).css("backgroundColor",color);
						});
						
						signDlg.getMainFrame().append(ul).append(div);
						
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
						  map.graphics.add(graphic);
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

				helpBtn.onClick(function(){
					alert(map.geographicExtent.xmin);
				});
				
				$(".content li").on("click",function(){
					var extent=Extent({xmin:113.45265157803748,ymin:22.585855345553064,xmax:113.67523091379587,ymax:22.8914332934256,spatialReference:{"wkid":4326}});
					map.setExtent(extent);
					//map.geographicExtent;
				});
			});
		});
    });
	