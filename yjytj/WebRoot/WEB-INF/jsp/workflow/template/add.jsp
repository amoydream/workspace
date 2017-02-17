<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">   
$(function(){
	$("#wftemplatetype").combobox({
		onChange:function(newValue, oldValue){
			if("00A"==newValue){
				$("#lcdiv").show();
			}else{
				$("#lcdiv").hide();
			}
		}
		});
	var rulegrid;
	var editRow = undefined;
	var rleng = 0;
	rulegrid = $("#attrGrid").datagrid({
			idField:'ID',
			fit: true, //datagrid自适应宽度
            fitColumn: true, //列自适应宽度
            rownumbers:true,
			 columns: [[//显示的列
		                 { field: 'PNAME', title: '节点名称', width: 150, sortable: true,
		                     editor: { type: 'textbox' }
		                 },
		                  { field: 'PTYPE', title: '节点类型', width: 100,
		                      editor: { type: 'combobox', options: { valueField: 'label1',textField: 'value1',panelHeight:"auto",
		                	 data: [{label1: '00A',value1: '普通'}, {label1: '00H',value1: '会签'}]
		                      } },formatter: function(value,row,index){
			                      if(value=='00A'){
				                      return '普通';
			                      }else if(value=='00H'){
			                    	  return '会签';
			                      }else{
			                    	  return value;
			                      }
		                      }
		                  },
		                   { field: 'CHECKNAME', title: '审批人', width: 350,
		                       editor: { type: 'textbox', options: { icons:[{iconCls:'icon-search',
		                   		handler: function(e){
			                   		var editors = $('#attrGrid').datagrid('getEditors', editRow);
		               				checkUserClick($(e.data.target),$(editors[3]));
		          				}
			               		}]} }
		                   },
		                   { field: 'CHECKUSER', title: '审批人ID', width: 100,hidden:true ,editor: { type: 'textbox'}}
		                   ]],
			toolbar: [{ text: '添加', iconCls: 'icon-add', handler: function () {//添加列表的操作按钮添加，修改，删除等
                //添加时先判断是否有开启编辑的行，如果有则把开户编辑的那行结束编辑
                if (editRow != undefined) {
                	rulegrid.datagrid("endEdit", editRow);
                }
                //添加时如果没有正在编辑的行，则在datagrid的最后一行插入一行
                if (editRow == undefined) {
                	rulegrid.datagrid("insertRow", {
                        index: rleng, // index start with 0
                        row: {}
                    });
                    //将新插入的那一行开户编辑状态
                    rulegrid.datagrid("beginEdit", rleng);
                    //给当前编辑的行赋值
                    editRow = rleng;
                    rleng ++;
                }
                editRowType = editRow;
            }
            }, '-',
             { text: '删除', iconCls: 'icon-delete', handler: function () {
                 //删除时先获取选择行
                 var row = rulegrid.datagrid("getSelected");
                 //选择要删除的行
                 if (row!=null ) {
                     $.messager.confirm("提示", "你确定要删除吗?", function (r) {
                         if (r) {
                             var rindex = rulegrid.datagrid('getRowIndex',row);
                             rulegrid.datagrid("deleteRow",rindex);
                             rleng --;
                         }
                     });
                 }
                 else {
                     $.messager.alert("提示", "请选择要删除的行", "error");
                 }
             }
             }, '-',
             { text: '修改', iconCls: 'icon-edit', handler: function () {
                 //修改时要获取选择到的行
                 var rows = rulegrid.datagrid("getSelections");
                 //如果只选择了一行则可以进行修改，否则不操作
                 if (rows.length == 1) {
                     //修改之前先关闭已经开启的编辑行，当调用endEdit该方法时会触发onAfterEdit事件
                     if (editRow != undefined) {
                         rulegrid.datagrid("endEdit", editRow);
                     }
                     //当无编辑行时
                     if (editRow == undefined) {
                         //获取到当前选择行的下标
                         var index = rulegrid.datagrid("getRowIndex", rows[0]);
                         //开启编辑
                         rulegrid.datagrid("beginEdit", index);
                         //把当前开启编辑的行赋值给全局变量editRow
                         editRow = index;
                         //当开启了当前选择行的编辑状态之后，
                         //应该取消当前列表的所有选择行，要不然双击之后无法再选择其他行进行编辑
                         rulegrid.datagrid("unselectAll");
                     }
                 }
                 editRowType = editRow;
             }
             }, '-',
             { text: '确定', iconCls: 'icon-save', handler: function () {
                 //保存时结束当前编辑的行，自动触发onAfterEdit事件如果要与后台交互可将数据通过Ajax提交后台
                 rulegrid.datagrid("endEdit", editRow);
             }
             }, '-'],
            onAfterEdit: function (rowIndex, rowData, changes) {
                //endEdit该方法触发此事件
                console.info(rowData);
                editRow = undefined;
                editRowType = editRow;
            },
            onDblClickRow: function (rowIndex, rowData) {
            //双击开启编辑行
                if (editRow != undefined) {
                    rulegrid.datagrid("endEdit", editRow);
                }
                if (editRow == undefined) {
                    rulegrid.datagrid("beginEdit", rowIndex);
                    editRow = rowIndex;
                }
                editRowType = editRow;
            }
		});
});
function formClick(value,name){
	//打开检索页面
	$("#sourceTempDialog").dialog({
		title:'表单检索',
		width: 500,
		height: 400,
		href: basePath+"Main/wfTemplate/getFormView",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
	    		var dba = $("#wfFormSource").datagrid("getSelected");
	    		$("#wf_formBox").searchbox("setValue",dba.FNAME);
	    		$("#wf_id").val(dba.ID);
	    		$("#sourceTempDialog").dialog('close');
			}}]
		});	
}
function checkUserClick(e1,e2){
	//打开检索页面
	$("#checkUserDialog").dialog({
		title:'审批人检索',
		width: 500,
		height: 400,
		href: basePath+"Main/wfTemplate/getcheckUser",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var ctype = $('input[name="uradio"]:checked').val();
		    	var rows = $("#usertable").treegrid("getChecked");
		    	var cname = '';
		    	var cid = '';
		    	if(rows && "role"==ctype){
			    	for(var i=0;i<rows.length;i++){
				    	cname = cname+","+rows[i].CHECKNAME;
				    	cid = cid+",r_"+rows[i].ID;
			    	}
		    	}
		    	if("user"==ctype){
		    		$("input:checkbox[name='userBox']:checked").each(function(){
		    			cname = cname+","+this.value;
				    	cid = cid+","+this.id;
		    		});
			    }
			    if(cname!=''){
			    	e1.textbox('setValue', cname.substring(1));
		   			$(e2[0].target).textbox('setValue',cid.substring(1));
		   			$("#checkUserDialog").dialog('close');
				}else{
			    	alert("请选择审批人！");
		    	}
	    		
			}}]
		});
}

