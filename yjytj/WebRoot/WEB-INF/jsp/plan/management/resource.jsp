<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/include/inc.jsp"%>
<script type="text/javascript">
	var zTree_preschRes;
	var setting_preschRes = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_preschRes
		}
	};
	
	var zNodes_preschRes =[
	     		{ id:"3000", pId:"0", name:"应急资源",open:true},
	     		{ id:"3020", pid:"3000", name:"应急物资"},
	     		{ id:"2080", pid:"3000", name:"应急专家"},
	     		{ id:"3010", pid:"3000", name:"应急队伍"},
	     		{ id:"3030", pid:"3000", name:"应急装备"}
	     	];

	function zTreeOnClick_preschRes(event, treeId, treeNode) {
		if('3000'!=treeNode.id){
			if(treeNode.id=='3020'){
				$('#preschResGrid').datagrid("showColumn",'TCODE');
				$('#preschResGrid').datagrid("hideColumn",'REMARK');
				$('#preschResGrid').datagrid("hideColumn",'TEAMJOB');
			}else if(treeNode.id=='2080'){
				$('#preschResGrid').datagrid("hideColumn",'TCODE');
				$('#preschResGrid').datagrid("showColumn",'REMARK');
				$('#preschResGrid').datagrid("hideColumn",'TEAMJOB');
			}else if(treeNode.id=='3010'){
				$('#preschResGrid').datagrid("hideColumn",'TCODE');
				$('#preschResGrid').datagrid("hideColumn",'REMARK');
				$('#preschResGrid').datagrid("showColumn",'TEAMJOB');
				
			}else if(treeNode.id=='3030'){
				$('#preschResGrid').datagrid("hideColumn",'TCODE');
				$('#preschResGrid').datagrid("showColumn",'REMARK');
				$('#preschResGrid').datagrid("hideColumn",'TEAMJOB');
			}
			$("#_presource").val(treeNode.id);
			$('#preschResGrid').datagrid({url:'<%=basePath%>Main/planMg/getResourceData?preschid=${id}&code='+treeNode.id});
			$.ajax({
            	url:"<%=basePath%>Main/planMg/getResourcelist",
            	type:'post',
            	dataType:'json',
            	traditional:true,
            	data:{'preschid':'${id}','code':treeNode.id},
            	success:function(data){
            		//$.lauvan.drawPictureOnGisMap(data.datalist,"YuanLayer");
            		drawGISPic(data.datalist);
            	}
            });
		}
	};
	$(document).ready(function(){
		var attrArray={
				<c:if test="${empty flag}">
				toolbar: [
		                  { text: '添加', iconCls: 'icon-add',
		                	  handler: function(){
	                	  		var pid = $("#_presource").val();
	                	  		if(pid==null ||pid==''||pid=='3000'){
	                	  			$.lauvan.MsgShow({msg:'请选择应急物资或应急专家或应急队伍或应急装备添加！'});
	            					return;
	                	  		}
	                	  		var dialogDef={
	                	  				title:'添加应急资源信息',
										width:800,
										height:600,
										href: '<%=basePath%>Main/planMg/add/presource-'+pid+"-${id}"
								};
								$.lauvan.openCustomDialog('planMgDialog',dialogDef,planresourceSave);
	                  		}}, '-', 
		                  { text: '删除',iconCls: 'icon-delete',delParams:{url:basePath+'Main/planMg/delete/presource'}}
		                 ],
		                 </c:if>
				fitColumns : true,
				idField:'ID',
				fit:true,
				onDblClickRow:infoview,
				onClickRow:gisview
	    };
		$.lauvan.dataGrid("preschResGrid",attrArray);
		$.fn.zTree.init($("#preschResTree"), setting_preschRes, zNodes_preschRes);
		zTree_preschRes = $.fn.zTree.getZTreeObj('preschResTree');
	});
	function planREC_doSearch(){
		$('#preschResGrid').datagrid('load',{
			itemname: $('#recName').val()
		});
	}
	function gisview(){
		var yjzy=$("#_presource").val();
		var node = $("#preschResGrid").datagrid('getSelected');
		$.ajax({
        	url:"<%=basePath%>Main/planmodel/getfocuslist/"+node.ID+"-"+yjzy,
        	type:'post',
        	dataType:'json',
        	traditional:true,
        	success:function(data){
        		//$.lauvan.focusPointOnGisMap(data.datalist,"YuanLayer");
        		drawGISPic(data.datalist);
        	}
        });
	}
	function infoview(){
		var yjzy=$("#_presource").val();
		var node = $("#preschResGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		if(yjzy=="3010"){
		var attrArray={
				title:'详情',
				height: 560,
				width:900,
				href: '<%=basePath%>Main/planmodel/getresourceview/'+node.ID+'-'+yjzy,
				buttons:[{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#preschResGrid").datagrid('reload');
						$("#planinfoDialog").dialog('close');
					}
				}
							         ]		
		};
		}else{
		var attrArray={
				title:'详情',
				height: 560,
				width:700,
				href: '<%=basePath%>Main/planmodel/getresourceview/'+node.ID+'-'+yjzy,
				buttons:[{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#preschResGrid").datagrid('reload');
						$("#planinfoDialog").dialog('close');
					}
				}
							         ]
		};
		}
		$.lauvan.openCustomDialog("planinfoDialog",attrArray,null,null);
	}
	function planresourceSave(){
		$('#planRecform').form('submit', {   
    		onSubmit: function(param){
			var planres = $("#planresSelect").datalist("getData");
			var rows = planres.rows;
			if(rows){
				var planresid="";
				var planresname="";
				for(var i=0;i<rows.length;i++){
					if(i==0){
						planresid=rows[i].ID;
						planresname=rows[i].NAME;
					}else{
						planresid=planresid+","+rows[i].ID;
						planresname=planresname+","+rows[i].NAME;
					}
				}
				param.planresid = planresid;    
   		     	param.planresname = planresname; 
			}else{
				$.lauvan.MsgShow({msg:'请选择应急资源！'});
				return false;    
			}	   
    	},success:function(data){ 
			$.lauvan.reflash(data);    
	    }}); 
	}
</script>
<div class="easyui-layout"  data-options="fit:true">
	<div data-options="region:'west',border:false" style="width: 200px;">
		<ul id="preschResTree" class="ztree"></ul>
	</div>
	<input type="hidden" id="_presource"/>
	<div data-options="region:'center',border:false">
		<div class="easyui-layout"  data-options="fit:true">
			<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
				<span>名称：</span>
				<input id="recName" type="text" class="easyui-textbox" >
				<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="planREC_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
			</div>
			<div data-options="region:'center',border:false">
				<table id="preschResGrid" cellspacing="0" cellpadding="0"> 
							    <thead> 
							        <tr> 
							            <th field="ITEMNAME" width="200" fixed="true">名称</th>
							            <th field="TEAMJOB" width="150"  hidden="true">队伍职责</th>
							            <th field="REMARK" width="150"  >备注</th> 
							            <th field="TCODE" width="100"  hidden="true">型号</th>
							            
							            
							        </tr> 
							    </thead> 
				</table>
			</div>
		</div>
		
	</div>
</div>	
	
	 
	
