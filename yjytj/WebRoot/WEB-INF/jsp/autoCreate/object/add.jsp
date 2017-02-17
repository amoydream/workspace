<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$.extend($.fn.validatebox.defaults.rules, {  
    checkSignCode:{//检查编码唯一性
        validator: function (value) {  
    		var dbaname = $("#dbaname").combobox('getValue');
            var checkR=$.ajax({  
                async : false,    
                cache : false,  
                type : 'post',    
                url : basePath+'Main/autoObject/check',    
                data : {    
                    'signcode' : value ,
                    'dbaname' : dbaname
                }   
            }).responseText;    
            return checkR=="true";   
        },  
        message: '该编码已存在，请重新填写！'  
    },
    codeStyle: {// 校验编码格式
        validator: function (value) {
            return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);
        },
        message: '字母开头，允许6-16字节，允许字母、数字、下划线'
    }  
});   
$(function(){
	var rulegrid;
	var editRow = undefined;
	rulegrid = $("#attrGrid").datagrid({
			idField:'ID',
			fit: true, //datagrid自适应宽度
            fitColumn: true, //列自适应宽度
            rownumbers:true,
			 columns: [[//显示的列
		                 { field: 'ATTRNAME', title: '字段名称', width: 150, sortable: true,
		                     editor: { type: 'textbox', options: { required: true} }
		                 },
		                 { field: 'ATTRCODE', title: '字段编码', width: 150, sortable: true,
		                     editor: { type: 'textbox', options: { required: true} }
		                 },
		                  { field: 'ATTRTYPE', title: '字段类型', width: 100,
		                      editor: { type: 'combobox', options: { required: true,valueField: 'label1',textField: 'value1',panelHeight:"auto",
		                	 data: [{label1: '001',value1: '字符类型'},{label1: '002',value1: '整数类型'},
				                	{label1: '003',value1: '日期类型'},{label1: '004',value1: '文本类型'},
				                	{label1: '005',value1: '浮点类型'}]
		                      } },formatter: function(value,row,index){
			                      if(value=='001'){
				                      return '变长字符类型';
			                      }else if(value=='011'){
				                      return '定长字符类型';
			                      }else if(value=='002'){
			                    	  return '数值类型';
			                      }else if(value=='003'){
			                    	  return '日期类型';
			                      }else if(value=='004'){
			                    	  return '文本类型';
			                      }else if(value=='005'){
			                    	  return '浮点类型';
			                      }else{
			                    	  return value;
			                      }
		                      }
		                  },
		                  { field: 'ACODELEN', title: '字段长度', width: 150, sortable: true,
			                     editor: { type: 'textbox', options: { validType:'acodelen'} }
			                 },
		                   { field: 'ISPKID', title: '是否主键', width: 100,
		                       editor: { type: 'checkbox',options:{  on: "1",  off: "0"  } }
			                  ,formatter: function(value,row,index){
			                      if(value=='1'){
				                      return "<input type=\"checkbox\"  checked=\"checked\" disabled=\"disabled\"   >";
			                      }else if(value=='0'){
			                    	  return "<input type=\"checkbox\"  disabled=\"disabled\"  >";
			                      }else{
			                    	  return value;
			                      }
		                      }
		                   },
		                   { field: 'REMARK', title: '备注', width: 350,
			                     editor: { type: 'textbox' }
			                 }
		                   ]],
			toolbar: [{ text: '添加', iconCls: 'icon-add', handler: function () {//添加列表的操作按钮添加，修改，删除等
                //添加时先判断是否有开启编辑的行，如果有则把开户编辑的那行结束编辑
                if (editRow != undefined) {
                	rulegrid.datagrid("endEdit", editRow);
                }
                //添加时如果没有正在编辑的行，则在datagrid的第一行插入一行
                if (editRow == undefined) {
                	rulegrid.datagrid("insertRow", {
                        index: 0, // index start with 0
                        row: {

                        }
                    });
                    //将新插入的那一行开户编辑状态
                    rulegrid.datagrid("beginEdit", 0);
                    //给当前编辑的行赋值
                    editRow = 0;
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
                             /*var ids = [];
                             for (var i = 0; i < rows.length; i++) {
                                 ids.push(rows[i].ID);
                             }
                             //将选择到的行存入数组并用,分隔转换成字符串，
                             //本例只是前台操作没有与数据库进行交互所以此处只是弹出要传入后台的id
                             alert(ids.join(','));*/
                             var rindex = rulegrid.datagrid('getRowIndex',row);
                             rulegrid.datagrid("deleteRow",rindex);
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

</script>
 	 <div class="easyui-layout"  data-options="fit:true">
	  <form id="autoDBA" method="post" action="<%=basePath%>Main/autoObject/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:130px;">
	 
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">名称：</td>
		    	<td><input id="fname_ds"  name="t_AutoTable.table_name" type="text" class="easyui-textbox" 
		    	data-options="required:true"  style="width: 300px;"/>  </td>
		    	
		  		<td class="sp-td1">数据库编码：</td>
		    	<td >
		    	<input id="stime" name="t_AutoTable.table_code" type="text" class="easyui-textbox" 
		    	data-options="required:true,validType:['codeStyle','checkSignCode']" style="width: 300px;"/>    
				</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">数据库类型：</td>
		    	<td>
		    		<select class="easyui-combobox" name="t_AutoTable.dba_type" panelHeight="auto">
		    			<c:forEach items="${dbalist}" var="dbatype">
		    				<option value="${dbatype}">${dbatype}</option>
		    			</c:forEach>
		    		</select>
		    	</td>
		    	
		  		<td class="sp-td1">数据源：</td>
		    	<td >
		    		<select id="dbaname" class="easyui-combobox" name="t_AutoTable.dba_name" panelHeight="auto" style="width:80px;">
		    			<option value="">默认</option>
		    			<c:if test="${!empty dbaname}">
		    			<c:forEach items="${dbaname}" var="dba">
		    				<option value="${dba}">${dba}</option>
		    			</c:forEach>
		    			</c:if>
		    		</select>
		    		
				</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">是否生成model类：</td>
		    	<td >
		    		<input type="checkbox" name="ismodel" value="1" style="width: 20px;" />
		    	</td>
		    	<td class="sp-td1">包路径：</td>
		    	<td >
		    		<input type="text" class="easyui-textbox" name="modelpath" style="width: 300px;" />
		    	</td>
		    	</tr>
	    </table>
	   
	    </div>
	    <div data-options="region:'center',border:false">
	    <table id="attrGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			</table>
		</div>
		
		 
		</div>	
    </form>
</div>