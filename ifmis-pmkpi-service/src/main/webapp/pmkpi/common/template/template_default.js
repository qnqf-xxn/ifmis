if(Ext.lt.ui == null){
    Ext.lt.ui = {};
}

Ext.lt.ui.template = function(config){
    if(Ext.lt.template[_BASE_STYLE] == null){

        return {draw:function(){alert('找不到指定样式' + template + '的模板')}};
    }
    return Ext.lt.template[_BASE_STYLE](config);
}
var hideLeftTree = false;
function getHideLeftTree(_hideLeftTree){
    var cache = Ext.lt.cache.getData('hideLeftTree');
    if(cache){
        return cache == "true";
    }else if(_hideLeftTree){
        return _hideLeftTree;
    }else{
        return hideLeftTree;
    }
}
var config_={};
Ext.lt.template["darkblue"] = function(config){
    var _cmp={};
    var mainmenu = Ext.lt.getparam("mainmenu");//PORTALFASP001
    var _switchBar = mainmenu!="PORTALFASP001";
    if(config.switchBar!=null){
        _switchBar = config.switchBar!=false;
    }
    var _spliter = null;//config.spliter;
    if(Ext.lt.isArray(_spliter)){
        Ext.lt.template.spliterbar = true;
    }
    var spliterbar = null;
    var _hideLeftTree = getHideLeftTree(config.hideLeftTree);
    _cmp.resize=function(w,h){
    };
    _cmp.draw=function(el){
        if(el==null) el=document.body;
        var headers = config.header;
        var footers = config.footer;
        var comps=config.main;
        var heights=config.heights;
        if(heights==null){heights=[]}
        config.el=el;
        config_=config;
        if(el.offsetWidth<800){
            w=400-10;
        }else{
            w=el.offsetWidth-10;
        }
        var maindiv = null;
        var bd_maindiv = null;
        var html=[];
        /*if(headers!=null && headers.length>0){
            if(!Ext.lt.isArray(headers))headers=[headers];
            if(headers.length>0)headers.shift();
        }*/

        if(headers!=null && headers.length>0){
            html.push("<div class='header'>");
            for(var i=0,j = headers.length; i <j; i++){
                html.push('<div style="width:100%;"></div>');
            }
            var padclassname = "bd_mainpad";
            if(document.location.href.indexOf("loadpage.page")!=-1){
                padclassname = "";
            }
            html.push("</div><div class='bd_main "+padclassname+"'></div>");
            if(footers!=null){
                if(!Ext.lt.isArray(footers))footers=[footers];
                html.push("<div class='winfooter'>");
                for(var i=0,j = footers.length; i <j; i++){
                    html.push('<div style="width:100%;"></div>');
                }
            }

            el.innerHTML = html.join('');
            maindiv = el.childNodes[1];
            var cn = el.firstChild.childNodes;
            for(var i=0,j = headers.length; i <j; i++){
                if(typeof(headers[i])=="string"){
                    eval(headers[i]).draw(cn[i]);
                }else{
                    headers[i].draw(cn[i]);
                }
            }
            if(footers!=null){
                config.footerel = el.lastChild;
                var cn = el.lastChild.childNodes;
                for(var i=0,j = footers.length; i <j; i++){
                    if(typeof(footers[i])=="string"){
                        eval(footers[i]).draw(cn[i]);
                    }else{
                        footers[i].draw(cn[i]);
                    }
                }
            }
        }else{
            // debugger;
            var padclassname ='';
            if(document.location.href.indexOf("show.page")!=-1){
                padclassname = "bd_mainpad";
                html.push("<div class='bd_main "+padclassname+"'></div>");
            } else if(document.location.href.indexOf("info.page")!=-1){
                padclassname = "bd_mainpad";
                html.push("<div class='bd_main "+padclassname+"'></div>");
            } else if(document.location.href.indexOf("index_set.page")!=-1){
                padclassname = "bd_mainpad";
                html.push("<div class='bd_main "+padclassname+"'></div>");
            } else {
                html.push("<div class='bd_main'></div>");
            }
            if(footers!=null){
                if(!Ext.lt.isArray(footers))footers=[footers];
                html.push("<div class='winfooter'>");
                for(var i=0,j = footers.length; i <j; i++){
                    html.push('<div id="',footers[i],'" style="width:100%;height:',42,'px"></div>');
                }
            }
            el.innerHTML = html.join('');
            maindiv = el.childNodes[0];
            if(footers!=null){
                config.footerel = el.lastChild;
                var cn = el.lastChild.childNodes;
                for(var i=0,j = footers.length; i <j; i++){
                    if(typeof(footers[i])=="string"){
                        eval(footers[i]).draw(cn[i]);
                    }else{
                        footers[i].draw(cn[i]);
                    }
                }
            }
        }
        bd_maindiv = maindiv;
        if(comps!=null){
            if(!Ext.lt.isArray(comps))comps=[comps];
            if(!Ext.lt.isArray(heights))heights=[heights];
            var autoh=200;

            var mh = (el.offsetHeight-el.firstChild.offsetHeight);
            if(config.footerel) mh -= config.footerel.offsetHeight;
            maindiv.style.height = (mh)+"px";
            if(config["left"]){
                var html=[];
                html.push("<div class='tpl_left'></div>");
                if(_switchBar){
                    html.push("<div id='switchBar' style='display:block; overflow:hidden;'>");
                    html.push("	<table border='0' cellspacing='0' cellpadding='0'>");
                    html.push("	   <tr>");
                    html.push("		   <td align='center' id='hidden_left'>");
                    html.push("			<span id='hiddenLeftBar' class='hideLeftBar' title='隐藏左侧树' onClick='doHiddenLeft(this);Ext.lt.layout.doLayout()' ></span>");
                    html.push("			</td>");
                    html.push("	   </tr>");
                    html.push("   </table>");
                    html.push("</div>");
                }
                html.push("<div class='tpl_right'></div>");
                maindiv.innerHTML = html.join('');
                var left=maindiv.firstChild;
                left.id = config["left"];
                if(typeof(config["left"])=="string"){
                    eval(config["left"]).draw(left);
                }else{
                    config["left"].draw(left);
                }
                config.leftdiv = left;
                if(_switchBar){
                    config.switchBar = left.nextSibling;
                }

                maindiv = maindiv.lastChild;
                if(_hideLeftTree){
                    doHiddenLeft(document.getElementById("hiddenLeftBar"));
                    w = w-12;
                }else{
                    // debugger;
                    w = w-270;
                }
                maindiv.style.width = w+"px";
            }else{
                //w=w-20;
                var html=[];
                html.push("<div class='bd_right'></div>");
                //maindiv.innerHTML = html.join('');
                //maindiv = maindiv.lastChild;
                maindiv.style.width = w+"px";
                maindiv.style.position="relative";
                //if(maindiv.nextSibling)maindiv.nextSibling.style.position="relative";
            }
            html=[];
            var autoComps =[];
            for(var i=0,j = comps.length; i <j; i++){
                var h=heights[i];
                if(comps[i] == 'tab'){h=35};//暂时写死tab标签的高度
                if(comps[i].indexOf("toolbutton")!=-1){
                    h = 60;
                }
                if(h==null||h=='auto'){
                    if(comps[i].indexOf("datatable")!=-1||comps[i].indexOf("service")!=-1){
                        autoComps[autoComps.length] = i;
                    }
                    // debugger;
                    html.push('<div id="',comps[i],'" style="width:',w,'px;"></div>');
                }else{
                    if(comps[i].indexOf("queryform")!=-1){
                        h = 37;
                    }
                    // debugger;
                    // html.push('<div style="width:',w-20,'px;height:',h,'px"></div>');
                    html.push('<div id="',comps[i],'" style="width:',w,'px;height:',h,'px"></div>');
                }
            }
            config.autoComps = autoComps;
            maindiv.innerHTML = html.join('');
            config.maindiv=maindiv;
            // debugger;
            var cn = maindiv.childNodes;
            for(var i=0,j = comps.length; i <j; i++){
                if(typeof(comps[i])=="string"){
                    // debugger;
                    if(comps[i] != "datatablediv"){
                        eval(comps[i]).draw(cn[i]);
                    }
                }else{
                    comps[i].draw(cn[i]);
                }
                cn[i].setAttribute("compid", comps[i]);
            }
            if(autoComps.length>0){
                var userHeight = 0;
                for(var i=0,j = cn.length; i <j; i++){
                    var isauto = false;
                    for(var k=0;k<autoComps.length;k++){
                        if(i==autoComps[k]){
                            isauto = true;
                            break;
                        }
                    }
                    //快速查询不需要计算它的高度，它和按钮区域放一行。另：快速查询和按钮区 现规则 规定是必须同时存在的。
                    if(cn[i].className && cn[i].className.indexOf('searchbox-first')>-1){
                        isauto = true;
                        continue;
                    }
                    if(!isauto){
                        userHeight += cn[i].offsetHeight;
                    }
                }
                var freeHeight = mh-userHeight-10;
                var autoCompsH = freeHeight/autoComps.length;
                if(autoCompsH<100)autoCompsH = 100;
                for(var k=0;k<autoComps.length;k++){
                    var i = autoComps[k];
                    cn[i].style.height = autoCompsH+'px';
                    cn[i].setAttribute("_height", "auto");
                    cn[i].setAttribute("compid", comps[i]);
                }
            }
        }
        var tpl=Ext.lt.template;
        Ext.lt.message.hook("layout","endlayout",function(){
            var comps=config.main;
            el=config.el;
            if(headers!=null){
                for(var i=0,j = headers.length; i <j; i++){
                    tpl.resize(eval(headers[i]),el.offsetWidth,null);
                }
            }
            var maindiv = config.maindiv;
            var mh = null;
            if(el.firstChild.className=="header"){
                mh = (el.offsetHeight-el.firstChild.offsetHeight);
            }else{
                mh = el.offsetHeight;
                mh = mh-5; //去边框
            }
            if(config.footerel) mh -= config.footerel.offsetHeight;

            //maindiv.style.height = (mh-2)+"px";
            var mw = el.offsetWidth;
            var left = config.leftdiv;
            if(left){
                tpl.resize(eval(config["left"]),left.offsetWidth,mh);
                mw -= (left.offsetWidth+8);
            }
            bd_maindiv.style.height = mh+"px";
            maindiv.style.height = mh+"px";
            // jinweiwei 20201206修改页面内容区域的宽度
            maindiv.style.width = mw-20+"px";
            //去除switchBar的高度
//			if(config.switchBar){
//				config.switchBar.style.height = mh+"px";
//			}
            Ext.lt.ui.template.switchBarHeight=mh;
            // debugger;
            // console.log(Ext.lt.ui);
            // console.log(Ext.lt.ui.isScrollY(maindiv));
            if (config["left"]) { // jinweiwei是否有左侧菜单
                // debugger;
                var w=maindiv.offsetWidth-(Ext.lt.ui.isScrollY(maindiv)?20:0);
            } else {
                // debugger;
                var w=maindiv.offsetWidth-(Ext.lt.ui.isScrollY(maindiv)?20:0)-20;
            }

            // var w=maindiv.offsetWidth-(Ext.lt.ui.isScrollY(maindiv)?20:0);
            if(Ext.lt.isArray(_spliter)){
                if(!!!spliterbar){
                    spliterbar = new Ext.lt.ui.spliterbar();
                    spliterbar.draw(_spliter);
                    config.autoComps = [];
                    var els=maindiv.childNodes;
                    for(var i=0,j = els.length; i <j; i++){
                        if(els[i].tagName && "auto" == els[i].getAttribute("_height")){
                            config.autoComps[config.autoComps.length] = i;
                        }
                    }
                }else{
                    tpl.resize(spliterbar,w,8);
                }
            }

            var autoComps = [];
            if(comps!=null){

                if(!Ext.lt.isArray(comps))comps=[comps];
                var els=maindiv.childNodes;
                var h=maindiv.offsetHeight;
                for(var i=0,j = els.length; i <j; i++){
                    // debugger;
                    if(els[i].tagName ){
                        var compid = els[i].getAttribute("compid")
                        if(typeof(compid)=="string"){
                            if(comps[i] == "datatablediv"  && els[i].UIComponent){
                                tpl.resize(els[i].UIComponent,w,els[i].offsetHeight);
                            }else{
                                tpl.resize(eval(compid),w,els[i].offsetHeight);
                            }
                        }else if(typeof(compid)=="object" && compid!=null){
                            tpl.resize(compid,w,els[i].offsetHeight);
                        }
                        if("auto" == els[i].getAttribute("_height") && els[i].style.display != "none"){
                            autoComps[autoComps.length] = i;
                        }
                    }
                }
                if(autoComps.length>0){
                    var userHeight = 0;
                    for(var i=0,j = els.length; i <j; i++){
                        var isauto = false;
                        // debugger;
                        for(var k=0;k<autoComps.length;k++){
                            if(i==autoComps[k]){
                                isauto = true;
                                break;
                            }
                        }
                        //快速查询文本框现在和按钮放在同一行了，因此，当有按钮区域的时候，算高度无需包含快速查询高度，
                        if(cn[i].className && cn[i].className.indexOf('searchbox-first')>-1){
                            isauto = true;
                            continue;
                        }
                        if(!isauto){
                            var elH = els[i].offsetHeight+fixHeight(els[i]);
                            userHeight += elH;
                        }
                    }
                    if(spliterbar)userHeight += 8;
                    var freeHeight = mh-userHeight-(Ext.lt.ui.isScrollX(el)?10:0);
                    var autoCompsH = Math.floor(freeHeight/autoComps.length);
                    if(autoCompsH<100)autoCompsH = 100;
                    for(var k=0;k<autoComps.length;k++){
                        var i = autoComps[k];
                        if(els[i].tagName){
                            var compid = els[i].getAttribute("compid")||comps[i];
                            if(compid.indexOf("datatable")!=-1){
                                autoCompsH -= 2;
                            }
                            els[i].style.height = autoCompsH+'px';
                            if(compid == "datatablediv" && els[i].UIComponent){
                                tpl.resize(els[i].UIComponent,w,autoCompsH);
                            }else{
                                tpl.resize(eval(compid),w,autoCompsH);
                            }
                        }
                    }
                }
            }

            Ext.lt.message.send("layout", "endlayout2",{});
        })
    }
    return _cmp;
};


