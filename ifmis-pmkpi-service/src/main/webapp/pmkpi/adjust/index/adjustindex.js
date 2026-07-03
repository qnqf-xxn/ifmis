if (!Ext)
    Ext = {};
if (!Ext.lt)
    Ext.lt = {};
if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if (!Ext.lt.pmkpi.adjust)
    Ext.lt.pmkpi.adjust = {};
/**
 * 初始化加载.
 */
var serviceid;
var _mainguid;
var _saveAgency;
var _datatype;
var isZJ;
var _adjustweightTotal = 0;
var _isadjustweight = false;
var _weight_sum;
var _ischeckweight = false;
//绩效指标审核 --- 审核时应该是只读，目前也可改只是没有保存按钮，不合理
Ext.lt.pmkpi.adjust.indexservice = function (config, service) {
    var commcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _viewtype = config.viewtype,
        _proguid = config.proguid,//项目/部门guid
        _mainguid = config.mainguid,//主单guid
        _ismergeindex = config.ismergeindex,//指标值是否合并
        _signs = config.signs,//计算符号
        _bustype = config.bustype,//业务类型
        _prolev = config.prolev,
        _kpivals = config["kpivals"], //合肥定量其他值.
        _kpicalnotapply = config["kpicalnotapply"],//不适用
        _ismergeindex = config["ismergeindex"],//指标值是否合并单位符号
        _pmkpidatatype = config.pmkpidatatype,//数据类型
        _procode = config.procode,
        _isnewPage = config.isnewPage,
        _isAH = config.isAH,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _ishebei = config.ishebei,
        _istianjin = config.isTianjin, //是否天津模式
        _isGx = config.isGx,//是否广西模式
        _pro_name = decodeURIComponent(config.pro_name),
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _busguid = config.busguid//审核定义guid，perf_t_busauditdefine表budguid
    ;
    var _displaycols = [];
    var delguids = [];
    var _indsource = config.indsource;

    var cmp = {};
    serviceid = service;
    _mainguid = config.mainguid;
    _saveAgency = config.saveAgency,
        _scrWidth = document.body.clientWidth;
    _scrHeight = document.body.clientHeight;
    _datatype = config.datatype;//数据类型
    isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });

    cmp.query = function (isquery) {
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.proguid = _proguid;
        params.bustype = _bustype;
        params.procode = _procode;
        params.queryYear = _queryYear;//跨年查询查询年度
        params.queryProvince = _queryProvince;//跨年查询查询区划
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "getDatas", params, function (rs) {
            datatable.setDatas(rs.data);
            delguids = [];
            if (_isadjustweight) {
                setTimeout(function () {
                    var superid = "";
                    for (var i = 0; i < rs.data.length; i++) {
                        var d = rs.data[i];
                        if (d.levelno == 3) {
                            if (d.superid != superid) {
                                gatherWeight(d.superid);
                            }
                            superid = d.superid;
                        }
                    }
                }, 500);
            }
            if(_ischeckweight){
                setTimeout(function () {
                    var superid = "";
                    for (var i = 0; i < rs.data.length; i++) {
                        var d = rs.data[i];
                        if (d.levelno == 3) {
                            if (d.superid != superid) {
                                gatherWeightNew(d.superid,"actualweight");
                            }
                            superid = d.superid;
                        }
                    }
                    amtTotal(datatable);
                }, 500);
            }
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！', function () {
            });
        });
    }

    cmp.save = function () {
        if (datatable.getEditor()){
            datatable.closeEdit();
        }
        if (!cmp.checkAll()) return false;//先校验
        if (!cmp.checkFrameWeight()) return;
        if (_isadjustweight) {
            if (_adjustweightTotal != 100){
                Ext.lt.ui.alert('调整后权重合计为100！',function(){
                });
                return;
            }
        }
        var params = {};
        //处理指标名称、指标值字段 特殊字替换
        var indexdatas = datatable.getRecordSet().toArray();
        if (indexdatas && indexdatas.length > 0) {
            for (var a = 0, leni = indexdatas.length; a < leni; a++) {
                if(indexdatas[a].levelno == "3" && (indexdatas[a].status == "2" || indexdatas[a].status == "3")) {
                    if (!commcmp.checkSpaceValue(indexdatas[a],"第" + (indexdatas[a]["_sortid"] + 1) + "行","datatable")) return;//校验空格
                    if(indexdatas[a].rowtype && indexdatas[a].rowtype == "add"){
                        indexdatas[a].name = convertStr(indexdatas[a].name);
                        indexdatas[a].indexval = convertStr(indexdatas[a].indexval);
                        indexdatas[a].kpi_val = convertStr(indexdatas[a].kpi_val);
                    }
                    indexdatas[a].adjustindexval = convertStr(indexdatas[a].adjustindexval);
                }
            }
        }
        params.datas = indexdatas;
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.proguid = _proguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.bustype = _bustype;
        params.procode = _procode;
        params.pro_name = _pro_name;
        params.delguids = delguids;
        params.queryYear = _queryYear;//跨年查询查询年度
        params.queryProvince = _queryProvince;//跨年查询查询区划
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid, "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    cmp.checkAll = function() {
        var datas = datatable.getRecordSet().toArray();
        var cols = datatable.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if(datas[i]["status"] == 1){ // 已删除数据不校验: 1-删除;2-修改;3-新增
                continue;
            }
            if (datas[i]["levelno"] == 3) {
                if(datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")){
                    Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。",{timeout:1},function(){});
                    return false;
                }
                if(datas[i]['computesign'] == '9' && (!datas[i].value_remark || datas[i].value_remark == '')){
                    Ext.lt.ui.alert("计算符号选择“定量（其他）”时，指标值说明必填！",{timeout:1},function(){});
                    return false;
                }
            }
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (datas[i]["levelno"] == 3) {
                    var value = datas[i][cols[j].colcode];
                    if(cols[j].requirement == '1'){
                        if (value == null || value == "" || ("" + value).trim().length == 0) {
                            Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                            return false;
                        }
                    }
                    if (datas[i]["status"] == 3 || !datas[i]["status"]) {
                        if (cols[j].colcode == 'indexval' && value && value.match(RegExp("[*_-]")) != null) {
                            Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。",{timeout:1},function(){});
                            return false;
                        }
                    }
                    if (datas[i]["status"] == 2) {
                        if (cols[j].colcode == 'adjustindexval' && value && value.match(RegExp("[*_-]")) != null) {
                            Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。",{timeout:1},function(){});
                            return false;
                        }
                    }
                }

            }
        }
        return true;
    }

    $(function () {
        commcmp.initDatatable();
        if (_viewtype == "query") {
            if (_isAH && _isnewPage != "1") {
                commcmp.changToolShowbuttont("ahexpdoc");
            } else {
                $("div[compid='toolbutton']").hide();
            }
            cmp.setTableColum();
        }
        var columncfg = datatable.config.data[0].columns;
        for (var i=0; i<columncfg.length; i++) {
            if(columncfg[i].colcode == "actualweight" && columncfg[i].isvisiable == "1"){
                _ischeckweight = true;
                break;
            }
        }
        cmp.query(true);
    })

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        var isapply;
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col.colcode == "adjustweight") {
                upcols.push(col["colcode"]);
                _isadjustweight = col.display;
                col.fn = function (l, c, data, col) {
                    //合计行（非末级）调整后权重加粗显示
                    var  adjustweight = data.adjustweight ? data.adjustweight : 0.00;
                    if (data.isleaf == "0") {
                        return "<b>" + adjustweight + "</b>";
                    } else {
                        return adjustweight;
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //是浙江、是三级指标或是新增且是挑选的指标可编辑
                    //if (isZJ == 1 && ((d.levelno != "3" || (d.status == "3" && (!d.tindex || d.tindex == ""))) || d.status == "1")) {
                    if (isZJ == 1 && (d.levelno != "3" || d.status == "1")) {
                            return false;
                    } else if (isZJ != "1" && (d.levelno != "3" || (d.status && d.status != "2"))) {
                        return false;
                    }
                }
            }
            if (col.colcode == "weight") {
                col.fn = function (l, c, data, col) {
                    //合计行（非末级）权重加粗显示
                    var  weight = data.weight ? data.weight : 0.00;
                    if (data.isleaf == "0") {
                        return "<b>" + weight + "</b>";
                    } else {
                        return weight;
                    }
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
                upcols.push(col["colcode"]);
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
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.status == "1") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    gatherWeightNew(d.superid,"actualweight");
                    amtTotal(datatable);
                }
            }
            if (col["colcode"] == "obligate1") {
                if (_viewtype != "query") {
                    col.style = " text-align:center;color:#468ac9;cursor:pointer;";
                    col.onclick = function (td, el, l, c, d) {
                        var levelno = d.levelno;
                        if (isZJ != "1" && levelno == "2") {
                            cmp.addrow( d.guid);
                            // cmp.add("", d.guid);
                        } else if (levelno == "3" && d.status != "1") {
                            if(_ishebei == '1' && (d.code == '149999' || d.name == '项目或定额成本控制率')){
                            }else {
                                cmp.del("", d.guid);
                            }
                        } else if (d.levelno == "3" && d.status == "1") {
                            if(_isGx && d.isfromparent == "1"){
                                Ext.lt.ui.alert("含有一级项目指标无法删除！",function(){});
                                return;
                            }
                            Ext.lt.ui.confirm("确认要撤销删除选中指标？", {icon: "warn"}, function (ret) {
                                if (ret) {
                                    var _sortid = d._sortid;
                                    d.status = "";
                                    d.obligate1 = "删除";
                                    d.adjustindexval = "";
                                    $.extend(d, d); //合并值集刷新
                                    datatable.reflash(_sortid);
                                }
                                if (_isadjustweight) {
                                    gatherWeight(d.superid);
                                }
                            })

                        }
                    };
                }
            }

            if (col["colcode"] == "indexval") {
                upcols.push(col["colcode"]);
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
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || (d.status != "3" && _isnewPage != "1")) {
                        return false;
                    }
                    /*if (isZJ == 1 && d.tindex && d.tindex != "" && d.status != "3") {
                        return false;
                    }*/
                    if (!d.indexval || d.indexval != '') {
                        if (!d.computesign || d.computesign == "") {
                            Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                            });
                            d.indexval = '';
                            return false;
                        }
                    }
                    if (d.computesign == "9") { //合肥添加定量其他
                        doMapper(_kpivals, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else if(d.computesign == "10"){
                        doMapper(_kpicalnotapply,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.indexval != undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                    }
                    //河北的固化指标不可修改
                    if(_ishebei == '1' && (d.code == '149999' || d.name == '项目或定额成本控制率')){
                        return false;
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
                    if (d.computesign == "9") {
                        d["kpivalsource"] = d["indexval"];
                    }
                }
            }
            if (col["colcode"] == "adjustindexval") {
                upcols.push(col["colcode"]);
                col.fn = function (l, c, data, col) {
                    if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10"  || _ismergeindex != "1") {
                        var indexvalue = !data.adjustindexval ? "" : data.adjustindexval;
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
                        var returnstr = !data.adjustindexval ? computesignstr + unit : computesignstr + data.adjustindexval + unit;
                        return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if(_istianjin && d.isunmod == "1"){//天津模式，河北一体化来源指标不可删除修改
                        return false;
                    }
                    //是浙江、是三级指标或是新增且是挑选的指标可编辑
                    if (isZJ == 1 && ((d.levelno != "3" || (d.status == "3" && (!d.tindex || d.tindex == ""))) || d.status=="1")) {
                        return false;
                    } else if (isZJ != "1" && (d.levelno != "3" || (d.status && d.status != "2"))) {
                        return false;
                    }
                    //河北的固化指标不可修改
                    if(_ishebei == '1' && (d.code == '149999' || d.name == '项目或定额成本控制率')){
                        return false;
                    }
                    if (_isGx == 1 && d.isfromparent == "1" && (d.isapply == "2" || d.isallowedit == "2")) { //父级指标，不允许修改标签 或 不适用 不可编辑
                        return false;
                    }
                    if (d.computesign == "9") { //合肥添加定量其他
                        doMapper(_kpivals, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else if(d.computesign == "10"){
                        doMapper(_kpicalnotapply,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.adjustindexval != undefined ? d.adjustindexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    var computesign = d.computesign;
                    if (computesign && computesign != '6' && computesign != '9' && computesign != '10') {
                        if (!checkReferencepole(d.adjustindexval)) {
                            d.adjustindexval = '';
                            return false;
                        }
                    }
                    if (d.adjustindexval != '') {
                        if (!computesign) {
                            Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                            });
                            d.adjustindexval = '';
                            return false;
                        }
                    }
                    if (computesign == "9") {
                        d["kpivalsource"] = d["adjustindexval"];
                    }
                    if (!d.status && d.status != 3) {
                        d.status = 2;
                        doMapper(_pmkpidatatype, table.getCol("status"));
                    }
                    if (d.status != 3 && !d["adjustindexval"]) {
                        d.status = "";
                    }
                }
            }

            if (col["colcode"] == "computesign") {
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != "9" && d.computesign != "10") {
                        if (d.indexval && !checkReferencepole(d.indexval)) {
                            d.indexval = '';
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
                        for (var i=0; i<_kpicalnotapply.length; i++) {
                            if (d.indexval == _kpicalnotapply[i].guid){
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

            if (col["colcode"] == "adjustweight") {
                col.oneditend = function (table, el, l, c, d) {
                    gatherWeight(d.superid);
                }
            }

            if (col["colcode"] == "isapply") {
                upcols.push(col["colcode"]);
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3") {
                        return false;
                    }
                    isapply = d.isapply;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (!d.status && d.status != 3) {
                        d.status = 2;
                        doMapper(_pmkpidatatype, table.getCol("status"));
                        var _isadd = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
                        doMapper(_isadd, table.getCol("isapply"));
                    }
                    if(d.status && d.status == "2"){
                        if (d.isapply == "2" && d.isfromparent == "1" && d.isallowedit == "1") {
                            d.adjustindexval = "—";
                        } else if (isapply == "2" && d.isapply == "1" && d.isfromparent == "1" && d.isallowedit == "1") {
                            d.adjustindexval = "";
                        }
                    }
                }
            }

            if (col["colcode"] == "name" || col["colcode"] == "perf_ind_name") {
                col.cseditfn = function (i, j, rs, style) {
                    if (rs.levelno == "3" && rs.is_remarked == "1") {
                        return updateStyle(style, 'color:#FF0000');
                    }
                    return style;
                }
            }

            if (_viewtype == 'query' && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
        if (_viewtype != 'query') {
            for(var i=0; i<cols.length; i++){
                if (cols[i]["colcode"] && cols[i]["isvisiable"] == 1) {
                    var iscol = false;
                    for (var j=0; j<upcols.length; j++) {
                        if (cols[i]["colcode"] == upcols[j]) {
                            iscol = true;
                            break;
                        }
                    }
                    if (!iscol) {
                        cols[i].oneditstart = function (table, e, l, c, d) {
                            //是浙江、是三级指标或是新增且是挑选的指标可编辑
                            if (isZJ == 1 && (d.levelno != "3" || (d.status == "3" && (d.tindex && d.tindex != "")))) {
                                return false;
                            }
                            if (d.levelno != "3" || (d.status != "3" && _isnewPage != "1")) {
                                return false;
                            }
                            if(_ishebei == '1' && (d.code == '149999' || d.name == '项目或定额成本控制率')){
                                return false;
                            }
                        }
                    }
                }
            }
        }
    });

    Ext.lt.pmkpi.addrow = function (data) {
        datatable.getRecordSet().addData(data, 999);
    }

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
        var rowdata = paramobj.rowdata;
        if(rowdata.levelno != 3){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

    /**
     *  新增行
     */
    cmp.addrow = function(selguid){
        var data = datatable.getRecordset().query({guid:selguid});
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
        indexdata.status = 3;
        indexdata.obligate1 = "删除";
        indexdata.is_add = "1";
        indexdata.isfromparent = "0";
        indexdata.isapply = "1";
        indexdata.indsource = '1';
        if (_isnewPage != "1") {
            doMapper(_pmkpidatatype, datatable.getCol("status"));
            if (datatable.getCol("isapply")) {
                var _isadd = [{guid: "2", code: 2, name: "否"}, {guid: "1", code: 1, name: "是"}];
                doMapper(_isadd, datatable.getCol("isapply"));
            }
        }
        if (datatable.getCol("indsource") && datatable.getCol("indsource")["isvisiable"] == 1) {
            commcmp.setColDatasource({"indsource": _indsource}, datatable);
        }
        datatable.getRecordSet().addData(indexdata,_sortid + datatable.getRecordset().toArray().length);
    }

    /**
     * 指标推荐方法.
     */
    cmp.recom = function () {
        var url = "";
        if (_bustype != null && ("dept" == _bustype || "depttrace" == _bustype)) {
            url = '/pmkpi/deptperformance/deptperf/recomindex.page';
        } else if (_bustype != null && ("program" == _bustype || "protrace" == _bustype)) {
            url = '/pmkpi/program/prjindex/recomindex.page';
        }
        var params = {};
        params.proguid = _proguid;
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.fromtype = "tree";
        params.isadjust = "true";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "指标推荐");
    }

    /**
     * 复制上年指标.
     */
    cmp.lastyear = function (btnobj) {
        var params = {};
        var name = btnobj.name;
        var url = '/pmkpi/program/prjindex/lastyear.page';
        params.fromtype = "tree";//树级填报
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.proguid = _proguid;
        params.procode = _procode;
        params.isadjust = "true";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, name);
    }

    /**
     * 复制总体指标.
     */
    cmp.totalindex = function (btnobj) {
        var params = {};
        var name = btnobj.name;
        var url = '/pmkpi/program/prjindex/totalindex.page';
        params.fromtype = "tree";//树级填报
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.proguid = _proguid;
        params.procode = _procode;
        params.isadjust = "true";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, name);
    }

    /**
     * 新增
     */
    cmp.add = function (obj, selguid) {
        var data = [];
        if (!selguid) {
            data = cmp.getSeletdata("1");
            if (data.length != 1) {
                Ext.lt.ui.alert("请选择一条二级指标！", function () {
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
        var url = "";
        if (_bustype != null && ("dept" == _bustype || "depttrace" == _bustype)) {
            url = "/pmkpi/adjust/report/deptedit/editindex.page";
        } else if (_bustype != null && ("program" == _bustype || "protrace" == _bustype)) {
            url = "/pmkpi/adjust/report/proedit/editindex.page";
        }
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.findex = data[0].findex;
        params.sindex = data[0].sindex;
        params.upguid = data[0].guid;
        params.type = "add";
        params.fromtype = "tree";
        params.is_add = "1";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "新增指标");
    }
    /**
     * 修改
     */
    cmp.mod = function () {
        var data = cmp.getSeletdata("2");
        if (data.length != 1) {
            Ext.lt.ui.alert("请选择一个三级指标修改！", function () {
            });
            return;
        } else if (data.length == 1 && (!data[0].levelno || data[0].levelno != 3)) {
            Ext.lt.ui.alert("请选择三级指标修改！", function () {
            });
            return;
        } else if (data.length == 1 && data[0].status != 3) {
            Ext.lt.ui.alert("请选择新增状态三级指标修改！", function () {
            });
            return;
        }
        var url = "";
        if (_bustype != null && ("dept" == _bustype || "depttrace" == _bustype)) {
            url = "/pmkpi/adjust/report/deptedit/editindex.page";
        } else if (_bustype != null && ("program" == _bustype || "protrace" == _bustype)) {
            url = "/pmkpi/adjust/report/proedit/editindex.page";
        }
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.findex = data[0].findex;
        params.sindex = data[0].sindex;
        params.modguid = data[0].guid;
        params.type = "mod";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "修改指标");
    }

    cmp.del = function (obj, selguid) {
        var data = [];
        if (!selguid) {
            data = datatable.getSelected();
            if (data.length == 0) {
                Ext.lt.ui.alert("请选择需要删除的指标！", function () {
                });
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid: selguid});
        }
        for (var i = 0; i < data.length; i++) {
            if(_istianjin && data[i].isunmod == "1"){
                Ext.lt.ui.alert("存在不可删除指标，请重新选择！", function () {
                });
                return;
            }
        }
        for(var i=0; i<data.length; i++){
            if(data[i].isfixed == "1"){
                Ext.lt.ui.alert("固化指标无法删除！",function(){});
                return;
            }
            if(_isGx && data[i].isfromparent == "1"){
                Ext.lt.ui.alert("含有一级项目指标无法删除！",function(){});
                return;
            }
        }
        Ext.lt.ui.confirm("确认要删除选中指标？", {icon: "warn"}, function (ret) {
            if (ret) {
                if (data && data.length > 0) {
                    getdataSource();
                    for (var i = 0; i < data.length; i++) {
                        var parent_sel_rows = datatable.getRecordset().query({guid: data[i].guid});
                        var parent_sel_obj = parent_sel_rows[0];
                        if (parent_sel_obj.levelno == 3) {
                            if (parent_sel_obj.status == 3 || _isnewPage == "1") {
                                delguids.push(parent_sel_obj.guid);
                                datatable.removeData(parent_sel_obj);
                            } else {
                                var _sortid = parent_sel_obj._sortid;
                                parent_sel_obj.status = 1;
                                parent_sel_obj.obligate1 = "撤销删除";
                                parent_sel_obj.actualweight = 0;
                                $.extend(parent_sel_obj, parent_sel_obj); //合并值集刷新
                                datatable.reflash(_sortid);
                            }
                            if (_isadjustweight) {
                                gatherWeight(parent_sel_obj.superid);
                            }
                            if (_ischeckweight){
                                gatherWeightNew(parent_sel_obj.superid,"actualweight");
                            }
                        }
                    }
                }
            }
        })
    }

    /**
     * 表格的选择行.
     * @param type 1:包含二级，2 只有末级
     */
    cmp.getSeletdata = function (type) {
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
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function () {
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            if (col.colcode == "obligate1") {
                _displaycols.push(col); //隐藏前暂存至sfagency;
                col.display = false; //display置为false，隐藏
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    cmp.checkFrameWeight = function (){
        if (_ischeckweight && !Ext.lt.pmkpi.weightCheckNew(datatable,_weight_sum,"frameweight","actualweight","adjindex", "1")) {//权重校验
            return false;
        }else{
            return true;
        }
    }

    return cmp;
}

function indexcheck(guid) {
    var url = "/pmkpi/deptperformance/report/indexcheck.page";
    var params = {};
    params.sindex = guid;
    params.saveAgency = _saveAgency;
    params.mainguid = _mainguid;
    url = Ext.lt.pmkpi.genPageUrl(url, params);
    Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "选择指标");
}

function gatherWeight(superid) {
    var datas = datatable.getRecordSet().toArray();
    if (superid) {
        if (datas != null && datas.length > 0) {
            var supguid = '';
            var result = 0.00;
            var ajdresult = 0.00;
            var guid = '';
            for (var i = 0; i < datas.length; i++) {
                var selectDatas = datas[i];
                if (superid == selectDatas.guid) {
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if (selectDatas.superid == superid && selectDatas.adjustweight && !isNaN(selectDatas.adjustweight) && selectDatas.status !="1") {
                    if (selectDatas.weight) {
                        result += parseFloat(selectDatas.weight);
                    }
                    ajdresult += parseFloat(selectDatas.adjustweight);
                } else if (selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)) {
                    result += parseFloat(selectDatas.weight);
                }
            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    datas[i]['weight'] = result == 0.00 ? "" : result.toFixed(2);
                    datas[i]['adjustweight'] = ajdresult == 0.00 ? "" : ajdresult.toFixed(2);
                }
            });
            gatherWeight(supguid);
            amtTotal(datatable);
        }
    }
}

function gatherWeightNew(superid,sumcol) {
    var sumcol = sumcol ||"actualweight";
    var datas = datatable.getRecordSet().toArray();
    if (superid) {
        if (datas != null && datas.length > 0) {
            var supguid = '';
            var result = 0.00;
            var guid = '';
            for (var i = 0; i < datas.length; i++) {
                var selectDatas = datas[i];
                if (superid == selectDatas.guid) {
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if (selectDatas.superid == superid && selectDatas[sumcol] && !isNaN(selectDatas[sumcol]) && selectDatas.status !="1") {
                    result += parseFloat(selectDatas[sumcol]);
                }
            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    datas[i][sumcol] = result == 0.00 ? "" : result.toFixed(2);
                }
            });
            gatherWeightNew(supguid,sumcol);
            amtTotal(datatable);
        }
    }
    datatable.reflash();
}

function amtTotal(table) {
    if (table.getSumobj()) {
        var totalrow = table.getRecordset();
        var sumamt = 0.00;
        var adjsumamt = 0.00;
        var sumactualweight = 0.00;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for (var i = 0; i < len; i++) {
            if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3" && rowarr[i].status !="1") {
                var adjustweight = rowarr[i]["adjustweight"] ? rowarr[i]["adjustweight"] : 0.00;
                adjsumamt += parseFloat(adjustweight);
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                sumamt += parseFloat(weight);
                var actualweight = rowarr[i]["actualweight"] ? rowarr[i]["actualweight"] : 0.00;
                sumactualweight += parseFloat(actualweight);
            } else if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                sumamt += parseFloat(weight);
                var actualweight = rowarr[i]["actualweight"] ? rowarr[i]["actualweight"] : 0.00;
                sumactualweight += parseFloat(actualweight);
            } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                var adjustweight = rowarr[i]["adjustweight"] ? rowarr[i]["adjustweight"] : 0.00;
                sumamt += parseFloat(weight);
                adjsumamt += parseFloat(adjustweight);
                var actualweight = rowarr[i]["actualweight"] ? rowarr[i]["actualweight"] : 0.00;
                sumactualweight += parseFloat(actualweight);
            }
        }
        _weight_sum = (sumamt ? sumamt.toFixed(2) : "0.00");
        var totalrs = {};
        totalrs["weight"] = sumamt == 0 ? "" : sumamt.toFixed(2);
        totalrs["adjustweight"] = adjsumamt == 0 ? "" : adjsumamt.toFixed(2);
        totalrs["actualweight"] = sumactualweight == 0 ? "" : sumactualweight.toFixed(2);
        totalrs.datatable_do_sum = true;
        _adjustweightTotal = totalrs["adjustweight"];
        table.getClockRowSet().setData(totalrs, 0);
        if ((totalrow.size && totalrow.size() > 0) || (totalrow.length && totalrow.length > 0)) {
            table.reflashdata();
        }
    }
}

function getdataSource() {
    var datatype_source = [];
    for (var i = 0; i < _datatype.length; i++) {
        var temparr = [];
        temparr.push(_datatype[i]["guid"]);
        temparr.push(_datatype[i]["code"]);
        temparr.push(_datatype[i]["name"]);
        datatype_source.push(temparr);
    }
    datatable.addMapperDatas("status", datatype_source);
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