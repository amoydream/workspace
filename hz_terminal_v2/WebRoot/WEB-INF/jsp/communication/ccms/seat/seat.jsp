<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<script>
	var seat_deptree;
    var selected_dept;
    var tree_setting = {
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
	    $('#seat_grid').datagrid({
	        url : 'Main/communication/ccms/seat/getByDeptId',
	        queryParams : {
		        pid : treeNode.id
	        }
	    });
	    selected_dept = seat_deptree.getSelectedNodes()[0];
	    $('#seat_grid').datagrid('clearSelections');
	    $('#seat_grid').datagrid('clearChecked');
    };

    function seat_initDeptree() {
	    $.ajax({
	        cache : false,
	        type : 'post',
	        dataType : 'json',
	        data : {
	            idKey : 'id',
	            pidKey : 'pid'
	        },
	        url : 'Main/department/getTreeData',
	        error : function() {
		        $.lauvan.msg('请求失败');
	        },
	        success : function(data) {
		        if(seat_deptree != null) {
			        seat_deptree.destroy();
		        }
		        seat_deptree = $.fn.zTree.init($('#seat_deptree'), tree_setting, data);
		        if(!selected_dept) {
			        selected_dept = seat_deptree.getNodeByParam('id', '0', null);
			        if(selected_dept.children && selected_dept.children.length > 0) {
				        selected_dept = selected_dept.children[0];
			        }
		        }
		        seat_deptree.selectNode(selected_dept);
		        seat_deptree.expandNode(selected_dept, true, false, false);
		        seat_deptree.setting.callback.onClick(null, seat_deptree.setting.treeId, selected_dept);
	        }
	    });
    }

    function seat_refresh() {
	    seat_deptree.setting.callback.onClick(null, seat_deptree.setting.treeId, selected_dept);
    }

    $(function() {
	    seat_initDeptree();
	    var setting = {
	        idField : 'SEAT_ID',
	        fitColumns : true,
	        toolbar : [{
	            text : '添加',
	            title : '添加座席',
	            iconCls : 'icon-add',
	            handler : seat_add
	        }, '-', {
	            text : '修改',
	            title : '修改座席',
	            iconCls : 'icon-pageedit',
	            handler : seat_edit
	        }, '-', {
	            text : '删除',
	            iconCls : 'icon-delete',
	            delParams : {
		            url : 'Main/communication/ccms/seat/delete'
	            }
	        }]
	    };
	    $.lauvan.dataGrid('seat_grid', setting);
    });

    function save($dialog) {
	    $('#seat_from').form('submit', {
	        onSubmit : function() {
		        return $(this).form('enableValidation').form('validate');
	        },
	        success : function(result) {
		        var obj = $.parseJSON(result);
		        if(!obj.success) {
			        $.lauvan.MsgShow({
				        msg : obj.msg
			        });
		        } else {
			        $dialog.dialog('close');
			        seat_refresh();
		        }
	        }
	    });
    }

    function seat_add() {
	    var options = $(this).linkbutton('options');
	    var setting = {
	        title : options.title,
	        width : 400,
	        height : 250,
	        iconCls : options.iconCls,
	        href : 'Main/communication/ccms/seat/add/' + seat_deptree.getSelectedNodes()[0].id
	    };
	    $.lauvan.openCustomDialog('seat_dialog', setting, function() {
		    save($('#seat_dialog'), 'seat_from');
	    });
    }

    function seat_edit() {
	    var row = $('#seat_grid').datagrid('getSelected');
	    if(!row) {
		    $.lauvan.msg('请选择要修改的记录');
		    return;
	    }

	    var options = $(this).linkbutton('options');
	    var setting = {
	        title : options.title,
	        width : 400,
	        height : 250,
	        iconCls : options.iconCls,
	        href : 'Main/communication/ccms/seat/edit/' + row.SEAT_ID
	    };
	    $.lauvan.openCustomDialog('seat_dialog', setting, function() {
		    save($('#seat_dialog'), 'seat_from');
	    });
    }
</script>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true,border:false" style="width: 230px">
		<ul id="seat_deptree" class="ztree"></ul>
	</div>
	<div data-options="region:'center',border:false">
		<table id="seat_grid" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th field="ID" data-options="hidden:true">ID</th>
					<th field="LOGINIP" width="25%">登陆IP</th>
					<th field="SEATIP" width="25%">坐席IP</th>
					<th field="SEATID" width="25%">座席号码</th>
					<th field="PRIORITY" width="25%">优先级</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
