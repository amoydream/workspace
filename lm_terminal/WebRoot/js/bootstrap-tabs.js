
var addTabs = function (obj) {
	if(obj.id!=undefined && obj.id.substr(0,13)=="parentAddtabs"){
	    id = "tab_" + obj.id;
	    //console.info(id);
	    parent.$(".active").removeClass("active");
	     
	    //如果TAB不存在，创建一个新的TAB
	    if (!$("#" + id)[0]) {
	        //固定TAB中IFRAME高度,根据需要自己修改
	    	var height = parent.$(".content-wrapper").height()*0.941; 
	        //mainHeight = window.screen.availHeight*0.55;
	        //创建新TAB的title
	        title = '<li role="presentation" id="tab_' + id + '"><a style="cursor: pointer;" href="javascript:void(0);" aria-controls="' + id + '" role="tab" data-toggle="tab" onclick="parentActive(this)"; >' + obj.title+'</a>';
	        //是否允许关闭
	        if (obj.close) {
	            title += ' <i class="close-tab glyphicon glyphicon-remove"></i>';
	        }
	        title += '</li>';
	        //是否指定TAB内容
	        if (obj.content) {
	            content = '<div role="tabpanel" class="content-main tab-pane" id="' + id + '">' + obj.content + '</div>';
	        } else {//没有内容，使用IFRAME打开链接
	        	var url = obj.url;
	        	if(obj.param != undefined && obj.param!=''){
	        		url = url+'?pid='+obj.param;
	        	}
	        	//console.info(url);
	            content = '<div role="tabpanel"  style="text-align:center;overflow: hidden;" class="tab-pane" id="' + id + '" name="' + id + '"><iframe id="' + id + '_iframe" name="' + id + '_iframe" src="' + url + '"  width="100%" height="'+height+'" frameborder="no" border="0" marginwidth="0" marginheight="0" allowtransparency="yes"></iframe></div>';
	        }
	        //加入TABS
	        parent.$(".nav-tabs").append(title);
	        parent.$(".tab-content").append(content);
	    }
	     
	    //激活TAB
	    parent.$("#tab_" + id).addClass('active');
	    parent.$("#" + id).addClass("active");
	}else{
	    id = "tab_" + obj.id;
		//console.info(id);
	    $(".active").removeClass("active");
	     
	    //如果TAB不存在，创建一个新的TAB
	   // console.info(!$("#" + id)[0]);
	    if (!$("#" + id)[0]) {
	        //固定TAB中IFRAME高度,根据需要自己修改
	    	var height = $(".content-wrapper").height()*0.941; 
	        //mainHeight = window.screen.availHeight*0.7;
	        //创建新TAB的title
	        title = '<li role="presentation" id="tab_' + id + '"><a style="cursor: pointer;" href="javascript:void(0);" aria-controls="' + id + '" role="tab" data-toggle="tab" onclick="active(this);">' + obj.title+'</a>';
	        //是否允许关闭
	        if (obj.close) {
	            title += ' <i class="close-tab glyphicon glyphicon-remove" ></i>';
	        }
	        title += '</li>';
	        //是否指定TAB内容
	        if (obj.content) {
	            content = '<div role="tabpanel" class="tab-pane" id="' + id + '"  >' + obj.content + '</div>';
	        } else {//没有内容，使用IFRAME打开链接
	        	var url = obj.url;
	        	if(obj.param != undefined && obj.param!=''){
	        		url = url+'?pid='+obj.param;
	        	}
	            content = '<div role="tabpanel"  class=" content-main tab-pane" id="' + id + '" name="' + id + '"><iframe id="' + id + '_iframe" name="' + obj.title + '" src="' + url + '"  width="100%" height="'+height+'" frameborder="no" border="0" marginwidth="0" marginheight="0" allowtransparency="yes"></iframe></div>';
	        }
	        //console.info(content);
	        //加入TABS
	        $(".nav-tabs").append(title);
	        $(".tab-content").append(content);
	    }else{
	    	//刷新页面
	    	var url = obj.url;
        	if(obj.param != undefined && obj.param!=''){
        		if(!document.getElementById("tab_fax")[0]){    //解决当前页面是传真页面时点击接收传真成功跳转失败
        			id="tab_fax";    
        		}
        		url = url+'?pid='+obj.param;
        	}
            
	    	document.getElementById(id+"_iframe").contentWindow.location=url;
	    	//alert("reflash:"+id+"_iframe");
	    }
	    
	    //console.info(content);
	    //激活TAB
	    $("#tab_" + id).addClass('active');
	    $("#" + id).addClass("active");	
	   
	}
	

};

var closeTab = function (id) {
    //如果关闭的是当前激活的TAB，激活他的前一个TAB
    if ($("li.active").attr('id') == "tab_" + id) {
        $("#tab_" + id).prev().addClass('active');
        $("#" + id).prev().addClass('active');
    }
    //关闭TAB
    $("#tab_" + id).remove();
    $("#" + id).remove();
};

$(function () {
    $("[addtabs]").click(function () {
        addTabs({id: $(this).attr("addtabs"), title: $(this).attr('title'), url: $(this).attr('url'), close: true,param:$(this).attr('param')});
    });
    
    $(".nav-tabs").on("click", ".close-tab", function () {
        id = $(this).prev("a").attr("aria-controls");
        closeTab(id);
    });
    
});

function tabs_init(){
	$("[addtabs]").click(function () {
        addTabs({id: $(this).attr("addtabs"), title: $(this).attr('title'), url: $(this).attr('url'), close: true,param:$(this).attr('param')});
    });
}
function tabs_init2(tabs){
	//console.info(tabs);
	$("."+tabs).click(function () {
		//console.info(11);
		addTabs({id: $(this).attr("addtabs"), title: $(this).attr('title'), url: $(this).attr('url'), close: true,param:$(this).attr('param')});
	});
}


/**
 * 激活当前tab
 */
function active(tab){
	 $(".active").removeClass("active");
	 id = $(tab).attr("aria-controls");
     $("#tab_" + id).addClass('active');
     $("#" + id).addClass('active');
}


/**
 * 激活当前父tab
 */
function parentActive(tab){
	 parent.$(".active").removeClass("active");
	 id = $(tab).attr("aria-controls");
     parent.$("#tab_" + id).addClass('active');
     parent.$("#" + id).addClass('active');
     refresh(id+"_iframe");
}

/**
 * 激活hometab
 */
function homeActive(){
	 $(".active").removeClass("active");
     $("#tab_home").addClass('active');
     $("#home").addClass('active');
}

function tabs_open(the){
	addTabs({id: $(the).attr("tab_id"), title: $(the).attr('title'), url: $(the).attr('url'), close: true,param:$(the).attr('param')});
}
function tabs_open2(id,title,url,param){
	/*if(!$("#tab_tab_fax")[0]){
		parent.$(".active").removeClass("active");
		parent.$("#tab_fax").addClass('active');
		parent.$("#tab_tab_fax").addClass('active');
	}else{*/
		addTabs({id: id, title: title, url: url, close: true,param:param});
	
	
		
	
}

/**
 * 刷新
 * @param name 是iframe 的id
 */
function refresh(name){
	parent.document.getElementById(''+name+'').contentWindow.location.reload(true);
}