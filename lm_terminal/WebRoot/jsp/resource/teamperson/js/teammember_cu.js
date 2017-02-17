$('#memberAddForm').bootstrapValidator();
$('#memberEditForm').bootstrapValidator();

function add(index,window,teId){
	$('#memberAddForm').bootstrapValidator('validate');
	if($('#memberAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/teammember/add?teId='+teId, $('#memberAddForm').serialize(), function(j) {	
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
		parent.layer.tips('红色输入框必填', '.layui-layer-btn0',{
		    tips: 1
		});
	}
}

function edit(index,window){
	$('#memberEditForm').bootstrapValidator('validate');
	if($('#memberEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/teammember/edit', $('#memberEditForm').serialize(),function(j){
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
			parent.layer.tips('红色输入框必填', '.layui-layer-btn0',{
			    tips: 1
			});
		}
}