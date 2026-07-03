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
Ext.lt.pmkpi.prjgoalservice = function(config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    var _saveAgency = config["saveAgency"]; //项目单位
    _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var _busguid = config.busguid;//审核定义guid
    var _prolev = config["prolev"]; //项目等级123级项目
    var _isyears = config["isyears"]; //1为项目库过来--》年度绩效页签，切换年度查看.
    var totalgoalname = config.totalname;//项目页签（编辑区）名称
    var isnzzj = config.isnzzj;//是否年中追加
    _procode = config.procode;
    showtab = config.showtab; //页签展示
    var tabnum = 0; //页签点击次数
    var _adjadd = config.adjadd;//是否调整
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
    var height = Math.floor(document.documentElement.clientHeight * 0.9);
    var width =  Math.floor(document.documentElement.clientWidth * 0.9);

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
        var goalnameele = $("textarea[name='kpi_target']").prev().find(".character");
        if (showtab == "1" || showtab == "2") {
            if (totalgoalname && totalgoalname != "") {
                goalnameele.text(totalgoalname);
            } else {
                goalnameele.text(tabname);
            }
        } else {
            goalnameele.text(tabname);
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
        Ext.lt.ui.loadingShow();
        if (isFirst) {
            isfirsttab = obj.code;
            isFirst = false;
        }
        try {
            if (obj.code !== "total" && _viewtype !== "query") {
                $("div[compid='toolbutton']").show();
            } else {
                $("div[compid='toolbutton']").hide();
            }
        } catch (e) {
        }
        tabname = obj.name;
        if(tabnum != 0 && _curtab != obj.code && showtab != 3){
            var num = 1;
            if (_curtab == isfirsttab){
                num = 0;
            }
            if ((_isedittotal != "1" || _curtab == "year") && _viewtype != "query" && !editform.check()) {
                setTimeout(function(){
                    tabpage.doActiveTab(num);
                    var radios = $("input[name='checktab']");
                    for(var i=0; i<radios.length; i++){
                        radios[i].checked = false;
                    }
                    $("input[name='checktab']")[num].checked = true;
                },200);
                Ext.lt.ui.loadingClose();
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
        var goalnameele = $("textarea[name='kpi_target']").prev().find(".character");
        if (showtab == "1" || showtab == "2") {
            if (totalgoalname && totalgoalname != "" && obj.code == "total") {
                goalnameele.text(totalgoalname);
            } else {
                goalnameele.text(tabname);
            }
        } else {
            goalnameele.text(tabname);
        }
        var isshowapplyfinamt = false;
        for (var i = 0; i < editform.cfg.data.length; i++) {
            if(editform.cfg.data[i].colcode == "APPLYFINAMT" && editform.cfg.data[i].isvisiable == "1"){
                isshowapplyfinamt = true;
            }
        }
        if (obj.code == "total") {
            editform.hide(['applyfinamt'],true);
        }else if(isshowapplyfinamt){
            editform.show(['applyfinamt'],true);
        }

        //"1" == _isyears &&
        if (showtab == "1" && _curtab == "year" && "1" == _isyears){ //年度显示切换select
            if ($("#changyears").length > 0){
                if (_panel) {
                    _panel.show(['curyear'], false);
                }
                var tempyear = _panel.getCol("curyear").getvalue();
                if (!!tempyear){
                    _cmp.queryCurYearperf(tempyear);
                }else{
                    _cmp.selectdefyear();
                }
            } else {
                _cmp.laypopupyear();
            }
        } else {
            if (_panel) {
                _panel.hide(['curyear'], false);
            }
        }
        setTimeout(function(){
            Ext.lt.ui.loadingClose();
        },300);
    }

    /**
     * 选中默认当前年度
     */
    _cmp.selectdefyear = function (){
        if(!!tabcomps["#year"] && !!tabcomps["#year"].kpi_target){
            var defyear = tabcomps["#year"].year;
            _panel.synchEditform({curyear:{text:defyear, value:defyear}});
        }
    }

    /**
     * 项目指标保存方法
     * @param obj
     */
    _cmp.save = function (obj) {
        if (!editform.check()) return;//先校验
        var tempdata =  editform.getEditFormValues();
        tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
        if ((showtab == "1" || showtab == "3")) {
            //校验年度目标是否为空
            if (!tabcomps["#year"] || !tabcomps["#year"].kpi_target || tabcomps["#year"].kpi_target == "") {
                Ext.lt.pmkpi.alert("请填写年度绩效目标！",{timeout:1},function(){});
                return;
            }
        }
        //目标值 特殊字替换
        var _totaldata = tabcomps["#total"];
        var _yeardata = tabcomps["#year"];
        if (_yeardata) {
            if (!perfcommon.checkSpaceValue(_yeardata,null,"editform")) return;//校验空格
            _yeardata.kpi_target = convertStr(_yeardata.kpi_target);
        }
        if (_totaldata) {
            if (!perfcommon.checkSpaceValue(_totaldata,null,"editform")) return;//校验空格
            _totaldata.kpi_target = convertStr(_totaldata.kpi_target);
        }
        //保存之前存放当前最后一次
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
        if(rs && rs.success){
            //_cmp.init();
        }
        return rs;
    }

    /**
     * 复制年度绩效目标
     */
    Ext.lt.pmkpi.copyyeargoal = function(obj){
        var btnname = obj.name;
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
                            editform.synchEditformByObj(rs.data);
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
        $(document).ready(function(){
            $('#tophead').append("<div id = 'changyears' style='float:right;width:25%;margin-top:-2px;'/>");
            _cmp.finintorgSelect("changyears");
        });
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
        _cmp.selectdefyear();
        // 先不默认选中，减少首次加载请求次数
        // var params = {};
        // params.province=config["province"];
        // params.procode=_procode;
        // params.proguid = _proguid; //有的年度在总体录入，根据项目guid区分.
        // params.adjadd = _adjadd;
        // Ext.lt.RCP.call(serviceid, "getYearOption", params, function (obj) {
        //         if (!!obj && obj.length > 0){
        //             var tempyear = obj[0]["guid"];
        //             _panel.synchEditform({curyear: {text: tempyear, value: tempyear}});
        //         }
        //     }, function (err) {
        //         alert(err);
        //     }
        // );

    }

    _cmp.queryCurYearperf = function (year){
        var params = {};
        params.province=config["province"];
        params.procode=_procode;
        params.year = year;
        params.proguid = _proguid; //有的年度在总体录入，根据项目guid区分.
        params.adjadd = _adjadd;
        Ext.lt.RCP.call(serviceid, "getYearGoal", params, function (obj) {
            editform.synchEditformByObj(obj.data);
            }, function (err) {
                alert(err);
            }
        );
    }

    return _cmp;
}