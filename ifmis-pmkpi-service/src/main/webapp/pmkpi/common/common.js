
if (Ext.lt.ui == null) {
	Ext.lt.ui = {}
};

if (typeof Platform == 'undefined') var Platform = {};
// 浏览器类型获取.
Platform.getUserAgent = navigator.userAgent;
Platform.isGecko = Platform.getUserAgent.indexOf("Gecko") != -1;
Platform.isOpera = Platform.getUserAgent.indexOf("Opera") != -1;
Platform.isIE = Platform.getUserAgent.indexOf("MSIE") != -1;

//jhl重写alert
window.alert = function(info){
	layui.use("layer",function(){
		var layer = layui.layer
		layer.alert(info)
	})
}
Ext.lt.ui.Utf8Encode = function(string) {
    string = string.replace(/\r\n/g, "\n");
    var utftext = "";

    for (var n = 0; n < string.length; n++) {
        var c = string.charCodeAt(n);
        if (c < 128) {
            utftext += String.fromCharCode(c);
        } else if ((c > 127) && (c < 2048)) {
            utftext += String.fromCharCode((c >> 6) | 192);
            utftext += String.fromCharCode((c & 63) | 128);
        } else {
            utftext += String.fromCharCode((c >> 12) | 224);
            utftext += String.fromCharCode(((c >> 6) & 63) | 128);
            utftext += String.fromCharCode((c & 63) | 128);
        }
    }

    return utftext;
};
Ext.lt.ui.crc32 = function(str,crc) {
    str = Ext.lt.ui.Utf8Encode(str);
    var table = "00000000 77073096 EE0E612C 990951BA 076DC419 706AF48F E963A535 9E6495A3 0EDB8832 79DCB8A4 E0D5E91E 97D2D988 09B64C2B 7EB17CBD E7B82D07 90BF1D91 1DB71064 6AB020F2 F3B97148 84BE41DE 1ADAD47D 6DDDE4EB F4D4B551 83D385C7 136C9856 646BA8C0 FD62F97A 8A65C9EC 14015C4F 63066CD9 FA0F3D63 8D080DF5 3B6E20C8 4C69105E D56041E4 A2677172 3C03E4D1 4B04D447 D20D85FD A50AB56B 35B5A8FA 42B2986C DBBBC9D6 ACBCF940 32D86CE3 45DF5C75 DCD60DCF ABD13D59 26D930AC 51DE003A C8D75180 BFD06116 21B4F4B5 56B3C423 CFBA9599 B8BDA50F 2802B89E 5F058808 C60CD9B2 B10BE924 2F6F7C87 58684C11 C1611DAB B6662D3D 76DC4190 01DB7106 98D220BC EFD5102A 71B18589 06B6B51F 9FBFE4A5 E8B8D433 7807C9A2 0F00F934 9609A88E E10E9818 7F6A0DBB 086D3D2D 91646C97 E6635C01 6B6B51F4 1C6C6162 856530D8 F262004E 6C0695ED 1B01A57B 8208F4C1 F50FC457 65B0D9C6 12B7E950 8BBEB8EA FCB9887C 62DD1DDF 15DA2D49 8CD37CF3 FBD44C65 4DB26158 3AB551CE A3BC0074 D4BB30E2 4ADFA541 3DD895D7 A4D1C46D D3D6F4FB 4369E96A 346ED9FC AD678846 DA60B8D0 44042D73 33031DE5 AA0A4C5F DD0D7CC9 5005713C 270241AA BE0B1010 C90C2086 5768B525 206F85B3 B966D409 CE61E49F 5EDEF90E 29D9C998 B0D09822 C7D7A8B4 59B33D17 2EB40D81 B7BD5C3B C0BA6CAD EDB88320 9ABFB3B6 03B6E20C 74B1D29A EAD54739 9DD277AF 04DB2615 73DC1683 E3630B12 94643B84 0D6D6A3E 7A6A5AA8 E40ECF0B 9309FF9D 0A00AE27 7D079EB1 F00F9344 8708A3D2 1E01F268 6906C2FE F762575D 806567CB 196C3671 6E6B06E7 FED41B76 89D32BE0 10DA7A5A 67DD4ACC F9B9DF6F 8EBEEFF9 17B7BE43 60B08ED5 D6D6A3E8 A1D1937E 38D8C2C4 4FDFF252 D1BB67F1 A6BC5767 3FB506DD 48B2364B D80D2BDA AF0A1B4C 36034AF6 41047A60 DF60EFC3 A867DF55 316E8EEF 4669BE79 CB61B38C BC66831A 256FD2A0 5268E236 CC0C7795 BB0B4703 220216B9 5505262F C5BA3BBE B2BD0B28 2BB45A92 5CB36A04 C2D7FFA7 B5D0CF31 2CD99E8B 5BDEAE1D 9B64C2B0 EC63F226 756AA39C 026D930A 9C0906A9 EB0E363F 72076785 05005713 95BF4A82 E2B87A14 7BB12BAE 0CB61B38 92D28E9B E5D5BE0D 7CDCEFB7 0BDBDF21 86D3D2D4 F1D4E242 68DDB3F8 1FDA836E 81BE16CD F6B9265B 6FB077E1 18B74777 88085AE6 FF0F6A70 66063BCA 11010B5C 8F659EFF F862AE69 616BFFD3 166CCF45 A00AE278 D70DD2EE 4E048354 3903B3C2 A7672661 D06016F7 4969474D 3E6E77DB AED16A4A D9D65ADC 40DF0B66 37D83BF0 A9BCAE53 DEBB9EC5 47B2CF7F 30B5FFE9 BDBDF21C CABAC28A 53B39330 24B4A3A6 BAD03605 CDD70693 54DE5729 23D967BF B3667A2E C4614AB8 5D681B02 2A6F2B94 B40BBE37 C30C8EA1 5A05DF1B 2D02EF8D";

    if (typeof(crc) == "undefined") {
        crc = 0;
    }
    var x = 0;
    var y = 0;

    crc = crc ^ ( - 1);
    for (var i = 0,
    iTop = str.length; i < iTop; i++) {
        y = (crc ^ str.charCodeAt(i)) & 0xFF;
        x = "0x" + table.substr(y * 9, 8);
        crc = (crc >>> 8) ^ x;
    }

    return crc ^ ( - 1);
};



