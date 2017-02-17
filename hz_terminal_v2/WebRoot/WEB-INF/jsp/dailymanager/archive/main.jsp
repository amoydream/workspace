<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script>
	var basePath = '<%=basePath%>';
	var zTree_archive;
	var setting_archive = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid"
			}
		},
		callback: {
			onClick: zTreeOnClick_archive
		},
		async: {
			enable: true,
			url: "Main/archive/getTreeData",
			autoParam:["id"],
			dataFilter: function(treeId, parentNode, responseData){
				var tdata =[]
			   	if (responseData) {
			   		var tlist = responseData;
			   	    for(var i =0; i < tlist.length; i++) {
			   	    	var data={};
			   	        data.id = tlist[i]['ID'];
			   	        data.pid = tlist[i]['PID'];
			   	        data.name = tlist[i]['NAME'];
			   	        //data.isParent=tlist[i]['ISLEAF']==0?false:true;
			   	        tdata.push(data);
			   	     }
			   	 }
			   	 return tdata;
			}
		}
	};
	
	var zNodes_archive =[
	     		{ id:"0", pId:"0", name:"归档目录",open:true}
	     		<c:forEach items="${ylist}" var="ylist" >
	     		,{ id:"${ylist.id}", pid:"${ylist.pid}", name:"${ylist.name}"}
	     		</c:forEach>
	     		<c:forEach items="${mlist}" var="mlist" >
	     		,{ id:"${mlist.id}", pid:"${mlist.pid}", name:"${mlist.name}"}
	     		</c:forEach>
	     		<c:forEach items="${list}" var="list" >
	     		,{ id:"${list.id}", pid:"${list.archivetime}", name:"${list.archivename}"}
	     		<c:forEach items="${plist}" var="plist" >
	     		,{ id:"${list.id}_${plist.p_acode}", pid:"${list.id}", name:"${plist.p_name}"}
	     		</c:forEach>
	     		</c:forEach>
	     	];
	
	function zTreeOnClick_archive(event, treeId, treeNode) {
		if(treeNode.id.indexOf("_")>0){
			var str = treeNode.id.split("_");
			$("#_archiveid").val(str[0]);
			$("#_archivetype").val(str[1]);
			$('#_archiveGrid').datagrid("options").queryParams={'aid':str[0],'type':str[1]};
			$('#_archiveGrid').datagrid({url:basePath+'Main/archive/getArchiveData'});
		}else if(treeNode.pid.indexOf("-")>0){
			$("#_archivename").val(treeNode.name);
			$("#_archiveid").val(treeNode.id);
			$("#_archivetype").val('');
		}else{
			$("#_archivename").val('');
			$("#_archiveid").val('');
			$("#_archivetype").val('');
		}
		
	};
	$(function(){
		var attrArray ={ toolbar: [
		                           { text: '创建归档目录',title:'创建归档目录', iconCls: 'icon-add',
		        	                   dialogParams:{dialogId:'archiveDialog',href:basePath+"Main/archive/add",width:800,
		        						height:250,formId:'archiveform',isNoParam:true}}, '-', 
		                          { text: '添加归档文件',iconCls: 'icon-pageedit', 
		        					handler: function(){
		                        	  		var aid = $("#_archiveid").val();
		                        	  		var atype = $("#_archivetype").val();
		                        	  		if(aid==null || aid==undefined ||aid==0){
		                        	  			$.lauvan.MsgShow({msg:'请选择归档目录!'});
		        	            				return;
		                        	  		}
		                        	  		var dialogDef={
		                        	  				title:'添加归档文件',
		        									width:700,
		        									height:350,
		        									href: basePath+"Main/archive/add?aid="+aid+"&atype="+atype
		        							};
		        							$.lauvan.openCustomDialog('archiveDialog',dialogDef,null,'archiveform');
		                          		}}, '-',
		                          { text: '删除目录',iconCls: 'icon-delete',
		                          		handler: function(){
		        	                  		var aname = $("#_archivename").val();
		        	                  		var aid = $("#_archiveid").val();
		        	                  		if(aname==null||aname==''||aname==undefined){
		        	                  			$.lauvan.MsgShow({msg:'请选择要删除的归档目录!'});
		        	            				return;
		        	                  		}
		                          			$.messager.confirm('删除',"您确定删除目录【"+aname+"】及其所有归档文件？",function(r){
		        	                  			if(r){
		        	                  				$.ajax({
		        	            		            	url:basePath+'Main/archive/delete',
		        	            		            	type:'post',
		        	            		            	dataType:'json',
		        	            		            	traditional:true,
		        	            		            	data:{'aid':aid,'flag':'folder'},
		        	            		            	success:function(data){
		        	            		            		if(data.success){
		        	            		            			$.lauvan.MsgShow({msg:'数据删除成功'});
					            		            			$("#_archiveGrid").datagrid('clearSelections');
					            		            			$("#_archiveGrid").datagrid('clearChecked');
					            		            			$("#_archiveGrid").datagrid('reload');
					            		            			//刷新树
					    		            					var treeObj =  $.fn.zTree.getZTreeObj("_archiveTree");
					    		            					if(data.reloadid!=null && ""!=data.reloadid && data.reloadid>0){
					    		            						var node = treeObj.getNodeByParam(data.idkey, data.reloadid, null);
					    		            						treeObj.reAsyncChildNodes(node, "refresh");
					    		            						treeObj.selectNode(node);
					    		            					}else{
					    		            						treeObj.reAsyncChildNodes(null, "refresh");
					    		            					}
		        	            		            		}else{
		        	            		            			$.messager.alert('错误',data.msg,data.errorcode);
		        	            		            		}
		        	            		            	}
		        	                  				});
		        	                  			}
		                          			});
		                          		}},'-',
		                          		{ text: '删除归档文件',iconCls: 'icon-delete',
		        	                  		handler: function(){
		        		                  		var aid = $("#_archiveid").val();
		        		                  		var rows=$("#_archiveGrid").datagrid('getChecked');
		        		                  		if(rows.length==0){
		        		            				$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
		        		            				return;
		        		            			}
		        	                  			$.messager.confirm('删除',"您确定删除该文件？",function(r){
		        		                  			if(r){
		        		                  				var ids=[];
		        		            			        for(var i=0;i<rows.length;i++){
		        		            						ids[i]=rows[i].ID;
		        		            					}
		        		                  				$.ajax({
		        		            		            	url:basePath+'Main/archive/delete',
		        		            		            	type:'post',
		        		            		            	dataType:'json',
		        		            		            	traditional:true,
		        		            		            	data:{'aid':aid,'ids':ids},
		        		            		            	success:function(data){
		        		            		            		if(data.success){
		        		            		            			$.lauvan.MsgShow({msg:'数据删除成功'});
		        		            		            			$("#_archiveGrid").datagrid('clearSelections');
		        		            		            			$("#_archiveGrid").datagrid('clearChecked');
		        		            		            			$("#_archiveGrid").datagrid('reload');
		        		            		            		}else{
		        		            		            			$.messager.alert('错误',data.msg,data.errorcode);
		        		            		            		}
		        		            		            	}
		        		                  				});
		        		                  			}
		        	                  			});
		        	                  	}}
		                         ],
		fitColumns : true,
		idField:'ID',
		url:basePath+"Main/archive/getArchiveData",
		onDblClickRow:function(rowIndex, rowData){
			//打开详情页面
			window.open(basePath+"Main/archive/getView/"+rowData.ID);
		}
		};
		$.lauvan.dataGrid("_archiveGrid",attrArray);
		$.fn.zTree.init($("#_archiveTree"), setting_archive, zNodes_archive);
		zTree_archive = $.fn.zTree.getZTreeObj('_archiveTree');
		});

	
	function _archive_doSearch(){
		//清空节点参数
		//$('#_archiveGrid').datagrid("options").queryParams={};
		$('#_archiveGrid').datagrid('load',{
			filename: $('#filename').val()
		});
	}
	
	</script>
 
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'west',border:false" style="width: 200px;">
 	<ul id="_archiveTree" class="ztree"></ul>
 </div>
 <div data-options="region:'center',border:false">
 <div class="easyui-layout"  data-options="fit:true">
	<div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
	 <input id="_archiveid" type="hidden"  >
  	<input id="_archivename" type="hidden"  >
  	<input id="_archivetype" type="hidden"  >
			<span>文件名称：</span>
			<input id="filename" type="text" class="easyui-textbox" >
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="_archive_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
			<table id="_archiveGrid" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr>   
			            <th field="FILENAME" width="150">文件名称</th> 
			            <th field="ARCHIVETYPE" width="100" CODE="GDFL" >归档类型</th>
			            <th field="MARKTIME" width="150" >归档时间</th>
			            <th field="FILETYPE" width="80"  >文件类型</th>
			            <th field="FILESIZE" width="80" >文件大小</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
</div>
</div>
