var ids=[],zTree,treeNodes,arrayIds;
var setting = {
		check: {
			enable: true
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};
$(function(){
	$.post('system/moduleinfo/tree2', {}, function(j) {
		zTree = $.fn.zTree.init($("#treeDemo"), setting, j);
		var moduleids = $("#moduleids").val();
		if(moduleids.trim()!='' && moduleids!=null){
			arrayIds = moduleids.split(",");
			
			var nodes = zTree.getNodes();
			//console.info(nodes);
			for(var i=0;i<nodes.length;i++){
				if(arrayIds.in_array(nodes[i].id)){
					nodes[i].checked = true;
					zTree.updateNode(nodes[i]);
				}
				if(nodes[i].children!=undefined){
					recursionTree(zTree,nodes[i].children);
				}
			}
		}
	});
	
});
function recursionTree(zTree,nodes){
	for(var i=0;i<nodes.length;i++){
		if(arrayIds.in_array(nodes[i].id)){
			nodes[i].checked = true;
			zTree.updateNode(nodes[i]);
		}
		if(nodes[i].children!=undefined){
			recursionTree(zTree,nodes[i].children);
		}
	}
}
$('#role_addform').bootstrapValidator();
function roleAdd_submitForm(index,window) {
	var nodes = zTree.getCheckedNodes(true);
	for(var i=0;i<nodes.length;i++){
		ids.push(nodes[i].id);
	}
	//console.info(ids);
	$("#moduleids").val(ids.toString());
	$('#role_addform').bootstrapValidator('validate');
	if($('#role_addform').data('bootstrapValidator').isValid()){
		$.post('system/roleinfo/add', $('#role_addform').serialize(), function(j) {	
			if(j.success){
				parent.refresh('tab_roleinfo_iframe');
				parent.layer.close(index);
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
			offset : 0,
			shift : 6
		});
	}
}
$('#role_editform').bootstrapValidator();
function roleEdit_submitForm(index,window) {
	var nodes = zTree.getCheckedNodes(true);
	for(var i=0;i<nodes.length;i++){
		ids.push(nodes[i].id);
	}
	$("#moduleids").val(ids.toString());
	$('#role_editform').bootstrapValidator('validate');
	if($('#role_editform').data('bootstrapValidator').isValid()){
		$.post('system/roleinfo/edit', $('#role_editform').serialize(), function(j) {	
			if(j.success){
				parent.refresh('tab_roleinfo_iframe');
				parent.layer.close(index);
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
			offset : 0,
			shift : 6
		});
	}
}