Ext.lt.ui.getUrlQueryString = function() {
	var urlprarmter = window.location.search;
	if(urlprarmter!=null){
		var regexp = new RegExp("(\\?|&)tokenid="+Ext.lt.token.getTokenid(),'gi'), 
		urlprarmter = urlprarmter.replace(regexp,"");
		regexp = new RegExp("^[(\\?|&)]",'gi'); 
		urlprarmter = urlprarmter.replace(regexp,"");
	}
    return urlprarmter;
}

Ext.lt.ui.getUrlParameters = function() {
	var urlParams = {};
	(function () {
		var match,
			pl     = /\+/g,  // Regex for replacing addition symbol with a space
			search = /([^&=]+)=?([^&]*)/g,
			decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); },
			query  = Ext.lt.ui.getUrlQueryString();

		while (match = search.exec(query))
		   urlParams[decode(match[1])] = decode(match[2]);
	})();
	return urlParams;
}
Ext.lt.ui.urlAddMenu = function(URL){
	var urlParams = Ext.lt.ui.getUrlParameters();
	if(URL.indexOf('mainmenu')==-1){
		var mainmenu = urlParams["mainmenu"];
		if(URL.indexOf('?')==-1){
			URL+='?mainmenu='+mainmenu;
		}else{
			URL+='&mainmenu='+mainmenu;
		}
	}

	var submenu = urlParams["submenu"];
	if(URL.indexOf('submenu')==-1 && submenu){
		if(URL.indexOf('?')==-1){
			URL+='?submenu='+submenu;
		}else{
			URL+='&submenu='+submenu;
		}
	}
	
	var menuId = urlParams["menuId"];
	if(URL.indexOf('menuId')==-1 && menuId){
		if(URL.indexOf('?')==-1){
			URL+='?menuId='+menuId;
		}else{
			URL+='&menuId='+menuId;
		}
	}
	
	return URL;
}
Ext.lt.ui.getViewportWidth = function() {
    var width = 0;
    if (document.documentElement && document.documentElement.clientWidth) {
        width = document.documentElement.clientWidth;
    } else if (document.body && document.body.clientWidth) {
        width = document.body.clientWidth;
    } else if (window.innerWidth) {
        width = window.innerWidth - 18;
    }
    return width;
}

Ext.lt.ui.getViewportHeight = function() {
    var height = 0;
    if (window.innerHeight) {
        height = window.innerHeight - 18;
    } else if (document.documentElement && document.documentElement.clientHeight) {
        height = document.documentElement.clientHeight;
    } else if (document.body && document.body.clientHeight) {
        height = document.body.clientHeight;
    }
    return height;
}

Ext.lt.ui.getViewportScrollX = function() {
    var scrollX = 0;
    if (document.documentElement && document.documentElement.scrollLeft) {
        scrollX = document.documentElement.scrollLeft;
    } else if (document.body && document.body.scrollLeft) {
        scrollX = document.body.scrollLeft;
    } else if (window.pageXOffset) {
        scrollX = window.pageXOffset;
    } else if (window.scrollX) {
        scrollX = window.scrollX;
    }
    return scrollX;
}

Ext.lt.ui.getViewportScrollY = function() {
    var scrollY = 0;
    if (document.documentElement && document.documentElement.scrollTop) {
        scrollY = document.documentElement.scrollTop;
    } else if (document.body && document.body.scrollTop) {
        scrollY = document.body.scrollTop;
    } else if (window.pageYOffset) {
        scrollY = window.pageYOffset;
    } else if (window.scrollY) {
        scrollY = window.scrollY;
    }
    return scrollY;
}
//对象窗口垂直左右居中
Ext.lt.ui.vAlign = function(obj){
    var top = Math.floor((Ext.lt.ui.getViewportHeight()- obj.offsetHeight)/2) + Ext.lt.ui.getViewportScrollY() ;
    if (!Platform.isIE) {
        top += 16;
    }
	var left = Math.floor((Ext.lt.ui.getViewportWidth()- obj.offsetWidth)/2)+ Ext.lt.ui.getViewportScrollX()
    obj.style.top = top + "px";
    obj.style.right = left + "px";
}
//是否有右侧滚动条
Ext.lt.ui.isScrollY = function(obj) {
	if ((obj.scrollHeight-15) > obj.clientHeight || obj.offsetHeight > obj.clientHeight) {
		return true;
	}
	return false;
}

Ext.lt.ui.isScrollX = function(obj) {
	if ((obj.scrollWidth-15) > obj.clientWidth || obj.offsetWidth > obj.clientWidth) {
		return true;
	}
	return false;
}

