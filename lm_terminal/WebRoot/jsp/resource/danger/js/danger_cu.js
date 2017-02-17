$('#dangerAddForm').bootstrapValidator();
$('#dangerEditForm').bootstrapValidator();

$(function() {
	$("#da_Patroldate").datetimepicker({
		language : 'zh-CN',
		format : 'yyyy-mm-dd',
		minView : 2,
		autoclose : true
	});
});

function dangerAddSubmitForm(index, p) {
	$('#dangerAddForm').bootstrapValidator('validate');
	if ($('#dangerAddForm').data('bootstrapValidator').isValid()) {
		$.post('resource/danger/add', $('#dangerAddForm').serialize(),
				function(j) {
					if (j.success) {
						parent.layer.close(index);
						p.postChild($("#pid").val());
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
function dangerEditSubmitForm(index, p) {
	$('#dangerEditForm').bootstrapValidator('validate');
	if ($('#dangerEditForm').data('bootstrapValidator').isValid()) {
		$.post('resource/danger/edit', $('#dangerEditForm').serialize(),
				function(j) {
					if (j.success) {
						parent.layer.close(index);
						p.postChild($("#pid").val());
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