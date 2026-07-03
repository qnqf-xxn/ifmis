if (!Ext)
    Ext = {};
if (!Ext.lt)
    Ext.lt = {};
if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if (!Ext.lt.pmkpi.promodmergeindex)
    Ext.lt.pmkpi.promodmergeindex = {};
/**
 * 初始化加载.
 */
var serviceid;
var _mainguid;
var _saveAgency;
var _datatype;
var isZJ;
var ismergeindex;
Ext.lt.pmkpi.promodmergeindex = function (config, service) {
    var _viewtype = config.viewtype,
        _proguid = config.proguid,//项目/部门guid
        _mainguid = config.mainguid,//主单guid
        ismergeindex = config.ismergeindex,//指标值是否合并
        _signs = config["signs"],//指标符号
        _modtype = config.modtype,
        _signs = config.signs,//计算符号
        _bustype = config.bustype,//业务类型
        _prolev = config.prolev,
        _kpivals = config["kpivals"], //合肥定量其他值.
        _kpicalnotapply = config["kpicalnotapply"],//不适用
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _ishebei = config.ishebei,
        _busguid = config.busguid//审核定义guid，perf_t_busauditdefine表budguid
    ;
    var cmp = {};
    var _busguid = config.busguid;//审核定义guid
    serviceid = service;
    _mainguid = config.mainguid;
    _saveAgency = config.saveAgency,
    _scrWidth = document.body.clientWidth,
    _scrHeight = document.body.clientHeight,
    _datatype = config.datatype;//数据类型
    isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
    /**
     *
     */
    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
    });

    cmp.query = function () {
        var params = {};
        params.mainguid = _mainguid;
        params.proguid = _proguid;
        params.modtype = _modtype;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "getDatas", params, function (rs) {
            if(rs.success){
                editform.synchEditformByObj(rs.editinfo);
                datatable.setDatas(rs.indexdata);
            }
            Ext.lt.ui.loadingClose();
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！', function () {
            });
        });
    }

    cmp.save = function () {
        if (!cmp.checkAll()) return false;//先校验
        if (!editform.check()) {
            return false;
        }
        var params = {};
        params.goaldatas = editform.getEditFormValues();
        params.indexdatas = datatable.getRecordSet().toArray();
        params.busguid = _busguid;
        params.proguid = _proguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.modtype = _modtype;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid, "saveData", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    $(function () {
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
            //editform.setdisabled({KPI_TARGET:true});
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                if (cols[i].colcode == "KPI_TARGET") {
                    c[cols[i].colcode.toLowerCase()] = true;
                }
            }
            editform.setdisabled(c);//设置基本信息不可编辑
        }
        cmp.query();
    })

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "obligate1") {
                if (_viewtype != "query") {
                    col.style = " text-align:center;";
                    col.fn = function (l, c, data, col) {
                        var html = "";
                        if(_ishebei == '1' && (data.code == '149999' || data.name == '项目或定额成本控制率')){
                            //河北的固化指标不可修改
                            return "";
                        }else {
                            if (data.levelno == "2" && isZJ != "1") {
                                // html += '<a title = "选择" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexcheck("'+data.guid+'")\'>选择</a>';
                                // html += '&nbsp;&nbsp;&nbsp;&nbsp';
                                html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" >新增</a>';
                            } else if (data.levelno == "3") {
                                html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" >删除</a>';
                            }
                            return html;
                        }
                    }
                    col.onclick = function (td, el, l, c, d) {
                        var levelno = d.levelno;
                        if (levelno == "2") {
                            cmp.add("", d.guid);
                        } else if (levelno == "3") {
                            if(_ishebei == '1' && (d.code == '149999' || d.name == '项目或定额成本控制率')){
                            }else {
                                cmp.del("", d.guid);
                            }
                        }
                    };
                }
            }

            if (col["colcode"] == "indexval") {
                col.fn = function (l, c, data, col) {
                    if(data.computesign == "6"|| data.computesign == "9" || data.computesign == "9" || ismergeindex != "1"){
                        var indexvalue = !data.indexval? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue+"</font>";
                    } else {
                        var computesignstr ="";
                        for(var i =0; i<_signs.size() ; i++){
                            if(data.computesign == _signs[i].guid){
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if(data["meterunit"]){
                            unit = data.meterunit;
                        }
                        var returnstr = !data.indexval ? computesignstr + unit :computesignstr + data.indexval + unit;
                        return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
                    //河北的固化指标不可修改
                    if(_ishebei = '1' && (d.code == '149999' || d.name == '项目或定额成本控制率')){
                        return false;
                    }
                    if(d.computesign == "9"){ //合肥添加定量其他
                        doMapper(_kpivals,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else if(d.computesign == "10"){
                        doMapper(_kpicalnotapply,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText =  d.indexval!=undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                    }
                    if (_viewtype == "query") {
                        return false;
                    }
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                        if(!checkReferencepole(d.indexval)){
                            d.indexval = '';
                            return false;
                        }
                    }
                    if(d.indexval!=''){
                        var computesign = d.computesign;
                        if (!d.computesign) {
                            Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                            d.indexval = '';
                            return false;
                        }
                    }
                    if(d.computesign == "9"){
                        d["kpivalsource"] = d["indexval"];
                    }
                }
            }

            //一二级指标不可修改
            if(col["colcode"]!="indexval"){
                col.oneditstart = function(table,el,l,c,d){
                    if(d.levelno != "3"){
                        return false;
                    }
                    //河北的固化指标不可修改
                    if(_ishebei = '1' && (d.code == '149999' || d.name == '项目或定额成本控制率')){
                        return false;
                    }
                    if (_viewtype == "query") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.levelno == "3" && d.rowtype!="add"){
                        d.rowtype ="mod";
                    }
                }
            }

            if(col["colcode"]=="computesign"){
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6' && d.computesign != "9"  && d.computesign != "10"){
                        if(d.indexval && !checkReferencepole(d.indexval)){
                            d.indexval = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "9") {
                        var istrue = false;
                        for (var i=0; i<_kpivals.length; i++) {
                            if (d.indexval == _kpivals[i].guid){
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexval = '';
                            return false;
                        }
                    }
                    else if (d.computesign && d.computesign == "10") {
                        var istrue = false;
                        for (var i=0; i<_kpicalnotapply.length; i++) {
                            if (d.indexval == _kpicalnotapply[i].guid){
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexval = '';
                            return false;
                        }
                    }
                    if(_ishebei = '1' && (d.code == '149999' || d.name == '项目或定额成本控制率')){
                        return false;
                    }
                    if (_viewtype == "query") {
                        return false;
                    }
                }
            }
        }
    });

    Ext.lt.pmkpi.addrow = function (data) {
        datatable.getRecordSet().addData(data, 999);
    }

    /**
     * 指标推荐方法.
     */
    cmp.recom = function () {
        var url = '/pmkpi/program/prjindex/recomindex.page';
        var params = {};
        params.proguid = _proguid;
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, _scrWidth * 0.8, _scrHeight * 0.8, "指标推荐");
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
        var url = "/pmkpi/program/prjindex/editindex.page";
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.findex = data[0].findex;
        params.sindex = data[0].sindex;
        params.upguid = data[0].guid;
        params.type = "add";
        params.fromtype = "tree";
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
        }
        var url = "/pmkpi/program/prjindex/editindex.page";
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
        Ext.lt.ui.confirm("确认要删除选中指标？", {icon: "warn"}, function (ret) {
            if (ret) {
                if (data && data.length>0) {
                    var guids = [];
                    for(var i=0; i<data.length; i++){
                        if (data[i]["levelno"] == 3){
                            guids.push(data[i]["guid"]);
                        }
                    }
                    datatable.remove({guid:guids});
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
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    cmp.checkAll = function() {
        var datas = datatable.getRecordSet().toArray();
        var cols = datatable.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if (datas[i]["levelno"] == 3) {
                if(datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")){
                    Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。",{timeout:1},function(){});
                    return;
                }
                if(datas[i]['computesign'] == '9' && (!datas[i].value_remark || datas[i].value_remark == '')){
                    Ext.lt.ui.alert("计算符号选择“定量（其他）”时，指标值说明必填！",{timeout:1},function(){});
                    return;
                }
            }
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        return true;
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
            var sortid = 0;
            var result = 0;
            var guid = '';
            for (var i = 0; i < datas.length; i++) {
                var selectDatas = datas[i];
                if (superid == selectDatas.guid) {
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if (selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)) {
                    result += parseFloat(selectDatas.weight);
                }
            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    datas[i]['weight'] = result == 0 ? "" : result.toFixed(2);
                }
            });
            gatherWeight(supguid);
            amtTotal(datatable);
        }
    }
    datatable.reflash();
}

function amtTotal(table) {
    if (table.getSumobj()) {
        var totalrow = table.getRecordset();
        var sumamt = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for (var i = 0; i < len; i++) {
            if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                sumamt += parseFloat(weight);
            } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                sumamt += parseFloat(weight);
            }
        }
        var totalrs = {};
        totalrs["weight"] = sumamt == 0 ? "" : sumamt.toFixed(2);
        totalrs.datatable_do_sum = true;
        table.getClockRowSet().setData(totalrs, 0);
        if ((totalrow.size && totalrow.size() > 0) || (totalrow.length && totalrow.length > 0)) {
            table.reflashdata();
        }
    }
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