</script>
 	 <div class="easyui-layout"  data-options="fit:true">
	  <form id="wfTemplate" method="post" action="<%=basePath%>Main/wfTemplate/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:160px;">
	 <input name="act" type="hidden" value="add"/>
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">流程名称：</td>
		    	<td><input id="fname_ds"  name="t_WF_Template.tname" type="text" class="easyui-textbox" data-options="required:true"  style="width: 200px;"/>  </td>
		    	
		  		<td class="sp-td1">流程方式：</td>
		    	<td><select id="wftemplatetype" name="t_WF_Template.ftype" class="easyui-combobox" panelHeight="auto" code="LCFS" style="width: 100px;" ></select>
				</td>
		    	</tr>
		    	<tr>
				<td class="sp-td1">流程表单：</td>
				<td >
		    	<input type="hidden" id="wf_id" name="t_WF_Template.formid" />
		    	<input id="wf_formBox" name="wf_name" type="text" class="easyui-searchbox"  style="width: 200px;" 
		    	data-options="searcher:formClick"/>    
				</td>
				<td class="sp-td1">流程类型：</td>
		    	<td><select name="t_WF_Template.tcode" class="easyui-combobox" panelHeight="auto" code="LCLX"  style="width: 100px;"></select>
				</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">描述：</td>
		    	<td colspan="3">
		    		<textarea name="t_WF_Template.remark" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width: 500px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
	    </table>
	    
	    </div>
	    <div  data-options="region:'center',border:false" >
	    <div id="lcdiv" style="display: none;width: 100%;height: 100%;">
	    <table id="attrGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			</table>
		</div>
		</div>
		
		 	
    </form>
</div>

<div id="sourceTempDialog"></div>
<div id="checkUserDialog"></div>