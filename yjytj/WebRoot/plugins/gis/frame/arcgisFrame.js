
define([$.basePath+"plugins/gis/frame/dynamicLoading.js",$.basePath+"plugins/gis/plugins/coordtransform.js","esri/map","dojo/on","esri/graphic","esri/geometry/webMercatorUtils","esri/layers/ArcGISDynamicMapServiceLayer","esri/layers/ArcGISTiledMapServiceLayer",
        "esri/layers/GraphicsLayer","esri/symbols/PictureMarkerSymbol","esri/geometry/Point","esri/tasks/FindTask", "esri/tasks/FindParameters","esri/InfoTemplate"],
	function(DynamicLink,coordtransform,Map,on,Graphic,webMercatorUtils,ArcGISDynamicMapServiceLayer,ArcGISTiledMapServiceLayer,GraphicsLayer,
			PictureMarkerSymbol,Point,FindTask,FindParameters,InfoTemplate){
	

	var customMap=function(containerId,centerLng,centerLat,mapServiceUrl,apiUrl,zoom){

		DynamicLink.css(apiUrl+"/dijit/themes/tundra/tundra.css");
		DynamicLink.css(apiUrl+"/esri/css/esri.css");
		 var me=this;
		 this.map=new Map(containerId,{
			 //basemap:'gray',
			 //extent: new Extent({xmin:113.45265157803748,ymin:22.585855345553064,xmax:113.67523091379587,ymax:22.8914332934256, "spatialReference":{"wkid":4326}}),
			 center:[centerLng,centerLat],
			 //zoom:14,
			 logo:false,
			 slider:false
			 });
		//var layer = new ArcGISDynamicMapServiceLayer(mapServiceUrl);
		 var layer = new ArcGISTiledMapServiceLayer(mapServiceUrl);
		this.map.addLayer(layer);
		
		on(this.map,"load",function(){
			//设置地图默认放大级数
			if(me.map.getMaxZoom()!=-1){
				var defaultZoom=Math.floor((me.map.getMaxZoom()-me.map.getMinZoom())/2);
				if(zoom)
					defaultZoom=zoom;
				me.map.setZoom(zoom);
			}
		});

		 /**
		 * 在地图上标注图片，
		 *
		 * @type {String} picSrc	图片地址
		 * @type {Int} picWidth		图片宽度
		 * @type {Int} picHeight	图片高度
		 * @type {Point} mapPoint	地图上点
		 * @return {Graphic}		添加的图层
		 */
		this.drawPicture=function(picSrc,picWidth,picHeight,mapPoint){
			var pictureSymbol= new PictureMarkerSymbol(picSrc, picWidth, picHeight);
			var graphic=new Graphic(mapPoint,pictureSymbol);
			this.map.graphics.add(graphic);
			return graphic;
		};
		
		this.mapPointToGeographicPoint=function(mapPoint){

			 return webMercatorUtils.webMercatorToGeographic(mapPoint);
		};

		/**
		* 清除地图上指定图层
		* @type {Graphic}	layer	图层
		*/
		this.clearLayer=function(layer){
			map.graphics.remove(layer);
		};

		/**
		* 清除地图上所有图层
		*/
		this.clearAllLayers=function(){
			this.map.graphics.clear();
		};
		
		this.getPoint=function(lat,lng){
			var point=new Point(lat,lng,this.map.spatialReference);
			if(this.map.spatialReference.isWebMercator()){
				point=webMercatorUtils.geographicToWebMercator(point);
			}
			return  point;
			
		};
		
		this.bdToArcgisForPoint=function(lat,lng){
			var result=coordtransform.bd09togcj02(lat, lng);
			result=coordtransform.gcj02towgs84(result[0],result[1]);
			return {lat:result[0],lng:result[1]};
		};
		
		this.addGraphicLayer=function(dialogObj,id){
			//添加标注图层
			var map=this.map;
			var graphicLayer=new GraphicsLayer({id:id});
			this.map.addLayer(graphicLayer);
			if(!dialogObj.graphicLayer)dialogObj.graphicLayer={};
			dialogObj.graphicLayer[id]=graphicLayer;
			dialogObj.addCloseEvent("layerHide_"+id,function(){graphicLayer.hide();});
			dialogObj.addOpenEvent("layerShow_"+id,function(){graphicLayer.show();});
			graphicLayer.on("visibility-change",function(obj){
				if(!obj.visible){
					for(var i=0,len=graphicLayer.graphics.length;i<len;i++)
						if(this.map.infoWindow.getSelectedFeature()==graphicLayer.graphics[i]){
							this.map.infoWindow.hide();
							break;
						}
				}
			});
			graphicLayer.on("graphic-remove",function(graphic){
				if(map.infoWindow.getSelectedFeature()==graphic.graphic)
					map.infoWindow.hide();
			});
			return graphicLayer;
		}
		
		this.findInfo=function(text,graphicLayer,callback){
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
					me.map.centerAt(point);
				  }
				  graphicLayer.show();
				  callback();
			  });
		}
	}

	//存储地图事件对象
	customMap.prototype.event={};
	/**
	* 添加事件
	* @type {String}	eventName	事件名称
	* @type {Function}  fn			函数对象(返回参数：Point[坐标点])
	*/
	customMap.prototype.addEvent=function(eventName,fn){
		if(!this.map)return;
		var eventFn=this.event[eventName];
		this.removeEvent(eventName);
		on(this.map,eventName,function(e){
			var pt=e.mapPoint;
			if(pt && pt.spatialReference.isWebMercator()){
				pt=webMercatorUtils.webMercatorToGeographic(pt);
			}
			fn(pt);
		});
	}
	
	/**
	* 移除事件
	* @type {String}  eventName	事件名称
	*/
	customMap.prototype.removeEvent=function(eventName){
		if(!this.map)return;
		var eventFn=this.event[eventName];
		if(eventFn){
			on(this.map,eventName,function(e){});
			this.event[eventName]=null;
		}
	}
	 
	return customMap;	
});