Ext.lt.ui.window = function(cfg){
	var _window = {};
	var _config = Ext.lt.apply({className:'windpblue',w:500,h:350,fitmode:'content',showredo:false,pop:true,mark:true,close:true,drag:true,buttons:[{
        name: 'close',
        title: '关闭',
        icon: 'close',
        action: function() {
            _window.close();
        },
        disabled: false
    }]},cfg);
	_window = new Ext.lt.window(_config);
	var _width = _config.w;
	var _height = _config.h;
	var _buttons = _config.buttons;
	var _footerheight= 40;
	_height = _height-38;
	var _html=[];
	_html.push('<div style="margin:0;overflow: hidden;width:',_width,'px;height:',_height,'px;">');
	_html.push('	<div id="maindiv" class="wincontent" style="position:relative; margin: 0 auto;overflow-x:hidden;overflow-y:auto;width:',_width,'px;height:'+(_height-_footerheight)+'px"><div></div>');
	_html.push('	</div>');
	_html.push('	<div id="footer" class="winfooter" style="width: 100%;height:'+_footerheight+'px;line-height:'+_footerheight+'px;">');
	if(_config.showredo){
		_html.push('		<div id ="redo" style="padding-left:5px;float: left;width:80px;"><input type="checkbox" name="redo" id="redo"><label for="redo" >&nbsp;&nbsp;连续录入</label></div>');
	}
	_html.push('		<div style="margin-top:3px;float: right;width:'+(_width-80-5)+'px;"></div>');
	_html.push('	</div>');
	_html.push('</div>');
	var div = $(_html.join('').replace(/\t/g,""))[0];
	_window.draw(div);
	_window.content = div.firstChild.firstChild;
	if(_config.showredo){
		_window.redo = div.lastChild.firstChild.firstChild;
		_window.isRedo=function(obj){
			return this.redo.checked;
		}
		_window.setRedo=function(istrue){
			return this.redo.checked = istrue;
		}
	}

    var _wintoolbuttonbar = _window.toolbuttonbar = new Ext.lt.ui.toolbuttonbar({
        data: {
            buttons: _buttons
        }
    });
    _wintoolbuttonbar.draw(div.lastChild.lastChild);
	_window.setTitle = function(title){
		$(".title",$(this)).html(title);
	}

	_window.draw=function(obj){
		var div = this.content;
		if (obj == null) {
			div.innerHTML == "";
			return;
		}
		if (Ext.lt.isFunction(obj.draw)) {
			obj.draw(div);
			this.obj = obj;
		}else if(typeof(obj)=="object"){
			div.appendChild(obj);
		}else {
			div.innerHTML = obj;
		}
		this.hide();
	}
	var _show = _window.show;
	_window.show = function(){
		_show();
		if (!!this.obj)this.obj.resize(_width,_height-_footerheight);
		Ext.lt.ui.vAlign(this);
	}
	_window.resize1 = function(w,h){
		this.resize(w,h);
		div.style.width=w+'px';
		div.style.height=h+'px';
		div.firstChild.style.width=w+'px';
		div.firstChild.style.height=(h-_footerheight)+'px';
		if(!!this.obj)this.obj.resize(w,(h-_footerheight));

	}
	_window.remove = function(){
		if(Ext.lt.isie){
			_window.removeNode(true);
		}else{
			var dandy = _window.parentNode; 
			try{
				dandy.removeChild(_window);
			}catch(e){
			}
		}
	}
	return _window;
}


/**
 * 打开模态窗口
 * @param url
 * @param width
 * @param height
 * @returns
 */
