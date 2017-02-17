<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
$.extend($.fn.validatebox.defaults.rules, {  
    checkSignCode:{//检查编码唯一性
        validator: function (value) {  
            var checkR=$.ajax({  
                async : false,    
                cache : false,  
                type : 'post',    
                url : basePath+'Main/wfForm/check',    
                data : {    
                    'signcode' : value  
                }   
            }).responseText;    
            return checkR==="true";   
        },  
        message: '该编码已存在，请重新填写！'  
    },
    codeStyle: {// 校验编码格式
        validator: function (value) {
            return /^[a-zA-Z][a-zA-Z0-9]{5,15}$/i.test(value);
        },
        message: '字母开头，允许6-16字节，允许字母数字'
    }  
});   
$(function(){
	var rulegrid;
	var editRow = undefined;
	rulegrid = $("#attrGrid").datagrid({
			idField:'ID',
			fit: true, //datagrid自适应宽度
            fitColumn: false, //列自适应宽度
            rownumbers:true,
			 columns: [[//显示的列
		                 { field: 'ATTRNAME', title: '属性名称', width: 150, sortable: true,
		                     editor: { type: 'textbox', options: { required: true} }
		                 },
		                  { field: 'SQLTYPE', title: '属性类型', width: 100,
		                      editor: { type: 'combobox', options: { required: true,valueField: 'label1',textField: 'value1',panelHeight:"auto",
		                	 data: [{label1: '001',value1: '时间类型'},{label1: '011',value1: '日期类型'},
		                	        {label1: '002',value1: '数值类型'},{label1: '003',value1: '布尔类型'},
		                	        {label1: '004',value1: '字符类型'},{label1: '005',value1: '文本类型'},
		                	        {label1: '006',value1: '下拉类型'}]
		                      } },formatter: function(value,row,index){
			                      if(value=='001'){
				                      return '时间类型';
			                      }else if(value=='011'){
			                    	  return '日期类型';
			                      }else if(value=='002'){
			                    	  return '数值类型';
			                      }else if(value=='003'){
			                    	  return '布尔类型';
			                      }else if(value=='004'){
			                    	  return '字符类型';
			                      }else if(value=='005'){
			                    	  return '文本类型';
			                      }else if(value=='006'){
			                    	  return '下拉类型';
			                      }else{
			                    	  return value;
			                      }
		                      }
		                  },
		                   { field: 'SYMBOL', title: '统计标志', width: 100,
		                       editor: { type: 'combobox',options:{valueField: 'label',textField: 'value',
		                       data: [{label: '001',value: '开始时间'},{label: '002',value: '结束时间'}],panelHeight:"auto"} }
			                  ,formatter: function(value,row,index){
			                      if(value=='001'){
				                      return '开始时间';
			                      }else if(value=='002'){
			                    	  return '结束时间';
			                      }else{
			                    	  return value;
			                      }
		                      }
		                   },
			               { field: 'DEFVALUE', title: '默认标示', width: 150,
			                    editor: { type: 'combobox',options:{valueField: 'label2',textField: 'value2',
		                       data: [{label2: '001',value2: '申请人名称'},{label2: '002',value2: '申请部门名称'},
				                       {label2: '003',value2: '申请人名称（可编辑）'}],panelHeight:"auto"} }
		                   ,formatter: function(value,row,index){
			                      if(value=='001'){
				                      return '申请人名称';
			                      }else if(value=='002'){
				                      return '申请部门名称';
			                      }else if(value=='003'){
			                    	  return '申请人名称（可编辑）';
			                      }else{
			                    	  return value;
			                      }
		                      }
			                },
			                { field: 'NUMGS', title: '数值格式', width: 100,
			                    editor: { type: 'textbox' }
			                },
			                { field: 'SELCONTENT', title: '下拉列表字段', width: 200,
			                     editor: { type: 'textbox' }
			                 },
			                 { field: 'SELFALG', title: '下拉其他标志', width: 100,
			                       editor: { type: 'combobox',options:{valueField: 'label3',textField: 'value3',
			                       data: [{label3: '0',value3: '否'},{label3: '1',value3: '是'}],panelHeight:"auto"} }
				                  ,formatter: function(value,row,index){
				                      if(value=='0'){
					                      return '否';
				                      }else if(value=='1'){
				                    	  return '是';
				                      }else{
				                    	  return value;
				                      }
			                      }
			                   },
			                 { field: 'REMARK', title: '描述', width: 300,
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
                           //保存编辑内容到缓存中去
                             var fname = $('#fname_ds').textbox('getValue');
                             var rows = rulegrid.datagrid("getData");
                             rows.fname = fname;
                       	  $("#attrview").load(basePath+"Main/wfForm/attrView",rows);
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
                 /*var rows = rulegrid.datagrid("getRows");
                 var rdata = "";
                 var flag = false;
                 for(var i=0;i<rows.length;i++){
                     //rdata.push({"name":rows[i].ATTRNAME,"atype":rows[i].SQLTYPE});
                    if(rows[i].ATTRNAME==null ||rows[i].ATTRNAME=="" ||rows[i].SQLTYPE==null || rows[i].SQLTYPE==""){
                        flag = true;
                        break;
                    }
                    rdata=rdata+"&name_"+i+"="+rows[i].ATTRNAME+"&atype_"+i+"="+rows[i].SQLTYPE;
                 }
                 if(!flag && rdata.length>0){
	                 //打开表单视图
	                 var fname = $("#fname").val();
	                 var attrArray={
	         				title:'表单视图',
	         				width: 800,
	         				height: 500,
	         				href: basePath+"Main/wfForm/attrView?fname="+fname+"&rsize="+rows.length+rdata
	         		};
	         		$.lauvan.openCustomDialog("attrDSDialog",attrArray,null);
                }*/
             }
             }, '-'],
            onAfterEdit: function (rowIndex, rowData, changes) {
                //endEdit该方法触发此事件
                console.info(rowData);
                editRow = undefined;
                editRowType = editRow;
              //保存编辑内容到缓存中去
              var fname = $('#fname_ds').textbox('getValue');
              var rows = rulegrid.datagrid("getData");
              rows.fname = fname;
        	  $("#attrview").load(basePath+"Main/wfForm/attrView",rows);
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
	  <form id="wf_form" method="post" action="<%=basePath%>Main/wfForm/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:112px;">
	 
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">表单名称：</td>
		    	<td><input id="fname_ds"  name="t_WF_Form.fname" type="text" class="easyui-textbox" data-options="required:true"  style="width: 300px;"/>  </td>
		    	
		  		<td class="sp-td1">表单编码：</td>
		    	<td >
		    	<input id="stime" name="t_WF_Form.fcode" type="text" class="easyui-textbox" data-options="required:true,validType:['codeStyle','checkSignCode']" style="width: 300px;"/>    
				</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">描述：</td>
		    	<td colspan="3">
		    		<textarea name="t_WF_Form.remark" class="textbox easyui-validatebox" 
		    		data-options="validType:'length[0,200]'"  style="width: 800px;height: 50px;" ></textarea>
		    	</td>
		    	</tr>
	    </table>
	    
	    </div>
	    <div data-options="region:'center',border:false">
	    <table id="attrGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			</table>
		</div>
		
		 <div data-options="region:'south',border:false" style="height:150px;">
		    <div id="attrview" >   
		    <p>表单详情</p>    
		</div>
		</div>	
    </form>
</div>