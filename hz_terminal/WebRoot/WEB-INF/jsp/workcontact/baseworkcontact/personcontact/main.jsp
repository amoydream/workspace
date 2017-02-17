<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var basePath = '<%=basePath%>';
	var zTree_person;
	var zNodes_person;
	var selectedNode_person;
	var setting = {
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pId"
			}
		},
		callback: {
			onClick: zTreeOnClick
		}
	};

	function zTreeOnClick(event, treeId, treeNode) {
		/* if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		} */
		$('#_personcontactlist_data').datagrid({url:'<%=basePath%>Main/personcontact/getGridData',queryParams:{p_orid:treeNode.id}});
		selectedNode_person=zTree_person.getSelectedNodes()[0];
		$("#_personcontactlist_data").datagrid("clearSelections");
		$("#_personcontactlist_data").datagrid("clearChecked");
	};

	function initTree(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/organcontact/getTreeData',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		            zNodes_person = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_person!=null)
		            	zTree_person.destroy();
		            zTree_person =$.fn.zTree.init($("#personcontactTree"), setting, zNodes_person);		    
					if(!selectedNode_person){
						selectedNode_person=zTree_person.getNodeByParam("id", '0', null);
						if(selectedNode_person.children && selectedNode_person.children.length>0)
							selectedNode_person=selectedNode_person.children[0];
					}
					zTree_person.selectNode(selectedNode_person);
					zTree_person.expandNode(selectedNode_person, true, false, false);
					zTree_person.setting.callback.onClick(null, zTree_person.setting.treeId, selectedNode_person);
		            
		        }  
		    });
		 
	}

	function refreshGrid(){
		zTree_person.setting.callback.onClick(null, zTree_person.setting.treeId, selectedNode_person);
	}
	
	$(function(){
		initTree();

		var attrArray={
				idField:'P_ID',
				fitColumns : true, 
				border:true,
				toolbar: [ 
						  { text: '添加',title:'添加机构人员', iconCls: 'icon-add',  handler: addClick,permitParams:'${pert:hasperti(applicationScope.addpersoncontact, loginModel.xdlimit)}'}, '-', 
						  { text: '修改', title:'修改机构人员',iconCls: 'icon-pageedit', handler: editClick,permitParams:'${pert:hasperti(applicationScope.editpersoncontact, loginModel.xdlimit)}'}, '-',
						  { text: '删除',iconCls: 'icon-delete',handler: deleteClick,permitParams:'${pert:hasperti(applicationScope.deletepersoncontact, loginModel.xdlimit)}'},'-',
						  { text: '导入',iconCls: 'icon-undo',handler: importClick,permitParams:'${pert:hasperti(applicationScope.importcontactperson, loginModel.xdlimit)}'}
						]
			};
		$.lauvan.dataGrid("_personcontactlist_data",attrArray);
	});
	
	function addClick(){

		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				width:500,
				height:400,
				href: '<%=basePath%>Main/personcontact/add/'+zTree_person.getSelectedNodes()[0].id
		};
		$.lauvan.openCustomDialog("addDialog",attrArray,function(){onSubmit($("#addDialog"));});
	}

	function editClick(){
		var row=$("#_personcontactlist_data").datagrid("getSelected");
		if(!row){
			$.lauvan.MsgShow({msg:'请选择欲修改的记录!'});
			return;
		}		

		var options=$(this).linkbutton("options");
		var attrArray={
				title:options.title,
				iconCls:options.iconCls,
				width:500,
				height:400,
				href: '<%=basePath%>Main/personcontact/edit/'+row.P_ID
		};
		$.lauvan.openCustomDialog("editDialog",attrArray,function(){onSubmit($("#editDialog"));});
	}
	
	
	function deleteClick(){
		var rows=$("#_personcontactlist_data").datagrid('getChecked');
		if(rows.length==0){
			$.lauvan.MsgShow({msg:'请选择欲删除的数据!'});
			return;
		}
		
		$.messager.confirm('删除','您确定删除选择的数据吗？',function(r){
		    if (r){
		    	var ids=[];
		        for(var i=0;i<rows.length;i++){
					ids[i] = rows[i]["P_ID"];
				}
		        $.ajax({
	            	url:'<%=basePath%>Main/personcontact/delete',
	            	type:'post',
	            	dataType:'json',
	            	traditional:true,
	            	data:{'ids':ids},
	            	success:function(data){
	            		if(data.success){
	            			$.lauvan.MsgShow({msg:'数据删除成功！'});
	            			refreshGrid();
	            		}
	            		else{
	            			$.messager.alert('错误',data.msg,data.errorcode);
	            		}
	            	}
	            });
		    }
		});
	}
	
	
	function importClick(){
		if(zTree_person.getSelectedNodes()[0].id==null){
			$.lauvan.MsgShow({msg:'请选择节点!'});
			return;
		}
		
		var options=$(this).linkbutton("options");
		var attrArray={
				title:'批量导入日常机构人员通讯录',
				iconCls:options.iconCls,
				width:800,
				height:450,
				href: '<%=basePath%>Main/personcontact/importPerson/'+zTree_person.getSelectedNodes()[0].id,
				buttons: [{
					text:'确定',
					iconCls:'icon-save',
					id : 'importBtnid',
					handler:function(){
						personimport_dialogSubmit();
					}
				},{
					text:'关闭',
					iconCls:'icon-no',
					handler:function(){
						$("#importPersDialog").dialog('close');
					}
				}]
		};
		$.lauvan.openCustomDialog("importPersDialog",attrArray,personimport_dialogSubmit,'person_form');
	}
	
	function personimport_dialogSubmit(){
  		$('#person_form').form('submit',{
  			onSubmit:function(param){
  				var namenum=document.getElementById("namenum").value;
  				var organum=document.getElementById("organum").value;
  				var positionum=document.getElementById("positionum").value;
  				var worknum=document.getElementById("worknum").value;
  				var phonenum=document.getElementById("phonenum").value;
  				var homenum=document.getElementById("homenum").value;
  				var faxnum=document.getElementById("faxnum").value;
  				var emailnum=document.getElementById("emailnum").value;
  				var addressnum=document.getElementById("addressnum").value;
  				if(namenum==""||organum==""){
  					$.messager.alert('错误','存在必填项未填！','error');
						return false;	
  				}else{
  					if(isNaN(namenum)||isNaN(organum)||isNaN(positionum)||isNaN(worknum)||isNaN(phonenum)||isNaN(homenum)||isNaN(faxnum)||isNaN(emailnum)||isNaN(addressnum)){
  						$.messager.alert('错误','输入有误，请检查！','error');
  						return false;
  					}
  				}
  				if(namenum<1||organum<1||positionum<1||worknum<1||phonenum<1||homenum<1||faxnum<1||emailnum<1||addressnum<1){
  					$.messager.alert('错误','输入的列数不得小于1！','error');
						return false;
  				}
  				 $("#importBtnid").linkbutton('disable');
  			},
			success:function(result){
				var obj=$.parseJSON(result);
				if(obj.success){
					$("#importPersDialog").dialog('close');
					//导入成功，提示成功信息
					initTree();
					$('#_personcontactlist_data').datagrid('clearSelections');
					$('#_personcontactlist_data').datagrid('clearChecked');
					$('#_personcontactlist_data').datagrid('reload'); 
					var msg = obj.msg;
					if(obj.errorStr!=''){
						msg = msg+"</br>"+obj.errorStr;
					}
					$.messager.alert('提示',msg,"info");
					
				}else{
					$.messager.alert('错误',obj.msg,"error");
				}
			}
		});
  	}
	
	function doSearch(){
		var orid;
		var name = $('#p_name').val();
		var position = $('#p_position').combobox('getValue');
		if((name==null||name==""||name==undefined)&&(position==null||position==""||position==undefined)){
			orid = zTree_person.getSelectedNodes()[0].id;
		}
		$('#_personcontactlist_data').datagrid('load',{
			p_orid:orid,
			p_name:name,
			p_position:position
		});
	}
    
	function CallNumber(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=callView('"+row.P_WORKNUMBER+"','"+row.P_MOBILE+"','"+row.P_HOMENUMBER+"')><span></span>拨打</a></li>"
			+"</ul>";
	    return act;
	}	
		
	function callView(worknum,mobilenum,homenum){
		var attrArray={
				title:'拨打电话',
				iconCls:'icon-help',
				width:420,
				height:210,
				href: '<%=basePath%>Main/personcontact/callview',
				queryParams:{worknum:worknum,mobilenum:mobilenum,homenum:homenum},
				buttons:[]
		};
		$.lauvan.openCustomDialog("calloutDialog",attrArray);	
	}
	
	</script>
 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,Prder:false" style="width:230px">
			<ul id="personcontactTree" class="ztree"></ul>
		</div>
		 <div data-options="region:'north'" style="padding: 5px;background:#f7f7f7;">
		    <input id="p_orid" type="hidden" value="${p_orid }" >
			<span>姓名：</span>
			<input id="p_name" type="text" class="easyui-textbox" >
			<span>岗位：</span>
			<input class="easyui-combotree" id="p_position" data-options="url:'<%=basePath%>Main/personcontact/getTypeTree',method:'get',editable:false,icons:iconClear" style="width:180px;">
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="doSearch()" data-options="iconCls:'icon-search',plain:true">查询</a>
		 </div>
		<div data-options="region:'center',Prder:false">
			<table id="_personcontactlist_data" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="P_ID" data-options="hidden:true">ID</th> 
			            <th field="P_ORID" data-options="hidden:true">ID</th> 
			            <th field="P_NAME" width="80">姓名</th>	
			            <th field="RPOSITION" width="100">岗位</th>	
			            <th field="P_WORKNUMBER" width="100">办公电话</th> 	    			          			        		    			          
			            <th field="P_MOBILE" width="100">手机</th> 
			            <th field="P_HOMENUMBER" width="100">住宅电话</th> 
			            <th field="P_FAX" width="100">传真</th> 
			            <th field="P_EMAIL" width="100">Email</th> 
			            <th field="P_ADDRESS" width="120">地址</th> 
			             <c:if test="${CCMSRole }">
			            <th field="CALLACTION" width="80" formatter="CallNumber">拨打电话</th>
			            </c:if> 
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