// jinweiwei 添加
Ext.lt.ui.openModalWindowNew = function(url,width,height,titlename,param){
	url = Ext.lt.token.urlAddToken(url);
	url = Ext.lt.ui.urlAddMenu(url);
	url += Ext.lt.token.getAuthorization();
	if(encodeURIComponent(url).length>(2083-40)){
		var query = "";
		var pos =  url.substr(0,2000).lastIndexOf('&');
		if(pos>0){
            query = url.substr(pos+1);
            url = url.substr(0,pos);
		}else{
            pos =  url.indexOf('?');
            query = url.substr(pos+1);
            url = url.substr(0,pos);
		}
		param = typeof(param)!="undefined"? param:{};
		(function () {
			var match,
				pl     = /\+/g,  // Regex for replacing addition symbol with a space
				search = /([^&=]+)=?([^&]*)/g,
				decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); };

			while (match = search.exec(query))
				param[decode(match[1])] = decode(match[2]);
		})();
	}
	if(!titlename){
		titlename=""
	}
	var _window = new Ext.lt.window({
		title:titlename,
		pop:true,
		mark:true,
		w:width,
		h:height,
		drag:true,
		fitmode:'content',
		className:'windpblue'
	});
	
	if(typeof(param)=="undefined"){
		var framediv = $('<div style="width:'
				+ (width) + 'px; height:' + (height) + 'px;overflow:hidden;"><iframe src="'
				+ url + '" scrolling="no" frameborder=0 style="width:'
				+ (width) + 'px; height:' + (height) + 'px"></iframe></div>');
		_window.draw(framediv[0]);
	}else{
		var iframeId = "frameId"+_window.id;
		var winIframeDiv = "winIframeDiv"+_window.id;
		var _url = "";
		var iframe;
		var framediv = $('<div style="width:'
				+ (width) + 'px; height:' + (height) + 'px;overflow:hidden;"><iframe id="'
				+ iframeId + '" name="'
				+ iframeId + '" src="'
				+ _url + '" scrolling="no" frameborder=0 style="width:'
				+ (width) + 'px; height:' + (height) + 'px"></iframe></div>');
		_window.draw(framediv[0]);
		iframe = document.getElementById(iframeId);
		var iframediv=document.getElementById(winIframeDiv);
		if(iframe){			
			var div=document.createElement("div");
			div.id=winIframeDiv;
			div.innerHTML="<form  action='' method='post' target='"+iframeId+"'></form>";
			div.style.display='none';
			document.body.appendChild(div);
			iframediv=document.getElementById(winIframeDiv);
			iframediv.firstChild.action = url;
			for(var name in param){
				var _input=document.createElement("input");
				_input.name = name;
				_input.type = "hidden";
				_input.value = param[name];
				iframediv.firstChild.appendChild(_input);
			}
			iframediv.firstChild.submit();			
		}
		
	}
	Ext.lt.ui.vAlign(_window);
    Ext.lt.ui.modalWindow = _window;
    _window.focus();
	return _window;
}
//jhl添加的layui弹框方法
Ext.lt.ui.openModalWindowLayer = function(url,width,height,titlename,callback){
	url = Ext.lt.token.urlAddToken(url);
	url = Ext.lt.ui.urlAddMenu(url);
	url += Ext.lt.token.getAuthorization();
	url = url+'&isShowPop=1';
	if(encodeURIComponent(url).length>(2083-40)){
		var query = "";
		var pos =  url.substr(0,2000).lastIndexOf('&');
		if(pos>0){
            query = url.substr(pos+1);
            url = url.substr(0,pos);
		}else{
            pos =  url.indexOf('?');
            query = url.substr(pos+1);
            url = url.substr(0,pos);
		}
		param = typeof(param)!="undefined"? param:{};
		(function () {
			var match,
				pl     = /\+/g,  // Regex for replacing addition symbol with a space
				search = /([^&=]+)=?([^&]*)/g,
				decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); };

			while (match = search.exec(query))
				param[decode(match[1])] = decode(match[2]);
		})();
	}
	if(!titlename){
		titlename=""
	}
	layui.use("layer",function(){
		var layer = layui.layer;  //layer初始化
		var index = layer.open({
			type: 2,
			title: titlename,
			shadeClose: false, //是否点击遮罩关闭
			shade: 0.8,
			area: [width, height],
			content: url,
			end: function(){
				if(typeof(callback) != 'undefined'){
					callback(index);
				}
			}
		})
	})
}
Ext.lt.ui.openModalWindow = function(url,width,height,titlename,param){
	url = Ext.lt.token.urlAddToken(url);
	url = Ext.lt.ui.urlAddMenu(url);
	url += Ext.lt.token.getAuthorization();
	url = url+'&isShowPop=1';
	if(encodeURIComponent(url).length>(2083-40)){
		var query = "";
		var pos =  url.substr(0,2000).lastIndexOf('&');
		if(pos>0){
            query = url.substr(pos+1);
            url = url.substr(0,pos);
		}else{
            pos =  url.indexOf('?');
            query = url.substr(pos+1);
            url = url.substr(0,pos);
		}
		param = typeof(param)!="undefined"? param:{};
		(function () {
			var match,
				pl     = /\+/g,  // Regex for replacing addition symbol with a space
				search = /([^&=]+)=?([^&]*)/g,
				decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); };

			while (match = search.exec(query))
				param[decode(match[1])] = decode(match[2]);
		})();
	}
	if(!titlename){
		titlename=""
	}
	var _window = new Ext.lt.window({
		title:titlename,
		pop:true,
		mark:true,
		w:width,
		h:height,
		drag:true,
		fitmode:'content',
		className:'windpblue'
	});
	
	if(typeof(param)=="undefined"){
		var framediv = $('<div style="width:'
				+ (width-2) + 'px; height:' + (height-40) + 'px;overflow:hidden;"><iframe src="'
				+ url + '" scrolling="no" frameborder=0 style="width:'
				+ (width-2) + 'px; height:' + (height-40) + 'px"></iframe></div>');
		_window.draw(framediv[0]);
	}else{
		var iframeId = "frameId"+_window.id;
		var winIframeDiv = "winIframeDiv"+_window.id;
		var _url = "";
		var iframe;
		var framediv = $('<div style="width:'
				+ (width-2) + 'px; height:' + (height-40) + 'px;overflow:hidden;"><iframe id="'
				+ iframeId + '" name="'
				+ iframeId + '" src="'
				+ _url + '" scrolling="no" frameborder=0 style="width:'
				+ (width-2) + 'px; height:' + (height-40) + 'px"></iframe></div>');
		_window.draw(framediv[0]);
		iframe = document.getElementById(iframeId);
		var iframediv=document.getElementById(winIframeDiv);
		if(iframe){			
			var div=document.createElement("div");
			div.id=winIframeDiv;
			div.innerHTML="<form  action='' method='post' target='"+iframeId+"'></form>";
			div.style.display='none';
			document.body.appendChild(div);
			iframediv=document.getElementById(winIframeDiv);
			iframediv.firstChild.action = url;
			for(var name in param){
				var _input=document.createElement("input");
				_input.name = name;
				_input.type = "hidden";
				_input.value = param[name];
				iframediv.firstChild.appendChild(_input);
			}
			iframediv.firstChild.submit();			
		}
		
	}
	Ext.lt.ui.vAlign(_window);
    Ext.lt.ui.modalWindow = _window;
    _window.focus();
	return _window;
}

Ext.lt.ui.closeModalWindow = function(){
	parent.Ext.lt.ui.modalWindow.close();
}


