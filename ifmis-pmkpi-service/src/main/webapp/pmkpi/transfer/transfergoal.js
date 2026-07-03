if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};

var tabcomps;
Ext.lt.pmkpi.transfergoal = function(config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var state = config["state"];//页面是否可修改 1新增 2修改，3查看
    var _viewtype = config["viewtype"]; //修改还是查看
    var _saveAgency = config["saveAgency"]; //项目单位
    _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var _busguid = config.busguid;//审核定义guid
    var _prolev = config["prolev"]; //项目等级123级项目
    var totalgoalname = config.totalname;//项目页签（编辑区）名称
    _procode = config.procode;
    showtab = config.showtab; //页签展示
    var tabnum = 0; //页签点击次数
    var _cmp = {};
    var _isGx = config.isGX;
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
        if (_viewtype == "query" || state == "3" || (_isedittotal == '1' && _curtab == "total")) {
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
    });

    /**
     * 点击页签.
     */
    _cmp.clickTabpage = function(obj){
        if (isFirst) {
            isfirsttab = obj.code;
            isFirst = false;
        }
        try {
            if (obj.code == "total" || _viewtype == "query") {
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
            if ((_viewtype != "query" || state != "3") && !editform.check()) {
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

    /**
     * 复制上年目标.
     */
    _cmp.lastyear = function(){
        //查询上年度指标
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.proguid = _proguid;
        params.procode = _procode;
        var datas = Ext.lt.RCP.asyncall(serviceid, "lastYearGoal", params);
        if(datas && datas.length>0){
            datas[0].guid = getCreateguid(serviceid);
            editform.synchEditformByObj(datas[0]);
            Ext.lt.ui.alert("复制成功！",{timeout:1},function(){});
        }
    }

    /**
     * 复制总体指标
     */
    _cmp.copy = function (obj) {
        var btnname = obj.name;
        var btncode = obj.code;
        Ext.lt.ui.confirm("是否" + btnname + "到年度绩效指标？", {icon: "warn"}, function (ret) {
            if (ret) {
                var data = tabcomps["#total"];
                setYeardata(data,btncode);
            }
        });
    }

    function setYeardata(data) {
        var yeardatas = Ext.lt.cloneobj(data);
        yeardatas.rowtype = "add";
        yeardatas.yearflag = "0";
        yeardatas.perf_obj_type_code = "2";
        yeardatas.perf_obj_type_name = "项目年度绩效";
        yeardatas['guid'] = createUUID().replace(/-/g, '');
        tabcomps["#year"] = yeardatas;
        editform.synchEditformByObj(yeardatas);
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
                Ext.lt.ui.alert("请填写年度绩效目标！",{timeout:1},function(){});
                return;
            }
        }
        //保存之前存放当前最后一次
       var params = {};
        params.projguid = _proguid;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.goaldata = tabcomps;
        params.showtab = showtab;
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

    return _cmp;
}