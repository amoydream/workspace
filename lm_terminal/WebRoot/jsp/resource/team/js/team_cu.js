$('#teamAddForm').bootstrapValidator();
$('#teamEditForm').bootstrapValidator();

function add(index, window) {
	$('#teamAddForm').bootstrapValidator('validate');
	if ($('#teamAddForm').data('bootstrapValidator').isValid()) {
		$.post('resource/team/add', $('#teamAddForm').serialize(), function(j) {
			if (j.success) {
				parent.layer.close(index);
				window.location.reload();
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
function edit(index, window) {
	$('#teamEditForm').bootstrapValidator('validate');
	if ($('#teamEditForm').data('bootstrapValidator').isValid()) {
		$.post('resource/team/edit', $('#teamEditForm').serialize(),
				function(j) {
					if (j.success) {
						parent.layer.close(index);
						window.location.reload();
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

