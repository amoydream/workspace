<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	var zTree_linkman;
	var zNodes_linkman;
	var selectedNode_linkman;
	var setting_linkman = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick_linkman
		}
	};
	function zTreeOnClick_linkman(event, treeId, treeNode) {
		if(treeNode.id.toString().indexOf("p_")==-1){
			var attrArray={
					//toolbar: '#linkman_tb',
					toolbar: [
	                  { text: '新增', iconCls: 'icon-add',handler:addlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_add, loginModel.xdlimit)}'}, '-', 
	                  { text: '修改',iconCls: 'icon-pageedit',handler:updlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_upd, loginModel.xdlimit)}'}, '-',
	                  { text: '删除',iconCls: 'icon-delete',handler:dellinkman,permitParams:'${pert:hasperti(applicationScope.linkman_del, loginModel.xdlimit)}'},'-',
	                  { text: '导入',iconCls: 'icon-undo',handler:importlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_import, loginModel.xdlimit)}'},'-',
	                  { text: '导出',iconCls: 'icon-save',handler:exportlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_export, loginModel.xdlimit)}'}
	                 ],
					fitColumns : true,
					idField:'ID',
					rownumbers:true,/*  
					frozenColumns:[[]], */
					url:"<%=basePath%>Main/linkman/getGridData?did="+treeNode.id,
					onDblClickRow:linkmanview
	        };
			$.lauvan.dataGrid("linkmanGrid",attrArray); 
			selectedNode_linkman=zTree_linkman.getSelectedNodes()[0];
			$("#linkmanGrid").datagrid("clearSelections");
			$("#linkmanGrid").datagrid("clearChecked");
			}else{
				var attrArray={
						//toolbar: '#linkman_tb',
						toolbar: [
                          { text: '追加工作联络网人员', iconCls: 'icon-add',handler:addgzllw,permitParams:'${pert:hasperti(applicationScope.linkman_addllw, loginModel.xdlimit)}'}, '-',
		                  /* { text: '新增群组', iconCls: 'icon-add',handler:addlinkmanq,permitParams:'${pert:hasperti(applicationScope.linkman_addq, loginModel.xdlimit)}'}, '-', 
		                  { text: '修改群组',iconCls: 'icon-pageedit',handler:updlinkmanq,permitParams:'${pert:hasperti(applicationScope.linkman_updq, loginModel.xdlimit)}'}, '-', */
		                  { text: '导入群组',iconCls: 'icon-undo',handler:importlinkmanq,permitParams:'${pert:hasperti(applicationScope.linkman_importq, loginModel.xdlimit)}'},'-',
 		                  { text: '导入下级群组',iconCls: 'icon-undo',handler:importlinkmanxjq,permitParams:'${pert:hasperti(applicationScope.linkman_importxjq, loginModel.xdlimit)}'},'-',
 		                  { text: '删除群组',iconCls: 'icon-delete',handler:dellinkmanq,permitParams:'${pert:hasperti(applicationScope.linkman_delq, loginModel.xdlimit)}'},'-',
		                  { text: '修改',iconCls: 'icon-pageedit',handler:updlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_upd, loginModel.xdlimit)}'}, '-',
 		                  { text: '删除',iconCls: 'icon-delete',handler:dellinkman,permitParams:'${pert:hasperti(applicationScope.linkman_del, loginModel.xdlimit)}'}
		                 ],
						fitColumns : true,
						idField:'ID',
						rownumbers:true,/*  
						frozenColumns:[[]], */
						url:"<%=basePath%>Main/linkman/getGridData?did="+treeNode.id,
						onDblClickRow:linkmanview
		        };
				$.lauvan.dataGrid("linkmanGrid",attrArray); 
			selectedNode_linkman=zTree_linkman.getSelectedNodes()[0];
			$("#linkmanGrid").datagrid("clearSelections");
			$("#linkmanGrid").datagrid("clearChecked");		
		} 
	};
	function initTree_linkmantree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/linkman/getTree',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		            zNodes_linkman = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_linkman!=null)
		            	zTree_linkman.destroy();
		            zTree_linkman =$.fn.zTree.init($("#typeTree"), setting_linkman, zNodes_linkman);
					if(!selectedNode_linkman){
						selectedNode_linkman=zTree_linkman.getNodeByParam("id", '0', null);
						if(selectedNode_linkman.children && selectedNode_linkman.children.length>0)
							selectedNode_linkman=selectedNode_linkman.children[0];
					}
		            zTree_linkman.selectNode(selectedNode_linkman);
		            zTree_linkman.expandNode(selectedNode_linkman, true, false, false);
		            zTree_linkman.setting.callback.onClick(null, zTree_linkman.setting.treeId, selectedNode_linkman);
		            
		        }  
		    });
		 
	}
	$(function(){
		initTree_linkmantree();
		 var attrArray={
				toolbar: '#linkman_tb',
				/* toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:addlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_add, loginModel.xdlimit)}'}, '-', 
                  { text: '修改',iconCls: 'icon-pageedit',handler:updlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_upd, loginModel.xdlimit)}'}, '-',
                  { text: '删除',iconCls: 'icon-delete',handler:dellinkman,permitParams:'${pert:hasperti(applicationScope.linkman_del, loginModel.xdlimit)}'},'-',
                  { text: '导入',iconCls: 'icon-undo',handler:importlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_import, loginModel.xdlimit)}'},'-',
                  { text: '导出',iconCls: 'icon-save',handler:exportlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_export, loginModel.xdlimit)}'}
                 ], */
                 toolbar: [
						  { text: '追加工作联络网人员', iconCls: 'icon-add',handler:addgzllw,permitParams:'${pert:hasperti(applicationScope.linkman_addllw, loginModel.xdlimit)}'}, '-',
 		                  /* { text: '新增群组', iconCls: 'icon-add',handler:addlinkmanq,permitParams:'${pert:hasperti(applicationScope.linkman_addq, loginModel.xdlimit)}'}, '-', 
 		                  { text: '修改群组',iconCls: 'icon-pageedit',handler:updlinkmanq,permitParams:'${pert:hasperti(applicationScope.linkman_updq, loginModel.xdlimit)}'}, '-', */
 		                  { text: '导入群组',iconCls: 'icon-undo',handler:importlinkmanq,permitParams:'${pert:hasperti(applicationScope.linkman_importq, loginModel.xdlimit)}'},'-',
  		                 { text: '导入下级群组',iconCls: 'icon-undo',handler:importlinkmanxjq,permitParams:'${pert:hasperti(applicationScope.linkman_importxjq, loginModel.xdlimit)}'},'-',
  		                  { text: '删除群组',iconCls: 'icon-delete',handler:dellinkmanq,permitParams:'${pert:hasperti(applicationScope.linkman_delq, loginModel.xdlimit)}'},'-',
 		                 { text: '修改',iconCls: 'icon-pageedit',handler:updlinkman,permitParams:'${pert:hasperti(applicationScope.linkman_upd, loginModel.xdlimit)}'}, '-',
 		                  { text: '删除',iconCls: 'icon-delete',handler:dellinkman,permitParams:'${pert:hasperti(applicationScope.linkman_del, loginModel.xdlimit)}'}
 		                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,/*  
				frozenColumns:[[]], */
				//url:"<%=basePath%>Main/linkman/getGridData",
				onDblClickRow:linkmanview
        };
		$.lauvan.dataGrid("linkmanGrid",attrArray);
		
	});
	function linkman_doSearch(){
		$('#linkmanGrid').datagrid('load',{
			did:selectedNode_linkman.id,
			linkmanname: $('#linkmanname').val(),
			linkmantel: $('#linkmantel').val()
			
		});	
	}
	function exportlinkman(){
		window.location.href("Main/linkman/export");
	}
	function addlinkman(){
		var attrArray={
				title:'新增联系人',
				height: 300,
				width:800,
				href: '<%=basePath%>Main/linkman/add/'+selectedNode_linkman.id,
		};
		
		$.lauvan.openCustomDialog("linkmanDialog",attrArray,linkman_dialogSubmit,'linkman_form');	
	}
	function addlinkmanq(){
		var attrArray={
				title:'新增群组',
				height: 300,
				width:500,
				href: '<%=basePath%>Main/linkman/addq',
		};
		
		$.lauvan.openCustomDialog("linkmanDialog",attrArray,linkmanq_dialogSubmit,'linkman_form');	
	}
	function addgzllw(){
		if(selectedNode_linkman!=null){
		var qid =selectedNode_linkman.id;
		if(qid==null||qid.indexOf("p_")==-1||qid=="p_0"){
			$.lauvan.MsgShow({msg:'请选择欲追加的群组！'});
			return;
		}
		var attrArray={
				title:'追加工作联络网人员',
				height: 300,
				width:500,
				href: '<%=basePath%>Main/linkman/addllw?qid='+qid,
		};
		
		$.lauvan.openCustomDialog("linkmanDialog",attrArray,linkmanllw_dialogSubmit,'linkman_form');
	}else{
		$.lauvan.MsgShow({msg:'请选择欲追加的群组！'});
		return;	
	}
	}
	function linkmanllw_dialogSubmit(){
  		$('#linkman_form').form('submit',{
  			onSubmit:function(param){
  				var lmqname=$('#lmqname').textbox('getValue');	
  	  			var lmllwid=document.getElementById("lmllwid").value;
  	  			if(lmqname==""||lmllwid==""){
  						$.messager.alert('错误','存在必填项未填，请检查！','error');
  		                return false;	
  					} 
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				initTree_linkmantree();
				$.lauvan.reflash(result);
			}
		});
  	}
	function updlinkmanq(){
		var qid =selectedNode_linkman.id;
		if(qid==null||qid.indexOf("p_")==-1){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		var attrArray={
				title:'修改群组',
				height: 300,
				width:500,
				href: '<%=basePath%>Main/linkman/updq/'+qid
		};
		$.lauvan.openCustomDialog("linkmanDialog",attrArray,linkmanq_dialogSubmit,'linkman_form');
	}
	function linkmanq_dialogSubmit(){
  		$('#linkman_form').form('submit',{
  			onSubmit:function(param){
  			var lmqname=$('#lmqname').textbox('getValue');	
  			var lmid=document.getElementById("lmid").value;
  			if(lmqname==""||lmid==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				} 
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				initTree_linkmantree();
				$.lauvan.reflash(result);
			}
		});
  	}
	function linkmanview(){
		var node = $("#linkmanGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
			return;
		}
		var attrArray={
				title:'联系人详情',
				height: 300,
				width:800,
				href: '<%=basePath%>Main/linkman/view/'+node.ID,
				buttons:[{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#linkmanGrid").datagrid('reload');
						$("#linkmanDialog").dialog('close');
					}
				}
							         ]
		};
		$.lauvan.openCustomDialog("linkmanDialog",attrArray,null,null);
	}
	function importlinkman(){
		var attrArray={
				title:'导入联系人',
				height: 300,
				width:800,
				href: '<%=basePath%>Main/linkman/importip'
		};
		
		$.lauvan.openCustomDialog("linkmanDialog",attrArray,linkmanimport_dialogSubmit,'linkman_form');
	}
	//导入群组
	function importlinkmanq(){
		var attrArray={
				title:'导入群联系人',
				height: 360,
				width:800,
				href: '<%=basePath%>Main/linkman/importqip?qid='+selectedNode_linkman.id
		};
		
		$.lauvan.openCustomDialog("linkmanDialog",attrArray,linkmanimportq_dialogSubmit,'linkmanq_form');
	}
	function importlinkmanxjq(){
		var attrArray={
				title:'下级群组导入群联系人',
				height: 360,
				width:800,
				href: '<%=basePath%>Main/linkman/importxjqip?qid='+selectedNode_linkman.id
		};
		
		$.lauvan.openCustomDialog("linkmanDialog",attrArray,linkmanimportq_dialogSubmit,'linkmanq_form');
	}
	function linkmanimportq_dialogSubmit(){
  		$('#linkmanq_form').form('submit',{
  			onSubmit:function(param){
  				var namenum=document.getElementById("namenum").value;
  				var telnum=document.getElementById("telnum").value;
  				var deptnum=document.getElementById("deptnum").value;
  				var positionnum=document.getElementById("positionnum").value;
  				var remarknum=document.getElementById("remarknum").value;
  				var qunname=document.getElementById("qunname").value;
  				if(namenum==""||telnum==""||deptnum==""||positionnum==""||remarknum==""||qunname==""){
  					$.messager.alert('错误','存在必填项未填！','error');
						return false;	
  				}else{
  					if(isNaN(namenum)||isNaN(telnum)||isNaN(deptnum)||isNaN(positionnum)||isNaN(remarknum)){
  						$.messager.alert('错误','输入有误，请检查！','error');
  						return false;
  					}
  				}
  				if(namenum<1||telnum<1||deptnum<1||positionnum<1||remarknum<1){
  					$.messager.alert('错误','输入的列数不得小于1！','error');
						return false;
  				}
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				initTree_linkmantree();
				$.lauvan.reflash(result);
			}
		});
  	}
	function linkmanimport_dialogSubmit(){
  		$('#linkman_form').form('submit',{
  			onSubmit:function(param){
  				var namenum=document.getElementById("namenum").value;
  				var telnum=document.getElementById("telnum").value;
  				var deptnum=document.getElementById("deptnum").value;
  				var positionnum=document.getElementById("positionnum").value;
  				var remarknum=document.getElementById("remarknum").value;
  				if(namenum==""||telnum==""||deptnum==""||positionnum==""||remarknum==""){
  					$.messager.alert('错误','存在必填项未填！','error');
						return false;	
  				}else{
  					if(isNaN(namenum)||isNaN(telnum)||isNaN(deptnum)||isNaN(positionnum)||isNaN(remarknum)){
  						$.messager.alert('错误','输入有误，请检查！','error');
  						return false;
  					}
  				}
  				if(namenum<1||telnum<1||deptnum<1||positionnum<1||remarknum<1){
  					$.messager.alert('错误','输入的列数不得小于1！','error');
						return false;
  				}
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				initTree_linkmantree();
				$.lauvan.reflash(result);
			}
		});
  	}
	function updlinkman(){
		var node = $("#linkmanGrid").datagrid('getSelected');
		if(!node){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		if(node.ID.indexOf("_")!=-1){
			$.lauvan.MsgShow({msg:'不能修改联络网记录，请检查！'});
			return;
		}
		var attrArray={
				title:'修改联系人',
				height: 300,
				width:800,
				href: '<%=basePath%>Main/linkman/update/'+node.ID
		};
		$.lauvan.openCustomDialog("linkmanDialog",attrArray,linkman_dialogSubmit,'linkman_form');
	}
	function linkman_dialogSubmit(){
  		$('#linkman_form').form('submit',{
  			onSubmit:function(param){
  			var linkmanname=$('#lmname').textbox('getValue');	
  			var linkmantel=$('#lmtel').textbox('getValue');
  			var linkmandept=$('#lmdept').textbox('getValue');
  			if(linkmanname==""||linkmantel==""||linkmandept==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				} 
  			var regBox = { 
						regMobile:/^0?1[3|4|5|8][0-9]\d{8}$/
						    }
				var tflag = regBox.regMobile.test(linkmantel);
				if(!tflag){
					$.messager.alert('错误','电话格式输入有误！','error');
	                return false;
				}
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				initTree_linkmantree();
				$.lauvan.reflash(result);
			}
		});
  	}
	function dellinkman(){
		var nodes= $("#linkmanGrid").datagrid('getChecked');
    	var ids="";
    	if(nodes.length==0){
    		$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;	
    	}
    	for (var i = 0; i < nodes.length; i++) {
			 ids=ids+nodes[i].ID+",";
			 }
    	ids=ids.substring(0,ids.length-1);
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	url:'<%=basePath%>Main/linkman/delete?qid='+selectedNode_linkman.id+'&ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			initTree_linkmantree();
	            			$("#linkmanGrid").datagrid('clearSelections');	
	            			$("#linkmanGrid").datagrid('clearChecked');
	            			$("#linkmanGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function dellinkmanq(){
		var qid =selectedNode_linkman.id;
		if(qid==null||qid=="p_0"||qid.indexOf("p_")==-1){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录！'});
			return;
		}
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		       $.ajax({
	            	url:'<%=basePath%>Main/linkman/delq?qid='+qid,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			initTree_linkmantree();
	            			$("#linkmanGrid").datagrid('clearSelections');	
	            			$("#linkmanGrid").datagrid('clearChecked');
	            			$("#linkmanGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	function findllw(){
		var attrArray={
				title:'选择联络网人员',
				width:1000,
				height:500,
				href: '<%=basePath%>Main/linkman/getllw',
				buttons:[
	{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				if(checkid!=","){
					checkid=checkid.substring(1,checkid.length-1);
					checkname=checkname.substring(1,checkname.length-1);
					$("#lmllwid").val(checkid);
					$("#lmllwname").textbox('setValue',checkname);
					$("#checklinkmanDialog").dialog('close');	
				}else{
					alert("请选择联系人！");
				}
					
			}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#checklinkmanDialog").dialog('close');
		}
	}
				         ]
		}; 
		$.lauvan.openCustomDialog("checklinkmanDialog",attrArray,null,null);	
	}
	function findlinkman(){
		var attrArray={
				title:'选择联系人',
				width:600,
				height:500,
				href: '<%=basePath%>Main/linkman/getLinkman',
				buttons:[
	{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
		    	var cname = '';
		    	var cid = '';
		    		$("input:checkbox[name='userBox']:checked").each(function(){
		    			cname = cname+","+this.value;
				    	cid = cid+","+this.id;
		    		});
			    if(cname!=''){
                $("#lmname").textbox('setValue', cname.substring(1));
			    	document.getElementById("lmid").value=cid.substring(1);
		   			$("#checklinkmanDialog").dialog('close');
				}else{
			    	alert("请选择联系人！");
		    	}
	    		
			}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#checklinkmanDialog").dialog('close');
		}
	}
				         ]
		}; 
		$.lauvan.openCustomDialog("checklinkmanDialog",attrArray,null,null);
	}
	</script>

		
 <div class="easyui-layout" data-options="fit:true">
 	 <div data-options="region:'west',split:true,border:false" style="width:20%">
			<ul id="typeTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',border:false">
		<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>名称:</span>
		<input id="linkmanname" type="text" class="easyui-textbox" >
		<span>电话:</span>
		<input id="linkmantel" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="linkman_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="linkmanGrid"   cellspacing="0" cellpadding="0" width="100%"> 
			    <thead> 
			        <tr id="gridtr"> <th field="NAME" width="100">姓名</th> 
			            <th field="TEL" width="100">电话</th> 	
			            <th field="DEPT" width="100">单位</th>
			             <th field="POSITION" width="100">职位</th>
			             <th field="REMARK" width="300">备注</th> 
			             	         
			        </tr> 
			    </thead> 
			</table> 
		</div>
		</div>
		</div>
		</div>