Ext.lt.ui.debug = false;
Ext.lt.ui.alert=function(str,cfg,callbakfn){
	if(typeof(cfg)=="function" && typeof(callbakfn)!="function"){
		callbakfn = cfg;
		cfg = {"callbakfn":callbakfn};
	}
	cfg = Ext.lt.apply({icon:'warn',buttons:[{确定:true}]},cfg);

	if(!!!callbakfn){
		alert(str);
	}else{
		return Ext.lt.ui.tipwindow(str,cfg,callbakfn);
	}
}

Ext.lt.ui.confirm=function(str,cfg,callbakfn){
	if(typeof(cfg)=="function" && typeof(callbakfn)!="function"){
		callbakfn = cfg;
		cfg = {"callbakfn":callbakfn};
	}
	var cfg = Ext.lt.apply({icon:'question',buttons:[{确定:true},{取消:false}]},cfg);
	if(!!!callbakfn){
		return confirm(str);
	}
	return Ext.lt.ui.tipwindow(str,cfg,callbakfn);
}

Ext.lt.ui.tipwindow=function(str,cfg,callbakfn){
	// 界面没有初始化完毕
	if(document.body==null){
		if(typeof(_alert)=="function"){
			_alert(str);
		}else{
			alert(str);
		}
		return;
	}
	if(typeof(callbakfn)=="function"){
		cfg["callbakfn"] = callbakfn;
	}
	if(str!=null && !!!cfg.html){
		str = (""+str).escapeHTML();
		str = (""+str).replace(/\n/g, '<br/>');
	}
	
	var _winsize = getWindowSize(str);
	var _config = Ext.lt.apply({className:'windpblue',style:'',bodystyle:'',icon:'warn',title:'系统提示',autoshow:true,pop:true,close:true,w:250,h:180,fitmode:'body',mark:true,drag:true,timeout:0,html:false,buttons:[],callbakfn:false},_winsize);
	var _config=Ext.lt.apply(_config,cfg);
	var _icon = _config.icon;
	if(_icon=="debug"&&!Ext.lt.ui.debug){
		return;
	}
	var _width = _config.w;
	var _height = _config.h;
	var _timeout = _config.timeout;
	var _showicon = _icon!="none";
	_icon += _icon.indexOf(".")==-1?".png":""; 
	var _buttons = _config.buttons;
	var _callbakfn = _config.callbakfn;
	var _buttonvalues = [];
	var btn;
	var modalDialog = _callbakfn==false;//无回调函数为模态窗口
	var _iconwidth = 0;
	var _footerheight= 38;
	var _fixh = 2;
	_height = _height-38;
	var _html=[];
	_html.push('<div style="margin: 0;width: '+_width+'px;height: '+_height+'px;background-color: #fff;">');
	_html.push('	<div id="content_container" style="margin: 0 auto;width: 100%;height:'+(_height-_footerheight-_fixh)+'px">');
	if(_showicon){
		_iconwidth = 50;
		_html.push('		<div id="content-icon" style="float: left;margin: 0 auto;width: '+_iconwidth+'px;height: 100%;">');
		_html.push('			<img  style="margin-left:10px;margin-top:'+(_height-_footerheight-40)/2+'px""  src="'+_APPID_PATH_+'/busfw/common/themes/default/images/icon/'+_icon+'" width="40"/>');
		_html.push('		</div>');
		
	}
	_html.push('		<div id="content_right" style="float: right;margin: 0 auto;overflow: auto;width: '+(_width-_iconwidth)+'px;height: 100%"><div id="content" class="spansize" style="position: relative;">');
	_html.push(str);
	_html.push('		</div></div>');
	_html.push('	</div>');
	_html.push('	<div id="footer" style="width: '+(_width-2)+'px;height:'+(_footerheight)+'px;background-color: #fbfbfb;border: 1px solid #e5e5e5;">');
	_html.push('		<div style="margin-top:3px;position: absolute;text-align: center;left:'+(_width/4-20)+'px;width:'+(_width/2+40)+'px;">');
	for(var i=0,l=_buttons.length;i<l;i++){
		btn=_buttons[i];
		for(var name in btn){
			_html.push('			<button method="'+name+'" style="line-height: 20px;padding: 4px 10px;white-space: nowrap;cursor: pointer;font-size: 14px;font-family:Microsoft YaHei;color: #666;background: #f0f2fb;border: 1px solid #cdd4f1;border-radius: 5px;" type="button" title="'+name+'">'+name+'</button>');
			_buttonvalues[name] = btn[name];
		}
		if(i<l-1)_html.push('			<span style="width:10px;height:30px;display:-moz-inline-box; display:inline-block;">&nbsp;&nbsp;&nbsp;&nbsp;</span>');
	}
	_html.push('		</div><div style="margin-top:10px;display:none;position: absolute;left:'+(_width/4*3+20)+'px;width:40px;"><span id="timeout" style="">0</span>秒</div>');
	_html.push('	</div>');
	_html.push('</div>');
	if(!modalDialog){
		var _wbody = $(_html.join('').replace(/\t/g,""));
		_config["icon"] = "wnd_icon";
		var _window = new Ext.lt.window(_config);
		_window.draw(_wbody[0]);
		_window.show();
		Ext.lt.ui.vAlign(_window);
		var content = $("#content",_wbody);
		if(_config.strw<(_width-_iconwidth)){
			var left = Math.floor((_width-_iconwidth-_config.strw)/2);
			content[0].style.width = _config.strw+'px';
			content[0].style.left = (left > 20 ? (left-15) : left)+'px';
		}
		var parentH = content[0].parentElement.clientHeight;
		if(content.height()<(parentH)){
			var top = Math.floor((parentH-content.height())/2);
			content[0].style.paddingTop   = top+'px';
		}
		
		_window.remove = function(){
			$(this).remove();
		}
		for(var i=0,l=_buttons.length;i<l;i++){
			btn=_buttons[i];
			for(var name in btn){
				$("button[method='"+name+"']",_wbody).bind("click",function(){
					_window.hide();
					_window.remove();
					_window = null;
					var m = this.getAttribute('method'); 
					var value = _buttonvalues[m]
					_callbakfn(value);
				});
			}
		}

		if(_timeout>0&&false){
			var showtime = 0;
			var showtip = $("#timeout",_wbody);
			showtip.parent().show();
			var _break = false;
			$(_window).on("click", function(event){
				_break = true;
			});
			(function () {
						if(_break){
							return;
						}
						if(showtime>=_timeout*1000){
							if(_window!=null){
								_window.hide();
								_window.remove();
								_window = null;
								var btn=_buttons[0];
								for(var name in btn){
									var value = btn[name]; 
									_callbakfn(value);
								}
							}
						}else{
							showtip.text((_timeout*1000-showtime)/1000);
							showtime+=100;
							setTimeout(arguments.callee, 90);
						}
					})();
		}
		Ext.lt.message.hook("window","minwindow",function(newwin){
			if(_window!=null&&newwin.id==_window.id){
				_window.remove();
				_window = null;
				var btn=_buttons[_buttons.length-1];
				for(var name in btn){
					var value = btn[name]; 
					_callbakfn(value);
				}
			}
		});
		var btn=_buttons[0];
		for(var name in btn){
			$("button[method='"+name+"']",_wbody).focus();
		}		
		return true;
	}else{
		var arguments ={};
		arguments["title"]=_config.title;
		arguments["html"]=_html.join('');
		arguments["buttons"]=_buttons;
		arguments["buttonsvalues"]=_buttonvalues;
		arguments["timeout"]=_timeout;
		arguments["strwidth"] = _config.strw;
		var returnvalue = window.showModalDialog(_APPID_PATH_+"/busfw/common/ui/window.html", arguments, "dialogWidth:"+_width+"px; dialogHeight:"+_height+"px;center:yes");
		return returnvalue;
	}
	

	function getWindowSize(str){
		var span = document.getElementById("__getWindowSize");
		if (span == null) {
			span = document.createElement("span");
			span.id = "__getWindowSize";
			document.body.appendChild(span);
			span.style.visibility = "hidden";
			span.style.whiteSpace = "normal";
		}
		span.innerHTML = str;
		span.className  = "windpblue";
		if(span.offsetWidth>550){
			span.style.width = 550+"px";
			span.className  = "spansize";
		}
		var strw = span.offsetWidth;
		var width = span.offsetWidth+50;
		var width = width<250?250:(width>600?600:width);
		var height = span.offsetHeight+88;
		var height = height<180?180:(height>500?500:height);
		document.body.removeChild(span);
		return {w:width,h:height,strw:strw};
	}

}


