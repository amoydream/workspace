$('#resAddForm').bootstrapValidator();
$('#resEditForm').bootstrapValidator();

function squareAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/squareAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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

function schoolAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/schoolAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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

function bazaarAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/bazaarAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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

function supermarketAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/supermarketAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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

function hospitalAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/hospitalAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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

function reservoirAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/reservoirAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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

function uptownAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/uptownAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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

function companyAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/companyAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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

function busstationAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/busstationAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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

function entertainmentAdd(index,window){
	$('#resAddForm').bootstrapValidator('validate');
	if($('#resAddForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/entertainmentAdd', $('#resAddForm').serialize(), function(j) {	
			if(j.success){
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




function squareEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/squareEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function schoolEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/schoolEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function bazaarEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/bazaarEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function supermarketEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/supermarketEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function hospitalEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/hospitalEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function reservoirEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/reservoirEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function uptownEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/uptownEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function companyEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/companyEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function busstationEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/busstationEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function entertainmentEdit(index,window){
	$('#resEditForm').bootstrapValidator('validate');
	if($('#resEditForm').data('bootstrapValidator').isValid()){
		$.post('resource/assets/entertainmentEdit', $('#resEditForm').serialize(),function(j){
				if(j.success){
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

function select_organ(){
	parent.layer.open({
	    type: 2,
	    title:'添加单位',
	    area:['500px','500px'],
	    scrollbar: false,
	    content: 'jsp/event/eventinfo/eventinfo_organ.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.selectOrgan(index,window);
	    }
	});
}


