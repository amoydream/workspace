<%@ page language='java' import='java.util.*' pageEncoding='utf-8'%>
<%@ include file='/include/inc.jsp'%>
<script type='text/javascript'>
	var fax_organTree;
    var selected_organ;
    var tree_options = {
        data : {
	        simpleData : {
	            enable : true,
	            idKey : 'id',
	            pIdKey : 'pid'
	        }
        },
        callback : {
	        onClick : nodeOnClick
        }
    };

    function nodeOnClick(event, treeId, treeNode) {
	    if(treeNode.id == 0) {
		    return;
	    }
	    $('#fax_organGrid').datagrid({
	        url : 'Main/communication/ccms/fax/getOrgans',
	        queryParams : {
		        pid : treeNode.id
	        }
	    });
	    var rows = $('#fax_organGrid').datagrid('getRows');
	    for(var i = 0; i < rows.length; i++) {
		    var FAX_NUMBER = rows[i].FAX_NUMBER;
		    if(FAX_NUMBER != null) {
			    var tags = $('#select_tagger').tagger('getTags');
			    if(tags != null || tags.length > 0) {
				    for(var j = 0; j < tags.length; j++) {
					    if(tags[j].FAX_NUMBER == FAX_NUMBER) {
						    var rowIndex = $('#fax_organGrid').datagrid('getRowIndex', FAX_NUMBER);
						    $('#fax_organGrid').datagrid('checkRow', rowIndex);
						    break;
					    }
				    }
			    }
		    }
	    }
	    selected_organ = fax_organTree.getSelectedNodes()[0];
    };

    function fax_initOrganTree() {
	    $.ajax({
	        cache : false,
	        type : 'POST',
	        dataType : 'json',
	        data : {
	            idKey : 'id',
	            pidKey : 'pid'
	        },
	        url : 'Main/communication/ccms/fax/getOrganTree',
	        error : function() {
		        $.lauvan.msg('请求失败');
	        },
	        success : function(data) {
		        if(fax_organTree != null) {
			        fax_organTree.destroy();
		        }
		        fax_organTree = $.fn.zTree.init($('#fax_organTree'), tree_options, data);
		        if(!selected_organ) {
			        selected_organ = fax_organTree.getNodeByParam('id', '0', null);
			        if(selected_organ.children && selected_organ.children.length > 0) {
				        selected_organ = selected_organ.children[0];
			        }
		        }
		        fax_organTree.selectNode(selected_organ);
		        fax_organTree.expandNode(selected_organ, true, false, false);
		        fax_organTree.setting.callback.onClick(null, fax_organTree.setting.treeId, selected_organ);
	        }
	    });
    }

    $(function() {
	    var options = {
	        fitColumns : true,
	        idField : 'FAX_NUMBER',
	        fit : true,
	        onCheck : function(index, data) {
		        var FAX_NUMBER = data.FAX_NUMBER;
		        if(FAX_NUMBER != null && FAX_NUMBER != '') {
			        $('#select_tagger').tagger('addTag', data);
		        }
	        },
	        onUncheck : function(index, data) {
		        var FAX_NUMBER = data.FAX_NUMBER;
		        if(FAX_NUMBER != null && FAX_NUMBER != '') {
			        $('#select_tagger').tagger('removeTag', FAX_NUMBER);
		        }
	        },
	        onCheckAll : function(rows) {
		        for(var i = 0; i < rows.length; i++) {
			        var FAX_NUMBER = rows[i].FAX_NUMBER;
			        if(FAX_NUMBER != null && FAX_NUMBER != '') {
				        $('#select_tagger').tagger('addTag', rows[i]);
			        }
		        }
	        },
	        onUncheckAll : function(rows) {
		        for(var i = 0; i < rows.length; i++) {
			        var FAX_NUMBER = rows[i].FAX_NUMBER;
			        if(FAX_NUMBER != null && FAX_NUMBER != '') {
				        $('#select_tagger').tagger('removeTag', FAX_NUMBER);
			        }
		        }
	        }
	    };
	    fax_initOrganTree();
	    $.lauvan.dataGrid('fax_organGrid', options);
	    var tagger_options = {
	        placeholderText : 'Add...',
	        maxNbTags : false,
	        confirmDelete : true,
	        caseSensitive : false,
	        disableAdd : false,
	        tagId : 'FAX_NUMBER',
	        tagName : 'OR_NAME',
	        clearBtn : true,
	        onRemoveTag : onRemoveTag,
	        validateFn : check_FAX,
	        clearFn : clearAll
	    };
	    $('#select_tagger').tagger(tagger_options);
	    if(fax_receivers.length > 0) {
		    $('#select_tagger').tagger('setTags', fax_receivers);
	    }
    });

    function onRemoveTag(tagId) {
	    var rowIndex = $('#fax_organGrid').datagrid('getRowIndex', tagId);
	    if(rowIndex != -1) {
		    $('#fax_organGrid').datagrid('uncheckRow', rowIndex);
	    } else {
		    $('#select_tagger').tagger('removeTag', tagId);
	    }
    }

    function clearAll() {
	    var tags = $('#select_tagger').tagger('getTags');
	    if(tags != null || tags.length > 0) {
		    for(var i = 0; i < tags.length; i++) {
			    var FAX_NUMBER = tags[i].FAX_NUMBER;
			    if(FAX_NUMBER != null) {
				    $('#select_tagger').tagger('removeTag', FAX_NUMBER);
				    var rowIndex = $('#fax_organGrid').datagrid('getRowIndex', FAX_NUMBER);
				    if(rowIndex != -1) {
					    $('#fax_organGrid').datagrid('uncheckRow', rowIndex);
				    }
			    }
		    }
	    }
    }
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',border:false" style="width: 200px;">
		<ul id="fax_organTree" class="ztree"></ul>
	</div>
	<div data-options="region:'center',border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',border:false">
				<table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="3">
							<select id="select_tagger" style="width: 520px;" />
						</td>
					</tr>
				</table>
			</div>
			<div data-options="region:'center',border:false">
				<table id="fax_organGrid" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th field="OR_NAME" width="30%">机构名称</th>
							<th field="FAX_NUMBER" width="35%">传真号码</th>
							<th field="TEL_OFFICE" width="35%">办公电话</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
