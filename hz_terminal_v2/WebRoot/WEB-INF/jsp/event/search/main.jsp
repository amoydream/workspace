<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	$(function(){
		var attrArray ={ toolbar: [
                  { text: '新增值班详情纪要',title:'新增值班详情纪要', iconCls: 'icon-add',handler:addEvDuty}, '-', 
                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/event/delete'}}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/eventSearch/getGridData",
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			var url = "";
			if(rowData.EV_STATE=='00X'){
				url="Main/event/view/"+rowData.ID+"-search";
		    }else{
			    url = "Main/eventRoutine/view/"+rowData.ID+"-search";
		    }
			var mainTab=$("#mainTab");
			if (mainTab.tabs('exists', "事件详情")){
		    	mainTab.tabs('select', "事件详情");
		    	// 调用 'refresh' 方法更新选项卡面板的内容
		    	var tab = mainTab.tabs('getSelected');  // 获取选择的面板
		    	tab.panel('refresh', url);
		    } else {
			    mainTab.tabs('add',{
			       title:"事件详情",
			       href:url,
			        closable:true
			    });
		    }
		}
		};
		$.lauvan.dataGrid("eventSearchGrid",attrArray);
		});
	function addEvDuty(){
		var rows = $('#eventSearchGrid').datagrid('getChecked');
		if(rows){
			var ids = "";
			for(var i=0;i<rows.length;i++){
				ids = ids +","+rows[i].ID;
			}
			ids = ids.substring(1);
			var attrArray_ed={
					title:'新增值班详情纪要',
					width: 800,
					height: 500,
					href: basePath+"Main/eventDuty/add?eids="+ids
			};
			
			$.lauvan.openCustomDialog("evDutyDialog",attrArray_ed,null,"evdutyform");
		}else{
			alert("请选择事件！");
		}
	}
	
	function e_doSearch(){
		$('#eventSearchGrid').datagrid('load',{
			ename: $('#esname_s').val(),
			etype: $('#estype_s').combotree('getValue'),
			elevel: $('#eslevel_s').combobox('getValue'),
			estatus: $('#esstatus_s').combobox('getValue')
		});
	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
			<span>事件名称：</span>
			<input id="esname_s" type="text" class="easyui-textbox" >
			<span>事件类型：</span>
			<input class="easyui-combotree" id="estype_s" data-options="url:'<%=basePath%>Main/event/getTypeTree',method:'get',editable:false,icons:iconClear" style="width:180px;">
			<span>事件级别：</span>
			<select class="easyui-combobox" id="eslevel_s"  panelHeight="auto" code="EVLV" style="width: 150px;" data-options="editable:false,icons:iconClear" ></select>
			<span>事件状态：</span>
			<select class="easyui-combobox" id="esstatus_s"  panelHeight="auto" code="EVST" style="width: 150px;" data-options="editable:false,icons:iconClear" ></select>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="e_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="eventSearchGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="EV_NAME" width="150">事件名称</th> 
			            <th field="EV_TYPE" width="100" CODE="EVTP" >事件类型</th>
			            <th field="EV_LEVEL" width="150" CODE="EVLV">事件级别</th>
			            <th field="EV_DATE" width="100"  >事发时间</th>
			            <th field="EV_STATUS" width="100" CODE="EVST" >事件状态</th>
			            <th field="MARKTIME" width="100"  >登记时间</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

