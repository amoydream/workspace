<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

  <script>
  var basePath = '<%=basePath%>';
  var userList=${userList};
  var colCount=4;
  $(function(){
	//绑定单选事件
		$(":radio[name='uradio']").click(function(){
			var ra=this.value;
			//清空内容
			$("#checkuserDiv").empty();
			//创建树表格
			$("#checkuserDiv").append('<table id="usertable"  cellspacing="0" cellpadding="0" ></table>');
			if(ra=='user'){
				$("#usertable").treegrid({
					url:'<%=basePath%>Main/document/getCheckData',
					idField:'D_ID',    
				    treeField:'D_NAME',
					queryParams:{checktype:'user'},
					fitColumns : true,
					nowrap: false, 
			        striped: true, 
			        border: true,
			        method: 'post',
			        collapsible:false,//是否可折叠的 
			        fit: true,//自动大小 
			        singleSelect: true,
			        selectOnCheck: false,
			        checkOnSelect: false,
					columns:[[{title:'组织',field:'D_NAME',width:180},
					          {title:'用户',field:'D_ID',width:300,
							formatter: function(value,row,index){
								var s="";
								if (value) {
									var list=[];
		
									for(var i in userList){
										if(value==userList[i].DEPT_ID)
											list.push(userList[i]);
										}
									var table=$('<table></table>');
									var row=Math.ceil(list.length/colCount);
									for(var i=0;i<row;i++){
										var tr=$("<tr>");
										for(var j=0;j<colCount;j++){
											var data=list[i*colCount+j];
											var td=$('<td style="border:none;"></td>');
											if(data){
												td.html('<label style="font-size:12px"><input type="checkbox" id="'+ data.USER_ID +'" value="' + data.USER_NAME + '" name="userBox"  >' + data.USER_NAME + '</label>&nbsp;&nbsp;&nbsp;');
											}
											tr.append(td);
										}
										table.append(tr);
									}
									return table[0].outerHTML;
							    }
						}
					}]]
				});
			}else{
				$("#usertable").treegrid({
					url:'<%=basePath%>Main/document/getCheckData',
					idField:'ID',    
				    treeField:'CHECKNAME',
					queryParams:{checktype:'dept'},
					columns:[[{title:'组织',field:'CHECKNAME',width:180}]],
					fitColumns : true,
					nowrap: false, 
			        striped: true, 
			        border: true,
			        method: 'post',
			        collapsible:false,//是否可折叠的 
			        fit: true,//自动大小 
			        singleSelect: true,
			        selectOnCheck: false,
			        checkOnSelect: false,
					frozenColumns:[[ {field:'ck',checkbox:true}]]		
				});
			}
		});
	  });
	</script>

 <div class="easyui-layout"  data-options="fit:true">
	 <div data-options="region:'north',border:false" style="height: 35px;">
	 <div id="dbasource_tb" style="margin-top: 5px;margin-left: 5px;">
			<input name="uradio" type="radio" value="user" ><span>用户</span>
			<input name="uradio" type="radio" value="dept" ><span>组织</span>
		</div>
	 </div>
		<div data-options="region:'center',border:false">
		<div id="checkuserDiv" style="width: 100%;height: 100%;">
			</div>
		</div>
		
	</div>


