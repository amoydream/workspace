(function($){

	//工具栏类
	var toolBar=function(container,className){
		this.obj=null;
		this.items={};
		
		var ul=$("<ul>");
		this.obj=container;
		container.addClass(className).append(ul);

		this.addItem=function(itemId,itemName,icon){
			var item=new button(itemId,itemName,icon);
			ul.append(item.obj);
			this.items[itemId]=item;
			return item;
		};

		this.getItem=function(itemId){
			return this.items[itemId];
		};
	};

	//按钮类
	var button=function(id,name,icon){
			
		var li=$("<li>"),img=$("<img>");
		img.attr("src",gisPath+"/css/icon/"+icon+".png").attr("title",name).css({width:"20px",height:"20px"});
		li.append(img);

		this.obj=li;
		this.id=id;
		this.value=name;
		this.icon=icon;

		this.setName=function(){};

		this.onClick=function(fn){
			li.on("click",fn);
		};

	};
	

	//对话框类
	var dialog=function(dlgContainer,id,title,icon){
		
		var container=$("<div>").addClass("dialog winbg_"+icon),minDlg;
		var windows=$("<div>").addClass("windows"),top=$("<div>").addClass("bt1"),
			topLeft=$("<div class=\"bt2\"><li>"+title+"</li></div>"),topRight=$("<div>").addClass("bt3"),
			topToolBar=$("<ul>"),winContent=$("<div class=\"container\">"),content=$("<div class=\"content\" framefor=\"main\">");
		//存储打开、关闭对话框回调函数
		var openEventHandler={},closeEventHandler={};
		
		topRight.append(topToolBar);
		top.append(topLeft).append(topRight);
		winContent.append(content);
		windows.append(top).append(winContent);
		container.append(windows);
		dlgContainer.append(container);
		container.hide();

		this.obj=container;
		this.dialogList=dlgContainer;	//存放对话框集外部容器
		
		var resize=function(){
	     	var height = $(window).height();    
		    var divHeight = dlgContainer.css("height","auto").height(),
		    	divWidth  = dlgContainer.width();
		
		  $("body").css("height",height);
		  if(divHeight>=height){
			  dlgContainer.css("height",height);
		  }
		  if(divHeight<height){
			  dlgContainer.css("height","auto");
		  }
		  
		  dlgContainer.css("width","auto");
		  var clientWidth=dlgContainer[0].clientWidth,
		  	  scrollWidth=dlgContainer[0].scrollWidth;
		  if(clientWidth<scrollWidth)
			  dlgContainer.css("width",scrollWidth+20);
		}
		
		window.onresize=resize;

		this.addOpenEvent=function(fnName,fn){
			openEventHandler[fnName]=fn;
		}

		this.removeOpenEvent=function(fnName){
			for(var ev in openEventHandler)
				if(ev==fnName){
					delete openEventHandler[ev];
					break;
			}
		}

		this.clearOpenEvent=function(){
			openEventHandler={};
		}

		this.addCloseEvent=function(fnName,fn){
			closeEventHandler[fnName]=fn;
		}

		this.removeCloseEvent=function(fnName){
			for(var ev in closeEventHandler)
				if(ev==fnName){
					delete closeEventHandler[ev];
					break;
				}
		}

		this.clearCloseEvent=function(){
			closeEventHandler={};
		}

		this.open=function(){
			container.show();
			minDlg.hide();
			resize();
			for(var name in openEventHandler)
				openEventHandler[name].call(this);
		};

		this.close=function(){
			container.hide();
			minDlg.hide();
			resize();
			for(var name in closeEventHandler)
				closeEventHandler[name].call(this);
		};

		this.minimize=function(){
			minDlg.show();
			container.hide();
			resize();
		}

		this.restore=function(){
			minDlg.hide();
			container.show();
			resize();
		}

		this.appendToolBar=function(className,name,fn){
			var li=$("<li title=\""+name+"\">"),img=$("<img>").addClass(className).attr("src",gisPath+"/css/icon/pixel.gif").appendTo(li);
			container.find(".bt3 ul").append(li);

			li.on("click",fn);
		};

		this.createMinDialog=function(){
			minDlg=$('<div class="specil_table" style="display:none;"><a class="specil_title"> '+title+'</a></div>');
			minDlg.css("background","url("+gisPath+"/css/icon/"+icon+".png) no-repeat right top");
			minDlg.insertAfter(container);
			minDlg.on("click",this.restore);
		}

		this.getMainFrame=function(){
			return content;
		};

		this.getFrameContainer=function(){
			return container;
		};

		this.getFrame=function(id){
			return container.find("div[framefor='"+id+"']");
		}

		this.getAllFrame=function(){
			return winContent.children();
		};
		
		this.appendFrame=function(id,frame){
			frame.attr("framefor",id).addClass("content").appendTo(winContent);
		};

		this.appendToolBar("closed","关闭",this.close);
		this.appendToolBar("min","最小化",this.minimize);
		
		this.createMinDialog();
	};

	$.fn.toolBar={
		init:function(obj){
			return new toolBar(obj,'toolbar');
		}
	};

	$.fn.customDialog={
		createDialog:function(id,title,icon,dlgContainer){
			
			//var dlgContainer=$("div.treeee2");
			if(!dlgContainer){
				dlgContainer=$("div.treeee2");
			}
			var dlgList=dlgContainer.data("dialog");
			if(dlgContainer.length==0){
				dlgContainer=$("<div>").addClass("treeee2");
				$("body").append(dlgContainer);
			}else{
				dlgContainer=dlgContainer.eq(0);
			}
			if(!dlgList)
				dlgList={};
			dlgList[id]=new dialog(dlgContainer,id,title,icon);
			this.container=dlgContainer;
			this.container.data("dialog",dlgList);
			return dlgList[id];
		},
		getDialog:function(id){
			var dlgList=this.container.data("dialog");
			return dlgList[id];
		}
	};

})(jQuery);

var _openDlg=function(url){
	var param ={
			title:'详细信息',
			width:800,
			height:500,
			maximizable:true,
			modal: true,
			buttons:[],
			href:url
		};
		$.lauvan.openCustomDialog("handleDialog", param, null, null);
}
var _openMedia=function(path){
var content="<div style='margin:5px 10px;height:95%;'>";
content+="<a href='"+path+"' style='display:block;width:100%;height:94%' id='player'></a></div>";
content+="<script>(function(){flowplayer('player', '"+$.basePath+"plugins/gis/plugins/flowplayer/flowplayer-3.2.5.swf');})();<\/script>";

parent.$.lauvan.openCustomDialog("mediaDlg",{
		title:'详细情况',
		width: 700,
	    height: 540,
	    iconCls:'icon-applicationform',
		content:content,
		buttons:[{
			text:'关闭',
			iconCls:'icon-no',
			handler:function(){
				parent.$("#mediaDlg").dialog('close');
			}
		}]
	},null,null);
}