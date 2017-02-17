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
 <link rel="stylesheet" href="<%=basePath %>plugins/gis/css/base.css"/>
 <link rel="stylesheet" href="<%=basePath %>plugins/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
 <style>
 .ztree li span{color:white;}
 .ztree li a.curSelectedNode{background-color: #565147;}
 .ztree.legend li span{color:black;}
 .ztree.legend li a.curSelectedNode{background-color: #FFE6B0;}
 </style>
  
 <script src="<%=basePath %>plugins/gis/core/jquery.js"></script>
 <script src="<%=basePath %>plugins/easyui/jquery.easyui.min.js"></script>
 <script src="<%=basePath %>plugins/ztree/js/jquery.ztree.all-3.5.min.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/bigcolorpicker.js"></script>
 <script src="<%=basePath %>plugins/gis/frame/base2.js"></script>
 
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/default/easyui.css"/>

 <script src="<%=basePath %>plugins/gis/core/baidu.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/extra/RectangleZoom_min.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/extra/RectangleClear.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/extra/DistanceTool_min.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/extra/DrawingManager.js"></script>
 
 <script>
   var gisPath="<%=basePath%>plugins/gis";
	function init(){
		var yingyanBtn,shuqianBtn,printBtn,narrowBtn,enlargeBtn,zoomOutBtn,zoomInBtn,gobalBtn,handBtn,findBtn,signBtn,
					blueglassBtn,targetBtn,resourceBtn,userBtn,systemBtn,helpBtn,aboutBtn,hideBtn,homeBtn;
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
				//gobalBtn=toolbar.addItem("gobal","全地图","gobal");
				handBtn=toolbar.addItem("hand","漫游","hand");
				homeBtn=toolbar.addItem("home","默认范围","home");
				findBtn=toolbar.addItem("find","查找","magnifier");
				signBtn=toolbar.addItem("sign","标注","pen");
				blueglassBtn=toolbar.addItem("accidentfind","事故查询","blueglass");

				targetBtn=toolbar.addItem("targetfind","重大目标查询","redglass");
				resourceBtn=toolbar.addItem("resource","资源查询","money");
				userBtn=toolbar.addItem("personfind","终端用户","person_find");

				systemBtn=toolbar.addItem("system","监控管理系统","camera");
				//helpBtn=toolbar.addItem("help","帮助","help");
				aboutBtn=toolbar.addItem("about","关于","about");
				hideBtn=toolbar.addItem("change","隐藏显示","change");
				
				
				function cancelEvent(){
					zoomIn.close();		//拉框放大
					zoomOut.close();	//拉框缩小
					zoomClear.close();	//拉框清除标注
					
					if(drawingManager)
						drawingManager.close();
					myDis.close();
					map.removeEventListener("click",drawPic);
					map.removeEventListener("click",drawText);
				}

				function clearSelect(){
					signDlg.getAllFrame().find("li a.select").removeClass("select");
				}

				function visibleGraphic(type,flag){
					var overlays=map.getOverlays();
					for(var i=0,len=overlays.length;i<len;i++){
						if(overlays[i].type && overlays[i].type==type){
							flag?overlays[i].show():overlays[i].hide();
						}
					}
				}

				//监听小对话框显示隐藏事件
				function listenVisibleChanged(dialogObj,type){
					
					dialogObj.addCloseEvent("layerHide_"+type,function(){
						cancelEvent();
						visibleGraphic(type,false);
						var infoWindow=map.getInfoWindow();
						if(infoWindow && infoWindow.type && infoWindow.type==type){
							map.closeInfoWindow();
						}
					});
					dialogObj.addOpenEvent("layerShow_"+type,function(){visibleGraphic(type,true);});
				}

				//清除对应类型标记
				function clearOverlays(type){
					var overlays=map.getOverlays();
					for(var i=0,len=overlays.length;i<len;i++){
						if(overlays[i].type && overlays[i].type==type){
							map.removeOverlay(overlays[i]);
						}
					}
				}

				function nullToEmpty(value){
					return value==null?"":value;
				}

				function bindInfoWindow(myMap,overlay,dlgWidth,dlgHeight,content,lng,lat){
					var point=new BMap.Point(lng,lat);
					var opts = {
					  width : dlgWidth,     // 信息窗口宽度
					  height: dlgHeight,     // 信息窗口高度
					  title : "详细信息"// 信息窗口标题
					}
					var infoWindow = new BMap.InfoWindow(content, opts); 
	                infoWindow.type=overlay.type;
	                overlay.addEventListener("click", function(){          
						myMap.openInfoWindow(infoWindow,point);
					});
	                overlay.addEventListener("remove",function(){
						if(infoWindow.isOpen())
							myMap.closeInfoWindow();
					});
					myMap.setCenter(point);
				}
				
				yingyanBtn.onClick(function(){
					overviewOpen.changeView();
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
								var point=map.getCenter();
								var template=$("#template");
								var newObj=template.clone();
								newObj.find("span").text(text);
								newObj.attr("data-lng",point.lng);		//地理经度
								newObj.attr("data-lat",point.lat);		//地理纬度
								newObj.attr("data-zoom",map.getZoom());	//缩放级别
								newObj.show();
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
									var lng=$(this).attr("data-lng"),lat=$(this).attr("data-lat"),zoom=$(this).attr("data-zoom");
									point=new BMap.Point(lng,lat);
									
									map.centerAndZoom(point,zoom);
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
							}
						});
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
					map.zoomOut();
				});
				
				enlargeBtn.onClick(function(){
					map.zoomIn();
				});

				zoomOutBtn.onClick(function(){
					cancelEvent();
					zoomOut.open();
				});

				zoomInBtn.onClick(function(){
					cancelEvent();
					zoomIn.open();
				});

				handBtn.onClick(function(){
					cancelEvent();
					clearSelect();
				});
				
				printBtn.onClick(function(){
					window.print();
				});

				homeBtn.onClick(function(){
					map.centerAndZoom(defaultPoint,zoomLevel);
				});

				findDlg=$.fn.customDialog.createDialog("findDlg","查找","magnifier");
				findDlg.appendToolBar("toolbar_table","查询结果",function(){
					findDlg.getAllFrame().hide();
					findDlg.getFrame("find").show();
				});
				findDlg.appendToolBar("toolbar_find","查询",function(){
					findDlg.getAllFrame().hide();
					findDlg.getMainFrame().show();
				});
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
						
						var addFrame=findDlg.getFrame("find");
						if(addFrame.length==0){
							var addFrame=$("<div>");
							var ul=$("<ul id=\"f-result\" style=\"color:black;\">");
							ul.appendTo(addFrame);
							findDlg.appendFrame("find",addFrame);
							addFrame.hide();
						}

						var local,cacheText="";
						var searchPlace=function(text){
							local = new BMap.LocalSearch(map, {
								renderOptions: {map: map, panel: "f-result"}
							});
							local.search(text);
							
							findDlg.getAllFrame().hide();
							findDlg.getFrame("find").show();
						}
						
						findDlg.addCloseEvent("layerHide_find",function(){
							if(local){
								cacheText=$.trim(textInput.val());
								clearBtn.click();
							}
						});
						findDlg.addOpenEvent("layerShow_find",function(){
							if(cacheText!=""){
								textInput.val(cacheText);
								findBtn.click();
							}
						});
						
						findBtn.on("click",function(){
							var text=$.trim(textInput.val());
							if(text==""){
								alert("请输入查找名称！");
								return;
							}
							searchPlace(text);
						});

						clearBtn.on("click",function(){
							if(local){
								local.clearResults();
							}
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
					cancelEvent();
					clearSelect();
					if(confirm("您确定清除所有标注吗？")){
						for(var i=0,overlays=map.getOverlays(),len=overlays.length;i<len;i++){
							if(overlays[i].type && overlays[i].type=="sign")
								map.removeOverlay(overlays[i]);
						}
						//map.clearOverlays();
					}
				});

				signDlg.appendToolBar("i_block","框选清除标注",function(){
					cancelEvent();
					zoomClear.open();
				});

				signDlg.appendToolBar("i_measure","测量",function(){
					myDis.open();	
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
							
							cancelEvent();
							map.addEventListener("click",drawPic);
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
					cancelEvent();
					map.addEventListener("click",drawPic);
					
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

					cancelEvent();
					map.addEventListener("click",drawText);
					
					signDlg.getAllFrame().hide();
					frame.show();

				});

				signDlg.appendToolBar("i_draw","标注",function(){
					signDlg.getAllFrame().hide();
					signDlg.getMainFrame().show();
					cancelEvent();
					drawGeometry();

					
				});

				
				
				signBtn.onClick(function(){
					if(signDlg.getMainFrame().html()==""){
						var picObj=[{"src":"/css/img/point.png","name":"画点","type":"MARKER"},{"src":"/css/img/circle.png","name":"画点","type":"CIRCLE"},{"src":"/css/img/line.png","name":"画线","type":"POLYLINE"},{"src":"/css/img/poly.png","name":"多边形","type":"POLYGON"},{"src":"/css/img/rectangle.png","name":"矩形","type":"RECTANGLE"}];
						var ul=$("<ul>").addClass("horizon"),li,div;
						for(var i=0;i<picObj.length;i++){
							li=$('<li><a href="#"><img src='+gisPath+picObj[i].src+'  title="'+picObj[i].name+'" data-type="'+picObj[i].type+'"></a></li>');
							ul.append(li);
						}
						div=$('<div style="clear:both;position:relative;height:30px;line-height:30px;"><span style="float:left;width:50px;text-align:right;">颜色：</span><div style="float:right;width:250px;"><input id="color1_select" type="text" class="input_bigpicker" readonly="" style="background-color:#660099;"></div></div>');
						div.find("#color1_select").bigColorpicker(function(el,color){
							$(el).css("backgroundColor",color);
							drawGeometry();
						});
						
						signDlg.getMainFrame().append(ul).append(div);
						cancelEvent();
						ul.find("li").on("click",function(){
							$(this).parent().find("a.select").removeClass("select");
							$(this).children().eq(0).addClass("select");
							drawGeometry();
						});
						
						listenVisibleChanged(signDlg,"sign");
					}
					signDlg.open();
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


						listenVisibleChanged(blueglassDlg,"blueglass");

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
															clearOverlays("blueglass");
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
											clearOverlays("blueglass");

											var getLocation=function(e){
												var marker=addPic(gisPath+"/css/icon/w_location.png",20,20,"blueglass",e.point.lat,e.point.lng);

												$.post("./updateEventLocation",{id:value.ID,flag:0,lng:e.point.lng,lat:e.point.lat},function(result){
													if(result.success){
														tempEm.hide();
														me.removeClass("location").addClass("editlocation");
														value.EV_LATITUDE=e.point.lat;
														value.EV_LONGITUDE=e.point.lng;
														parent.attr("data-value",JSON.stringify(value));
														window.setTimeout(function(){map.removeOverlay(marker);},800);
													}else{
														alert(result.msg);
													}
													map.removeEventListener("click",getLocation);
												});
											}

											map.addEventListener("click",getLocation);
											event.stopPropagation();
										});
										newObj.on("click",function(){
											if(!$(this).find(".search").is(":hidden")){
												alert("该事件尚未定位！");
												return;
											}
											var value=$.parseJSON($(this).attr("data-value"));

											clearOverlays("blueglass");
											var marker=addPic(gisPath+"/css/img/donghua.gif",32,32,"blueglass",value.EV_LATITUDE,value.EV_LONGITUDE);
											var point=new BMap.Point(value.EV_LONGITUDE,value.EV_LATITUDE);
											map.setCenter(point);

											var opts = {
											  width : 300,     // 信息窗口宽度
											  height: 100,     // 信息窗口高度
											  title : "详细信息"// 信息窗口标题
											}
											var infoWindow = new BMap.InfoWindow("<b>事件名称: </b>"+value.EV_NAME+"<br>"
									                + "<b>事件地点: </b>"+value.EVQY_ADDRESS+"+"+value.EV_ADDRESS+"<br>"
									                + "<b>事件类型: </b>"+value.EVTYPE_NAME+"<br>"
									                + "<b>事件级别: </b>"+value.EVLEVEL_NAME+"<br>"
									                + "<b>事发时间: </b>"+value.EV_DATE+"<br>", opts); 
							                infoWindow.type="blueglass";
											marker.addEventListener("click", function(){          
												map.openInfoWindow(infoWindow,point);
											});
											marker.addEventListener("remove",function(){
												if(infoWindow.isOpen())
													map.closeInfoWindow();
											});
										});
									}
									clearOverlays("blueglass");
									$("#accidentCount").text(data.length);
									blueglassDlg.getAllFrame().hide();
									mainFrame.show();
								});
							}		
						});

						clearBtn.on("click",function(){
							textInput.val("");
							clearOverlays("blueglass");
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
					var protectObj,hiddenObj,dangerObj;
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

						listenVisibleChanged(targetDlg,"redglass");
						
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

										clearOverlays("redglass");
										var marker=addPic(gisPath+"/css/img/donghua.gif",32,32,"redglass",value.LATITUDE,value.LONGITUDE);
										var content = "<b>名称: </b>"+nullToEmpty(value.DEFOBJNAME)+"<br>"
								                + "<b>地址: </b>"+nullToEmpty(value.DISTRICTCODE_NAME)+nullToEmpty(value.ADDRESS)+"<br>"
								                + "<b>负责人: </b>"+nullToEmpty(value.RESPPER)+"<br>"
								                + "<b>负责人办公电话: </b>"+nullToEmpty(value.RESPOTEL)+"<br>"
								                + "<b>主管单位: </b>"+nullToEmpty(value.CHARGEDEPT)+"<br>"
								                + "<b>主管单位地址: </b>"+nullToEmpty(value.CDEPTADDRESS)+"<br>"
								                + "<b>面积: </b>"+nullToEmpty(value.AREA)+"<br>"
								                + "<b>人数: </b>"+nullToEmpty(value.PERSONNUM)+"<br>"
								                + "<b>应急通信方式: </b>"+nullToEmpty(value.COMMTYPE)+"<br>"
								                + "<b>监测方式: </b>"+nullToEmpty(value.MONITMODE)+"<br>"
								                + "<b>基本情况: </b>"+nullToEmpty(value.DESCRIPTION); 

										bindInfoWindow(map,marker,300,200,content,value.LONGITUDE,value.LATITUDE);
									});
								}
								$("#targetCount").text(len);
								targetDlg.getAllFrame().hide();
								mainFrame.show();
							});
						});
						projectObj.clearObj.on("click",function(){
							clearOverlays("redglass");
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
										clearOverlays("redglass");
										var marker=addPic(gisPath+"/css/img/donghua.gif",32,32,"redglass",value.LATITUDE,value.LONGITUDE);
										var content = "<b>名称: </b>"+nullToEmpty(value.HIDTRUBNAME)+"<br>"
							                + "<b>隐患点类别: </b>"+nullToEmpty(value.HIDTRUBNAME)+"<br>"
							                + "<b>危险程度: </b>"+nullToEmpty(value.HIDTRUBCLASS)+"<br>"
							                + "<b>所属单位: </b>"+nullToEmpty(value.CHECKDEPT)+"<br>"
							                + "<b>隐患点地址: </b>"+nullToEmpty(value.HIDTRUBADDR)+"<br>"
							                + "<b>隐患点电话: </b>"+nullToEmpty(value.HIDTRUBTEL)+"<br>"
							                + "<b>隐患原因: </b>"+nullToEmpty(value.HIDTRUBDETAIL)+"<br>"
							                + "<b>情况说明: </b>"+nullToEmpty(value.HIDTRUBRESULT); 

										bindInfoWindow(map,marker,300,180,content,value.LONGITUDE,value.LATITUDE);
									});
								}
								$("#targetCount").text(len);
								targetDlg.getAllFrame().hide();
								mainFrame.show();
							});
						});
						hiddenObj.clearObj.on("click",function(){
							clearOverlays("redglass");
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

										clearOverlays("redglass");
										var marker=addPic(gisPath+"/css/img/donghua.gif",32,32,"redglass",value.LATITUDE,value.LONGITUDE);
										
										var content = "<b>名称: </b>"+nullToEmpty(value.DANGERNAME)+"<br>"
							                + "<b>地址: </b>"+nullToEmpty(value.DISTRICTCODE_NAME)+nullToEmpty(value.ADDRESS)+"<br>"
							                + "<b>负责人: </b>"+nullToEmpty(value.RESPPER)+"<br>"
							                + "<b>负责人办公电话: </b>"+nullToEmpty(value.RESPOTEL)+"<br>"
							                + "<b>主管单位: </b>"+nullToEmpty(value.CHARGEDEPT)+"<br>"
							                + "<b>主管单位地址: </b>"+nullToEmpty(value.CDEPTADDRESS)+"<br>"
							                + "<b>面积: </b>"+nullToEmpty(value.AREA)+"<br>"
							                + "<b>人数: </b>"+nullToEmpty(value.PERSONNUM)+"<br>"
							                + "<b>应急通信方式: </b>"+nullToEmpty(value.COMMTYPE)+"<br>"
							                + "<b>基本情况: </b>"+nullToEmpty(value.DESCRIPTION); 

										bindInfoWindow(map,marker,300,180,content,value.LONGITUDE,value.LATITUDE);
									});
								}
								$("#targetCount").text(len);
								targetDlg.getAllFrame().hide();
								mainFrame.show();
							});
						});
						dangerObj.clearObj.on("click",function(){
							clearOverlays("redglass");
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
						
						listenVisibleChanged(userDlg,"userclient");
						
						$.post("<%=basePath%>Main/mobileuser/getContent",null,function(data){
							var onCheck=function(event, treeId, treeNode){
								var nodes=tree.getChangeCheckedNodes();
								var uid=treeNode.id.split("_")[1];
								clearOverlays("userclient");
								if(treeNode.checked){
									$.post("<%=basePath%>Main/gpsinfo/getContent",{uid:uid},function(data){
										var i,len,point,pathList=[],pointList=[],picList=[];
										for(i=0,len=data.length;i<len;i++){

											point =new BMap.Point(data[i].POSX,data[i].POSY);
											pathList.push(point);
											if(i==0 || i==len-1){
												pointList.push(point);
											}
											if(data[i].ISUPLOAD=="1" && data[i].PATH!=""){
												picList.push({point:point,attrs:data[i]});
											}
											if(i==0)
												map.centerAndZoom(point,16);
										}
										 var polyline = new BMap.Polyline(pathList,{strokeColor:"green", strokeWeight:6, strokeOpacity:0.8});
										 polyline.type="userclient";
										 map.addOverlay(polyline);

										 for(i=0,len=pointList.length;i<len;i++){
											 addPic(gisPath+"/css/icon/"+(i==0?"start":"end")+".png",25,40,"userclient",pointList[i].lat,pointList[i].lng,{anchor:new BMap.Size(13,40)});
										 }

										 for(i=0,len=picList.length;i<len;i++){
											 var marker=addPic(gisPath+"/css/icon/expert.png",32,32,"userclient",picList[i].point.lat,picList[i].point.lng);
											 marker.attributes=picList[i].attrs;
											 marker.addEventListener("click",function(e){
												 var attr=e.target.attributes,type=attr.FILETYPE,content;
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
											 });
										 }
										 
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

						//graphicLayer=addGraphicLayer(map,systemDlg,"systemLayer");
						listenVisibleChanged(systemDlg,"system");

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

							var markerList=[];

							function onCheck(event, treeId, treeNode){
								var nodes=tree.getChangeCheckedNodes(),i,j,lng,lat,len,layers=[],flag=false,firstAddGra;

								for(i=0,len=nodes.length;i<len;i++){
									flag=false;
									for(j=0;j<markerList.length;j++){
										lng=markerList[j].point.lng,lat=markerList[j].point.lat;
										if(!nodes[i].isParent && lng==nodes[i].lng && lat==nodes[i].lat){
											layers=layers.concat(markerList.splice(j,1));
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

										 var marker=addPic(gisPath+"/css/icon/"+icon,20,20,"system",nodes[i].lat,nodes[i].lng);
										 var content="<b>设备名称: </b>"+nullToEmpty(nodes[i].name)+"<br>"
								                + "<b>设备编码: </b>"+nullToEmpty(nodes[i].code)+"<br>"
								                + "<b>设备地址: </b>"+nullToEmpty(nodes[i].address)+"<br>"
								                + "<b>设备IP: </b>"+nullToEmpty(nodes[i].ip)+"<br>"
								                + "<b>设备端口: </b>"+nullToEmpty(nodes[i].port)+"<br>";
								         
								         bindInfoWindow(map,marker,250,130,content,nodes[i].lng,nodes[i].lat);
								         layers.push(marker);
								         if(!firstAddGra){
												firstAddGra=marker.point;
								         }
									}
								}

								for(i=0,len=markerList.length;i<len;i++)
									map.removeOverlay(markerList[i]);
								markerList=layers;
								if(firstAddGra)
									map.setCenter(firstAddGra);
							}

							var tree=$.fn.zTree.init(ul, setting, data);
						});
									
					}
					systemDlg.open();
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
										listenVisibleChanged(resourceDlg,layerId+"_resource");
									}

									if(!nodes[i].root){
										
										if(loadedNodeList.indexOf(nodeId)==-1){
											switch(nodeId.split("_")[0].toLowerCase()){
												//应急队伍
												case "yjdw":
													icon="home.png";lngAttr="TEA_LONGITUDE";latAttr="TEA_LATITUDE";
													break;
												//应急专家
												case "yjzj":icon="expert.png";lngAttr="LONGITUDE";latAttr="LATITUDE";
													break;
												//应急避难所
												case "shtype":icon="refuge.gif";lngAttr="LONGITUDE";latAttr="LATITUDE";
													break;
												//应急设备
												case "eqtype":icon="equiment.gif";lngAttr="LONGITUDE";latAttr="LATITUDE";
													break;
												//应急案例
												case "evtp":icon="case.png";lngAttr="CAS_LONGITUDE";latAttr="CAS_LATITUDE";
													break;
												//物资仓库
												case "maleve":icon="house.png";lngAttr="LONGITUDE";latAttr="LATITUDE";
													break;
											}
											dataList=nodes[i].data;
											for(j=0,count=dataList.length;j<count;j++){
												lng=dataList[j][lngAttr],lat=dataList[j][latAttr];
												if(lng && lat){
													var marker=addPic(gisPath+"/css/icon/"+icon,25,25,layerId+"_resource",lat,lng);
											         marker.attributes=dataList[j];
											         switch(nodeId.split("_")[0].toLowerCase()){
														//应急队伍
														case "yjdw":
															infoTemplate="<b>队伍名称: </b>"+nullToEmpty(dataList[j].NAME)+"<br>"
												                + "<b>队伍类型: </b>"+nullToEmpty(dataList[j].P_NAME)+"<br>"
												                + "<b>所属单位: </b>"+nullToEmpty(dataList[j].D_NAME)+"<br>"
												                + "<b>人员数: </b>"+nullToEmpty(dataList[j].MEMBERNUM)+"<br>"
												                + "<b>负责人: </b>"+nullToEmpty(dataList[j].MASTER)+"<br>"
												                + "<b>负责人电话: </b>"+nullToEmpty(dataList[j].MASTERPHONE)+"<br>";
															break;
														//应急专家
														case "yjzj":
															infoTemplate="<b>专家姓名: </b>"+nullToEmpty(dataList[j].NAME)+"<br>"
																+ "<b>专家类型: </b>"+nullToEmpty(dataList[j].P_NAME)+"<br>"
												                + "<b>学历: </b>"+nullToEmpty(dataList[j].DEGREE)+"<br>"
												                + "<b>毕业院校: </b>"+nullToEmpty(dataList[j].GRADUATESCHOOL)+"<br>"
												                + "<b>职业: </b>"+nullToEmpty(dataList[j].JOB)+"<br>"
												                + "<b>职称: </b>"+nullToEmpty(dataList[j].JOBTITLE)+"<br>"
												                + "<b>技术成果: </b>"+nullToEmpty(dataList[j].ACHIEVEMENT)+"<br>";
															break;
														//应急避难所
														case "shtype":
															infoTemplate="<b>场所名称: </b>"+nullToEmpty(dataList[j].NAME)+"<br>"
																+ "<b>类别: </b>"+nullToEmpty(dataList[j].P_NAME)+"<br>"
												                + "<b>所属单位: </b>"+nullToEmpty(dataList[j].D_NAME)+"<br>"
												                + "<b>面积: </b>"+nullToEmpty(dataList[j].AREA)+"<br>"
												                + "<b>容纳人数: </b>"+nullToEmpty(dataList[j].GALLERYFUL)+"<br>"
												                + "<b>联系人: </b>"+nullToEmpty(dataList[j].LINKMAN)+"<br>"
												                + "<b>联系人电话: </b>"+nullToEmpty(dataList[j].LINKMANTEL)+"<br>";
															break;
														//应急设备
														case "eqtype":
														infoTemplate="<b>装备名称: </b>"+nullToEmpty(dataList[j].EQN_NAME)+"<br>"
											                + "<b>所属单位: </b>"+nullToEmpty(dataList[j].DEPTNAME)+"<br>"
											                + "<b>数量: </b>"+nullToEmpty(dataList[j].EQUIPNUM)+"<br>"
											                + "<b>存放地址: </b>"+nullToEmpty(dataList[j].ADDRESS);
															break;
														//应急案例
														case "evtp":
															infoTemplate="<b>案例标题: </b>"+nullToEmpty(dataList[j].TITLE)+"<br>"
																+ "<b>事件类型: </b>"+nullToEmpty(dataList[j].P_NAME)+"<br>"
												                + "<b>事件等级: </b>"+nullToEmpty(dataList[j].EVENTLEVELNAME)+"<br>"
												                + "<b>数据来源单位: </b>"+nullToEmpty(dataList[j].D_NAME)+"<br>"
												                + "<b>开始时间: </b>"+nullToEmpty(dataList[j].STARTTIME)+"<br>"
												                + "<b>结束时间: </b>"+nullToEmpty(dataList[j].ENDTIME)+"<br>"
												                + "<b>地址: </b>"+nullToEmpty(dataList[j].ADDRESS)+"<br>";
															break;
														//物资仓库
														case "maleve":
															infoTemplate="<b>名称: </b>"+nullToEmpty(dataList[j].NAME)+"<br>"
																+ "<b>级别: </b>"+nullToEmpty(dataList[j].JB_NAME)+"<br>"
												                + "<b>地址: </b>"+nullToEmpty(dataList[j].ADDRESS)+"<br>"
												                + "<b>负责人: </b>"+nullToEmpty(dataList[j].MASTER)+"<br>"
												                + "<b>负责人电话: </b>"+nullToEmpty(dataList[j].MASTERPHONE)+"<br>"
												                + "<b>防护等级: </b>"+nullToEmpty(dataList[j].DJ_NAME)+"<br>"
												                + "<b>监测方式: </b>"+nullToEmpty(dataList[j].MONITMODE)+"<br>";
															break;
													}
											         bindInfoWindow(map,marker,300,200,infoTemplate,lng,lat);
											         if(!firstGra)
												         firstGra=new BMap.Point(lng,lat);

												}
											}
											loadedNodeList.push(nodeId);
											visibleGraphic(layerId+"_resource",true);

										}else{

											for(j=0,lays=map.getOverlays(),count=lays.length;j<count;j++){
												if(lays[j].type && lays[j].type==layerId+"_resource" 
														&& lays[j].attributes.P_ID==typeId){
													nodes[i].checkedOld?lays[j].hide():lays[j].show();
													var infoWindow=map.getInfoWindow();
													if(infoWindow && infoWindow.type && infoWindow.type==layerId+"_resource"){
														map.closeInfoWindow();
													}
													if(!nodes[i].checkedOld && !firstGra)firstGra=lays[j].point;
												}
											}
										}
										nodes[i].checkedOld=!nodes[i].checkedOld;
									}
								}
								if(firstGra)
									map.setCenter(firstGra);
							}
							var tree=$.fn.zTree.init(ul, setting, data);
						});
					}

					resourceDlg.open();
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
					var me=$(".treeee2");
					if(me.is(":hidden"))
						me.show();
					else
						me.hide();

				});


			// 百度地图API功能
			var defaultPoint=new BMap.Point(${lng},${lat}),zoomLevel=${zoom};
			var map = new BMap.Map("map");    // 创建Map实例
			map.centerAndZoom(defaultPoint,zoomLevel);  // 初始化地图,设置中心点坐标和地图级别
			map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
			map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
			
			var overviewOpen=new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_TOP_LEFT,isOpen:false,offset:new BMap.Size(5,40)});
			var zoomOut = new BMapLib.RectangleZoom(map, {zoomType:1,followText: "拉框缩小"});
			var zoomIn=new BMapLib.RectangleZoom(map, {followText: "拉框放大"});
			var zoomClear=new BMapLib.RectangleClear(map,{followText:"框选清除标注"});
			//地图上绘几何图形
			var drawingManager;
			var drawGeometry=function(){
				//添加鼠标绘制工具监听事件，用于获取绘制结果
				 var color=$("#color1_select").css("backgroundColor");
				 var type=signDlg.getMainFrame().find("a.select img").attr("data-type");
				 if(type)
					type=type.toLowerCase();
				 else
				   return;
				
				 var styleOptions = {
					strokeColor:color,    //边线颜色。
					fillColor:color,      //填充颜色。当参数为空时，圆形将没有填充效果。
					strokeWeight: 2,       //边线的宽度，以像素为单位。
					strokeOpacity: 0.6,	   //边线透明度，取值范围0 - 1。
					fillOpacity: 0.2,      //填充的透明度，取值范围0 - 1。
					strokeStyle: 'solid' //边线的样式，solid或dashed。
				 };
				 //实例化鼠标绘制工具
				drawingManager = new BMapLib.DrawingManager(map, {
					type:"sign",
					isOpen: false, //是否开启绘制模式
					circleOptions: styleOptions, //圆的样式
					polylineOptions: styleOptions, //线的样式
					polygonOptions: styleOptions, //多边形的样式
					rectangleOptions: styleOptions //矩形的样式
				});
				cancelEvent();

				drawingManager.open();
				drawingManager.setDrawingMode(type);
			}
			//图片标注
			var drawPic=function(e){
				var src= signDlg.getFrame("i_image").find("ul a.select img").attr("src");
					point=new BMap.Point(e.point.lng,e.point.lat),
					icon=new BMap.Icon(src,new BMap.Size(32,32)),
					marker=new BMap.Marker(point,{icon:icon});
					marker.type="sign";
					map.addOverlay(marker);
			 };
			var drawText=function(e){
				var frame=signDlg.getFrame("i_text"),
					txt=frame.find("#sign_fontTxt").val(),
					color=frame.find("#sign_colorSel").css("backgroundColor"),
					fontFamily=frame.find("#sign_fontSel option:selected").text(),
					fontSize=frame.find("#sign_fontSize").val(),
					point=new BMap.Point(e.point.lng,e.point.lat);
					if(txt){
						var options={position:point,offset:new BMap.Size(-8,-8)},
						label=new BMap.Label(txt,options),
						style={color:color,fontSize:fontSize+"px",fontFamily:fontFamily,backgroundColor:"",border:""};
						label.setStyle(style);
						label.type="sign";
						map.addOverlay(label);
					}
			};
			//往地图添加图片标记
			var addPic=function(picSrc,width,height,type,lat,lng,iconOpts){
				var point=new BMap.Point(lng,lat),
					icon=new BMap.Icon(picSrc,new BMap.Size(width,height),iconOpts),
					marker=new BMap.Marker(point,{icon:icon});

				marker.type=type;
				map.addOverlay(marker);
				return marker;
			}
			
			//测量工具
			var myDis = new BMapLib.DistanceTool(map);

			map.addControl(overviewOpen);

	}

	
	function loadJScript() {
		var script = document.createElement("script");
		script.type = "text/javascript";
		script.src = "http://api.map.baidu.com/api?v=2.0&ak=FB4758dd1b4fb9e40f95fbf21c81b300&callback=init";
		document.body.appendChild(script);

		script=document.createElement("script");
		script.type = "text/javascript";
		script.src = "<%=basePath %>plugins/gis/plugins/extra/DrawingManager_min.js";
		document.body.appendChild(script);
	}
	window.onload = init; 
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
