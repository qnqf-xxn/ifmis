if (!Ext)
    Ext = {};
if (!Ext.lt)
    Ext.lt = {};
if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
 var datasmap = {};
var _procode;
var _treeid;
Ext.lt.pmkpi.tragoalandindex = function (config, serviceid) {
    var _cmp = {};
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _viewtype = config["viewtype"]; //修改还是查看
    _procode = config["procode"];//项目编码
    var ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
    var _busguid = config.busguid;//审核定义guid
    var _signs = config.signs;
    var iframeurl = config.iframeurl;//嵌套url
    var hideIframeHtml = "";
    var _indexdatas = [];
    var _goaldata = [];
    var _submofdatas;
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol + "//" + document.location.host + "/" + iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    }
    var isFirst = true;

    //页面加载完成后执行
    $(function () {
        perfcommon.initDatatable();
        _cmp.setTableColum();
        if (hideIframeHtml != null && hideIframeHtml != "") {
            $("#datatable").append(hideIframeHtml);
        }
        if (datatable.config["remark"] && datatable.config["remark"] != null) {
            $('.busnomalbtn').append("<p title='' style=\"float:right;margin:0 10px 0 15px;color: red;\" class=\"layui-text\">" + datatable.config["remark"] + "</p>");
        }
        if (_viewtype == "query") {
            perfcommon.editSetdisabled(editform);
            perfcommon.changToolShowbuttont("expdata")
            // document.getElementById("toolbutton").style.display = "none";
        }
        _submofdatas = lefttree.qtree.getAllData();
        _cmp.query();
        if (datasmap.submofs && datasmap.submofs.length > 0) {
            _cmp.queryiframedastas();
            //先把未填报左侧树标红，如果末级填报，非末级未填报，则末级会同步标红，所以再次循环，把填报过的数据改为黑色
            for (var i=0; i<datasmap.submofs.length; i++) {
                var node = lefttree.qtree.getNode(datasmap.submofs[i]);
                if (node) {
                    $(node).find("FONT").css("color", "red");
                }
            }
        } else {
            if (!_indexdatas || _indexdatas.length == 0) {
                _indexdatas = datasmap.indexdatas;
                if (datasmap.indexdatas) {
                    _indexdatas.size = datasmap.indexdatas.length;
                }
            }
            if (!_goaldata || _goaldata.length == 0) {
                _goaldata = datasmap.goaldata;
            }
        }
        parent._isQuery = true;
        isFirst = false;
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    _cmp.setTableColum = function () {
        var cols = datatable.getCols(); //获取列表所有列
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            if (col.colcode == "isallowedit" || col.colcode == "onlyself" || col.colcode == "sumtype") {//广西 隐藏二级项目的[是否允许修改指标值]列
                col.display = false;
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 获取年度绩效目标、指标数据
     */
    Ext.lt.pmkpi.queryiframedastas = function () {
        _cmp.queryiframedastas();
    }

    /**
     * 获取嵌套页签年度目标、指标数据
     */
    _cmp.queryiframedastas = function () {
        var indexdatas;
        var goaldata;
        try {
            //项目库嵌套
            var iframes = window.parent.document.getElementById("dcdatatable").childNodes;
            for (var i=0; i<iframes.length; i++) {
                var iframe = iframes[i];
                if (iframe && iframe.contentDocument) {
                    var url = iframe.contentDocument.URL;
                    if (url) {
                        var f = url.indexOf("/pmkpi/");
                        var l = url.lastIndexOf(".page");
                        url = url.substring(f,l);
                        if (iframe.contentWindow) {
                            if (url == "/pmkpi/program/report/treeindex") {
                                if (iframe.contentWindow._curtab == "year") {
                                    indexdatas = iframe.contentWindow.datatable.getRecordSet().toArray();
                                } else {
                                    indexdatas = iframe.contentWindow.tabcomps["#year"];
                                }
                            } else if (url == "/pmkpi/program/report/protabgoal") {
                                if (iframe.contentWindow._curtab == "year") {
                                    goaldata = iframe.contentWindow.editform.getEditFormValues();
                                } else {
                                    goaldata = iframe.contentWindow.tabcomps["#year"];
                                }
                                if (goaldata && (!goaldata.kpi_target || goaldata.kpi_target == "")) {
                                    goaldata = undefined;
                                }
                            }
                        }
                    }
                }
            }
        } catch (e) {
            //开发环境绩效系统
            var iframes = window.parent.document.getElementsByClassName("bd_main")[0].childNodes;
            for (var i=0; i<iframes.length; i++) {
                var iframe = iframes[i];
                if (iframe && iframe.childNodes && iframe.childNodes[0] && iframe.childNodes[0].contentDocument) {
                    var url = iframe.childNodes[0].contentDocument.URL;
                    if (url) {
                        var f = url.indexOf("/pmkpi/");
                        var l = url.lastIndexOf(".page");
                        url = url.substring(f,l);
                        if (iframe.contentWindow) {
                            if (url == "/pmkpi/program/report/treeindex") {
                                if (iframe.contentWindow._curtab == "year") {
                                    indexdatas = iframe.contentWindow.datatable.getRecordSet().toArray();
                                } else {
                                    indexdatas = iframe.contentWindow.tabcomps["#year"];
                                }
                            } else if (url == "/pmkpi/program/report/protabgoal") {
                                if (iframe.contentWindow._curtab == "year") {
                                    goaldata = iframe.contentWindow.editform.getEditFormValues();
                                } else {
                                    goaldata = iframe.contentWindow.tabcomps["#year"];
                                }
                                if (goaldata && (!goaldata.kpi_target || goaldata.kpi_target == "")) {
                                    goaldata = undefined;
                                }
                            }
                        }
                    }
                }
            }
        }
        //页面获取不到时，展示库里的，深度克隆，才能保证点击页签切换后，不会修改前面页签填报过的目标、指标，深度克隆，同时要给数据长度，用以后面循环
        if (!indexdatas || indexdatas.length == 0) {
            _indexdatas = datasmap.indexdatas;
            if (datasmap.indexdatas) {
                _indexdatas.size = datasmap.indexdatas.length;
            }
        } else {
            _indexdatas = $.extend(true, {}, indexdatas);
            _indexdatas.size = indexdatas.length;
        }
        if (!goaldata || goaldata.length == 0) {
            _goaldata = datasmap.goaldata;
        } else {
            _goaldata = $.extend(true, {}, goaldata);
        }
        if (_viewtype != "query" && (!_indexdatas || _indexdatas.size == 0 || !_goaldata)) {
            alert("请填写年度绩效目标、指标后再填写“细化区域年度绩效”！");
            return;
        }
    }

    /**
     * 页面初始化.
     */
    _cmp.query = function () {
        var params = {};
        params.procode = _procode;
        params.submofdatas = _submofdatas;
        Ext.lt.ui.loadingShow();
        var datas = Ext.lt.RCP.asyncall(serviceid, "getDatas", params);
        datasmap = datas;
        Ext.lt.ui.loadingClose();
    }

    /**
     * 点击左侧树.
     */
    Ext.lt.message.hook("left", "click",function(obj){
        if (_viewtype != "query" && ((datasmap.submofs && datasmap.submofs.length > 0) && (!_indexdatas || _indexdatas.size == 0 || !_goaldata))) {
            alert("请填写年度绩效目标、指标后再填写“细化区域年度绩效”！");
            return;
        }
        var treeNode = obj.node.data;
        if (treeNode && datasmap[treeNode.guid] && _treeid != treeNode.guid){
            if (_viewtype != "query") {
                //先校验
                if (_treeid && (!_cmp.check() || !editform.check())){
                    var node = lefttree.qtree.getNode(_treeid);
                    if(node != null) {
                        lefttree.qtree.selectedNode(node);
                    }
                    return;
                }
                var params = {};
                var goal =  editform.getEditFormValues();
                var indexs = datatable.getRecordSet().toArray();
                if (indexs.length > 0 && Object.keys(goal).length > 0) {
                    if (goal.sub_mof_div_code != _treeid || indexs[0].sub_mof_div_code != _treeid) {
                        alert("请数据加载完成后再次切换区划！");
                        var node = lefttree.qtree.getNode(_treeid);
                        if(node != null) {
                            lefttree.qtree.selectedNode(node);
                        }
                        datatable.reflashdata();
                        return;
                    }
                    params.goal = goal;
                    params.indexs = indexs;
                    datasmap[_treeid] = params;
                }
            }
            var params = datasmap[treeNode.guid];
            datatable.setDatas(params.indexs);
            editform.synchEditformByObj(params.goal);
            _treeid = treeNode.guid;
        } else if (_viewtype != "query" && treeNode && !datasmap[treeNode.guid]){
            if (_treeid && _treeid != treeNode.guid) {
                //先校验
                if (!_cmp.check() || !editform.check()){
                    var node = lefttree.qtree.getNode(_treeid);
                    if(node != null) {
                        lefttree.qtree.selectedNode(node);
                    }
                    return;
                }
                var goal =  editform.getEditFormValues();
                var indexs = datatable.getRecordSet().toArray();
                if (indexs.length > 0 && Object.keys(goal).length > 0) {
                    if (goal.sub_mof_div_code != _treeid || indexs[0].sub_mof_div_code != _treeid) {
                        alert("请数据加载完成后再次切换区划！");
                        var node = lefttree.qtree.getNode(_treeid);
                        if(node != null) {
                            lefttree.qtree.selectedNode(node);
                        }
                        datatable.reflashdata();
                        return;
                    }
                    var params = {};
                    params.goal = goal;
                    params.indexs = indexs;
                    datasmap[_treeid] = params;
                }
            }
            var indexs = [];
            for (var i=0; i < _indexdatas.size; i++) {
                var map = _indexdatas[i];
                if(map.levelno == 3) {
                    map['guid'] = createUUID().replace(/-/g, '');
                }
                map['sub_mof_div_code'] = treeNode.guid;
                var dataisapply = map['isapply'];
                var dataisallowedit = map['isallowedit'];
                if(dataisallowedit && dataisallowedit == "1" && dataisapply && dataisapply =="1"){//是否允许编辑为是，并且适用的指标值清空
                    map['indexval'] = "";
                    map['kpi_val'] = "";
                }else if (!dataisallowedit){//是否允许编辑为空
                    if(dataisapply && dataisapply =="1" ){
                        map['indexval'] = "";
                        map['kpi_val'] = "";
                    }else  if(dataisapply && dataisapply =="2" ){
                        map['indexval'] = "—";
                        map['kpi_val'] = "—";
                    }
                }
                indexs.push(map);
            }
            _goaldata['guid'] = createUUID().replace(/-/g, '');
            _goaldata['sub_mof_div_code'] = treeNode.guid;
            datatable.setDatas(Ext.lt.cloneobj(indexs));
            editform.synchEditformByObj(_goaldata);
            var params = {};
            params.goal = _goaldata;
            params.indexs = Ext.lt.cloneobj(indexs);
            datasmap[treeNode['guid']] = params;
            _treeid = treeNode.guid;
        } else if (!treeNode) {
            alert("不能点击全部");
            var node = lefttree.qtree.getNode(_treeid);
            if(node != null) {
                lefttree.qtree.selectedNode(node);
            }
        } else if (_viewtype == "query" && _treeid != treeNode.guid) {
            datatable.setDatas([]);
            editform.synchEditformByObj({});
            _treeid = treeNode.guid;
        }
        if (_viewtype != "query" && _treeid) {
            var node = lefttree.qtree.getNode(_treeid);
            if (node) {
                if ($(node).find("DIV") && $(node).find("DIV")[0] && $(node).find("DIV")[0].childNodes && $(node).find("DIV")[0].childNodes[0]) {
                    $(node).find("DIV")[0].childNodes[0].style='black';
                }
            }
        }
    });

    _cmp.updaedata = function () {
        if (_submofdatas.length == 0) {
            alert("未获取到下级区划，请确认！");
            return;
        }
        Ext.lt.ui.confirm("获取最新指标会清除页面已填报内容！", {icon: "warn"}, function (ret) {
            if (ret) {
                var params = {};
                params.submofdatas = _submofdatas;
                params.procode = _procode; //项目编码
                Ext.lt.ui.loadingShow();
                if (!_submofdatas || _submofdatas.length > 0) {
                    Ext.lt.RCP.asyncall(serviceid, "updaedata", params);
                }
                Ext.lt.ui.loadingClose();
                _cmp.queryiframedastas();
                var submofdivs = [];
                for (var i=0; i < _submofdatas.length; i++) {
                    delete datasmap[_submofdatas[i].guid];
                    submofdivs.push(_submofdatas[i].guid);
                }
                //取消页签选中状态
                var node = lefttree.qtree.getNode(_treeid);
                if (node) {
                    $(node).find("FONT").attr('class', '.folderqtree .link');
                }
                datasmap['submofs'] = submofdivs;
                _treeid = undefined;
                datatable.setDatas([]);
                editform.synchEditformByObj({});
                for (var i=0; i<_submofdatas.length; i++) {
                    var node = lefttree.qtree.getNode(_submofdatas[i].guid);
                    if (node) {
                        $(node).find("FONT").css("color", "red");
                    }
                }
            }
        })
    }

    /**
     * 保存方法.
     */
    _cmp.save = function (obj) {
        if (!_indexdatas || _indexdatas.size == 0 || !_goaldata) {
            return {success : true};
        }
        if (_treeid) {
            if (datatable.getEditor()){
                datatable.closeEdit();
            }
            if (!_cmp.check() || !editform.check()) return false;//先校验
            if (!datasmap || Object.keys(datasmap).length === 0) return {success: true};
            //最后一次，更新到数组对象里
            var goal = editform.getEditFormValues();
            var indexs = datatable.getRecordSet().toArray();
            var data = {};
            data.goal = goal;
            data.indexs = indexs;
            datasmap[_treeid] = data;
            Object.keys(datasmap).forEach(key => {
                var node = lefttree.qtree.getNode(key);
                if (node) {
                    var goaldata = datasmap[key].goal;
                    goaldata.kpi_target = convertStr(goaldata.kpi_target);
                    var indexsdata = datasmap[key].indexs;
                    if (indexsdata && indexsdata.length > 0) {
                        for (var a = 0, leni = indexsdata.length; a < leni; a++) {
                            if(indexsdata[a].levelno == "3") {
                                if (!perfcommon.checkSpaceValue(indexsdata[a],"绩效指标-第" + (indexsdata[a]["_sortid"] + 1) + "行","datatable")) return;//校验空格
                                indexsdata[a].name = convertStr(indexsdata[a].name);
                                indexsdata[a].indexval = convertStr(indexsdata[a].indexval);
                                indexsdata[a].kpi_val = convertStr(indexsdata[a].kpi_val);
                            }
                        }
                    }
                }
            });
            var params = {};
            params.datas = datasmap;
            params.busguid = _busguid;
            params.procode = _procode; //项目编码
            Ext.lt.ui.loadingShow();
            var rs = Ext.lt.RCP.asyncall(serviceid, "saveGoalAndIndex", params);
            Ext.lt.ui.loadingClose();
            return rs;
        } else {
            return {success : true};
        }
    }

    _cmp.check = function () {
        var datas = datatable.getRecordSet().toArray();
        if (datas.length == 0) {
            Ext.lt.pmkpi.alert("区划列表数据未加载，请刷新页面后重试！", {timeout: 1}, function () {
            });
            return false;
        }
        var cols = datatable.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if (datas[i]["levelno"] == 3) {
                if(datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")){
                    Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。", {timeout: 1}, function () {
                    });
                    return;
                }
                for (var j = 0,lenj = cols.length; j < lenj; j++) {
                    if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                        var value = datas[i][cols[j].colcode];
                        if (value == null || value == "" || ("" + value).trim().length == 0) {
                            Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。", {timeout: 1}, function () {
                            });
                            Ext.lt.ui.loadingClose();
                            return false;
                        }
                        if (cols[j].colcode == 'indexval' && value.match(RegExp("[*_-]")) != null) {
                            Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。", {timeout: 1}, function () {
                            });
                            return false;
                        }
                        if ((cols[j].colcode == 'name') && (value == "-" || value == "_" || value == "*")) {
                            Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。", {timeout: 1}, function () {
                            });
                            Ext.lt.ui.loadingClose();
                            return false;
                        }
                    }
                }
            }
        }
        return true;
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
            if (col["colcode"] == "obligate1") {
                col.display = false;
            }
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
                    if (rs.levelno != "3" || rs.isapply == "2" || rs.isallowedit == "2") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.isapply == "2" || d.isallowedit == "2") {
                        return false;
                    }
                    el.innerText = d.indexval != undefined ? d.indexval : '';
                    table.getCol(c).mapping = null;
                    table.nowtype = "input";
                    table.getCol(c).format = "";
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10') {
                        if (d.indexval && !checkReferencepole(d.indexval)) {
                            d.indexval = '';
                            return false;
                        }
                    }
                    if (d.indexval != '') {
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
                    if (d.levelno != "3") {
                        return false;
                    }
                    isapply = d.isapply;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.isallowedit != "2") {
                        if (d.isapply == "2") {
                            d.indexval = "—";
                        } else if (isapply == "2" && d.isapply == "1") {
                            d.indexval = "";
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
                        cols[i].style = 'style="background-color:#f2f2f2;"';
                        cols[i].oneditstart = function (table, e, l, c, d) {
                            if (d.levelno != "3" || datatable.getCol(l).colcode != "indexval" || datatable.getCol(l).colcode != "isapply") {
                                return false;
                            }
                        }
                    }
                }
            }
        }
    });

    /**
     * 导入
     * @param obj
     */
    _cmp.impdata = function (obj) {
        if (_submofdatas.length == 0) {
            alert("未获取到下级区划，请确认！");
            return;
        }
        if (_viewtype != "query" && ((datasmap.submofs && datasmap.submofs.length > 0) && (!_indexdatas || _indexdatas.size == 0 || !_goaldata))) {
            alert("请填写年度绩效目标、指标后再导入“细化区域年度绩效”！");
            return;
        }
        var checksub = true;
        for (var i=0; i<_submofdatas.length; i++) {
            var submofcode = _submofdatas[i].guid;
            var subdatas = datasmap[submofcode];
            if (subdatas && subdatas.indexs && subdatas.indexs.length > 0) {
                var indexs = subdatas.indexs;
                if (indexs.length != _indexdatas.size) {
                    checksub = false;
                    break;
                }
                var sublist = [];
                for (var k=0; k<indexs.length; k++) {
                    sublist.push(indexs[k].name);
                }
                for (var j=0; j<_indexdatas.size; j++) {
                    var name = _indexdatas[j].name;
                    if (sublist.indexOf(name) == -1) {
                        checksub = false;
                        break;
                    }
                }
            }
            if (!checksub) {
                break;
            }
        }
        if (!checksub) {
            alert("整体年度绩效指标发生了调整，请先点击'获取最新整体绩效指标'后，再进行导入！");
            return;
        }
        var config = eval('(' + obj.config + ')');
        var params = {};
        params.beanid = "pmkpi.prjindex.PrjTraGoalAndIndexBOTX";
        params.impexpcode = "traindex";//导出编码
        params.procode = _procode;
        params.busguid = _busguid;
        params.expfilename = config.expfilename + ".xls";//导出模板文件名称
        var submofdivcodes = "";
        for (var i=0; i<_submofdatas.length; i++) {
            submofdivcodes += _submofdatas[i].guid + ",";
        }
        if (submofdivcodes && submofdivcodes.length > 0) {
            submofdivcodes = submofdivcodes.substring(0, submofdivcodes.length - 1);
        }
        params.submofdatas = submofdivcodes;
        impexp.imp(params, function (){
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.pmkpi.impsucess();
        });
    }

    Ext.lt.pmkpi.impsucess = function () {
        Ext.lt.pmkpi.alert("导入成功！", function () {
            _cmp.query();
            Object.keys(datasmap).forEach(key => {
                var node = lefttree.qtree.getNode(key);
                if (node) {
                    $(node).find("FONT").css("color", "black");
                }
            });
            if (_treeid) {
                datatable.setDatas(datasmap[_treeid]["indexs"]);
                editform.synchEditformByObj(datasmap[_treeid]["goal"]);
                var node = lefttree.qtree.getNode(_treeid);
                if (node) {
                    $(node).find("FONT").css("color", "#fff");
                }
            }
        });
    }

    _cmp.expdata = function(obj){
        if (_submofdatas.length == 0) {
            alert("未获取到下级区划，请确认！");
            return;
        }
        if (_viewtype != "query" && ((datasmap.submofs && datasmap.submofs.length > 0) && (!_indexdatas || _indexdatas.size == 0 || !_goaldata))) {
            alert("请填写年度绩效目标、指标后再导出“细化区域年度绩效”！");
            return;
        }
        var checksub = true;
        for (var i=0; i<_submofdatas.length; i++) {
            var submofcode = _submofdatas[i].guid;
            var subdatas = datasmap[submofcode];
            if (subdatas && subdatas.indexs && subdatas.indexs.length > 0) {
                var indexs = subdatas.indexs;
                if (indexs.length != _indexdatas.size) {
                    checksub = false;
                    break;
                }
                var sublist = [];
                for (var k=0; k<indexs.length; k++) {
                    sublist.push(indexs[k].name);
                }
                for (var j=0; j<_indexdatas.size; j++) {
                    var name = _indexdatas[j].name;
                    if (sublist.indexOf(name) == -1) {
                        checksub = false;
                        break;
                    }
                }
            }
            if (!checksub) {
                break;
            }
        }
        if (!checksub) {
            alert("整体年度绩效指标发生了调整，请先调整细化区域绩效后，再进行导出!");
            return;
        }
        Ext.lt.ui.loadingShow();
        var config = eval('(' + obj.config + ')');
        var params = {};
        params.beanid = "pmkpi.prjindex.PrjTraGoalAndIndexBOTX";
        params.impexpcode = "traindex";//导出编码
        params.procode = _procode;
        params.busguid = _busguid;
        params.expfilename = config.expfilename + ".xls";//导出模板文件名称
        params.btncode = obj.code;
        var submofdivcodes = "";
        for (var i=0; i<_submofdatas.length; i++) {
            submofdivcodes += _submofdatas[i].guid + ",";
        }
        if (submofdivcodes && submofdivcodes.length > 0) {
            submofdivcodes = submofdivcodes.substring(0, submofdivcodes.length - 1);
        }
        params.submofdatas = submofdivcodes;
        params.expimp = "impmodel";
        Ext.lt.RCP.down("pmkpi.perfcommon.impexp.ImpExpAComponet", 'impexp',params,function(resp){
            alert(resp);
        });
        setTimeout(function(){
            Ext.lt.ui.loadingClose();
        },2000);
    }

    return _cmp;


}