Ext.lt.ui.prompt=function(cfg){
	var datas = cfg.datas;
	var _config ={className:'windpblue',style:'',bodystyle:'',title:'系统提示',autoshow:true,pop:true,close:true,w:300,h:200,fitmode:'body',mark:true,drag:true,columnsize:1,elements:[],buttons:[{确定:true},{取消:false}]};
	var elements = [];
	var ds={};
	var numargs = arguments.length;
	var callbakfn;
	var modalDialog = false;
	if(typeof(cfg)=="string"){//第一个参数字符串，录入提示。
		elements[0]={name:cfg,label:cfg,type:"input"};
	}else if(typeof(cfg)=="object"){
		_config = Ext.lt.apply(_config,cfg);
	}else{
		 Ext.lt.ui.alert("Ext.lt.ui.prompt参数错误.\nExt.lt.ui.prompt(提示字符串,<默认值字符串>,<回调函数>);\nExt.lt.ui.prompt(提示字符串,<默认值字符串>,<回调函数>);\nExt.lt.ui.prompt(cfg对象,<回调函数>);\n",{timeout:5});
		 return;
	}
	if(numargs>1){
		if(typeof(arguments[1])=="function"){// 获取回调函数。
			callbakfn = arguments[1];
		}else{//第二个参数，录入默认值.
			elements[0]["value"] = arguments[1];
			if(numargs>2){ // 获取回调函数。
				var fn = arguments[2];
				if(typeof(fn)=="function"){
					callbakfn=fn;
				}
			}
		}
	}

	if(_config.elements && _config.elements.length>0){
		elements = _config.elements;
	}
	
	var _buttons = _config.buttons;
	for(var i=0,l=_buttons.length;i<l;i++){
		btn=_buttons[i];
		for(var name in btn){
			if(typeof(callbakfn)=="function"){
				btn[name] = callbakfn;
			}
			if(typeof(btn[name])!="function") modalDialog= true;
			callbakfn = btn[name];
		}
	}
	var _width = _config.w;
	var _height = _config.h;
	var _footerheight= 38;
	if(!modalDialog)_height = _height-38;
	var _html=[];
	_html.push('<div style="margin: 0;width: '+_width+'px;height: '+_height+'px;background-color: #fff;">');
	_html.push('	<div id="content_container" style="margin: 0 auto;width: 100%;height:'+(_height-_footerheight)+'px">');
//	_html.push('		<div id="content" style="position: relative;float: right;margin: 0 auto;overflow: auto;width: '+(_width)+'px;height: 100%">');
	_html.push('		<div id="content" style="position: relative;float: right;margin: 0 auto;overflow: auto;width: '+(_width)+'px;height:'+_height+'px">');
	_html.push('		</div>');
	_html.push('	</div>');
	_html.push('	<div id="footer" style="margin: 0 auto;width:'+(_width-2)+'px;height:'+(_footerheight)+'px;background-color: #fbfbfb;border: 1px solid #e5e5e5">');
	_html.push('		<div style="margin-top:3px;position: absolute;text-align: center;left:'+(_width/4)+'px;width:'+(_width/2)+'px;">');
	for(var i=0,l=_buttons.length;i<l;i++){
		btn=_buttons[i];
		for(var name in btn){
			_html.push('			<button method="'+name+'" index="'+i+'" style="line-height: 20px;padding: 4px 10px;white-space: nowrap;cursor: pointer;font-size: 14px;font-family:Microsoft YaHei;color: #666;background: #f0f2fb;border: 1px solid #cdd4f1;border-radius: 5px;" type="button" title="'+name+'">'+name+'</button>');
		}
		if(i<l-1)_html.push('			<span style="width:20px;height:30px;display:-moz-inline-box; display:inline-block;">&nbsp;&nbsp;&nbsp;&nbsp;</span>');
	}
	_html.push('		</div>');
	_html.push('	</div>');
	_html.push('</div>');
	if(!modalDialog){
		if(datas && datas.length > 0){
			var cfg = {
					columnsize:_config.columnsize,
					configs:elements,
					labelwidth:_config.labelwidth,
					datas:datas
				}
			var _edpanel = new Ext.lt.bus.ui.specialtextare(cfg);
		}else{
			var cfg = {
					columnsize:_config.columnsize,
					configs:elements,
					labelwidth:_config.labelwidth,
					datas:datas
			}
			if (Ext.lt.bus.ui.specialtextare) {
				var _edpanel = new Ext.lt.bus.ui.specialtextare(cfg);
			} else {
				var _edpanel = new Ext.lt.editpanel2(cfg);
			}
		}
		for(var i=0,l=elements.length;i<l;i++){
			var element = elements[i];
			ds[element.name]= element.value;
		}
//		var _edpanel = new Ext.lt.editpanel2(cfg);
		var _window = new Ext.lt.window(_config);
		var _wbody = $(_html.join(''));
		_window.draw(_wbody[0]);
		var content = $("#content",_wbody);
		_edpanel.draw(content[0]);
		_edpanel.bind(ds);
		_edpanel.resize(_width,_height-_footerheight);
//		if(content.height()<(_height-_footerheight)){
//			var top = Math.floor((_height-_footerheight-content.height())/2);
//			content[0].style.top = top+'px';
//		}
		content[0].style.width = _width + "px";
		content[0].style.height = (_height-_footerheight + 2) + "px";
		_window.show();
		Ext.lt.ui.vAlign(_window);
		_window.remove = function(){
			$(this).remove();
		}
		for(var i=0,l=_buttons.length;i<l;i++){
			btn=_buttons[i];
			for(var name in btn){
				var btnel = $("button[method='"+name+"']",_wbody);
				if(name != "取消"){
					btnel.bind("click",function(){
						var r = true;
						var m=this.getAttribute('method');
						var index = ""+this.getAttribute('index');
						//判断是审核意见是否必填,必填是否有值
						var isrequired = _config.elements[0].isrequired;
						if(typeof(isrequired) != "undefined" && isrequired && _edpanel.getvalue().opinion == ""){
							alert("请填写处理意见");
							//_window.hide();
							//_window.remove();
							return;
						}
						var retvalue = index=="0"?_edpanel.getvalue():null;
						if(typeof(callbakfn)=="function")r = callbakfn(retvalue);
						
						//暂时修改
						if(r === true || r === undefined){
							_edpanel.pophide();
							_window.hide();
							_window.remove();
						}
					});
				}else{
					btnel.bind("click",function(){
						_edpanel.pophide();
						_window.hide();
						_window.remove();
					});
					
				}
				
				if(i==0)btnel.focus();
			}
		}
		Ext.lt.message.hook("window","minwindow",function(newwin){
			if(_window!=null&&newwin.id==_window.id){
				_window.remove();
				if(typeof(callbakfn)=="function")callbakfn(null);
			}
		})
	}else{
		var arguments ={};
		arguments["title"]=_config.title;
		arguments["html"]=_html.join('');
		arguments["buttons"]=_buttons;
		arguments["columnsize"]=_config.columnsize;
		arguments["elements"]=elements;
		var returnvalue = window.showModalDialog(_APPID_PATH_+"/busfw/common/ui/prompt.html", arguments, "dialogWidth:"+_width+"px; dialogHeight:"+_height+"px;center:yes");
		return returnvalue;
	}
}

