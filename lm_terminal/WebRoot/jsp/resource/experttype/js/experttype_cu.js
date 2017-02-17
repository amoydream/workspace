$('#typeAddForm').bootstrapValidator();
$('#typeEditForm').bootstrapValidator();
function typeAddSubmitForm(index, p) {
	$('#typeAddForm').bootstrapValidator('validate');
	if ($('#typeAddForm').data('bootstrapValidator').isValid()) {
		$.post('resource/experttype/add', $('#typeAddForm').serialize(),
				function(j) {
					if (j.success) {
						parent.layer.msg("添加成功");
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

function typeEditSubmitForm(index, p) {
	$('#typeEditForm').bootstrapValidator('validate');
	if ($('#typeEditForm').data('bootstrapValidator').isValid()) {
		$.post('resource/experttype/edit', $('#typeEditForm').serialize(),
				function(j) {
					if (j.success) {
						parent.layer.msg("编辑成功");
						parent.layer.close(index);
						p.postChild($("#pid").val());
					}
					parent.layer.msg(j.msg, {
					    offset: 0,
					    shift: 6
					});
				}, 'json');
			}else {
				parent.layer.msg('红色输入框必填', {
				    offset: 0,
				    shift: 6
				});
			}
}