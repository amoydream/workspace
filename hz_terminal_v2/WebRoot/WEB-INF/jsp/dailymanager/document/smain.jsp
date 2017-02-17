<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<script type="text/javascript">	
	$(function(){
		var attrArray={
				//toolbar: '#document_tb',
				toolbar: [
                  { text: '新增', iconCls: 'icon-add',handler:adddoc,permitParams:'${pert:hasperti(applicationScope.documentadd, loginModel.xdlimit)}'}, '-', 
                  /* { text: '详情',iconCls: 'icon-search',handler:viewdoc,permitParams:'${pert:hasperti(applicationScope.documentview, loginModel.xdlimit)}'}, '-', */
                  { text: '删除',iconCls: 'icon-delete',handler:deldoc,permitParams:'${pert:hasperti(applicationScope.documentdel, loginModel.xdlimit)}'}
                 ],
				fitColumns : true,
				idField:'ID',
				rownumbers:true,
				url:"<%=basePath%>Main/document/getsGridData",
				onDblClickRow :viewdoc
        };
		$.lauvan.dataGrid("documentGrid",attrArray);
		
	});
	function document_doSearch(){
		$('#documentGrid').datagrid('load',{
			dname: $('#dname').val(),
			dcode: $('#dcode').val()
			
		});	
	}
	function adddoc(){
		var attrArray={
				title:'新增公文',
				height: 500,
				width:700,
				href: '<%=basePath%>Main/document/docadd',
		};
		
		$.lauvan.openCustomDialog("docDialog",attrArray,doc_dialogSubmit,'doc_form');
		
	}
	function viewdoc(){
			var node = $("#documentGrid").datagrid('getSelected');
			if(!node){
				$.lauvan.MsgShow({msg:'请选择欲查看的记录！'});
				return;
			}
			var attrArray={
					title:'公文详情',
					height: 500,
					width:700,
					href: '<%=basePath%>Main/document/docview/'+node.ID,
					buttons:[]
			};
			$.lauvan.openCustomDialog("docDialog",attrArray,null,null);		
	}
	function doc_dialogSubmit(){
  		$('#doc_form').form('submit',{
  			onSubmit:function(param){
  			var doctitle=$('#doctitle').textbox('getValue');
  			var receiveid=document.getElementById("receiveid").value;
  			var doccontent=document.getElementById("doccontent").value;
  			if(doctitle==""||receiveid==""||doccontent==""){
					$.messager.alert('错误','存在必填项未填，请检查！','error');
	                return false;	
				}
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				$.lauvan.reflash(result);
			}
		});
  	}
	function findreceive(){
		var attrArray={
				title:'选择接收人',
				width:600,
				height:500,
				href: '<%=basePath%>Main/document/getUsers',
				buttons:[
	{text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				var ctype = $('input[name="uradio"]:checked').val();
		    	var rows = $("#usertable").treegrid("getChecked");
		    	var cname = '';
		    	var cid = '';
		    	if(rows && "dept"==ctype){
			    	for(var i=0;i<rows.length;i++){
				    	cname = cname+","+rows[i].CHECKNAME;
				    	cid = cid+","+rows[i].ID;
			    	}
		    	}
		    	if("user"==ctype){
		    		$("input:checkbox[name='userBox']:checked").each(function(){
		    			cname = cname+","+this.value;
				    	cid = cid+","+this.id;
		    		});
			    }
			    if(cname!=''){
			    	$("#rname").textbox('setValue', cname.substring(1));
			    	document.getElementById("receiveid").value=cid.substring(1);
			    	document.getElementById("receivetype").value=ctype;
		   			$("#userDialog").dialog('close');
				}else{
			    	alert("请选择接收人！");
		    	}
	    		
			}
	},{
		text:'关闭',
		iconCls:'icon-no',
		handler:function(){
			$("#userDialog").dialog('close');
		}
	}
				         ]
		}; 
		$.lauvan.openCustomDialog("userDialog",attrArray,null,null);
	}
	function deldoc(){
    	/* var node= $("#documentGrid").datagrid('getSelected');
		if(node==null || node.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		} */
    	var nodes= $("#documentGrid").datagrid('getChecked');
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
	            	//url:'<%=basePath%>Main/document/docdel/'+node.ID,
	            	url:'<%=basePath%>Main/document/docdel?ids='+ids,
	            	type:'post',
	            	traditional:true,
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功'});
	            			$("#documentGrid").datagrid('clearSelections');
	            			$("#documentGrid").datagrid('clearChecked');
	            			$("#documentGrid").datagrid('reload');
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	</script>
 <div class="easyui-layout"  data-options="fit:true">
 <div data-options="region:'north',border:false" style="padding: 5px;background:#f7f7f7;">
		<span>公文编号:</span>
		<input id="dcode" type="text" class="easyui-textbox" >
		<span>公文标题:</span>
		<input id="dname" type="text" class="easyui-textbox" >			
		<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="document_doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		</div>
		<div data-options="region:'center',border:false">
		<!-- <div id="document_tb">	
		<a href="javascript:void(0);" onclick="adddoc()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
		<a href="javascript:void(0);" onclick="viewdoc()" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">详情</a>
		<a href="javascript:void(0);" onclick="deldoc()" class="easyui-linkbutton" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div> -->
		
			<table id="documentGrid"   cellspacing="0" cellpadding="0"  width="100%"> 
			    <thead> 
			        <tr> 
			            <th field="NAME" width="200">公文标题</th> 
			            <th field="CONTENT" width="500">公文内容</th>
			             <th field="RECEIVENAME" width="200">公文接收人</th>
			             <th field="SENDERNAME" width="100">公文发送人</th> 
			             <th field="SENDTIME" width="200">发送时间</th> 
			            <th field="NOTE" width="300">备注</th> 		         
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>
