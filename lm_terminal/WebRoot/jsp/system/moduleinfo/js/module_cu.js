$('#module_addform').bootstrapValidator();
function moduleAdd_submitForm(index,p) {
	$('#module_addform').bootstrapValidator('validate');
	if($('#module_addform').data('bootstrapValidator').isValid()){
		$.post('system/moduleinfo/add',$('#module_addform').serialize(), function(j) {
			if(j.success){
				parent.layer.close(index);
				p.postChild($("#mo_Pid").val());
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}
$('#module_editform').bootstrapValidator();
function moduleEdit_submitForm(index,p) {
	$('#module_editform').bootstrapValidator('validate');
	if($('#module_editform').data('bootstrapValidator').isValid()){
				$.post('system/moduleinfo/edit',
						$('#module_editform').serialize(), function(j) {
					if(j.success){
						parent.layer.close(index);
						p.postChild($("#mo_Pid").val());
					}
					parent.layer.msg(j.msg, {
					    offset: 0,
					    shift: 6
					});
				}, 'json');
			}else{
				parent.layer.msg('红色输入框必填', {
				    offset: 0,
				    shift: 6
				});
			}
		}