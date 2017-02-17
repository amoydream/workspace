$('#suppliesAddForm').bootstrapValidator();
$('#suppliesEditForm').bootstrapValidator();

function suppliesAddSubmitForm(index, p) {
	$('#suppliesAddForm').bootstrapValidator('validate');
	if ($('#suppliesAddForm').data('bootstrapValidator').isValid()) {
		$.post('resource/supplies/add', $('#suppliesAddForm').serialize(),
				function(j) {
					if (j.success) {
						parent.layer.close(index);
						p.postChild($("#pid").val());
					}
					parent.layer.msg(j.msg, {
					    offset: 0,
					    shift: 6
					});
				}, 'json');
	} else {
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}

function suppliesEditSubmitForm(index, p) {
	$('#suppliesEditForm').bootstrapValidator('validate');
	if ($('#suppliesEditForm').data('bootstrapValidator').isValid()) {
		$.post('resource/supplies/edit', $('#suppliesEditForm').serialize(),
				function(j) {
					if (j.success) {
						parent.layer.close(index);
						p.postChild($("#pid").val());
					}
					parent.layer.msg(j.msg, {
					    offset: 0,
					    shift: 6
					});
				}, 'json');
	} else {
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}