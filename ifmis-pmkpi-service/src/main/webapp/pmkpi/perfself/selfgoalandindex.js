if (!Ext)
    Ext = {};
if (!Ext.lt)
    Ext.lt = {};
if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if (!Ext.lt.pmkpi.self)
    Ext.lt.pmkpi.self = {};


var serviceid;
var _mainguid;
var _saveAgency;
var _viewtype;
var _dxzbsource;//定性指标数据源
var _weight_sum;
var _isHebei;
Ext.lt.pmkpi.self.goalandindex = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,//项目guid
        _mainguid = config.mainguid,//
        _taskguid = config.taskguid,//任务guid
        _qualtype = config.qualtype, //定性指标类型：1-下拉框（默认）；2-手动输入；
        _prolev = config.prolev,//项目级次
        _saveAgency = config.saveAgency,//单位
        _busguid = config.busguid,//审核定义guid
        _viewtype = config.viewtype, //区分是否查询:query是查询，其他可修改
        _signs = config.signs,//计算符号
        _bustype = config.bustype,//任务类型
        _procode = config.procode,//项目编码
        _istianjin = config.isTianjin, //是否天津模式
        _dxzbsource = config.dxzbsource,
        _ismergeindex = config.ismergeindex,
        _isSx = config.isSX,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _defquerysql = {},
        _isdisplay, //[序时进度预警]列是否显示,不显示时,[偏差原因分析],不校验规则
        _indexvaldatas = config.indexvaldatas,
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;
        serviceid = service;
        var cmp = {};
        var firstpage = true;



    $(function () {
        if (!_defquerysql["tipmark"] || _defquerysql["tipmark"] == null || _defquerysql["tipmark"] == ""){
            changToolbuttonStatus(toolbutton,parseInt(obj.ordernum),"评分说明");
        }
        if (_viewtype == "query") {
            changToolbuttonStatus(toolbutton,parseInt(obj.ordernum),"获取最新目标");
            //document.getElementById("toolbutton").style.display = "none";
        }
        common.initDatatable(maintable); //初始化加载主表
        common.initDatatable(); //初始化加载子表
        cmp.mainquery(true);
        if (_viewtype == "query") {
            for(var i=2; i<maintable.getCols().length; i++){
                maintable.getCols()[i].edit = false;
            }
            for(var i=2; i<datatable.getCols().length; i++){
                datatable.getCols()[i].edit = false;
            }
            maintable.redraw();
            datatable.redraw();
            $("#add").hide();
            $("#del").hide();
        }
        cmp.resiztable();

    })

    /**
     * 主表查询.
     * goaltype -- 1 中长期， 0 年度
     */
    cmp.mainquery = function (isquery){
        if (firstpage || parent._issavetmp){
            var params = {};
            params.tablesql = _defquery;
            params.orderby = _orderby;
            params.tablecode = _tablecode;
            params.mainguid = _mainguid;
            params.proguid = _proguid;
            params.bustype = _bustype;
            params.procode = _procode;
            params.compconfigid = "maintable";
            params.url = maintable.config.pageurl;
            params.viewtype = _viewtype;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(serviceid , "getMainDatas", params, function(rs){
                yeargoals = rs.yeargoals;
                maintable.setDatas(yeargoals);
                maintable.clearSelected();
                datatable.setDatas([]);
                setMidSaveHidButtons(rs);
                Ext.lt.ui.loadingClose();
                if (isquery) {
                    setTimeout(function(){
                        parent._isQuery = true;
                    },500);
                }
            },function(){
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert('目标查询失败！',function(){
                });
            });
        } else {
            maintable.setDatas(yeargoals);
            maintable.clearSelected();
            datatable.setDatas([]);
        }
        firstpage = false;
    }

    /**
     * 主表的选中单选事件
     */
    Ext.lt.message.hook("fasp2datatable", "onRadioClick", function (d) {
        //处理子表数据保存到主表上
        var datas = datatable.getRecordSet().toArray();
        var isdata = false;
        for(var i=0; i<datas.length; i++) {
            if (datas[i].isleaf == "1") {
                isdata = true;
                break;
            }
        }
        if (datas != null && datas.length > 0 && isdata) {
            var goalguid = datas[0].goalguid;
            var mainsel = maintable.getRecordset().query({guid: goalguid});
            if (mainsel.length > 0) {
                mainsel[0]["#indexs"] = datas;
            }
        }
        cmp.query(d[4]);
        /*var selectDatas = maintable.getSelected();
        cmp.query(selectDatas[0]);*/

    });

    /**
     * 子表查询
     * @param d -- 选中数据.
     */
    cmp.query = function (d) {
        var indexs = d["#indexs"];
        var isdata = false;
        for(var i=0; i<indexs.length; i++) {
            if (indexs[i].isleaf == "1") {
                isdata = true;
                break;
            }
        }
        if (indexs.length > 0 && isdata) {
            datatable.setDatas(indexs);
            setTimeout(function () {
                var superid = "";
                for (var i = 0; i < indexs.length; i++) {
                    var d = indexs[i];
                    if (d.levelno == 3) {
                        if (d.superid != superid) {
                            gatherScore(d.superid);
                            gatherWeightAll(d.superid);
                        }
                        superid = d.superid;
                    }
                }
                amtTotal(datatable);
            }, 500);
        } else {
            var params = {};
            params.mainguid = d.mainguid;
            params.goalguid = d.guid;
            params.procode = _procode;
            var goaldatas = maintable.getRecordset().query({guid: d.guid});
            params.goaldatas = goaldatas;
            Ext.lt.RCP.call(serviceid, "getSubData", params, function (rs) {
                var goaldata = rs.yeargoals;
                var indexdatas = goaldata[0]['#indexs'];
                datatable.setDatas(indexdatas);
                goaldatas[0]["#indexs"] = indexdatas;
                setTimeout(function () {
                    var superid = "";
                    for (var i = 0; i < indexdatas.length; i++) {
                        var d = indexdatas[i];
                        if (d.levelno == 3) {
                            if (d.superid != superid) {
                                gatherScore(d.superid);
                                gatherWeightAll(d.superid);
                            }
                            superid = d.superid;
                        }
                    }
                    amtTotal(datatable);
                }, 500);
            }, function () {
                Ext.lt.ui.alert('查询失败！', function () {
                });
            });
        }
    }


    cmp.save = function () {
        //1 表格切换之前先保存一下子表到主表行。
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = maintable.getRecordset().query({guid: goalguid});
            if (mainsel.length > 0) {
                mainsel[0]["#indexs"] = datas;
            }
        }
        //2将主表保存到全局变量上
        yeargoals = maintable.getRecordSet().toArray();
        if (!cmp.checkall()) return false;//先校验
        var params = {};
        params.datas = maintable.getRecordSet().toArray();
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.proguid = _proguid;
        params.procode = _procode;
        params.taskguid = _taskguid;
        params.compconfigid = "maintable";
        params.url = maintable.config.pageurl;
        var rs = Ext.lt.RCP.asyncall(serviceid, "savePrjIndex", params);
        if (rs && rs.success) {
            cmp.mainquery();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        //1 表格切换之前先保存一下子表到主表行。
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = maintable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        //2将主表保存到全局变量上
        yeargoals = maintable.getRecordSet().toArray();
        var params = {};
        params.mainguid = _mainguid;
        params.data = maintable.getRecordSet().toArray();
        params.url = maintable.config.pageurl;
        params.componentid = maintable.config.server;
        params.compconfigid = "maintable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.mainquery();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        params.url = maintable.config.pageurl;
        params.componentid = maintable.config.server;
        params.compconfigid = "maintable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.mainquery();
        }
        return rs;
    }

    cmp.checkall = function () {
        for (var k = 0, lenk = yeargoals.length; k < lenk; k++) {
            var datas = yeargoals[k]["#indexs"];
            var cols = datatable.getCols();
            for (var i = 0, leni = datas.length; i < leni; i++) {
                for (var j = 0, lenj = cols.length; j < lenj; j++) {
                    if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                        var value = datas[i][cols[j].colcode];
                        if (value == null || value == "" || ("" + value).trim().length == 0) {
                            alert("第" + (k + 1) + "行目标的第" + (datas[i]["_sortid"] + 1) + "行的绩效指标" + cols[j].alias + "为必录项，必须有值。");
                            return false;
                        }
                    }
                }
                //处理计算符号为定性，单位不填情况
                if (datas[i]["computesign"] != "6" && (datas[i]["meterunit"] == "" || datas[i]["meterunit"] == null || datas[i]["meterunit"] == undefined) && datas[i]["levelno"] == 3) {
                    alert("第" + (k + 1) + "行目标的第" + (datas[i]["_sortid"] + 1) + "行的绩效指标单位必须有值。");
                    return false;
                }
            }
        }
        return true;
    }

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = maintable.uiconfig;
        _defquerysql = eval('(' + uiconfig.config + ')');
    });

    cmp.selfrule = function () {
        //评分说明配置
        var tipmark = _defquerysql["tipmark"];
        Ext.lt.ui.alert(tipmark,function(){
        });
    }


    Ext.lt.message.hook("datatable", 'beforesetcols', function (data) {
        var cols = data.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "computesign") { //计算符号
                col.fn = function (l, c, d, val) {
                    var computesignstr = "";
                    for (var i = 0; i < _signs.size(); i++) {
                        if (d.computesign == _signs[i].guid) {
                            computesignstr = _signs[i].name;
                        }
                    }
                    return "<font style=\"margin-left:10px;\">" + computesignstr + "</font>";
                }
            }

            if (col["colcode"] == "indexval") { //指标值
                col.fn = function (l, c, data, col) {
                    if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10" || _ismergeindex != "1") {
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
            }

            if (col["colcode"] == "actualvalue") { // 实际完成值
                col.fn = function (l, c, d, val) {
                    if (d.computesign == "6" || d.computesign == "9" || d.computesign == "10" || _ismergeindex != "1") {
                        var actualvalue = !d.actualvalue ? "" : d.actualvalue;
                        return "<font style=\"margin-left:10px;\">" + actualvalue + "</font>";
                    } else {
                        var computesignstr = "";
                        for (var i = 0; i < _signs.size(); i++) {
                            if (d.computesign == _signs[i].guid) {
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if (d.meterunit) {
                            unit = d.meterunit;
                        }
                        var returnstr = !d.actualvalue ? computesignstr + unit : computesignstr + d.actualvalue + unit;
                        return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3") {
                        return false;
                    }
                    if (d.computesign == "6" || d.computesign == "9" || d.computesign == "10") {
                        doMapper(_dxzbsource, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.actualvalue != undefined ? d.actualvalue : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                        return;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10') {
                        if (!d.actualvalue || d.actualvalue == "") {
                            d.warn = '';
                            return false;
                        }
                        if (!checkReferencepoles(d.actualvalue)) { // 数字校验
                            d.actualvalue = '';
                            d.warn = '';
                            return false;
                        }
                    }
                    if (d.actualvalue && d.actualweight && (d.computesign == "1" || d.computesign == "2" || d.computesign == "3" || d.computesign == "4" || d.computesign == "5")) {
                        Ext.lt.pmkpi.warn(d);
                    }
                    if (d.computesign == "6" && d.actualvalue && d.actualweight) { //校验得分区间
                        Ext.lt.pmkpi.warn(d);
                    }
                }
            }
            if (col["colcode"] == "actualweight") {
                col.fn = function (l, c, data, col) {
                    if (data.isleaf == "0") {
                        var actualweight = 0;
                        if (data.actualweight) {
                            actualweight = data.actualweight;
                        }
                        return "<b>" + Math.round(actualweight * 100) / 100 + "</b>";
                    } else {
                        return data.actualweight ? data.actualweight : 0.00;
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    gatherWeightAll(d.superid); // 一二级汇总
                    amtTotal(datatable);  //汇总到合计行
                    if (d.actualvalue && d.actualweight && (d.computesign == "1" || d.computesign == "2" || d.computesign == "3" || d.computesign == "4" || d.computesign == "5")) {
                        Ext.lt.pmkpi.warn(d);
                    }
                    if (d.computesign == "6" && d.actualvalue && d.actualweight) {
                        Ext.lt.pmkpi.warn(d);
                    }
                }
            }
            if (col["colcode"] == "score") { //得分
                col.fn = function (l, c, data, col) {
                    if (data.isleaf == "0") {
                        var score = 0;
                        if (data.score) {
                            score = data.score;
                        }
                        return "<b>" + Math.round(score * 100) / 100 + "</b>";
                    } else {
                        var score = data.score ? data.score : 0.00;
                        var actualvalue = data.actualvalue ? getPointNum(parseFloat(data.actualvalue)) : 0.00;
                        var indexval = data.indexval ? getPointNum(parseFloat(data.indexval)) : 0.00;
                        if (data.computesign == "1" || data.computesign == "2" || data.computesign == "3") {
                            if (actualvalue >= indexval * 1.2 && indexval != 0) {
                                data.isscoreEdit = 1;
                                return "<a style='color:#FF0000'>" + score + "</a>";
                            } else {
                                data.isscoreEdit = 0;
                            }
                        }
                        return score;
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    var actualweight = d.actualweight ? getPointNum(parseFloat(d.actualweight)) : 0.00;
                    var score = d.score ? getPointNum(parseFloat(d.score)) : 0.00;
                    //处理得分必须小于权重
                    if (score > actualweight) {
                        Ext.lt.ui.alert("得分必须小于权重！", {timeout: 1}, function () {
                        });
                        d.score = 0;
                        return false;
                    }
                    if (d.computesign == "6" && d.actualvalue && d.actualweight) { //校验得分区间
                        qualCheck(d);
                    }
                    gatherScore(d.superid);
                    amtTotal(datatable);
                }
            }

            if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
    });
    /**
     * 初始化加载列表消息
     * @param table
     */
    cmp.initDatatable = function (table) {
        if (!table) {
            table = datatable;
        }
        Ext.lt.message.send("datatable", 'beforesetcols', {
            table: table,
            cols: table.getCols()
        });
        Ext.lt.message.send("busdatatable", 'drawed', table);
    }

    /**
     * 重新刷新表格.
     */
    cmp.resiztable = function () {
        var width = $("#maintable").width;
        maintable.resize(width - 20, _scrHeight * 0.4);
        datatable.resize(width - 20, _scrHeight);
    }

    /**
     * 获取最新的绩效指标、目标数据
     */
    cmp.getindexAndGoal = function () {
        Ext.lt.ui.confirm('系统将自动清除页面已填报目标和指标数据，自评得分、结论信息重新计算(如有该信息需重新保存)，请确认？',null,function(is){
            if(is){
                var params = {};
                params.tablecode = _tablecode;
                params.mainguid = _mainguid;
                params.proguid = _proguid;
                params.bustype = _bustype;
                params.procode = _procode;
                params.compconfigid = "maintable";
                params.url = maintable.config.pageurl;
                params.viewtype = _viewtype;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "getindexAndGoal", params, function(rs) {
                    yeargoals = rs.yeargoals;
                    maintable.setDatas(yeargoals);
                    maintable.clearSelected();
                    datatable.setDatas([]);
                    setMidSaveHidButtons(rs);
                    Ext.lt.ui.loadingClose();

                })
            }
        })
    }

    return cmp;
}



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


/**
 * 定性指标区间规则
 */
function qualCheck(d) {
    var flag = true;
    var params = {};
    var indexname = d.name;
    var parent_sel_rows = datatable.getRecordset().query({guid: d.superid});
    var parent_sel_obj = parent_sel_rows[0];
    var sindexname = parent_sel_obj.name;
    params.warmtype = "selfqualscorecheck"; //正向指标
    params.weight = d.actualweight;//实际权重值
    params.actualvalue = d.actualvalue;//实际完成值
    params.score = d.score;//实际完成值
    var warndata = Ext.lt.RCP.asyncall(serviceid, "getWarn", params);
    flag = false;
    if (warndata && warndata != "1") {
        /**  XX-二级指标名称； MM-三级指标名称
         * 达成年度指标                XX指标：MM指标的实际得分区间为[权重*80%(含)-权重]，请调整后再保存。
         部分达成年度指标并具有一定效果    XX指标：MM指标的实际得分区间为[权重*60%(含)-权重*80%]，请调整后再保存。
         未达成年度指标且效果较差        XX指标：MM指标的实际得分区间为[0-权重*60%]，请调整后再保存。
         */
        d.score = 0;
        Ext.lt.ui.alert(sindexname + "指标：" + indexname + "指标的实际得分区间为[" + warndata + "]，请调整后再保存。", {timeout: 1}, function () {
        });
        return false;
    }
    return flag;
}

/**
 * 权重三级汇总二级然后汇总一级
 * @param superid
 */
function gatherWeightAll(superid) {
    var datas = datatable.getRecordSet().toArray();
    if (superid) {
        if (datas != null && datas.length > 0) {
            var supguid = '';
            var result = 0;
            var guid = '';
            for (var i = 0; i < datas.length; i++) { //计算二级权重汇总
                var selectDatas = datas[i];
                if (superid == selectDatas.guid) {
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if (selectDatas.superid == superid && selectDatas.actualweight && !isNaN(selectDatas.actualweight)) {
                    result += parseFloat(selectDatas.actualweight);
                }
            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    datas[i]['actualweight'] = result == 0.00 ? "" : result.toFixed(2);
                }
            });
            gatherWeightAll(supguid); //递归汇总一级的
        }
    }
    datatable.reflash();
    // datatable.resize(width - 20, _scrHeight);
}

/**
 * 合计列汇总权重和得分
 */
function amtTotal(table) {
    var totalrow = table.getRecordset();
    var weightsumamt = 0;
    var actualweightsumamt = 0;
    var ownscoresumamt = 0;
    var rowarr = totalrow.toArray();
    var len = rowarr.length;
    for (var i = 0; i < len; i++) {
        if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
            var ownscore = rowarr[i]["score"] ? rowarr[i]["score"] : 0.00;
            ownscoresumamt += parseFloat(ownscore);
        }
        if (rowarr[i].levelno == "3") {
            var actualweight = rowarr[i]["actualweight"] ? rowarr[i]["actualweight"] : 0.00;
            actualweightsumamt += parseFloat(actualweight);
        }
        if (rowarr[i].levelno == "1") {
            var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
            weightsumamt += parseFloat(weight);
        }
    }
    var totalrs = {};
    _weight_sum = (weightsumamt ? weightsumamt.toFixed(2) : "0.00");
    totalrs["weight"] = _weight_sum;
    totalrs["actualweight"] = (actualweightsumamt ? actualweightsumamt.toFixed(2) : "0.00");
    totalrs["score"] = (ownscoresumamt ? ownscoresumamt.toFixed(2) : "0.00");
    totalrs.datatable_do_sum = true;
    table.getClockRowSet().setData(totalrs, 0);
    if ((totalrow.size && totalrow.size() > 0) || (totalrow.length && totalrow.length > 0)) {
        table.reflashdata();
    }
    //处理指标权重得分
    var score = totalrs["score"];
    var goalguid = rowarr[0].goalguid;
    var mainsel = maintable.getRecordset().query({guid: goalguid});
    if (mainsel.length > 0) {
        var ratio = (mainsel[0].ratio == 0 ? 0 :mainsel[0].ratio);
        var weightscore = (score == 0? 0 : score * (ratio/100));
        mainsel[0]["weightscore"] = weightscore;
        maintable.reflashdata();
    }
}

/**
 * 只能输入数字校验
 * @param referencepole
 * @returns {boolean}
 */
function checkReferencepoles (str){
    var re = /^(-?\d+)\.?(\d*)$/;//支持录入负数
    if(!re.test(str)){
        Ext.lt.ui.alert("定量指标的指标值为数值！");
        return false;
    }else{
        return true;
    }
}

/**
 * 自评得分计算规则
 * @param d
 */
Ext.lt.pmkpi.warn = function (d) {
    var params = {};
    params.indexval = d.indexval;  //指标值
    params.actualvalue = d.actualvalue;//实际完成值
    //判断实际完成值为负数，默认赋值为0
    if(d.actualvalue < "0"){
        params.actualvalue = "0";//实际完成值赋值为0
    }
    params.weight = d.actualweight;//实际权重值
    /**
     * 正向指标-绩效自评    selfpositiveindex
     * 等于指标-绩效自评    selfequalindex
     * 反向指标-绩效自评    selfreverseindex
     * 定性指标-绩效自评    selfqualitativeindex
     */
    if (d.computesign == "1" || d.computesign == "2") {
        params.warmtype = "selfpositiveindex"; //正向指标
    } else if (d.computesign == "3") { //等于指标
        params.warmtype = "selfequalindex";
    } else if (d.computesign == "4" || d.computesign == "5") { //反向指标
        params.warmtype = "selfreverseindex";
    } else if(d.computesign == "6"){
         params.warmtype = "selfqualitativeindex";
    }
    var warndata = Ext.lt.RCP.asyncall(serviceid, "getWarn", params);
    var parent_sel_rows = datatable.getRecordset().query({guid: d.guid});
    var parent_sel_obj = parent_sel_rows[0];
    var _sortid = parent_sel_obj._sortid;
    parent_sel_obj["score"] = warndata;
    datatable.reflash(_sortid);
    gatherScore(parent_sel_obj.superid);
    amtTotal(datatable);
}


function gatherScore(superid) {
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
                if (selectDatas.superid == superid && selectDatas.score && !isNaN(selectDatas.score)) {
                    result += parseFloat(selectDatas.score);
                }
            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    datas[i]['score'] = result == 0.00 ? "" : result.toFixed(2);
                }
            });
            gatherScore(supguid);
        }
    }
    datatable.reflash();
}

function getPointNum(num) {
    var str = String(num);
    var index = str.split(".");
    var str1 = null;
    if (index.length == 2) {
        str1 = index[1].substring(0, 2);
        str1 = Number(index[0] + "." + str1);
    } else {
        str1 = Number(index[0]);
    }
    return str1;
}
