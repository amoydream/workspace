$('#expertAddForm').bootstrapValidator();
$('#expertEditForm').bootstrapValidator();
$(function() {
	$("#ex_Borndate").datetimepicker({
		language : 'zh-CN',
		format : 'yyyy-mm-dd',
		minView : 2,
		autoclose : true
	});
	$("#ex_Graduatetime").datetimepicker({
		language : 'zh-CN',
		format : 'yyyy-mm-dd',
		minView : 2,
		autoclose : true
	});
	$("#ex_Workdate").datetimepicker({
		language : 'zh-CN',
		format : 'yyyy-mm-dd',
		minView : 2,
		autoclose : true
	});
});

function add() {
	$("#expertAddBtn").html("正在提交中。。。");
	$("#expertAddBtn").attr("disabled","disabled");
	$('#expertAddForm').bootstrapValidator('validate');
	if ($('#expertAddForm').data('bootstrapValidator').isValid()) {
		$.post('resource/expert/add', $('#expertAddForm').serialize(),
				function(j) {
					if (j.success) {
						parent.closeTab("tab_expertAddTab");
						parent.layer.msg("添加成功");
					}else{
						$("#expertAddBtn").html("保存");
			    		$("#expertAddBtn").attr("disabled",false);
					}
					parent.layer.msg(j.msg, {
						offset : 0,
						shift : 6
					});
				}, 'json');
	} else {
		parent.layer.msg('红色输入框必填', {
			offset : 0,
			shift : 6
		});
	}
}

function edit() {
	$("#expertEditBtn").html("正在提交中。。。");
	$("#expertEditBtn").attr("disabled","disabled");
	$('#expertEditForm').bootstrapValidator('validate');
	if ($('#expertEditForm').data('bootstrapValidator').isValid()) {
		$.post('resource/expert/edit', $('#expertEditForm').serialize(),
				function(j) {
					if (j.success) {
						parent.closeTab("tab_parentAddtabs");
						parent.layer.msg("编辑成功");
					}else{
						$("#expertEditBtn").html("保存");
			    		$("#expertEditBtn").attr("disabled",false);
					}
					parent.layer.msg(j.msg, {
						offset : 0,
						shift : 6
					});
				}, 'json');
	} else {
		parent.layer.msg('红色输入框必填', {
			offset : 0,
			shift : 6
		});
	}
}

function back() {
	parent.closeTab("tab_expertAddTab");
}

var mapDialog;
function getMap() {
	mapDialog = parent.layer.open({
		type : 2,
		title : '地点选择',
		area : [ '800px', '500px' ],
		content : 'gismap/common/map.jsp',
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow.getResult(
					index, window);
		},
	});
}

function select_organ() {
	parent.layer.open({
		type : 2,
		title : '添加单位',
		area : [ '500px', '500px' ],
		scrollbar : false,
		content : 'jsp/event/eventinfo/eventinfo_organ.jsp',
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			layero.find('iframe')[0].contentWindow.selectOrgan(index, window);
		}
	});
}

function select_type() {
	parent.layer.open({
		type : 2,
		title : '选择专家类型',
		area : [ '500px', '500px' ],
		scrollbar : false,
		content : 'jsp/resource/experttype/experttype_select.jsp',
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			layero.find('iframe')[0].contentWindow.selectType(index, window);
		}
	});
}