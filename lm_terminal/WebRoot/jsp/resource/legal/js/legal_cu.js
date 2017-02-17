$('#legalAddForm').bootstrapValidator();
$('#legalEditForm').bootstrapValidator();
$(function() {
	$("#le_Effectivedate").datetimepicker({
		language : 'zh-CN',
		format : 'yyyy-mm-dd',
		minView : 2,
		autoclose : true
	});
	$("#le_Validity").datetimepicker({
		language : 'zh-CN',
		format : 'yyyy-mm-dd',
		minView : 2,
		autoclose : true
	});
});

var editor;
KindEditor.ready(function(K) {
	editor = K.create('textarea[name="le_Content"]', {
		cssPath : 'lauvanUI/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : 'lauvanUI/kindeditor/file-upload',
		fileManagerJson : 'lauvanUI/kindeditor/file-manager',
		allowFileManager : true,
		afterCreate : function() {
			var self = this;
			K.ctrl(document, 13, function() {
				self.sync();
				document.forms['legalEditForm'].submit();
			});
			K.ctrl(self.edit.doc, 13, function() {
				self.sync();
				document.forms['legalEditForm'].submit();
			});
		}
	});
});

function legalAddSubmitForm() {
	$("#legalAddBtn").html("正在提交中。。。");
	$("#legalAddBtn").attr("disabled","disabled");
	$('#legalAddForm').bootstrapValidator('validate');
	if ($('#legalAddForm').data('bootstrapValidator').isValid()) {
		$('#le_Content').val(editor.html());
		$.post('resource/legal/add', $('#legalAddForm').serialize(),
				function(j) {
					if (j.success) {
						parent.closeTab("tab_tab_legalAddTab_iframe");
						parent.layer.msg("添加成功");						
					}else{
						$("#legalAddBtn").html("保存");
			    		$("#legalAddBtn").attr("disabled",false);
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

function legalEditSubmitForm() {
	$("#legalEditBtn").html("正在提交中。。。");
	$("#legalEditBtn").attr("disabled","disabled");
	$('#legalEditForm').bootstrapValidator('validate');
	if ($('#legalEditForm').data('bootstrapValidator').isValid()) {
		$('#le_Content').val(editor.html());
		$.post('resource/legal/edit', $('#legalEditForm').serialize(),
				function(j) {
					if (j.success) {
						parent.closeTab("tab_parentAddtabs");
						parent.layer.msg("编辑成功");
					}else{
						$("#legalEditBtn").html("保存");
			    		$("#legalEditBtn").attr("disabled",false);
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
