if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var _curtab;
var tabcomps;
var showtab;
var _isedittotal;
var _procode;
Ext.lt.pmkpi.approvalgoalservice = function(config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    var _saveAgency = config["saveAgency"]; //项目单位
    _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var _busguid = config.busguid;//审核定义guid
    var totalgoalname = config.totalname;//项目页签（编辑区）名称
    _procode = config.procode;
    showtab = config.showtab; //页签展示
    var tabnum = 0; //页签点击次数
    var _cmp = {};
    tabcomps = config["goaldata"]; //目标数据.
    var iframeurl = config.iframeurl;//嵌套url
    var tabname = "";
    var hideIframeHtml = "";
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol+"//" + document.location.host + "/" + iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    }
    var isFirst = true;
    var isfirsttab;

    //页面加载完成后执行
    $(function() {
        if(hideIframeHtml != null && hideIframeHtml != ""){
            $("#editform").append(hideIframeHtml);
        }
        if (_viewtype == "query" || (_isedittotal == '1' && _curtab == "total")) {
            editform.setdisabled({kpi_target:true});
        }
        if (tabcomps && tabcomps["#"+_curtab]){
            editform.synchEditformByObj(tabcomps["#"+_curtab]);
        }
        if (showtab == "1" || showtab == "2") {
            if (totalgoalname && totalgoalname != "") {
                $(".character").text(totalgoalname);
            } else {
                $(".character").text(tabname);
            }
        } else {
            $(".character").text(tabname);
        }
        parent._isQuery = true;
        _cmp.bulidTopHead();
    });

    /**
     * tabpage转radio
     */
    _cmp.bulidTopHead = function (){
        var tabpagedatas = tabpage.cfg.data;
        $("#tabpage").hide();
        var topheadHtml = [];
        topheadHtml.push("<div id='tophead' style='display:block;overflow:hidden;font-size:15px;height:45px;'>");
        topheadHtml.push("<div id='topheadcontent' style='width:70%;float:left;padding-top:5px;'>&nbsp;&nbsp;&nbsp;&nbsp;");
        if(tabpagedatas.length == 1){
            var tabdata = tabpagedatas[0];
            topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio' checked>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
        }else if(tabpagedatas.length > 1){
            for(var i=0;i<tabpagedatas.length;i++) {
                var tabdata = tabpagedatas[i];
                var ischecked = tabdata.classname;
                if(ischecked == "choosed"){
                    topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio' checked>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
                }else{
                    topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio'>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
                }
            }
        }
        topheadHtml.push("</div>");
        topheadHtml.push("</div>");
        $(".bd_main").children().first().before(topheadHtml.join(''));
        $("input[type='radio'][name='checktab']").click(function () {
            _cmp.checktabRadioClick();
        });
    }

    /**
     * radio点击触发clickTabpage
     */
    _cmp.checktabRadioClick = function(){
        var checktab = $("input[name='checktab']:checked");
        var checkcode = checktab.attr("id");
        var checkname = checktab.attr("value");
        var hidebtns = checktab.attr("hidebtns");
        var tabobj = {};
        tabobj.code = checkcode;
        tabobj.name = checkname;
        tabobj.hidebtns = hidebtns;
        _cmp.clickTabpage(tabobj);
    }

    /**
     * 点击页签.
     */
    _cmp.clickTabpage = function(obj){
        if (isFirst) {
            isfirsttab = obj.code;
            isFirst = false;
        }
        try {
            if (obj.code == "total") {
                $("div[compid='toolbutton']").hide();
            }else {
                $("div[compid='toolbutton']").show();
            }
        } catch (e) {
            console.log('异常:' + e);
        }

        tabname = obj.name;
        if(tabnum != 0 && _curtab != obj.code && showtab != 3){
            var num = 1;
            if (_curtab == isfirsttab){
                num = 0;
            }
            if (_viewtype != "query" && !editform.check()) {
                tabpage.doActiveTab(num);
                return;//先校验
            }
            var goaldata =  editform.getEditFormValues();
            if (obj.code == "year"){
                tabcomps["#total"] =Ext.lt.cloneobj(goaldata);
            } else {
                tabcomps["#year"] =Ext.lt.cloneobj(goaldata);
            }
            goaldata = tabcomps["#"+obj.code];
            if (goaldata) {
                editform.synchEditformByObj(goaldata);
            } else {
                goaldata = {};
                goaldata.kpi_target = "";
                editform.synchEditformByObj(goaldata);
            }
        }
        if (showtab == 1 && tabnum != 0) {
            if (obj.code == "total" && _isedittotal == '1') {
                editform.setdisabled({kpi_target:true});
            } else {
                editform.setdisabled({kpi_target:false});
            }
            if (_viewtype == "query"){
                editform.setdisabled({kpi_target:true});
            }
        }
        _curtab = obj.code;
        tabnum ++;
        if (showtab == "1" || showtab == "2") {
            if (totalgoalname && totalgoalname != "" && obj.code == "total") {
                $(".character").text(totalgoalname);
            } else {
                $(".character").text(tabname);
            }
        } else {
            $(".character").text(tabname);
        }
    }
    return _cmp;
}