$('#typeAddForm').bootstrapValidator();
function typeAddSubmitForm(index,p) {
	$('#typeAddForm').bootstrapValidator('validate');
	if($('#typeAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/dangertype/add',$('#typeAddForm').serialize(), function(j) {
			if(j.success){
				parent.layer.close(index);
				p.postChild($("#pid").val());
			}
			parent.layer.msg(j.msg, {
				offset : 0,
				shift : 6
			});
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
			offset : 0,
			shift : 6
		});
	}
}

$('#typeEditForm').bootstrapValidator();
function typeEditSubmitForm(index,p) {
	$('#typeEditForm').bootstrapValidator('validate');
	if($('#typeEditForm').data('bootstrapValidator').isValid()){
				$.post('resource/dangertype/edit',
						$('#typeEditForm').serialize(), function(j) {
					if(j.success){
						parent.layer.close(index);
						p.postChild($("#pid").val());
					}
					parent.layer.msg(j.msg, {
						offset : 0,
						shift : 6
					});
				}, 'json');
			}else{
				parent.layer.msg('红色输入框必填', {
					offset : 0,
					shift : 6
				});
			}
		}