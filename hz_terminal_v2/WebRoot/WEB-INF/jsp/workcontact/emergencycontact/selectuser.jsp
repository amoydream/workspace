<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<script>
	var zTree_scontactuser;
	var zNodes_scontactuser;
	var selectedNode_scontactuser;
	var bookids = '${bookids}';
	var bookidsArr = bookids.split(","); 
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
		if(treeNode.id==0){
			//treeNode=treeNode.children[0];
			return;
		}
		$('#s_usercontactlist_data').datagrid({url:'<%=basePath%>Main/systemcontact/usercontact/getGridData',queryParams:{pid:treeNode.id}});
		selectedNode_scontactuser=zTree_scontactuser.getSelectedNodes()[0];
		//$("#_usercontactlist_data").datagrid("clearSelections");
		//$("#_usercontactlist_data").datagrid("clearChecked");
	};

	function initTree_scontactuser(){
		 $.ajax({  
		        cache:false,  
		        type: 'POST',  
		        dataType : "json",
		        data:{idKey:'id',pidKey:'pId'},
		        url: '<%=basePath%>Main/department/getTreeData',
		        error: function () {
		            alert('请求失败');  
		        },  
		        success:function(data){ 
		        	zNodes_scontactuser = data;   //把后台封装好的简单Json格式赋给treeNodes  
		            if(zTree_scontactuser!=null)
		            	zTree_scontactuser.destroy();
		            zTree_scontactuser =$.fn.zTree.init($("#susercontactTree"), setting, zNodes_scontactuser);
					if(!selectedNode_scontactuser){
						selectedNode_scontactuser=zTree_scontactuser.getNodeByParam("id", '0', null);
						if(selectedNode_scontactuser.children && selectedNode_scontactuser.children.length>0)
							selectedNode_scontactuser=selectedNode_scontactuser.children[0];
					}
					zTree_scontactuser.selectNode(selectedNode_scontactuser);
					zTree_scontactuser.expandNode(selectedNode_scontactuser, true, false, false);
					zTree_scontactuser.setting.callback.onClick(null, zTree_scontactuser.setting.treeId, selectedNode_scontactuser);
		            
		        }  
		    });
		 
	}

	function refreshGrid(){
		zTree_scontactuser.setting.callback.onClick(null, zTree_scontactuser.setting.treeId, selectedNode_scontactuser);
	}
	
	$(function(){
		initTree_scontactuser();
		//删除数组元素方法
		Array.prototype.indexOf = function(val) {  
	         for (var i = 0; i < this.length; i++) {  
	             if (this[i] == val) return i;  
	         }  
	         return -1;  
	     };  
	     Array.prototype.remove = function(val) {  
	         var index = this.indexOf(val);  
	         if (index > -1) {  
	             this.splice(index, 1);  
	         }  
	     };  
	   //删除数组第一个空元素 
			if(bookidsArr[0]==""){
				bookidsArr.remove(bookidsArr[0]);  
			}
		var attrArray={
				idField:'BO_ID',
				fitColumns : true,
				onCheck:function(rowIndex,rowData){	
					var isContain = false;
					for(var i=0;i<bookidsArr.length;i++){
						if(bookidsArr[i]==rowData['BO_ID']){
							isContain = true;
					        break;	
						}
					}
					if(isContain==false){						
						bookidsArr.push(rowData['BO_ID']);
					}
				},
				onUncheck:function(rowIndex,rowData){
					var isContain = false;
					for(var i=0;i<bookidsArr.length;i++){
						if(bookidsArr[i]==rowData['BO_ID']){
							isContain = true;
					        break;	
						}
					}
					if(isContain==true){	
						bookidsArr.remove(rowData['BO_ID']);		
					}
				
				},
				onCheckAll:function(rows){				
	                 var isContain = false;
					 for (var i = 0; i <rows.length; i++) {
	                    	for(var j = 0; j < bookidsArr.length; j++){ 
	                    		//alert(rows[j]['P_ID']);
	                          if (rows[i]['BO_ID']==bookidsArr[j]) {
	                        	//alert("已经存在："+rows[i]['P_ID']);
	                        	isContain = true;
	                            break;                                 
	                          }else{
	                        	  isContain = false;
	                          }
	                    	} 
	                    	if(isContain == false){
	                    		//alert(rows[i]['P_ID']);
	                            bookidsArr.push(rows[i]['BO_ID']);  
	                    	}
	                    }		
				},
				onUncheckAll:function(rows){				
					 for (var i = 0; i <rows.length; i++) {
	                    	for(var j = 0; j < bookidsArr.length; j++){ 	            

       		
	                          if (rows[i]['BO_ID']==bookidsArr[j]) {
	                        	//alert("已经存在："+rows[i]['P_ID']);
	                        	bookidsArr.remove(rows[i]['BO_ID']);
	                            break;                                 
	                          }
	                    	} 	                    	
	                    }							
				},
				onLoadSuccess:function(){
					var bids = '${bookids}';
					var arrids = bids.split(",");    
					var rows=$('#s_usercontactlist_data').datagrid('getRows');
                    var rowindex;
                    for (var i = 0; i < rows.length; i++) {
                    	for(var j = 0; j < arrids.length; j++){            
                        if (rows[i]['BO_ID'] == arrids[j]) {
                            rowindex = i;                      
                            $('#s_usercontactlist_data').datagrid('checkRow', rowindex);                      
                          }
                    	} 
                    }
				}			
			};
		$.lauvan.dataGrid("s_usercontactlist_data",attrArray);
	});
    
	function onSubmit($dialog){
		var e_id = ${e_id};
		if(bookidsArr.length==0||bookidsArr.length==1){
			  var idStr = bookidsArr.join("");
			}else{	
			  var idStr = bookidsArr.join(',');
			}
		var url = "<%=basePath%>Main/emergencycontact/usercontactSave";
		$.post(url,{ids:idStr,e_id:e_id}, function(result) {
			if (result.success) {
				refreshEmergencyGrid();
				$.messager.show({title:'提示',msg:'保存成功！',timeout:1000,showType:'fade',style:{right:'',bottom:''}});
				$dialog.dialog('close');
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}
		}, 'json');
		
	}
	
	function CallNumber(value,row,index){
		var act = "<ul class=\"specil_button\"><li class=\"s_b_1\">"
			+"<a  href=\"javascript:void(0);\" onclick=phonecall('"+row.P_WORKNUMBER+"') ><span></span>拨打</a></li>"
			+"</ul>";
	    return act;
	}
	
	function phonecall(num){
		alert("拨打电话...");
	}
	
	</script>

 <div class="easyui-layout"  data-options="fit:true">
		<div data-options="region:'west',split:true,Prder:false" style="width:230px">
			<ul id="susercontactTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center',Prder:false">
			<table id="s_usercontactlist_data" cellspacing="0" cellpadding="0"> 
			    <thead> 
			        <tr> 
			            <th field="BO_ID" data-options="hidden:true">ID</th> 
			            <th field="USER_NAME" width="80">姓名</th>
			             <th field="EMPOSITION" width="100">岗位</th>
			            <th field="BO_WORKNUMBER" width="100">办公电话</th>			    			          
			            <th field="BO_MOBILE" width="100">手机</th> 
			            <th field="BO_HOMENUMBER" width="100">住宅电话</th> 
			            <th field="CALLACTION" width="80" formatter="CallNumber">拨打电话</th>			         
			        </tr> 
			    </thead> 
			</table> 
		</div>
	</div>