function getswitchBarHeight(config_){
    //设置变量Ext.lt.ui.template.switchBarHeight赋值
    var mh = null;
    var el=config_.el;
    if(el.firstChild.className=="header"){
        mh = (el.offsetHeight-el.firstChild.offsetHeight);
    }else{
        mh = el.offsetHeight;
    }
    if(config_.footerel) mh -= config_.footerel.offsetHeight;
    Ext.lt.ui.template.switchBarHeight=mh;
}
function getPadding(el) {
    var pt = parseInt(Ext.lt.HTML.getRealStyle(el).paddingTop, 10) || 0;
    var pb = parseInt(Ext.lt.HTML.getRealStyle(el).paddingBottom, 10) || 0;
    var pl = parseInt(Ext.lt.HTML.getRealStyle(el).paddingLeft, 10) || 0;
    var pr = parseInt(Ext.lt.HTML.getRealStyle(el).paddingRight, 10) || 0;
    return [pt, pr, pb, pl];
}

function getBorder(el) {
    var bt = parseInt(Ext.lt.HTML.getRealStyle(el).borderTopWidth, 10) || 0;
    var bb = parseInt(Ext.lt.HTML.getRealStyle(el).borderBottomWidth, 10) || 0;
    var bl = parseInt(Ext.lt.HTML.getRealStyle(el).borderLeftWidth, 10) || 0;
    var br = parseInt(Ext.lt.HTML.getRealStyle(el).borderRightWidth, 10) || 0;
    return [bt, br, bb, bl];
}
function fixWidth(el){
    var br = getBorder(el);
    var pb = getPadding(el);
    return br[1]+br[3]+pb[1]+pb[3];
}
function fixHeight(el){
    var br = getBorder(el);
    var pb = getPadding(el);
    return br[0]+br[2]+pb[0]+pb[2] + getStyle(el, 'marginTop')+getStyle(el, 'marginBottom');
}

