<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

  <script>
  var basePath = '<%=basePath%>';
  var lmList=${lmList};
  var colCount=3;
  $(function(){
	//绑定单选事件
			//清空内容
			$("#checkuserDiv").empty();
			//创建树表格
			$("#checkuserDiv").append('<table id="usertable"  cellspacing="0" cellpadding="0" ></table>');
				$("#usertable").treegrid({
					url:'<%=basePath%>Main/linkman/getCheckData',
					idField:'DID',    
				    treeField:'DEFT',
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
					columns:[[{title:'部门',field:'DEPT',width:180},
					          {title:'联系人',field:'DID',width:300,
							formatter: function(value,row,index){
								var s="";
								if (value) {
									var list=[];
									for(var i in lmList){
										if(value==lmList[i].DID)
											list.push(lmList[i]);
										}
									var table=$('<table></table>');
									var row=Math.ceil(list.length/colCount);
									for(var i=0;i<row;i++){
										var tr=$("<tr>");
										for(var j=0;j<colCount;j++){
											var data=list[i*colCount+j];
											var td=$('<td style="border:none;"></td>');
											if(data){
												td.html('<label style="font-size:12px"><input type="checkbox" id="'+ data.ID +'" value="' + data.NAME + '" name="userBox"  >' + data.NAME + '</label>&nbsp;&nbsp;&nbsp;');
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
	  });
	</script>

 <div class="easyui-layout"  data-options="fit:true">
	 <div data-options="region:'north',border:false" style="height: 35px;">
	 <div id="dbasource_tb" style="margin-top: 5px;margin-left: 5px;">
		</div>
	 </div>
		<div data-options="region:'center',border:false">
		<div id="checkuserDiv" style="width: 100%;height: 100%;">
			</div>
		</div>
		
	</div>