/**
 * 向编辑区同步数据
 * @param editobj 编辑区对象
 * @param rowobj 数据对象
 * @param mapper 翻译数据对象
 */
Ext.lt.ui.synObjToEditForm = function(editobj,rowobj,mapper){
	if(typeof(editobj) == 'undefined' || rowobj.length<1){
		return;
	}
	var sa = rowobj;
	
	var object1 = {};
	var co = editobj.cfg.data;
	for(var i=0;i<co.length;i++){
		var code = co[i].colcode.toLowerCase();
		var k = {};
		if(co[i].type == 'tree'){
			if(sa[code] != null){
				k['text'] = mapper[code][0][1]+'-'+mapper[code][0][2];
				k['value'] = mapper[code][0][0];
				object1[code] = k;
			}else{
				k['text'] = '';
				k['value'] = '';
				object1[code] = k;
			}
		}else{
			if(sa[code] != null){
				object1[code] = sa[code];
			}else{
				object1[code] = '';
			}
			
		}
	}
	editobj.synchEditform(object1);
}

Ext.lt.ui.writeLog = function(log){
	window.setTimeout(function(){
			Ext.lt.RCP.server("busfw.CommonLogService",
			"writeLog", log, function(obj) {
				if(obj && obj["error"])
				Ext.lt.ui.alert(obj["error"],"",function(){});
			},function(error){
				
			});
	
	},10);
}
window.logguid = null;
window.logcontent = null;
Ext.lt.ui.addtempLog = function(log){
	if(window.logcontent == null){
		window.logcontent = log;	
	}else if(typeof(window.logcontent)== "string"){
		window.logcontent+= "\n"+log;
	}else if(typeof(window.logcontent)== "object"){
		if(window.logcontent==null){
			window.logcontent.content = log;
		}else{
			window.logcontent.content += "\n"+log;
		}
	}
}
Ext.lt.ui.appendLog = function(log){
	if(window.logguid ==null && parent.window.logguid !=null){
		window.logguid = parent.window.logguid;
		parent.window.logguid = null;
	}
	if(window.logguid!=null){
		if(typeof(log)== "string"){
			log = {logid:window.logguid,content:log};
		}
		if(typeof(log)== "object" && !log.guid){
			log.logid=window.logguid;
		}
		if(window.logcontent !=null){
			if(typeof(window.logcontent)== "string"){
				log.content = window.logcontent+"\n"+log.content;
			}else if(typeof(window.logcontent)== "object"){
				log = Ext.lt.apply(window.logcontent,log);
			}
			window.logcontent = null;
		}
		window.logguid = null;
		
		window.setTimeout(function(){
				Ext.lt.RCP.server("busfw.CommonLogService",
				"appendLog", log, function(obj) {
					if(obj && obj["error"])
					Ext.lt.ui.alert(obj["error"],"",function(){});
				},function(error){
					
				});
		
		},10);
		
	}
}
var filterproperty = ["_locationposition","_sortid","check","wfstep"];
function isFilterProperty(property){
	for(var i=0,len = filterproperty.length;i<len;i++){
		if(filterproperty[i]==property){
			return true;
		}
	}
	return false;
}
Object.extend(Object, {
  toLOGJSON: function(object) {
	if(window.logguid==null)return;
	
	var type = typeof object;
    switch (type) {
      case 'undefined':
      case 'function':
      case 'unknown': return;
      case 'boolean': return object.toString();
    }

    if (object === null) return 'null';
    if (object.toLOGJSON) return object.toLOGJSON();
	if (object.toJSON) return object.toJSON();
    if (Object.isElement(object)) return;

    var results = [];
    for (var property in object) {
	  if(!isFilterProperty(property)){
		  var value = Object.toLOGJSON(object[property]);
		  if (value !== undefined && value != null && value != 'null' && value.length>0)
			results.push(property.toJSON() + ': ' + value);
	  }
    }

    return '{' + results.join(', ') + '}';
  }
});

