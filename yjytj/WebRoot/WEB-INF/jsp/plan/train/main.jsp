<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	var button_plantrain = [{
		text:'开始演练',
		iconCls:'icon-save',
		handler:function(){
			planTrainSubmit();
		}
	}];
	var zTree_planTrain;
	var setting_planTrain = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_planTrain
		}
	};
	
	var zNodes_planTrain =[
	     		{ id:"0", pId:"0", name:"预案",open:true}
	     		<c:forEach items="${plist}" var="plist" >
	     		,{ id:"${plist.id}", pid:"${plist.sup_id==745?0:plist.sup_id}", name:"${plist.p_name}",pacode:"${plist.p_acode}"}
	     		</c:forEach>
	     		<c:forEach items="${tlist}" var="tlist" >
	     		,{ id:"${tlist.tid}", pid:"${tlist.pid}", name:"${tlist.preschname}",pacode:"${tlist.id}"}
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_planTrain(event, treeId, treeNode) {
		$("#seltreeid").val(treeNode.id);
		$("#selplanid").val(treeNode.pacode);
		$('#planylGrid').datagrid("options").queryParams={'planid':treeNode.pacode,'treeid':treeNode.id};
		$('#planylGrid').datagrid({url:basePath+'Main/planyl/getGridData'});
	};
	$(function(){
		var attrArray ={ toolbar: [
                  { text: '演练', iconCls: 'icon-add'
						,handler: function(){
							var treeid = $("#seltreeid").val();
							var planid = $("#selplanid").val();
							if(treeid!=null && treeid!='' && treeid!=undefined && treeid.indexOf('p_')==0){
								var dialogDef={
	                	  				title:'演练与培训',
										width:800,
										height:350,
										href: basePath+"Main/planyl/add/"+planid,
										buttons:button_plantrain
								};
								$.lauvan.openCustomDialog('planTrainDialog',dialogDef,planTrainSubmit);
							}else{
								alert("请选择需要演练的预案！");
							}
							
						}}
                 ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/planyl/getGridData",
		onDblClickRow:function(rowIndex, rowData){
			//打开演示页面
			var mainTab=$("#mainTab");
			if (mainTab.tabs('exists', "预案演示培训")){
		    	mainTab.tabs('select', "预案演示培训");
		    	// 调用 'refresh' 方法更新选项卡面板的内容
		    	var tab = mainTab.tabs('getSelected');  // 获取选择的面板
		    	tab.panel('refresh', "Main/geographic/dispatch/index?eventid="+rowData.ID+"&flag=train");
		    } else {
			    mainTab.tabs('add',{
			       title:"预案演示培训",
			       href:"Main/geographic/dispatch/index?eventid="+rowData.ID+"&flag=train",
			       closable:true
			    });
		    }
		}
		};
		$.lauvan.dataGrid("planylGrid",attrArray);
		$.fn.zTree.init($("#_planTrainTree"), setting_planTrain, zNodes_planTrain);
		zTree_planTrain = $.fn.zTree.getZTreeObj('_planTrainTree');
		});
	
	function planTrainSubmit(){
  		$('#planTrainform').form('submit',{
  			onSubmit:function(){
  				var fboolean = $('#planTrainform').form('enableValidation').form('validate');
  				if(!fboolean){
  					$.messager.alert('警告','请按要求填写信息！');
  				}
				return fboolean;
			},
			success:function(result){
				var obj=$.parseJSON(result);
				if(obj.success){
					$.lauvan.reflash(result);
					//打开演示页面
					var mainTab=$("#mainTab");
					if (mainTab.tabs('exists', "预案演示培训")){
				    	mainTab.tabs('select', "预案演示培训");
				    	// 调用 'refresh' 方法更新选项卡面板的内容
				    	var tab = mainTab.tabs('getSelected');  // 获取选择的面板
				    	tab.panel('refresh', "Main/geographic/dispatch/index?eventid="+obj.eventid+"&flag=train");
				    } else {
					    mainTab.tabs('add',{
					       title:"预案演示培训",
					       href:"Main/geographic/dispatch/index?eventid="+obj.eventid+"&flag=train",
					       closable:true
					    });
				    }
				}else{
					alert("操作异常，请检查！");
				}
				
				
			}
		});
  	}
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'west',border:false" style="width: 200px;">
 	<ul id="_planTrainTree" class="ztree"></ul>
 </div>
		
		<div data-options="region:'center',border:false">
		<input type="hidden" name="selplanid" id="selplanid" />
		<input type="hidden" name="seltreeid" id="seltreeid" />
			<table id="planylGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr>   
			            <th field="EV_NAME" width="150">演练事件名称</th> 
			            <th field="EV_TYPE" width="100" CODE="EVTP" >演练事件类型</th>
			            <th field="EV_LEVEL" width="150" CODE="EVLV" >演练事件级别</th>
			            <th field="EV_DATE" width="100" >事发时间</th>
			           	<th field="EV_ADDRESS" width="200" >事发地点</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

