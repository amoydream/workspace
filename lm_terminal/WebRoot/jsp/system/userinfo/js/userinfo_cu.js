var useradd_vo_Code,useradd_searchVo,useradd_organ_select;
$('#user_addform').bootstrapValidator();
function userAdd_submitForm(index,window) {
	$('#user_addform').bootstrapValidator('validate');
	if($('#user_addform').data('bootstrapValidator').isValid()){
		$.post('system/userinfo/add', $('#user_addform').serialize(), function(j) {	
			if(j.success){
				parent.refresh('tab_userinfo_iframe');
				parent.layer.close(index);
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
$('#user_editform').bootstrapValidator();
function userEdit_submitForm(index,window) {
		$('#user_editform').bootstrapValidator('validate');
		if($('#user_editform').data('bootstrapValidator').isValid()){
				$.post('system/userinfo/edit', $('#user_editform').serialize(), function(j) {	
					if(j.success){
						parent.refresh('tab_userinfo_iframe');
						parent.layer.close(index);
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
function check_voice(v){
	$.post('system/voicetable/checkCode', {code:v}, function(j) {	
		if(j.success){
			$("#vo_Code").val("");
		}
		parent.layer.msg(j.msg, {
		    offset: 0,
		    shift: 6
		});
	}, 'json');
}