Object.extend(String.prototype, {
  toLOGJSON: function() {
	if(this!=null && this.length>0){
		return this.inspect(true);
	}
  }
});
Object.extend(Array.prototype, {
  toLOGJSON: function() {
    var results = [];
    this.each(function(object) {
      var value = Object.toLOGJSON(object);
      if (value !== undefined && value != null && value != 'null' && value.length>0) results.push(value);
    });
    return '[' + results.join(', ') + ']';
  }
});

function setLastTimeCookie(lastEventTime){
	var exdate = new Date();
	exdate.setDate(exdate.getDate()+5);
	exdate.setHours(0,0,0);
	document.cookie= "lastEventTime"+ "=" +lastEventTime+";expires="+exdate.toGMTString()+"; path=/";
}

function getLastTimeCookie(){
	var reg="lastEventTime"+"=(.*)";
	var vs=new RegExp(reg).exec(document.cookie)
	if(vs!=null){
		return vs[1].split(/;.*/)[0];
	}
	return null;
}

var lastEventTime = (new Date()).getTime();
setLastTimeCookie(lastEventTime);
var timelong=1000*60*100;
var _logout_url ="/";

/*top.window.ukeytimer = window.setTimeout(function(){
	lastEventTime = getLastTimeCookie();
	if(lastEventTime){
		lastEventTime = parseFloat(lastEventTime);
		if((new Date()).getTime()-lastEventTime>=timelong){
			//alert((timelong/(1000))+"秒没有操作，系统自动退出");
				//销毁session关闭窗口	
			
			Ext.lt.RCP.server('busportal.basefunction','logout&logouttype=timeout',null);
			if(_logout_url.charAt(0)!='/'){
				_logout_url='/'+_logout_url;
			}
			var serverhost= window.location.protocol+"//"+ window.location.host;
			window.location.href=serverhost+_logout_url;			
			//window.close();
		}else{
			top.window.ukeytimer = window.setTimeout(arguments.callee, timelong-((new Date()).getTime()-lastEventTime));
		}
	}
}, timelong);*/
Ext.lt.bindEvent(document,'onmousedown',function(){
	var lastEventTime = (new Date()).getTime();
	setLastTimeCookie(lastEventTime);
})


Ext.lt.bindEvent(document,'onkeypress',function(){
	var lastEventTime = (new Date()).getTime();
	//alert(getLastTimeCookie()+"\n"+lastEventTime+"\n"+document.cookie );
	setLastTimeCookie(lastEventTime);
});