function getStyle(obj,attr){
    if(obj.currentStyle){
        return parseInt(obj.currentStyle[attr], 10);
    }
    else{
        return parseInt(document.defaultView.getComputedStyle(obj,null)[attr], 10);
    }
}

function closebuswin(obj){
    Ext.lt.message.send("buswindow", "close",obj);
    if(obj["close"]){
        self.opener.focus();
        self.close();
    }
}

Ext.lt.message.hook("buswindow", "close",function(obj){
    obj["close"] = confirm("确定关闭窗口");
});
Ext.lt.ui.template.switchBarHeight="";
function doHiddenLeft(obj){
    // debugger;
    getswitchBarHeight(config_);
    var switchBar = $("#switchBar");
    var left_tree = switchBar.prev()[0];
    var right_main = switchBar.next()[0];
    var flag = 1;
    if(left_tree.style.display=="block" || left_tree.style.display==""){
        left_tree.style.display="none";
        switchBar[0].style.left = "5px";
        right_main.style.left = "18px";
        switchBar[0].style.height = Ext.lt.ui.template.switchBarHeight+"px";
        obj.title = "展开左侧树";
        obj.className="showLeftBar";
        flag = 1;
        Ext.lt.cache.setData('hideLeftTree',"true");
    }else{
        left_tree.style.display="block";
        switchBar[0].style.left = "230px";
        right_main.style.left = "270px";
        switchBar[0].style.height = 45+"px";
        obj.title = "隐藏左侧树";
        obj.className="hideLeftBar";
        Ext.lt.cache.setData('hideLeftTree',"false");
        flag = 0;
    }
    Ext.lt.message.send("layout", "dohiddenleft",flag);
}