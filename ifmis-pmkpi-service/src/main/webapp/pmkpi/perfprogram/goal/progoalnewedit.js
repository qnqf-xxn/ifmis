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
var _panel; //切换年度的组件.
var _isfrombdm;
Ext.lt.pmkpi.prjgoalneweditservice = function(config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    var _saveAgency = config["saveAgency"]; //项目单位
    _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var _busguid = config.busguid;//审核定义guid
    var _prolev = config["prolev"]; //项目等级123级项目
    var _isyears = config["isyears"]; //1为项目库过来--》年度绩效页签，切换年度查看.
    var isnzzj = config.isnzzj;//是否年中追加
    _procode = config.procode;
    showtab = config.showtab; //页签展示
    var _adjadd = config.adjadd;//是否调整
    var _cmp = {};
    tabcomps = config["goaldata"]; //目标数据.
    var iframeurl = config.iframeurl;//嵌套url
    var hideIframeHtml = "";
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol+"//" + document.location.host + "/" + iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    }
    var height = Math.floor(document.documentElement.clientHeight * 0.9);
    var width =  Math.floor(document.documentElement.clientWidth * 0.9);
    var totalname = "";
    var yearname = "";
    _isfrombdm = config.isfrombdm;
    var _issaveed = false;
    var _inittabdatas = Ext.lt.apply({}, tabcomps);// 记录初始化数据用于对比是否变更

    //页面加载完成后执行
    $(function() {
        $("#tabpage").hide();
        var isshowtotal = false;
        var isshowyear = false;
        var tabpagedatas = tabpage.cfg.data;
        for(var i=0;i<tabpagedatas.length;i++) {
            var tabdata = tabpagedatas[i];
            if(tabdata.code == "total"){
                totalname = tabdata.name;
                isshowtotal = true;
            }
            if(tabdata.code == "year"){
                yearname = tabdata.name;
                isshowyear = true;
            }
        }
        if (_viewtype == "query" || (isshowtotal && !isshowyear) ) {
            $("div[compid='toolbutton']").hide();
        }
        if(isshowtotal){
            $("#totaleditform").show();
        }else{
            $("#totaleditform").hide();
        }
        if(isshowyear){
            $("#yeareditform").show();
        }else{
            $("#yeareditform").hide();
        }
        if(hideIframeHtml != null && hideIframeHtml != ""){
            $("#yeareditform").append(hideIframeHtml);
        }
        if (_viewtype == "query") {
            totaleditform.setdisabled({kpi_target:true});
            yeareditform.setdisabled({kpi_target:true});
        }
        if(_isedittotal == '1'){
            totaleditform.setdisabled({kpi_target:true});
        }
        if(isshowtotal && totaleditform && tabcomps && tabcomps["#total"]){
            totaleditform.synchEditformByObj(tabcomps["#total"]);
        }
        if(isshowyear && yeareditform && tabcomps && tabcomps["#year"]){
            yeareditform.synchEditformByObj(tabcomps["#year"]);
        }
        if (showtab == "1" && isshowyear &&  "1" == _isyears){ //年度显示切换select
            if ($("#changyears").length > 0){
                if (_panel) {
                    _panel.show(['curyear'], false);
                }
                var tempyear = _panel.getCol("curyear").getvalue();
                if (!!tempyear){
                    _cmp.queryCurYearperf(tempyear);
                } else {
                    _cmp.selectdefyear();
                }
            } else {
                _cmp.bulidTopHead();
                _cmp.laypopupyear();
                _cmp.selectdefyear();
            }
        } else {
            if (_panel) {
                _panel.hide(['curyear'], false);
            }
        }
        if (isshowtotal && totaleditform) {
            totaleditform.hide(['applyfinamt'],true);
        }
        if(isshowyear && yeareditform){
            var isshowapplyfinamt = false;
            for (var i = 0; i < yeareditform.cfg.data.length; i++) {
                if(yeareditform.cfg.data[i].colcode == "APPLYFINAMT" && yeareditform.cfg.data[i].isvisiable == "1"){
                    isshowapplyfinamt = true;
                }
            }
            if(isshowapplyfinamt){
                yeareditform.show(['applyfinamt'],true);
            }
        }
        if(isshowtotal && totalname && totalname!="" && totaleditform){
            var totalgoalnameele = $("#totaleditform").find("textarea[name='kpi_target']").prev().find(".character");
            totalgoalnameele.text(totalname);
        }
        if(isshowyear && yearname && yearname!="" && yeareditform){
            var yeargoalnameele = $("#yeareditform").find("textarea[name='kpi_target']").prev().find(".character");
            yeargoalnameele.text(yearname);
        }
        if (!isshowyear) {
            $("div[compid='toolbutton']").hide();
        }
        parent._isQuery = true;
    });

    _cmp.selectdefyear = function (){
        if(!!tabcomps["#year"] && !!tabcomps["#year"].kpi_target){
            var defyear = tabcomps["#year"].year;
            _panel.synchEditform({curyear:{text:defyear, value:defyear}});
        }
    }

    _cmp.bulidTopHead = function (){
        var topheadHtml = [];
        topheadHtml.push("<div id='tophead' style='display:block;overflow:hidden;font-size:15px;height:45px;'>");
        topheadHtml.push("<div id='topheadcontent' style='width:70%;float:left;padding-top:5px;'>&nbsp;&nbsp;&nbsp;&nbsp;");
        topheadHtml.push("</div>");
        topheadHtml.push("</div>");
        $(".bd_main").children().first().before(topheadHtml.join(''));
    }

    _cmp.clickTabpage = function(obj){

    }

    /**
     * 是否需要提示保存
     * @returns {boolean}
     */
    Ext.lt.pmkpi.isneed2save = function (){
        if(_isfrombdm == "1") {
            var _ischangeed = false;
            var editformvalues = yeareditform.getEditFormValues();
            var nowdatas = {};
            var editformcfg = yeareditform.cfg.data;
            for (var val in editformvalues) {
                for(var j=0;j<editformcfg.length;j++) {
                    if(editformcfg[j].colcode.toLowerCase() == val && editformcfg[j].isvisiable == 1) {
                        nowdatas[val] = editformvalues[val];
                    }
                }
            }
            var paneldata = _inittabdatas["#year"];
            for (var i in nowdatas) {
                var _v = nowdatas[i];
                switch (typeof(paneldata[i])) {
                    case 'string':
                        _ischangeed = paneldata[i] != _v;
                        break;
                    case 'object':
                        if (paneldata[i] != null) {
                            _ischangeed = paneldata[i].value != _v.value;
                        }else{
                            _ischangeed = _v && _v.value != null;
                        }
                        break;
                    case 'number':
                        if (paneldata[i] == null) {
                            if (_v == null) _v = "0";
                            _ischangeed = ('0').toNumber() != _v.toNumber();
                        } else {
                            if (_v == null) _v = "0";
                            _ischangeed = (paneldata[i] + '').toNumber() != _v.toNumber();
                        }
                        break;
                    case 'undefined':
                        if (typeof(_v) != "undefined") {
                            if(typeof(_v) == "object"){
                                _v = _v.value;
                            }
                            if (_v != null && _v != "" && _v != "0") {
                                _ischangeed = true;
                            }
                        }
                        break;
                    default:
                        break;
                }
                if (_ischangeed) break;
            }
            if(_ischangeed && !_issaveed){//数据变更需要保存 没有保存过
                return true;
            }else{
                return false;
            }
        }
    }
    Ext.lt.pmkpi.savedata = function (){
        _cmp.save();
        return _issaveed;
    }

    /**
     * 项目指标保存方法
     * @param obj
     */
    _cmp.save = function (obj) {
        if(totaleditform){
            if (!totaleditform.check()) return;//先校验
        }
        if(yeareditform){
            if (!yeareditform.check()) return;//先校验
        }
        tabcomps["#total"] =Ext.lt.cloneobj(totaleditform.getEditFormValues());
        tabcomps["#year"] =Ext.lt.cloneobj(yeareditform.getEditFormValues());
        //目标值 特殊字替换
        var _totaldata = tabcomps["#total"];
        var _yeardata = tabcomps["#year"];
        if (_yeardata) {
            if (!perfcommon.checkSpaceValue(_yeardata,null,"yeareditform")) return;//校验空格
            _yeardata.kpi_target = convertStr(_yeardata.kpi_target);
        }
        if (_totaldata) {
            if (!perfcommon.checkSpaceValue(_totaldata,null,"totaleditform")) return;//校验空格
            _totaldata.kpi_target = convertStr(_totaldata.kpi_target);
        }
        var params = {};
        params.projguid = _proguid;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.goaldata = tabcomps;
        params.showtab = showtab;
        params.isnzzj = isnzzj;
        params.isedittotal = _isedittotal;
        params.procode = _procode; //项目编码
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid, "saveGoal", params);
        Ext.lt.ui.loadingClose();
        if(_isfrombdm == "1") {
            if (rs && rs.success) {
                _issaveed = true;
                Ext.lt.pmkpi.alert("保存成功!",function(){});
            } else if(rs && rs.success == false){
                Ext.lt.pmkpi.openlistdiv(rs);
            } else if (rs){
                if (rs && rs.msg) {
                    Ext.lt.pmkpi.alert(rs.msg,function(){
                    });
                } else {
                    Ext.lt.pmkpi.alert('保存失败！',function(){
                    });
                }
            }
        }else if (rs && rs.success) {
            //_cmp.init();
        }
        return rs;
    }

    /**
     * 复制年度绩效目标
     */
    Ext.lt.pmkpi.copyyeargoal = function(obj){
        var btncode = obj.code;
        var ismultipro = false;
        if(obj.config){
            var btnconfig = eval('(' + obj.config + ')');
            ismultipro = btnconfig.ismultipro ? btnconfig.ismultipro : ismultipro;
        }
        if (btncode && btncode == "copyyeargoal") {
            if (showtab != "2") {
                Ext.lt.ui.confirm("是否复制上年绩效目标到年度绩效目标？",{icon:"warn"},function(ret){
                    if(ret){
                        var params = {};
                        params.procode = _procode; //项目编码
                        params.ismultipro = ismultipro;
                        params.isconfirm = false;
                        var rs = Ext.lt.RCP.asyncall(serviceid, "copyGoal", params);
                        if(rs.success){
                            yeareditform.synchEditformByObj(rs.data);
                            Ext.lt.pmkpi.alert("复制成功!",function(){});
                        } else if(ismultipro){ //多项目不存在对应关系打开项目列表选择关系
                            Ext.lt.pmkpi.alert(rs.error,function(){
                                var tparams = {};
                                var url = '/pmkpi/program/prjindex/sellastyearpro.page';
                                tparams.agency_code = _saveAgency; //项目单位
                                tparams.pro_code = _procode;
                                tparams.type = "fromgoal";
                                url = Ext.lt.pmkpi.genPageUrl(url, tparams);
                                Ext.lt.ui.openModalWindow(url,width,height,"选择上年项目");
                            });
                        } else {
                            Ext.lt.pmkpi.alert("该项目上年绩效目标值不存在!",function(){});
                        }
                    }
                });
            } else {
                Ext.lt.pmkpi.alert("年度绩效目标页签未展示不能复制！",function(){
                });
            }
        }
    }
    /**
     * 项目库查询明细，构建多年度绩效查询.
     * @param curryear -- 当前年度.
     */
    _cmp.laypopupyear = function(curryear) {
        $('#tophead').append("<div id = 'changyears' style='float:right;width:25%;margin-top:-2px;'/>");
        _cmp.finintorgSelect("changyears");
    }
    _cmp.finintorgSelect = function (divId) {
        var div = document.getElementById(divId);
        _panel = new Ext.lt.bus.ui.editformpanel({
            columnsize: 1,
            data: [
                {
                    colcode: 'curyear',
                    guid: 'curryear',
                    name: '绩效年度',
                    isvisiable: 1,
                    requirement: 0,
                    type: 'tree',
                    issource: 1,
                    isedit: 1,
                    levelcontrol: 0,
                    colspannum: 0,
                    textarearows: 0,
                    config: "{clearbtn:false,clickchoose:true,format:'#name'}"
                }
            ]
        });
        _panel.attachEvent({
            curyear: {
                asyncloaddata: function (resp) {
                    var params = {};
                    params.province=config["province"];
                    params.procode=_procode;
                    params.proguid = _proguid; //有的年度在总体录入，根据项目guid区分.
                    params.adjadd = _adjadd;
                    Ext.lt.RCP.call(serviceid, "getYearOption", params, function (obj) {
                            resp.data = obj;
                        }, function (err) {
                            alert(err);
                        }
                    );
                }
            }
        });
        _panel.afterchange(function (param) {
            if (typeof _panel.getCol('curyear') != "undefined" && _panel.getCol('curyear').ischange()) {
                if (!!param.curyear) {
                    _cmp.queryCurYearperf(param.curyear);
                }
            }
        });
        _panel.draw(div);
    }

    _cmp.queryCurYearperf = function (year){
        var params = {};
        params.province=config["province"];
        params.procode=_procode;
        params.year = year;
        params.proguid = _proguid; //有的年度在总体录入，根据项目guid区分.
        params.adjadd = _adjadd;
        Ext.lt.RCP.call(serviceid, "getYearGoal", params, function (obj) {
            yeareditform.synchEditformByObj(obj.data);
            }, function (err) {
                alert(err);
            }
        );
    }

    return _cmp;
}

Ext.lt.message.hook("toolbutton","beforecreatbtn",function(obj){
    _isfrombdm =  Ext.lt.getparam("isfrombdm");
    if(_isfrombdm == "1") {// 预算编制页面增加单独的保存按钮
        var savebtn = {};
        savebtn.code ="save";
        savebtn.name ="保存";
        savebtn.title ="保存";
        savebtn.action ="Ext.lt.bus.ui.clickwrapper";
        savebtn.oriaction = "progoalnewedit.save";
        obj.data.buttons.unshift(savebtn);
    }
})