$('#storeAddForm').bootstrapValidator();
$('#storeEditForm').bootstrapValidator();
$(function(){
	$("#st_Storedate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd',minView:2,autoclose:true});
});

function map(){
	var latitude = $("#latitude").val();
	var longitude = $("#longitude").val();
	var map = new BMap.Map("container");
	var point = new BMap.Point(longitude, latitude);
	map.centerAndZoom(point, 13);
    map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
	map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
    var marker = new BMap.Marker(point);  // 创建标注
	map.addOverlay(marker);               // 将标注添加到地图中
	marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
}

function add(index,window){
	$('#storeAddForm').bootstrapValidator('validate');
	if($('#storeAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/suppliesstore/add', $('#storeAddForm').serialize(), function(j) {	
			if(j.success){
				parent.layer.msg("添加成功");
				parent.layer.close(index);
				window.location.reload();
			}
			parent.layer.tips(j.msg, '.layui-layer-btn0',{
			    tips: 1
			});
		}, 'json');
	}else{
		parent.layer.tips('带*输入框必需正确输入', '.layui-layer-btn0',{
		    tips: 1
		});
	}
}

function edit(index,window){
	$('#storeEditForm').bootstrapValidator('validate');
	if($('#storeEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/suppliesstore/edit', $('#storeEditForm').serialize(),function(j){
				if(j.success){
					parent.layer.msg("编辑成功");
					parent.layer.close(index);
					window.location.reload();
				}
				parent.layer.tips(j.msg, '.layui-layer-btn0',{
				    tips: 1
				});
			}, 'json');
		}else{
			parent.layer.tips('带*输入框必需正确输入', '.layui-layer-btn0',{
			    tips: 1
			});
		}
}

var mapDialog;
function getMap(){
	mapDialog = parent.layer.open({
		type : 2,
		title : '地点选择',
		area : [ '800px', '500px' ],
		content : 'gismap/common/map.jsp',
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow
					.getResult(index,window);
		},
	});
}

function select_supplies(){
	parent.layer.open({
	    type: 2,
	    title:'选择物资',
	    area:['900px','600px'],
	    scrollbar: false,
	    content: 'jsp/resource/supplies/supplies_select2.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.selectSupplies(index,window);
	    }
	});
}


