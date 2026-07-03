if (!Ext)
    Ext = {};
if (!Ext.lt)
    Ext.lt = {};
if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var _prolev;
var _saveAgency;
var _curtab = ""; //当前页签.
var tabcomps;
var showtab;
var zcolumns = {};
var _procode;
var _panel; //切换年度的组件.
var _isfrombdm;
var _weight_sum;
var _ischeckweight = false;
Ext.lt.pmkpi.treeindex = function (config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _parentproid = config["parentproid"];//父级一级项目id
    var _viewtype = config["viewtype"]; //修改还是查看
    _saveAgency = config["saveAgency"]; //项目单位
    _procode = config["procode"];//项目编码
    var selectbillguid = config.selectbillguid;//调整前的guid
    var _isnewapply = config.isnewapply; // 是否新填报方式
    var adjadd = config.adjadd;//是否调整
    var isnzzj = config.isnzzj;//是否年中追加
    var _signs = config["signs"];//指标符号
    var frametype = config.frametype;//层次分了类型
    var _kpivals = config["kpivals"]; //合肥定量其他值.
    var _kpicalnotapply = config["kpicalnotapply"];//不适用
    var ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
    var indexIsAddrow = config.indexIsAddrow;//指标是否是新增行，1是 其他否
    var _isyears = config["isyears"]; //1为项目库过来--》年度绩效页签，切换年度查看.
    isZJ = config["isZJ"];//标识是否是浙江（1.是）
    isGx = config["isGx"];//标识是否是广西（1.是）
    isJiangXI = config["isJiangXI"];
    var _busguid = config.busguid;//审核定义guid
    _prolev = config["prolev"]; //项目等级123级项目
    var _cmp = {};
    tabcomps = config["indexdata"]; //总体的指标数据.
    tabcomps["del#total"] = []; //总体删除
    tabcomps["del#year"] = []; //年度删除
    var iframeurl = config.iframeurl;//嵌套url
    showtab = config.showtab; //页签展示
    var hideIframeHtml = "";
    var height = Math.floor(document.documentElement.clientHeight * 0.95);
    var width =  Math.floor(document.documentElement.clientWidth * 0.95);
    if (height < 400) {
        height = 400;
    }
    if (width < 800) {
        width = 1000;
    }
    var isSX = config["isSX"];//标识是否是山西（1.山西）
    var _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var tabnum = 0; //页签点击次数
    var pdmsave = config.pdmsave;//暂存方法.
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol + "//" + document.location.host + "/" + iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    }
    var isFirst = true;
    var firsetyear = true;
    var isfirsttab;
    var _isAH = config.isAH;
    _isfrombdm = config.isfrombdm;
    var _issaveed = false;
    var _indsource = config.indsource;
    var _isNINGXIA = config.isNINGXIA;

    //页面加载完成后执行
    $(function () {
        _cmp.setTableColum();
        if (hideIframeHtml != null && hideIframeHtml != "") {
            $("#datatable").append(hideIframeHtml);
        }
        _cmp.bulidTopHead();
        if (_viewtype != "query" && datatable.config["tiptext"] && datatable.config["tiptext"] != null) {
            $('#tophead').append("<p title='' style=\"text-align:center;float:right;padding: 9px 20px 0 15px;color: red;\" class=\"layui-text\">" + datatable.config["tiptext"] + "</p>");
        }
        var columncfg = datatable.config.data[0].columns;
        for (var i=0; i<columncfg.length; i++) {
            if(columncfg[i].colcode == "actualweight" && columncfg[i].isvisiable == "1"){
                _ischeckweight = true;
                break;
            }
        }
        var tempdata = tabcomps["#" + _curtab];
        datatable.setDatas(tempdata);
        setTimeout(function () {
            if(_ischeckweight){
                var superid = "";
                for (var i = 0; i < tempdata.length; i++) {
                    var d = tempdata[i];
                    if (d.levelno == 3) {
                        if (d.superid != superid) {
                            gatherWeight(d.superid,"actualweight");
                        }
                        superid = d.superid;
                    }
                }
            }
            amtTotal(datatable);
        }, 500);
        parent._isQuery = true;
        if (isJiangXI == "1" && _viewtype != "query"){ //江西默认弹出指标推荐
            _cmp.recom();
        }
        isFirst = false;
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
     *
     */
    _cmp.clickTabpage = function (obj) {
        Ext.lt.ui.loadingShow();
        if (isFirst) {
            isfirsttab = obj.code;
        }
        if(isGx == 1){//广西：一级项目/二级项目预算编制（显示总+年并且总体不可编辑） 隐藏[获取最新一级项目指标]按钮
            if(_prolev == "1" || (_prolev == "2" && showtab == "1" && _isedittotal == "1" )){
                obj.hidebtns += ",获取最新一级项目指标";
            }
        }
        if (_isnewapply == "true") {
            newApplyHideBtns(obj.hidebtns);
        } else {
            perfcommon.changTooltoolbuttontStatus(0, obj.hidebtns);
        }
        if (showtab != 1) {
            toolbutton.hidden("lastyear");
        }
        if (tabnum != 0 && _curtab != obj.code && showtab != 3) {
            var num = 1;
            if (_curtab == isfirsttab) {
                num = 0;
            }
            if ((_isedittotal != "1" || _curtab == "year") && _viewtype != "query" && !_cmp.checkAll()) {
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
            var tempdata = datatable.getRecordSet().toArray();
            var yearflag = "";
            for (var i=0; i<tempdata.length; i++) {
                if (tempdata[i].levelno == 3 && tempdata[i].yearflag) {
                    yearflag = tempdata[i].yearflag;
                    break;
                }
            }
            if (yearflag == "1"){
                tabcomps["#total"] =Ext.lt.cloneobj(tempdata);
            } else if (yearflag == "0") {
                tabcomps["#year"] =Ext.lt.cloneobj(tempdata);
            }
            var tempdata = tabcomps["#" + obj.code];
            datatable.setDatas(tempdata);
            if(obj.code == "year" && _ischeckweight){
                setTimeout(function () {
                    var superid = "";
                    for (var i = 0; i < tempdata.length; i++) {
                        var d = tempdata[i];
                        if (d.levelno == 3) {
                            if (d.superid != superid) {
                                gatherWeight(d.superid,"actualweight");
                            }
                            superid = d.superid;
                        }
                    }
                }, 500);
            }
        }
        _curtab = obj.code;
        tabnum++;
        $("div[compid='toolbutton']").show();
        if (_viewtype == "query") {
                if (_isAH && _curtab == "year") {
                    perfcommon.changToolShowbuttont("ahexpdoc");
                } else {
                    $("div[compid='toolbutton']").hide();
                }
        }
        if (_isedittotal == "1" && _curtab == "total") {
            $("div[compid='toolbutton']").hide();
        }
        if(isZJ == 1) {
            setTimeout(function () {
                amtTotal(datatable);
            }, 500);
        }
        if (!isFirst) {
            _cmp.setTableColum();
        }
        if (showtab == "1" && _curtab == "year" && "1" == _isyears) { //年度显示切换select
            if ($("#changyears").length > 0) {
                if (_panel) {
                    _panel.show(['curyear'], false);
                }
                var tempyear = _panel.getCol("curyear").getvalue();
                if (!!tempyear) {
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
        if (isJiangXI == "1" && firsetyear && isfirsttab != _curtab && _viewtype != "query") { //切换到年度 第一次弹出指标推荐。
            _cmp.recom();
            firsetyear = false;
        }
        setTimeout(function(){
            Ext.lt.ui.loadingClose();
        },500);
    }

    /**
     * 选中默认当前年度
     */
    _cmp.selectdefyear = function (){
        if(tabcomps["#year"]){
            var yeardatas = tabcomps["#year"];
            var defyear = "";
            for(var i=0; i<yeardatas.length; i++){
                if(yeardatas[i].isleaf == 1) {
                    defyear = yeardatas[i].year;
                    break;
                }
            }
            _panel.synchEditform({curyear:{text:defyear, value:defyear}});
        }
    }

    /**
     * 复制总体指标
     */
    Ext.lt.pmkpi.copytotalindex = function (obj) {
        var btnname = obj.name;
        var btncode = obj.code;
        var data;
        if (btncode && (btncode == "copytotalindex" || btncode == "copytotalindexnoval")) { //复制中期到年度
            Ext.lt.ui.confirm("是否" + btnname + "到年度绩效指标？", {icon: "warn"}, function (ret) {
                if (ret) {
                    data = tabcomps["#total"];
                    setYeardata(data,btncode);
                }
            });
        } else if (btncode && btncode == "copyyearindex") { //复制年度到中期
            if (_isedittotal != "1" && showtab == "1") {
                Ext.lt.ui.confirm("是否" + btnname + "到总体绩效指标？", {icon: "warn"}, function (ret) {
                    if (ret) {
                        data = tabcomps["#year"];
                        setTotaldata(data);
                    }
                });
            } else {
                Ext.lt.pmkpi.alert("年度绩效指标页签未展示不能复制！", function () {
                });
            }
        }
    }

    function setYeardata(data,btncode) {
        var yeardatas = Ext.lt.cloneobj(data);
        if(isGx == 1){//广西，复制时过滤掉名称相同的指标，避免多次复制一级项目指标无法删除
            var pageindex = datatable.getRecordset().toArray();
            for (var j = 0; j < yeardatas.length; j++) {
                for (var i = 0; i < pageindex.length; i++) {
                    if (yeardatas[j].levelno == 3 && pageindex[i].levelno == 3 && yeardatas[j].name == pageindex[i].name) {
                        yeardatas.remove(yeardatas[j]);
                    }
                }
            }
        }
        for (var i = 0; i < yeardatas.length; i++) {
            if (yeardatas[i].levelno == 3) {

                var params = {};
                for (var key in yeardatas[i]) {
                    params[key] = yeardatas[i][key];
                }
                params.rowtype = "add";
                params.yearflag = "0";
                params.perf_obj_type_code = "2";
                params.perf_obj_type_name = "项目年度绩效";
                params.isfixed = "";
                if(btncode && btncode == "copytotalindexnoval"){//复制总体绩效目标（不带指标值）
                    if(params.isallowedit && params.isallowedit == "1" && params.isapply && params.isapply =="1"){//是否允许编辑为是，并且适用的指标值清空
                        params.indexval = "";
                    }else if (!params.isallowedit){//是否允许编辑为空
                        if(params.isapply && params.isapply =="1" ){
                            params.indexval = "";
                        }else  if(params.isapply && params.isapply =="2" ){
                            params.indexval = "—";
                        }
                    }
                }
                params['guid'] = createUUID().replace(/-/g, '');
                tabcomps["#year"].push(params);
            }
        }
        Ext.lt.pmkpi.alert("复制成功！", function () {
            if (_curtab == "year") {
                var tempdata = tabcomps["#" + _curtab];
                datatable.setDatas(tempdata);
            }
        });
    }

    function setTotaldata(data) {
        var totaldatas = Ext.lt.cloneobj(data);
        for (var i = 0; i < totaldatas.length; i++) {
            if (totaldatas[i].levelno == 3) {
                var params = {};
                for (var key in totaldatas[i]) {
                    params[key] = totaldatas[i][key];
                }
                params.rowtype = "add";
                params.yearflag = "1";
                params.perf_obj_type_code = "1";
                params.perf_obj_type_name = "项目整体绩效";
                params.isfixed = "";
                params['guid'] = createUUID().replace(/-/g, '');
                tabcomps["#total"].push(params);
            }
        }
        Ext.lt.pmkpi.alert("复制成功！", function () {
            if (_curtab == "total") {
                var tempdata = tabcomps["#" + _curtab];
                datatable.setDatas(tempdata);
            }
        });
    }

    Ext.lt.pmkpi.inittreeindex = function (){
        _cmp.init();
    }

    /**
     * 页面初始化.
     */
    _cmp.init = function () {
        var params = {};
        params.proguid = _proguid;
        params.showtab = showtab;
        params.pdmsave = pdmsave;
        params.selectbillguid = selectbillguid;
        params.adjadd = adjadd;
        params.prolev = _prolev;
        params.frametype = frametype;
        params.procode = _procode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "findAllIndex", [params], function (data) {
            tabcomps = data;
            tabcomps["del#total"] = []; //总体删除
            tabcomps["del#year"] = []; //年度删除
            var tempdata = tabcomps["#" + _curtab];
            datatable.setDatas(tempdata);
            setTimeout(function () {
                if(_ischeckweight){
                    var superid = "";
                    for (var i = 0; i < tempdata.length; i++) {
                        var d = tempdata[i];
                        if (d.levelno == 3) {
                            if (d.superid != superid) {
                                gatherWeight(d.superid,"actualweight");
                            }
                            superid = d.superid;
                        }
                    }
                }
                amtTotal(datatable);
            }, 500);
            Ext.lt.ui.loadingClose();
        })
    }

    /**
     * 新增
     */
    _cmp.add = function (obj, selguid) {
        var data = [];
        if (!selguid) {
            data = _cmp.getSeletdata("1");
            if (data.length != 1) {
                Ext.lt.pmkpi.alert("请选择一条二级指标！", function () {
                });
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid: selguid});
        }
        var _sortid = data[0]._sortid;
        if (data[0][FOLDING_FILED] == 'close') {
            data[0][FOLDING_FILED] = 'open';
            datatable.getViewRecordSet().showChildren(data[0], _sortid);
        }
        var url = '/pmkpi/program/prjindex/editindex.page';
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.sindex = data[0].sindex;
        params.upguid = data[0].guid;
        params.type = "add";
        params.is_add = "1";
        params.fromtype = "tree";
        params.is_intoindexlib = 2; //新增指标默认标记 未纳入指标库
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, width, height, "新增指标");
    }

    /**
     * 新增行
     */
    _cmp.addrow = function (selguid) {
        var data = datatable.getRecordset().query({guid: selguid});
        var _sortid = data[0]._sortid;
        if (data[0][FOLDING_FILED] == 'close') {
            data[0][FOLDING_FILED] = 'open';
            datatable.getViewRecordSet().showChildren(data[0], _sortid);
        }
        var indexdata = {};
        indexdata.guid = createUUID().replace(/-/g, '');
        indexdata.saveAgency = _saveAgency; //项目单位
        indexdata.sindex = data[0].sindex;
        indexdata.findex = data[0].findex;
        indexdata.superid = data[0].sindex;
        indexdata.levelno = 3;
        indexdata.isleaf = 1;
        indexdata._isleaf = 1;
        indexdata.rowtype = "add";
        indexdata.is_add = "1";
        indexdata.isfixed = "";
        indexdata.indsource = '1';
        indexdata.isfromparent = "0";
        indexdata.isapply = "1";
        if (_curtab == "total") {
            indexdata.yearflag = "1";
        } else if (_curtab == "year") {
            indexdata.yearflag = "0";
        }
        var isadd_source = [];
        indexdata.is_intoindexlib = 2; //新增指标默认标记 未纳入指标库
        if (datatable.getCol("is_add") && datatable.getCol("is_add")["isvisiable"] == 1) {
            var _isadd = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
            for (var i = 0; i < _isadd.length; i++) {
                var temparr = [];
                temparr.push(_isadd[i]["guid"]);
                temparr.push(_isadd[i]["code"]);
                temparr.push(_isadd[i]["name"]);
                isadd_source.push(temparr);
            }
            datatable.addMapperDatas("is_add", isadd_source);
        }
        if (datatable.getCol("isapply") && datatable.getCol("isapply")["isvisiable"] == 1) {
            var _isadd = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
            for (var i = 0; i < _isadd.length; i++) {
                var temparr = [];
                temparr.push(_isadd[i]["guid"]);
                temparr.push(_isadd[i]["code"]);
                temparr.push(_isadd[i]["name"]);
                isadd_source.push(temparr);
            }
            datatable.addMapperDatas("isapply", isadd_source);
        }
        if (datatable.getCol("is_intoindexlib") && datatable.getCol("is_intoindexlib")["isvisiable"] == 1) {
            var _isadd = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
            for (var i = 0; i < _isadd.length; i++) {
                var temparr = [];
                temparr.push(_isadd[i]["guid"]);
                temparr.push(_isadd[i]["code"]);
                temparr.push(_isadd[i]["name"]);
                isadd_source.push(temparr);
            }
            datatable.addMapperDatas("is_intoindexlib", isadd_source);
        }
        if (datatable.getCol("indsource") && datatable.getCol("indsource")["isvisiable"] == 1) {
            perfcommon.setColDatasource({"indsource" : _indsource}, datatable);
        }
        datatable.getRecordSet().addData(indexdata, _sortid + datatable.getRecordset().toArray().length);
    }

    /**
     * 修改
     */
    _cmp.mod = function () {
        var data = _cmp.getSeletdata("2");
        if (data.length != 1) {
            Ext.lt.pmkpi.alert("请选择一个三级指标修改！", function () {
            });
            return;
        } else if (data.length == 1 && (!data[0].levelno || data[0].levelno != 3)) {
            Ext.lt.pmkpi.alert("请选择三级指标修改！", function () {
            });
            return;
        }
        var url = '/pmkpi/program/prjindex/editindex.page';
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.sindex = data[0].sindex;
        params.modguid = data[0].guid;
        params.type = "mod";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, width, height, "修改指标");
    }

    /**
     * 删除.
     * @param selguid -- 选中行
     */
    _cmp.del = function (obj, selguid) {
        var data = [];
        if (!selguid) {
            data = datatable.getSelected();
            if (data.length == 0) {
                Ext.lt.pmkpi.alert("请选择需要删除的指标！", function () {
                });
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid: selguid});
        }
        var islevel3 = false;
        for(var i=0; i<data.length; i++){
            if(data[i].levelno == 3){
                islevel3 = true;
            }
            if(data[i].isfixed == "1"){
                Ext.lt.pmkpi.alert("固化指标无法删除！",function(){});
                return;
            }
            if(isGx == 1 && data[i].isfromparent == "1"){
                Ext.lt.pmkpi.alert("含有一级项目指标无法删除！",function(){});
                return;
            }
        }
        if(!islevel3){ // 选中指标不包含三级指标时提示，避免没有响应的情况
            Ext.lt.pmkpi.alert("一二级指标无法删除！",function(){});
            return;
        }
        Ext.lt.ui.confirm("确认要删除选中指标？", {icon: "warn"}, function (ret) {
            if (ret) {
                if (data && data.length > 0) {
                    var guids = [];
                    var superguid = [];
                    var delguids = [];//原来存在要物理删除的数据
                    var deldatas = [];
                    for (var i = 0; i < data.length; i++) {
                        if (data[i]["levelno"] == 3) {
                            guids.push(data[i]["guid"]);
                            if (superguid.indexOf(data[i]["superid"]) < 0) {
                                superguid.push(data[i]["superid"]);
                            }
                        }
                        if (data[i]["levelno"] == "3") {
                            delguids.push(data[i]["guid"]);
                            deldatas.push(data[i]);
                        }
                    }
                    if (delguids.length > 0) { //记录整体还是年度删除的数据.
                        var tempArr = [];
                        if (_curtab == "total") { //总体
                            tempArr = tabcomps["del#total"];
                            tabcomps["del#total"] = tempArr.concat(delguids); //总体删除
                        } else {
                            tempArr = tabcomps["del#year"];
                            tabcomps["del#year"] = tempArr.concat(delguids); //年度删除
                        }
                    }
                    datatable.removeData(deldatas);
                    if (superguid.length > 0) { //判断是否还有下级科目，没有isleaf置1
                        _cmp.upSuperIslef(superguid);
                    }
                    var tempdata = datatable.getAllData();
                    var yearflag = "";
                    for (var i=0; i<tempdata.length; i++) {
                        if (tempdata[i].levelno == 3 && tempdata[i].yearflag) {
                            yearflag = tempdata[i].yearflag;
                            break;
                        }
                    }
                    if (yearflag == "1" || (yearflag == "" && _curtab == "total")){
                        tabcomps["#total"] =Ext.lt.cloneobj(tempdata);
                    } else if (yearflag == "0" || (yearflag == "" && _curtab == "year")) {
                        tabcomps["#year"] =Ext.lt.cloneobj(tempdata);
                    }
                    if (_ischeckweight && superguid.length > 0){
                        for (var i = 0; i < superguid.length; i++) {
                            gatherWeight(superguid[i],"actualweight");
                        }
                    }
                }
            }
        })
    }

    /**
     * 是否需要提示保存
     * @returns {boolean}
     */
    Ext.lt.pmkpi.isneed2save = function (){
        if(_isfrombdm == "1") {
            var _isneed2save = false;
            var _isaddrow = false;
            var yeargoals = tabcomps["#year"];
            if(_curtab == "year"){
                var datas = datatable.getRecordSet().toArray();
                yeargoals = Ext.lt.cloneobj(datas);
            }
            for (var i=0; i<yeargoals.length; i++) {
                if (yeargoals[i].levelno == 3 && yeargoals[i].rowtype == "add") {
                    _isaddrow = true;
                    break;
                }
            }
            var updatas = datatable.getUpdataData();
            var deldatas = datatable.getRemoveData();
            if (updatas.length > 0 || deldatas.length > 0 || _isaddrow) {
                _isneed2save = true;
            }
            if(_isneed2save && !_issaveed){//数据变更需要保存 没有保存过
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
     * 保存方法.
     */
    _cmp.save = function (obj) {
        if (datatable.getEditor()){
            datatable.closeEdit();
        }
        if (!_cmp.checkAll()) return;//先校验
        if (!_cmp.saveCheck()) return;
        if (!_cmp.checkFrameWeight()) return;
        //处理指标名称、指标值字段 特殊字替换
        var totalgoals = tabcomps["#total"];////总体目标
        var yeargoals = tabcomps["#year"];//年度目标
        if (totalgoals && totalgoals.length > 0) {
            for (var a = 0, tleni = totalgoals.length; a < tleni; a++) {
                if(totalgoals[a].levelno == "3"){
                    if (!perfcommon.checkSpaceValue(totalgoals[a],"总体绩效指标-第" + (totalgoals[a]["_sortid"] + 1) + "行","datatable")) return;//校验空格
                    totalgoals[a].name = convertStr(totalgoals[a].name);
                    totalgoals[a].indexval = convertStr(totalgoals[a].indexval);
                    totalgoals[a].kpi_val = convertStr(totalgoals[a].kpi_val);
                }
            }
        }
        if (yeargoals && yeargoals.length > 0) {
            for (var b = 0, yleni = yeargoals.length; b < yleni; b++) {
                if(yeargoals[b].levelno == "3") {
                    if (!perfcommon.checkSpaceValue(yeargoals[b], "年度绩效指标-第" + (yeargoals[b]["_sortid"] + 1) + "行","datatable")) return;//校验空格
                    yeargoals[b].name = convertStr(yeargoals[b].name);
                    yeargoals[b].indexval = convertStr(yeargoals[b].indexval);
                    yeargoals[b].kpi_val = convertStr(yeargoals[b].kpi_val);
                }
            }
        }
        var params = {};
        params.projguid = _proguid;
        params.datas = tabcomps;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.prolev = _prolev;//项目级别 123
        params.showtab = showtab; //展示的目标数
        params.procode = _procode; //项目编码
        params.isedittotal = _isedittotal;
        params.adjadd = adjadd;
        params.isnzzj = isnzzj;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid, "savePrjTreeIndex", params);
        Ext.lt.ui.loadingClose();
        if(_isfrombdm == "1") {
            if (rs && rs.success) {
                _issaveed = true;
                Ext.lt.pmkpi.alert("保存成功!",function(){});
                _cmp.init();
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
            _cmp.init();
        }
        return rs;
    }

    _cmp.saveCheck = function () {
        var datas = datatable.getRecordSet().toArray();
        var yearflag = "";
        var alertmsg = "";
        for (var i=0; i<datas.length; i++) {
            if (datas[i].levelno == 3 && datas[i].yearflag) {
                yearflag = datas[i].yearflag;
                break;
            }
        }
        //校验没问题，插入数据
        if (yearflag == "1"){
            tabcomps["#total"] = Ext.lt.cloneobj(datas);
        } else if (yearflag == "0") {
            tabcomps["#year"] =Ext.lt.cloneobj(datas);
        }
        var tatalindex = tabcomps["#total"];
        var yearindex = tabcomps["#year"];
        if(tatalindex){
            for(var i=0;i<tatalindex.length;i++) {
                if(tatalindex[i]["levelno"] == 3 && tatalindex[i].yearflag != "1"){
                    alertmsg= "【总体指标】三级指标：" + tatalindex[i].name + "录入不正确，请删除后重新录入!";
                    Ext.lt.pmkpi.alert(alertmsg, {timeout:1},function(){});
                    return false;
                }
            }
        }
        if(yearindex){
            for(var i=0;i<yearindex.length;i++) {
                if(yearindex[i]["levelno"] == 3 && yearindex[i].yearflag != "0"){
                    alertmsg= "【年度指标】三级指标：" + yearindex[i].name + "录入不正确，请删除后重新录入!";
                    Ext.lt.pmkpi.alert(alertmsg, {timeout:1},function(){});
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * 精准推荐方法.
     */
    _cmp.recom = function () {
        var url = '/pmkpi/program/prjindex/recomindex.page';
        var params = {};
        params.proguid = _proguid;
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.fromtype = "tree";
        params.showtab = showtab;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, width, height, "指标推荐");
    }

    /**
     * 挑选指标.
     * frame -- 二级指标
     * guid -- guid
     */
    _cmp.pick = function () {
        var data = _cmp.getSeletdata("1");
        var url = '/pmkpi/program/prjindex/pickindex.page';
        var params = {};
        if (data.length > 0) {
            params.sindex = data[0].sindex;
            params.guid = data[0].guid;
        }
        params.fromtype = "tree";//树级填报
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.proguid = _proguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, width, height, "挑选指标");
    }

    /**
     * AI绩效指标智能推荐方法.
     */
    _cmp.AIrecoindex = function (btn){
        var url = '/pmkpi/program/airecoindex.page';
        var btnconfig = eval('(' + btn.config + ')');
        var params = {};
        params.proguid = _proguid;
        params.procode = _procode;
        params.fromtype = "tree";
        params.showtab = showtab;
        params.recomtype = "AI";
        params.frametype = "PM001";
        params.api_key = btnconfig.api_key;
        params.api_code = btnconfig.api_code;
        params.loadingtips = btnconfig.loadingtips;
        if (_curtab == "total"){
            params.yearflag = '1';
        } else {
            params.yearflag = '0';
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,Math.floor(document.documentElement.clientWidth * 0.98),height,"绩效指标智能推荐");
    }

    /**
     * 复制上年指标.
     */
    _cmp.lastyear = function (obj) {
        var ismultipro = false;
        if(obj.config){
            var btnconfig = eval('(' + obj.config + ')');
            ismultipro = btnconfig.ismultipro ? btnconfig.ismultipro : ismultipro;
        }
        if(ismultipro){ //多项目不存在对应关系打开项目列表选择关系
            var cparams = {};
            cparams.pro_code = _procode;
            var rs = Ext.lt.RCP.asyncall(serviceid, "getLastProData", cparams);
            if(rs.success){
                var lastprolist = rs.prolastyearlist;
                if(lastprolist.size() == 0){ //不存在对应关系
                    Ext.lt.pmkpi.alert("未匹配到该项目上年对照关系,请选择项目进行复制!",function(){
                        var tparams = {};
                        var url = '/pmkpi/program/prjindex/sellastyearpro.page';
                        tparams.agency_code = _saveAgency; //项目单位
                        tparams.pro_code = _procode;
                        tparams.type = "fromindex";
                        url = Ext.lt.pmkpi.genPageUrl(url, tparams);
                        Ext.lt.ui.openModalWindow(url,width,height,"选择上年项目");
                    });
                }else{
                    var params = {};
                    var url = '/pmkpi/program/prjindex/lastyear.page';
                    params.fromtype = "tree";//树级填报
                    params.saveAgency = _saveAgency; //项目单位
                    params.prolev = _prolev;//项目级别 123
                    params.proguid = _proguid;
                    params.procode = _procode;
                    params.ismultipro = "1";
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    indexwindow = Ext.lt.ui.openModalWindow(url, width, height, "上年指标");
                }
            }else{
                Ext.lt.pmkpi.alert(rs.msg, function () {});
            }
        }else{
            var params = {};
            var url = '/pmkpi/program/prjindex/lastyear.page';
            params.fromtype = "tree";//树级填报
            params.saveAgency = _saveAgency; //项目单位
            params.prolev = _prolev;//项目级别 123
            params.proguid = _proguid;
            params.procode = _procode;
            params.ismultipro = "0";
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            indexwindow = Ext.lt.ui.openModalWindow(url, width, height, "上年指标");
        }
    }

    /**
     * 往年预算执行情况.
     */
    _cmp.budget = function () {
        var params = {};
        var url = '/pmkpi/program/prjindex/budget.page';
        params.fromtype = "tree";//树级填报
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.proguid = _proguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, width, height, "往年预算执行情况");
    }

    /**
     * 获取最新一级项目指标
     */
    _cmp.getparentproindex = function (){
        var params = {};
        params.proguid = _proguid;
        params.parentproid = _parentproid;
        params.yearflag = '1';
        Ext.lt.ui.confirm("确认清除已填报的一级项目指标，重新获取最新一级项目指标？",{icon:"warn"},function(ret){
            if(ret){
                var rs = Ext.lt.RCP.asyncall(serviceid, "getparentproindex", params);
                if(rs.success){
                    var parentproindex = rs.parentproindex;
                    if(parentproindex.length>0){
                        //删除页面现有的一级项目指标
                        var data = datatable.getRecordset().toArray();
                        var deldatas = [];
                        var delguids = [];//原来存在要物理删除的数据
                        for(var i=0;i<data.length;i++){
                            if (data[i]["levelno"] == "3" && data[i]["isfromparent"] == "1") {
                                deldatas.push(data[i]);
                                delguids.push(data[i]["guid"]);
                            }
                        }
                        if (delguids.length > 0) { //记录整体还是年度删除的数据.
                            var tempArr = tabcomps["del#total"];
                            tabcomps["del#total"] = tempArr.concat(delguids); //总体删除
                        }
                        datatable.removeData(deldatas);
                        //覆盖最新的一级项目指标
                        var selMap = {};
                        var tempobj = {};
                        var sindex = "";
                        for(var i=0;i<parentproindex.length;i++){
                            tempobj = parentproindex[i];
                            tempobj.levelno = 3;
                            tempobj.isleaf = 1;
                            tempobj.rowtype = "add";
                            sindex = tempobj["sindex"];
                            if(!selMap[sindex]){
                                selMap[sindex] = [];
                            }
                            selMap[sindex].push(tempobj);
                        }
                        var zbxs_source = [];
                        for(var i=0; i<_signs.length; i++){
                            var temparr = [];
                            temparr.push(_signs[i]["guid"]);
                            temparr.push(_signs[i]["code"]);
                            temparr.push(_signs[i]["name"]);
                            zbxs_source.push(temparr);
                        }
                        datatable.addMapperDatas("computesign",zbxs_source);
                        var isapply_source = [];
                        var _isapply = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
                        for (var i = 0; i < _isapply.length; i++) {
                            var temparr = [];
                            temparr.push(_isapply[i]["guid"]);
                            temparr.push(_isapply[i]["code"]);
                            temparr.push(_isapply[i]["name"]);
                            isapply_source.push(temparr);
                        }
                        datatable.addMapperDatas("isapply", isapply_source);
                        for (var key in selMap) {
                            var parent_sel_rows = datatable.getRecordset().query({guid:key});
                            if (parent_sel_rows.length > 0 ) {
                                var parent_sel_obj = parent_sel_rows[parent_sel_rows.length -1];
                                var _sortid = parent_sel_obj._sortid;
                                datatable.getRecordSet().addData(selMap[key],_sortid + datatable.getRecordset().toArray().length);
                            }
                        }
                        datatable.reflash();
                        //保存之前存放当前最后一次
                        var tempdata =  datatable.getAllData();
                        tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
                        Ext.lt.pmkpi.alert("操作成功！",function(){});
                    }else{
                        Ext.lt.pmkpi.alert("不存在一级项目指标数据！",function(){});
                    }
                } else {
                    Ext.lt.pmkpi.alert(rs.error,function(){});
                }
            }
        });
    }

    /**
     * 重画表格列.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var uiconfig = obj.table.uiconfig;
        zcolumns = uiconfig.columns;
        var cols = obj.cols;
        var upcols = [];
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        var isapply;
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "indexval") {
                upcols.push(col["colcode"]);
                col.fn = function (l, c, data, col) {
                    if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10" || ismergeindex != "1") {
                        var indexvalue = !data.indexval ? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
                    } else {
                        var computesignstr = "";
                        for (var i = 0; i < _signs.size(); i++) {
                            if (data.computesign == _signs[i].guid) {
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if (data["meterunit"]) {
                            unit = data.meterunit;
                        }
                        var returnstr = !data.indexval ? computesignstr + unit : computesignstr + data.indexval + unit;
                        return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
                    }
                }
                col.cseditfn = function (i, j, rs, style) {
                    if (isGx == 1 && (rs.levelno != "3" || rs.isallowedit == "2" || rs.isapply == "2")) {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (_isedittotal == "1" && _curtab == "total") {
                        return false;
                    }
                    if (d.levelno != "3") {
                        return false;
                    }
                    if (_isnewapply == "true" && d.value_change == "2") { // 四个部门是否可编辑规则
                        return false;
                    }
                    if (isGx == 1 && d.isfromparent == "1" && (d.isapply == "2" || d.isallowedit == "2")) { //父级指标，不允许修改标签 或 不适用 不可编辑
                        return false;
                    }
                    if (d.computesign == "9") { //合肥添加定量其他
                        doMapper(_kpivals, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else if (d.computesign == "10") {
                        doMapper(_kpicalnotapply, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.indexval != undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                    }
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10') {
                        if (!checkReferencepole(d.indexval)) {
                            d.indexval = '';
                            return false;
                        }
                    }
                    if (d.indexval != '') {
                        var computesign = d.computesign;
                        if (!d.computesign) {
                            Ext.lt.pmkpi.alert("请先选择计算符号！", {timeout: 1}, function () {
                            });
                            d.indexval = '';
                            return false;
                        }
                    }
                    if (d.levelno == "3" && d.rowtype != "add") {
                        d.rowtype = "mod";
                    }
                    if (d.computesign == "9") {
                        d["kpivalsource"] = d["indexval"];
                    }
                }
            }
            if (col["colcode"] == "estimated_val") {
                upcols.push(col["colcode"]);
                col.fn = function (l, c, data, col) {
                    if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10" || ismergeindex != "1") {
                        var indexvalue = !data.estimated_val ? "" : data.estimated_val;
                        return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
                    } else {
                        var computesignstr = "";
                        for (var i = 0; i < _signs.size(); i++) {
                            if (data.computesign == _signs[i].guid) {
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if (data["meterunit"]) {
                            unit = data.meterunit;
                        }
                        var returnstr = !data.estimated_val ? computesignstr + unit : computesignstr + data.estimated_val + unit;
                        return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
                    }
                }
                col.cseditfn = function (i, j, rs, style) {
                    if (isGx == 1 && (rs.levelno != "3" || rs.isallowedit == "2" || rs.isapply == "2")) {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (_isedittotal == "1" && _curtab == "total") {
                        return false;
                    }
                    if (d.levelno != "3") {
                        return false;
                    }
                    if (_isnewapply == "true" && d.value_change == "2") { // 四个部门是否可编辑规则
                        return false;
                    }
                    if (isGx == 1 && d.isfromparent == "1" && (d.isapply == "2" || d.isallowedit == "2")) { //父级指标，不允许修改标签 或 不适用 不可编辑
                        return false;
                    }
                    if (d.computesign == "9") { //合肥添加定量其他
                        doMapper(_kpivals, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else if (d.computesign == "10") {
                        doMapper(_kpicalnotapply, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.estimated_val != undefined ? d.estimated_val : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                    }
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10') {
                        if (!checkReferencepole(d.estimated_val)) {
                            d.estimated_val = '';
                            return false;
                        }
                    }
                    if (d.estimated_val != '') {
                        if (!d.computesign) {
                            Ext.lt.pmkpi.alert("请先选择计算符号！", {timeout: 1}, function () {
                            });
                            d.estimated_val = '';
                            return false;
                        }
                    }
                    if (d.levelno == "3" && d.rowtype != "add") {
                        d.rowtype = "mod";
                    }
                }
            }
            if (col["colcode"] == "isapply") {
                upcols.push(col["colcode"]);
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.levelno != "3") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || (_isedittotal == "1" && _curtab == "total")) {
                        return false;
                    }
                    isapply = d.isapply;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.isapply == "2" && d.isfromparent == "1" && d.isallowedit == "1") {
                        d.indexval = "—";
                    } else if (isapply == "2" && d.isapply == "1" && d.isfromparent == "1" && d.isallowedit == "1") {
                        d.indexval = "";
                    }
                }
            }
            if (isSX == 1) {

                if (col["colcode"] == "zqindexval") {
                    col.fn = function (l, c, data, col) {
                        if (data.zqcomputesign == "6" || data.zqcomputesign == "9" || data.zqcomputesign == "10") {
                            var zqindexvalue = !data.zqindexval ? "" : data.zqindexval;
                            return "<font style=\"margin-left:10px;\">" + zqindexvalue + "</font>";
                        } else {
                            var zqcomputesignstr = "";
                            for (var i = 0; i < _signs.size(); i++) {
                                if (data.zqcomputesign == _signs[i].guid) {
                                    zqcomputesignstr = _signs[i].name;
                                }
                            }
                            var zqunit = "";
                            if (data["zqmeterunit"]) {
                                zqunit = data.zqmeterunit;
                            }
                            var returnstr = !data.zqindexval ? zqcomputesignstr + ' ' + zqunit : zqcomputesignstr + ' ' + data.zqindexval + ' ' + zqunit;
                            return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
                        }
                    }

                }
            }

            if (col["colcode"] == "obligate1") {
                if (_viewtype != "query") {
                    col.style = " text-align:center;";
                    col.fn = function (l, c, data, col) {
                        var html = "";
                        if (data.levelno == "2") {
                            // html += '<a title = "选择" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexcheck("'+data.guid+'")\'>选择</a>';
                            // html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            //if(isZJ != 1){
                            if (indexIsAddrow) {
                                html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:prjtreeindex.add("","' + data.guid + '")\'>新增</a>';
                            } else {
                                html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:prjtreeindex.addrow("' + data.guid + '")\'>新增</a>';
                            }
                            //}
                        } else if (data.levelno == "3" && (data.isfromparent == null || data.isfromparent =="0")) {
                            html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:prjtreeindex.del("","' + data.guid + '")\'>删除</a>';
                        }
                        if ((_isedittotal == "1" && _curtab == "total") || _isnewapply == "true") {
                            return "";
                        } else {
                            return html;
                        }
                    }
                } else {
                    col.isvisiable = 0;
                }
            }
            if (col["colcode"] == "weight") {
                col.fn = function (l, c, data, col) {
                    if (data.isleaf == "0") {
                        var weight = 0;
                        if (data.weight) {
                            weight = data.weight;
                        }
                        return "<b>" + Math.round(weight * 100) / 100 + "</b>";
                    } else {
                        return data.weight ? data.weight : "";
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    gatherWeight(d.superid);
                    amtTotal(datatable);
                }
            }
            if (col["colcode"] == "frameweight") {
                col.cseditfn = function (i, j, rs, style) {
                    var newstyle = 'text-align:right;padding-right:5px;';
                    if(rs.levelno != "3"){
                        newstyle = 'text-align:right;padding-right:5px;font-weight: bold';
                    }
                    var styleresult = updateStyle(style, newstyle);
                    return styleresult;
                }
                col.fn = function (l, c, data, col) {
                    if (data.levelno != "3") {
                        return data.frameweight;
                    } else {
                        return "";
                    }
                }
            }
            if (col["colcode"] == "actualweight") {
                col.cseditfn = function (i, j, rs, style) {
                    var newstyle = 'text-align:right;padding-right:5px;';
                    if(rs.levelno != "3"){
                        newstyle = 'text-align:right;padding-right:5px;font-weight: bold';
                    }
                    var styleresult = updateStyle(style, newstyle);
                    return styleresult;
                }
                col.fn = function (l, c, data, col) {
                    var actualweight = 0;
                    if (data.actualweight) {
                        actualweight = data.actualweight;
                    }
                    if (data.levelno != "3") {
                        return Math.round(actualweight * 100) / 100;
                    } else {
                        return actualweight;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    gatherWeight(d.superid,"actualweight");
                    amtTotal(datatable);
                }
            }
            if (col["colcode"] == "computesign") {
                upcols.push(col["colcode"]);
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || (_isedittotal == "1" && _curtab == "total")) {
                        return false;
                    }
                    if (_isnewapply == "true") { // 四个部门不可编辑
                        return false;
                    }
                    if (d.isfixed == "1") { // 固化指标不可编辑
                        return false;
                    }
                    if (isGx == 1 && d.isfromparent == "1") { // 父级指标不可编辑
                        return false;
                    }
                    if (isJiangXI == "1" && d["is_add"]!="1"){
                        return false;
                    }
                }
                col.cseditfn = function (i, j, rs, style) {
                    if (isJiangXI == "1" && rs["is_add"]!="1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != "9" && d.computesign != "10") {
                        if (d.indexval && !checkReferencepole(d.indexval)) {
                            d.indexval = '';
                            d.meterunit = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "9") {
                        var istrue = false;
                        for (var i = 0; i < _kpivals.length; i++) {
                            if (d.indexval == _kpivals[i].guid) {
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexval = '';
                            d.meterunit = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "10") {
                        var istrue = false;
                        for (var i = 0; i < _kpicalnotapply.length; i++) {
                            if (d.indexval == _kpicalnotapply[i].guid) {
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexval = '';
                            d.meterunit = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "6") {
                        d.indexval = '';
                        d.meterunit = '';
                        return false;
                    } else if (!d.computesign || d.computesign == "") {
                        d.indexval = '';
                        d.meterunit = '';
                        return false;
                    }
                }
            }
            if (col["colcode"] == "name" || col["colcode"] == "perf_ind_name") {
                upcols.push(col["colcode"]);
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.levelno == "3" && rs.is_remarked == "1") {
                        return updateStyle(style, 'color:#FF0000');
                    }
                    return style;
                }
            }
            if (col["colcode"] == "name" || col["colcode"] == "meterunit" || col["colcode"] == "kpi_remark" || col["colcode"] == "isallowedit" || col["colcode"] == "onlyself" || col["colcode"] == "sumtype") {
                upcols.push(col["colcode"]);
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || (_isedittotal == "1" && _curtab == "total")) {
                        return false;
                    }
                    if (_isnewapply == "true") { // 四个部门不可编辑
                        return false;
                    }
                    if (d.isfixed == "1") { // 固化指标不可编辑
                        return false;
                    }
                    if (isGx == 1 && d.isfromparent == "1") { // 父级指标不可编辑
                        return false;
                    }
                }
            }
            //江西非新增不可编辑列
            if (isJiangXI == "1") {
                if (col["colcode"] == "name" || col["colcode"] == "meterunit" || col["colcode"] == "islinked"
                    || col["colcode"] == "kpi_remark" || col["colcode"] == "value_remark"|| col["colcode"] == "kpi_evalstd"
                    || col["colcode"] == "indexcategories" || col["colcode"] == "industrycategory"
                    || col["colcode"] == "indexcategory" || col["colcode"] == "filed" || col["colcode"] == "occupation") {
                    upcols.push(col["colcode"]);
                    col.oneditstart = function (table, el, l, c, d) {
                        if (d.levelno != "3") {
                            return false;
                        } else if (d["is_add"] != "1") {
                            return false;
                        } else if (_isedittotal == "1" && _curtab == "total"){
                            return false;
                        }else if (d.isfixed == "1") { // 固化指标不可编辑
                            return false;
                        }
                    }
                    col.cseditfn = function (i, j, rs, style) {
                        if (rs.levelno != "3") {
                            style = 'style="background-color:#f2f2f2;"';
                        } else if (rs["is_add"] != "1") {
                            style = 'style="background-color:#f2f2f2;"';
                        } else if (_isedittotal == "1" && _curtab == "total"){
                            style = 'style="background-color:#f2f2f2;"';
                        }
                        return style;
                    }
                }
                if (col["colcode"] == "is_add") {
                    upcols.push(col["colcode"]);
                    col.fn = function (l, c, data, col) {
                        if (data.is_add == "2") {
                            return "<font style=\"margin-left:10px;\">" + "" + "</font>";
                        } else {
                            return "<font style=\"margin-left:10px;\">" + col + "</font>";
                        }
                    }
                }
            }
            if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
        if (_viewtype != 'query') {
            for (var i = 0; i < cols.length; i++) {
                if (cols[i]["colcode"] && cols[i]["isvisiable"] == 1) {
                    var iscol = false;
                    for (var j = 0; j < upcols.length; j++) {
                        if (cols[i]["colcode"] == upcols[j]) {
                            iscol = true;
                            break;
                        }
                    }
                    if (!iscol) {
                        cols[i].oneditstart = function (table, e, l, c, d) {
                            if (d.levelno != "3" || (_isedittotal == "1" && _curtab == "total")) {
                                return false;
                            }
                        }
                    }
                }
            }
        }
    })

    function gatherWeight(superid,sumcol) {
        var sumcol = sumcol || "weight";
        var datas = datatable.getRecordSet().toArray();
        if (superid) {
            if (datas != null && datas.length > 0) {
                var supguid = '';
                var sortid = 0;
                var result = 0;
                var guid = '';
                for (var i = 0; i < datas.length; i++) {
                    var selectDatas = datas[i];
                    if (superid == selectDatas.guid) {
                        supguid = selectDatas.superid;
                        guid = selectDatas.guid;
                    }
                    if (selectDatas.superid == superid && selectDatas[sumcol] && !isNaN(selectDatas[sumcol])) {
                        result += parseFloat(selectDatas[sumcol]);
                    }
                }
                datas.each(function (data, i) {
                    if (data.guid == guid) {
                        datas[i][sumcol] = result == 0 ? "" : result.toFixed(2);
                    }
                });
                gatherWeight(supguid,sumcol);
                amtTotal(datatable);
            }
        }
        datatable.reflash();
    }

    _cmp.checkFrameWeight = function (){
        if (_ischeckweight && !Ext.lt.pmkpi.weightCheckNew(datatable,_weight_sum,"frameweight","actualweight","prjindex","1")) {//权重校验
            return false;
        }else{
            return true;
        }
    }

    /**
     * 表格的选择行.
     * @param type 1:包含二级，2 只有末级
     */
    _cmp.getSeletdata = function (type) {
        var _datas = datatable.getRecordSet().toArray();
        var seldata = [];
        var len = _datas.length;
        for (var i = 0; i < len; i++) {
            if ("1" == type) {
                if (_datas[i]["check"] == 1 && _datas[i]["levelno"] != 1) {
                    seldata.push(_datas[i]);
                }
            } else if ("2" == type) {
                if (_datas[i]["check"] == 1 && _datas[i]["levelno"] == 3) {
                    seldata.push(_datas[i]);
                }
            } else {
                seldata.push(_datas[i]);
            }
        }
        return seldata;
    }

    /**
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    _cmp.checkAll = function (datas) {
        var datas = datas || datatable.getRecordSet().toArray();
        var cols = datatable.getCols();
        var sumweight = 0;
        for (var i = 0, leni = datas.length; i < leni; i++) {
            if (datas[i]["levelno"] == 3) {
                if (datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")) {
                    Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。", {timeout: 1}, function () {
                    });
                    Ext.lt.ui.loadingClose();
                    return false;
                }
                if (datas[i]['computesign'] == '9' && (!datas[i].value_remark || datas[i].value_remark == '')) {
                    Ext.lt.pmkpi.alert("计算符号选择“定量（其他）”时，指标值说明必填！", {timeout: 1}, function () {
                    });
                    Ext.lt.ui.loadingClose();
                    return false;
                }
                sumweight += Number(datas[i]['weight']);
            }
            for (var j = 0, lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    // if(_isnewapply=="true" && datas[i]["value_change"] == "2"){ // 四个部门固定值不可更改，所以跳过校验
                    //     return true;
                    // }
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。", {timeout: 1}, function () {
                        });
                        Ext.lt.ui.loadingClose();
                        return false;
                    }
                    if (cols[j].colcode == 'indexval' && value.match(RegExp("[*_-]")) != null && (_curtab == "year" || (_isedittotal != "1" && _curtab == "total"))) {
                        Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。", {timeout: 1}, function () {
                        });
                        Ext.lt.ui.loadingClose();
                        return false;
                    }
                }
            }
        }
        if (isZJ == 1) {
            var columns = datatable.config.data[0].columns;
            var isvisiable = 0;
            for (var i = 0; i < columns.length; i++) {
                if (columns[i]["colcode"] == "weight") {
                    isvisiable = columns[i]["isvisiable"];
                    break;
                }
            }
            if (sumweight != 100 && isvisiable == 1) {
                Ext.lt.pmkpi.alert("绩效指标权重需为100，保存失败!", {timeout: 1}, function () {
                });
                Ext.lt.ui.loadingClose();
                return false;
            }
        }
        return true;
    }

    /**
     *
     * @param superids -- 要判断的二级.
     */
    _cmp.upSuperIslef = function (superids) {
        var datas = datatable.getRecordSet().toArray();
        var isUpdate = true;
        if (datas != null && datas.length > 0) {
            var lev2arr = [];
            var seltDatas = {};
            for (var i = 0; i < datas.length; i++) {
                seltDatas = datas[i];
                if (seltDatas.superid != "" && seltDatas.levelno == 3 && lev2arr.indexOf(seltDatas["superid"]) < 0) {
                    lev2arr.push(seltDatas.superid);
                }
            }
            if (superids.length > 0) {
                var suprow = {};
                for (var i = 0; i < superids.length; i++) {
                    gatherWeight(superids[i]);
                    if (lev2arr.indexOf(superids[i]) < 0) {
                        suprow = datatable.getRecordset().query({guid: superids[i]})[0];
                        suprow['isleaf'] = '1';
                        suprow['_isleaf'] = '1';
                        var _sortid = suprow._sortid;
                        datatable.reflash(_sortid);
                    }
                }
                //datatable.reflash();
            }
        }
    }

    /**
     * * 复查看评审意见
     * */
    _cmp.reviewinfo = function () {
        var params = {};
        var url = '/pmkpi/review/report/proindex.page';
        params.saveAgency = _saveAgency; //项目单位
        params.viewtype = "query";
        params.bustype = "program";
        params.procode = _procode;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, width, height, "评审意见");
    }

    _cmp.import = function (obj) {
        //判断是否保存已经保存项目，即查询项目表里有没有数据
        var para = {};
        para.mainguid = _proguid;
        Ext.lt.ui.loadingShow();
        var resuleflag = Ext.lt.RCP.asyncall(serviceid, "chcekProgram", para);
        Ext.lt.ui.loadingClose();
        if (resuleflag == "false") {
            Ext.lt.pmkpi.alert("请先保存项目！", function () {
            });
            return;
        }
        // 暂时写死导入模板的code
        var importcode = "005001";
        var vchtypeid = "C37567D248794199E053B11FA8C015A7";
        var tokenid = Ext.lt.getparam("tokenid");
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.vchtypeid = vchtypeid;
        params.tabtype = _curtab;
        params.proguid = _proguid;
        params.pagetype = "add";
        params.procode = _procode;
        params.agencyguid = _saveAgency;
        params.adjadd = adjadd;
        params.isnzzj = isnzzj;
        params.selectbillguid = selectbillguid;
        window.importparam = params;
        // parent.document.getElementById("importdata");
        // $(window.frames[0].document).contents().find("#importdata").hide();
        Ext.lt.importdata.imports(tokenid, importcode, vchtypeid, Object.toJSON(params), function () {
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.pmkpi.impsucess();
        });
    }
    Ext.lt.pmkpi.impsucess = function () {
        Ext.lt.pmkpi.alert("导入成功！", function () {
            Ext.lt.pmkpi.query();
        });
    }
    Ext.lt.pmkpi.query = function () {
        _cmp.init();
    };

    /**
     * 重新构建表格.
     */
    _cmp.refdrawtable = function (obj) {
        // var oldcols = datatable.getColumns();
        var oldcols = zcolumns;
        datatable.columns.checkbox.style = "text-align:center";
        var columns = [datatable.columns.seq, datatable.columns.checkbox];
        $.each(oldcols, function (i, item) {
            if (item) {
                if (obj.code == "total") {//实施期
                    if (item.config["columncode"] && item["config"]["columncode"] == "zqindexval") {
                        item.display = false;
                        item.isvisiable = 0;
                    }
                }

                if (obj.code == "year") {//年度
                    if (item.config["columncode"] && item["config"]["columncode"] == "zqindexval") {
                        item.display = true;
                        item.isvisiable = 1;
                    }
                }
                columns.push(item);
            }
        });
        Ext.lt.cache.removeData("dtcolumn_" + datatable.id);
        datatable.setCols(columns);
        datatable.setDatas([]);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    var _displaycols = [];
    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    _cmp.setTableColum = function () {
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            if (col.colcode == "opinion_remark") {
                col.edit = config[col.colcode];
            }
            if (_viewtype == "query" || (_isedittotal == "1" && _curtab == "total")) {
                if (col.colcode == "obligate1") {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                    continue;
                }
                if (col.config && col.config["viewty"] && col.config["viewty"] != _curtab) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            } else if (col.colcode == "obligate1") {
                col.display = true;
            } else {
                //江西个性化，总体显示新增，年度显示：新增，入库，行业，职能，活动等。
                if (col.config && col.config["viewty"] && col.config["viewty"] != _curtab) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            }
            if (isGx == 1 && col.colcode == "isapply" && _prolev == "1") {//广西 隐藏一级项目的[是否适用]列
                _displaycols.push(col);
                col.display = false;
            }
            var colconfig = eval(col.config);
            if (isGx == 1 && colconfig && !$.isEmptyObject(colconfig) && col.alias != "序号") {
                if (colconfig.prolev == "1") {
                    col.display = true;
                }
            }
        }
        var allcols = datatable.getAllCols(); //获取列表所有列
        for (var i = 0, len = allcols.length; i < len; i++) {
            var col = allcols[i];
            var colconfig = col.config;
            if (isGx == 1 && colconfig && !$.isEmptyObject(colconfig) && col.alias != "序号") {
                if (_prolev && colconfig.prolev == _prolev) {//一级项目局列显示处理
                    col.display = true;
                }
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
        perfcommon.initDatatable();
    }

    /**
     * 引用指标
     */
    _cmp.refindi = function () {
        var url = '/pmkpi/program/prjindex/refindi.page';
        var params = {};
        params.proguid = _proguid;
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.fromtype = "tree";
        params.showtab = showtab;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, width, height, "引用指标");
    }

    /**
     * 参考历年指标
     */
    _cmp.calendarindex = function () {
        var url = '/pmkpi/program/prjindex/calendarindex.page';
        var params = {};
        params.proguid = _proguid;
        params.procode = _procode;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, width, height, "参考历年指标");
    }

    /**
     * 清空指标
     */
    _cmp.clear = function () {
        var msg = isGx == 1 ? "确认清空页面所有三级指标(不包括所属一级项目指标)？" : "确认清空页面所有三级指标？";
        Ext.lt.ui.confirm(msg,{icon:"warn"},function(ret){
            if (!ret) return;
            var data = datatable.getRecordSet().toArray();
            if (data && data.length > 0) {
                var guids = [];
                var superguid = [];
                var delguids = [];//原来存在要物理删除的数据
                var deldatas = [];
                for (var i = 0; i < data.length; i++) {
                    if (data[i]["levelno"] == 3) {
                        guids.push(data[i]["guid"]);
                        if (superguid.indexOf(data[i]["superid"]) < 0) {
                            superguid.push(data[i]["superid"]);
                        }
                    }
                    if (data[i]["levelno"] == "3" && data[i].isfromparent != "1") {
                        delguids.push(data[i]["guid"]);
                        deldatas.push(data[i]);
                    }
                }
                if (delguids.length > 0) { //记录整体还是年度删除的数据.
                    var tempArr = [];
                    if (_curtab == "total") { //总体
                        tempArr = tabcomps["del#total"];
                        tabcomps["del#total"] = tempArr.concat(delguids); //总体删除
                    } else {
                        tempArr = tabcomps["del#year"];
                        tabcomps["del#year"] = tempArr.concat(delguids); //年度删除
                    }
                }
                datatable.removeData(deldatas);
                if (superguid.length > 0) { //判断是否还有下级科目，没有isleaf置1
                    _cmp.upSuperIslef(superguid);
                }
                var tempdata = datatable.getAllData();
                var yearflag = "";
                for (var i=0; i<tempdata.length; i++) {
                    if (tempdata[i].levelno == 3 && tempdata[i].yearflag) {
                        yearflag = tempdata[i].yearflag;
                        break;
                    }
                }
                if (yearflag == "1" || (yearflag == "" && _curtab == "total")){
                    tabcomps["#total"] =Ext.lt.cloneobj(tempdata);
                } else if (yearflag == "0" || (yearflag == "" && _curtab == "year")) {
                    tabcomps["#year"] =Ext.lt.cloneobj(tempdata);
                }
            }
        })
    }

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable', 'buildLineStyle', function (paramobj) {
        var rowdata = paramobj.rowdata;
        if (rowdata.levelno != 3 || (_isedittotal == "1" && _curtab == "total")) {
            paramobj.style = ' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

    /**
     * 项目库查询明细，构建多年度绩效查询.
     * @param curryear -- 当前年度.
     */
    _cmp.laypopupyear = function (curryear) {
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
                    params.province = config["province"];
                    params.procode = _procode;
                    params.proguid = _proguid; //有的年度在总体录入，根据项目guid区分.
                    params.adjadd = adjadd;
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
        // params.adjadd = adjadd;
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

    _cmp.queryCurYearperf = function (year) {
        var params = {};
        params.province = config["province"];
        params.procode = _procode;
        params.proguid = _proguid; //有的年度在总体录入，根据项目guid区分.
        params.year = year;
        params.adjadd = adjadd;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "getYearIndicator", params, function (obj) {
                datatable.setDatas(obj.data);
                setTimeout(function () {
                    if(_ischeckweight){
                        var superid = "";
                        for (var i = 0; i < obj.data.length; i++) {
                            var d = obj.data[i];
                            if (d.levelno == 3) {
                                if (d.superid != superid) {
                                    gatherWeight(d.superid,"actualweight");
                                }
                                superid = d.superid;
                            }
                        }
                    }
                    amtTotal(datatable);
                }, 500);
                Ext.lt.ui.loadingClose();
            }, function (err) {
                alert(err);
            }
        );
    }

    /**
     * 纳入指标库
     */
    _cmp.intoindexlib = function (btnobj) {
        var datas = datatable.getSelected();
        if(datas.length == 0){
            Ext.lt.pmkpi.alert("请选择纳入数据！",function(){});
            return;
        }
        if (!_cmp.checkAll(datas)) return;//先校验
        //处理指标名称、指标值字段 特殊字替换
        for (var a = 0, tleni = datas.length; a < tleni; a++) {
            if(datas[a].levelno == "3"){
                //校验空格
                if (!perfcommon.checkSpaceValue(datas[a],"总体绩效指标-第" + (datas[a]["_sortid"] + 1) + "行","datatable")){
                    return
                }
                if (_isNINGXIA && datas[a]['indsource'] == '2') {
                    Ext.lt.pmkpi.alert("请选择新增指标进行纳入！", {timeout: 1}, function () {
                    });
                    Ext.lt.ui.loadingClose();
                    return false;
                }
            }
        }
        var proinfo;
        try {
            // 项目库嵌套项目基本信息editform
            proinfo = parent.editform.getEditFormValues();
        } catch (e) {
            try {
                proinfo = parent.parent.editform.getEditFormValues();
            } catch (e) {
                proinfo = {};
            }
        }
        var params = {};
        if(proinfo.agency_code == undefined){
            params.agency_code = Ext.lt.getparam("saveAgency");
            var pro_code = Ext.lt.getparam("procode");
            var prolist =parent.parent.dataTable.getRecordset().toArray();
            var pro_name ="";
            for (var i = 0; i < prolist.size; i++) {
                if(pro_code == prolist[i].PRO_CODE){
                    pro_name = prolist[i].PRO_NAME;
                }
            }
            params.pro_name = encodeURIComponent(pro_name);
        }else{
            params.agency_code = proinfo.agency_code;
            params.pro_name = encodeURIComponent(proinfo.pro_name);
        }
        var btnconfig = eval("(" + btnobj.config + ")");
        var url = '/pmkpi/intoindexlib/index.page';
        params.bustype = "program";
        params.workflow = btnconfig.workflow;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, width, height, "纳入指标库");
    }

    return _cmp;


}

/**
 * 动态改变列的属性.
 * @param rs
 * @param col
 */
function doMapper(rs, col) {
    var mapping = [];
    var columns = [];
    for (var i = 0; i < rs.size(); i++) {
        var arr = [];
        arr.push(rs[i].guid);
        arr.push(rs[i].code);
        arr.push(rs[i].name);
        columns.push(arr);
        mapping[rs[i].code] = arr;
    }
    col.mapping = mapping;
    col.mapper = {};
    col.mapper.columns = ['guid', 'code', 'name', 'supcode', 'pinyin'];
    col.mapper.datas = columns;
    col.mapper.regs = ['#guid', '#code', '#name', '#supcode', '#pinyin'];
    col.mapper.default_column = 'code';
    col.format = '#name';
}

function amtTotal(table) {
    if (table.getSumobj()) {
        var totalrow = table.getRecordset();
        var sumweight = 0;
        var sumactualweight = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for (var i = 0; i < len; i++) {
            if ((rowarr[i].isleaf == "1" || rowarr[i]._isleaf == "1") && rowarr[i].levelno == "3") {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                sumweight += parseFloat(weight);
                var actualweight = rowarr[i]["actualweight"] ? rowarr[i]["actualweight"] : 0;
                sumactualweight += parseFloat(actualweight);
            } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                sumweight += parseFloat(weight);
                var actualweight = rowarr[i]["actualweight"] ? rowarr[i]["actualweight"] : 0;
                sumactualweight += parseFloat(actualweight);
            }
        }
        _weight_sum = (sumweight ? sumweight.toFixed(2) : "0.00");
        var totalrs = {};
        totalrs["weight"] = sumweight == 0 ? "" : sumweight.toFixed(2);
        totalrs["actualweight"] = sumactualweight == 0 ? "" : sumactualweight.toFixed(2);
        totalrs.datatable_do_sum = true;
        table.getClockRowSet().setData(totalrs, 0);
        if ((totalrow.size && totalrow.size() > 0) || (totalrow.length && totalrow.length > 0)) {
            table.reflashdata();
        }
    }
}

/**
 *
 * @param hidebtns
 */
function newApplyHideBtns(hidebtns) {
    if (toolbutton) {
        var buttons = toolbutton.cfg.data.buttons;
        for (var i = 0, length = buttons.length; i < length; i++) {
            var btn = buttons[i];
            if (btn.name != "引用指标" && btn.name != "清空指标" && btn.name != "复制总体绩效指标" && btn.name != "复制总体绩效目标（不带指标值）" && btn.name != "复制年度绩效指标" && btn.name!="获取最新一级项目指标"){
                hidebtns += "," + btn.name;
            }
            //修改为隐藏显示
            if (("," + hidebtns + ",").indexOf("," + btn.name + ",") != -1) {
                toolbutton.hidden(btn.name);
            } else if (btn.isvisiable == 1) {
                toolbutton.unHidden(btn.name);
            }
        }
    }
}

Ext.lt.message.hook("toolbutton","beforecreatbtn",function(obj){
    _isfrombdm =  Ext.lt.getparam("isfrombdm");
    if(_isfrombdm == "1") {// 预算编制页面增加单独的保存按钮
        var savebtn = {};
        savebtn.code ="save";
        savebtn.name ="保存";
        savebtn.title ="保存";
        savebtn.action ="Ext.lt.bus.ui.clickwrapper";
        savebtn.oriaction = "prjtreeindex.save";
        obj.data.buttons.unshift(savebtn);
    }
})