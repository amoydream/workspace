<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

  <script>
  var basePath = '<%=basePath%>';
  var colCount=9;
  function deptToUser(value,row,index){
	  var s="";
		if (value) {
			var list=row.USERLIST;
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
			}
			table.append(tr);
			return table[0].outerHTML;
	   }
  }
	</script>

 <div class="easyui-layout"  data-options="fit:true">
	 
		<div data-options="region:'center',border:false">
			<table id="wfCheckUser" class="easyui-treegrid" cellspacing="0" cellpadding="0" 
			data-options="url:'<%=basePath%>Main/wfInstance/getCheckUserData',idField:'D_ID',treeField:'D_NAME',fitColumns : true,nowrap: false, 
			striped: true, border: true,method:'post',collapsible:false, fit: true,singleSelect: true,selectOnCheck: false,checkOnSelect: false,
			queryParams:{ftype:'${ftype}',instid:'${instid}',flag:'${flag}'}"> 
			    <thead> 
			        <tr> 
			            <th field="D_NAME" >组织</th> 
			            <th field="D_ID" width="300" formatter="deptToUser">用户</th>
			        </tr> 
			    </thead> 
			</table> 
		</div>
		
	</div>


