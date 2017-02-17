$.ajaxSetup({ 
　　　　error: function (XMLHttpRequest, textStatus, errorThrown){
　　　　　　if(XMLHttpRequest.status==403){
　　　　　　　　$.messager.alert('我的消息', '您没有权限访问此资源或进行此操作！', 'success');
　　　　　　　　return false;
　　　　　　}
　　　　}, 
　　　　complete:function(XMLHttpRequest,textStatus){ 
　　　　　　var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); //通过XMLHttpRequest取得响应头,sessionstatus， 　　　　　　
			//alert(sessionstatus);
			if(sessionstatus=='timeout'){ 
　　　　　　　　//如果超时就处理 ，指定要跳转的页面 　　　　　　　　
				var top = getTopWinow(); //获取当前页面的顶层窗口对象 　　　　　　　　
				//$.messager.alert('我的消息', '登录超时-请重新登录！', 'info');
				alert("用户未登录或者登录超时，请重新登录！");
　　　　　　　　	//top.location.href = "http://"+window.location.host+"/base/Login"; //跳转到登陆页面 对多服务器同样适用 　　　
				top.location.href = win_getRootPath()+"/Login/index"; //跳转到登陆页面 对多服务器同样适用 　　　　
			} 
　　　　} 
});

/** 
* 在页面中任何嵌套层次的窗口中获取顶层窗口 
* @return 当前页面的顶层窗口对象 
*/ function getTopWinow(){ 
　　　　　　　　var p = window; 
　　　　　　　　while(p != p.parent){ 
　　　　　　　　　　　　p = p.parent; 
　　　　　　　　} 
　　　　return p; 
　　　}

//js获取项目根路径，如： http://localhost:85/base
function win_getRootPath(){
    //获取当前网址，如：http://localhost:85/base/Main/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： base/Main/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:85
    var localhostPaht=curWwwPath.substring(0,pos);
    //获取带"/"的项目名，如：/base
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    return(localhostPaht+projectName);
}