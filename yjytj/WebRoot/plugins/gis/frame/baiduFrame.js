define(['core/baidu'],function(){
	alert('');
	/**
	 * 地图类
	 *
	 * @type {String} containerId	地图容器id
	 * @type {Number} lng			经度
	 * @type {Number} lat			纬度
	 * @type {Int} zoomLevel(1-19)	缩放级别
	*/
	var customMap=function(containerId,lng,lat,zoomLevel){
		
		// 百度地图API功能
		var defaultPoint=new BMap.Point(lng, lat);
		this.map = new BMap.Map(containerId);    // 创建Map实例
		this.map.centerAndZoom(defaultPoint,zoomLevel);  // 初始化地图,设置中心点坐标和地图级别
		this.map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
		//map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
		this.map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		
		 /**
		 * 在地图上标注图片，
		 *
		 * @type {String} picSrc	图片地址
		 * @type {Int} picWidth		图片宽度
		 * @type {Int} picHeight	图片高度
		 * @type {Number} lng		经度
		 * @type {Number} lat		纬度
		 * @return {Overlay}		添加的图层
		 */
		this.drawPicture=function(picSrc,picWidth,picHeight,lng,lat){
			var point = new BMap.Point(lng,lat),
				size=new BMap.Size(picWidth,picHeight),
				icon=new BMap.Icon(picSrc,size),
				marker=new BMap.Marker(point,{icon:icon});
			this.map.addOverlay(marker);
			return marker;
		}
		
		/**
		* 清除地图上指定图层
		* @type {Overlay}	layer	图层
		*/
		this.clearLayer=function(layer){
			this.map.removeOverlay(layer);
		}

		/**
		* 清除地图上所有图层
		*/
		this.clearAllLayers=function(){
			this.map.clearOverlays();
		}

	}
	
	//存储地图事件对象
	customMap.prototype.event={};
	
	/**
	* 添加事件
	* @type {String}	eventName	事件名称
	* @type {Function}  fn			函数对象(返回参数：lng[经度],lat[纬度])
	*/
	customMap.prototype.addEvent=function(eventName,fn){
		var eventFn=this.event[eventName];
		this.removeEvent(eventName);
		this.map.addEventListener(eventName,function(e){
				fn(e.point.lng,e.point.lat);
		});
	}
	
	/**
	* 移除事件
	* @type {String}  eventName	事件名称
	*/
	customMap.prototype.removeEvent=function(eventName){
		var eventFn=this.event[eventName];
		if(eventFn){
			this.map.removeListener(eventName,eventFn);
			this.event[eventName]=null;
		}
	}

	return customMap;
});