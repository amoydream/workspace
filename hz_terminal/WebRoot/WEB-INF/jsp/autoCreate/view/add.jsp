<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
var basePath = '<%=basePath%>';
function sourceClick(value,name){
	//打开数据源检索页面
	$("#sourceDialog").dialog({
		title:'对象检索',
		width: 500,
		height: 400,
		href: basePath+"Main/autoView/getSource",
		buttons: [{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
	    		var dba = $("#dbasource").datagrid("getSelected");
	    		$("#source_box").searchbox("setValue",dba.TABLE_NAME);
	    		$("#source_id").val(dba.TABLE_CODE);
	    		$("#sourceDialog").dialog('close');
	    		$("#attrGrid").datagrid("load",{"tcode":dba.TABLE_CODE});
			}}]
		});	
}
$(function(){
	$('#attrGrid').datagrid({
		url:basePath+'Main/autoView/getAttrData',
		idField:'ID',
		fit: true, //datagrid自适应宽度
        fitColumn: true, //列自适应宽度
        rownumbers:true,
        singleSelect: true,
		columns:[[
			{field:'ATTRNAME',title:'控件名称',width:200},
              { field: 'UITYPE', title: '控件类型', width: 100,
                  editor: { type: 'combobox', options: { required: true,valueField: 'label1',textField: 'value1',panelHeight:"auto",
            	 data: [{label1: '001',value1: '时间控件'},{label1: '002',value1: '输入框'},
	                	{label1: '003',value1: '下拉框'},{label1: '004',value1: '复选框'},
	                	{label1: '005',value1: '单选框'},{label1: '006',value1: '文本框'}]
                  } },formatter: function(value,row,index){
                      if(value=='001'){
	                      return '时间控件';
                      }else if(value=='002'){
                    	  return '输入框';
                      }else if(value=='003'){
                    	  return '下拉框';
                      }else if(value=='004'){
                    	  return '复选框';
                      }else if(value=='005'){
                    	  return '单选框';
                      }else if(value=='006'){
                    	  return '文本框';
                      }else{
                    	  return value;
                      }
                  }
              },
               { field: 'ISADD', title: '新增', width: 50,
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
               },{ field: 'ISEDIT', title: '修改', width: 50,
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
               },{ field: 'ISSEARCH', title: '查询', width: 50,
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
               },{ field: 'ISVIEW', title: '可见', width: 50,
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
               {field:'DEAFULVAL',title:'变量值',width:100,editor: { type: 'textbox' }},
               {field:'UIVAL',title:'变量文本',width:200,editor: { type: 'textbox' }},
               {field:'STATICVAL',title:'静态参数',width:100,editor: { type: 'textbox' }}
		]],
		onClickRow:function(rowIndex, rowData){
		$('#attrGrid').datagrid("beginEdit", rowIndex);
		}
	});
	
});
</script>
 	 <div class="easyui-layout"  data-options="fit:true">
	  <form id="autoView_form" method="post" action="<%=basePath%>Main/autoView/save" style="width:100%;margin: 0 auto;padding: 0;">
	  <div data-options="region:'north',border:false" style="height:208px;">
	    <table class="sp-table" width="100%" cellpadding="0" cellspacing="0">
		    	<tr>
		    	<td class="sp-td1">视图名称：</td>
		    	<td><input   name="t_AutoView.view_name" type="text" class="easyui-textbox" 
		    	data-options="required:true"  style="width: 200px;"/>  </td>
		    	
		  		<td class="sp-td1">对象：</td>
		    	<td >
		    	<input type="hidden" id="source_id" name="t_AutoView.data_source" />
		    	<input id="source_box" name="data_source" type="text" class="easyui-searchbox"  style="width: 200px;" 
		    	data-options="searcher:sourceClick"/>    
				</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">视图类型：</td>
		    	<td >
		    		<input type="checkbox" name="viewType" value="00M" style="width: 20px;" /><font style="font-size: 12px;">主页</font> 
		    		<input type="checkbox" name="viewType" value="00A" style="width: 20px;" /><font style="font-size: 12px;">新增</font>
		    		<input type="checkbox" name="viewType" value="00U" style="width: 20px;" /><font style="font-size: 12px;">修改</font>
		    	</td>
		    	
		    	<td class="sp-td1">页面地址：</td>
		    	<td >
		    		<input type="text" class="easyui-textbox" name="t_AutoView.view_path" style="width: 200px;" />
		    	</td>
		    	
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">表单列数：</td>
		    	<td >
		    		<input type="text" class="easyui-numberbox" name="fcol_num" style="width: 200px;" data-options="min:1,precision:0" value="2"/>
		    	</td>
		    	<td class="sp-td1">对象变量：</td>
		    	<td >
		    		<input type="text" class="easyui-textbox" name="varval" style="width: 200px;" />
		    	</td>
		    	</tr>
		    	<tr>
		    	<td class="sp-td1">控制类名称：</td>
		    	<td >
		    		<input type="text" class="easyui-textbox" name="t_AutoView.controller" style="width: 200px;" />
		    	</td>
		    	<td class="sp-td1">包路径：</td>
		    	<td >
		    		<input type="text" class="easyui-textbox" name="t_AutoView.pack_path" style="width: 200px;" />
		    	</td>
		    	</tr>
		    	<tr>
		  		<td class="sp-td1">主页布局：</td>
		    	<td colspan="3">
		    		<div>
		    		<input type="checkbox" name="viewlayout" value="north" style="width: 20px;" /><font style="font-size: 12px;">上</font>
		    		<font style="font-size: 12px;">高度</font><input type="text" name="viewWH_north"  style="width: 60px;border-left: 0;border-right: 0;border-top: 0;" />
		    		<input type="checkbox" name="viewlayout" value="center" style="width: 20px;" checked="checked"  /><font style="font-size: 12px;">中</font>
		    		<input type="checkbox" name="viewlayout" value="south" style="width: 20px;" /><font style="font-size: 12px;">下</font>
		    		<font style="font-size: 12px;">高度</font><input type="text" name="viewWH_south"  style="width: 60px;border-left: 0;border-right: 0;border-top: 0;" />
		    		
		    		<input type="checkbox" name="viewlayout" value="west" style="width: 20px;" /><font style="font-size: 12px;">左</font>
		    		<font style="font-size: 12px;">宽度</font><input type="text" name="viewWH_west"  style="width: 60px;border-left: 0;border-right: 0;border-top: 0;" />
		    		<input type="checkbox" name="viewlayout" value="east" style="width: 20px;" /><font style="font-size: 12px;">右</font>
		    		<font style="font-size: 12px;">宽度</font><input type="text" name="viewWH_east"  style="width: 60px;border-left: 0;border-right: 0;border-top: 0;" />
		    		</div>
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

<div id="sourceDialog"></div>