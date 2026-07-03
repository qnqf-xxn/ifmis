if (!Ext)
    Ext = {};
if (!Ext.lt)
    Ext.lt = {};
if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if (!Ext.lt.pmkpi.case)
    Ext.lt.pmkpi.case = {};
/**
 * 初始化加载.
 */
var datastatus ="";  //数据状态  1新增  2修改  3删除
//绩效指标审核 --- 审核时应该是只读，目前也可改只是没有保存按钮，不合理
Ext.lt.pmkpi.case.indexservice = function (config, service) {
    var commcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var _viewtype = config.viewtype,
        _mainguid = config.mainguid,//主单guid
        _ismergeindex = config.ismergeindex,//指标值是否合并
        _signs = config.signs,//计算符号
        _bustype = config.bustype,//业务类型
        _kpivals = config["kpivals"], //合肥定量其他值.
        _kpicalnotapply = config["kpicalnotapply"],//不适用
        _datatype = config.datatype,//数据类型
        _finintorgguid = config.finintorgguid,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _delguids = [],
        _saveAgency = config.saveAgency,
        _busguid = config.busguid//审核定义guid，perf_t_busauditdefine表budguid
    ;
    var _isGx = config["isGx"];//标识是否是广西
    var cmp = {};
    var _data_source = [];
    var _displaycols = [];
    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });

    cmp.query = function (_isquery) {
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service, "getDatas", params, function (rs) {
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
            if (_isquery) {
                parent._isQuery = true;
            }
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！', function () {
            });
        });
    }

    cmp.save = function () {
        if (!cmp.checkAll()) return false;//先校验
        var params = {};
        var indexdatas = datatable.getRecordSet().toArray();
        if (indexdatas && indexdatas.length > 0) {
            for (var a = 0, leni = indexdatas.length; a < leni; a++) {
                if(indexdatas[a].levelno == "3"){
                    if (!commcmp.checkSpaceValue(indexdatas[a],"绩效指标-第" + (indexdatas[a]["_sortid"] + 1) + "行","datatable")) return;//校验空格
                    indexdatas[a].name = convertStr(indexdatas[a].name);
                    indexdatas[a].indexvalue = convertStr(indexdatas[a].indexvalue);
                    indexdatas[a].indexval = convertStr(indexdatas[a].indexval);
                    indexdatas[a].kpi_val = convertStr(indexdatas[a].kpi_val);
                }
            }
        }
        params.datas = indexdatas;
        params.updatas = datatable.getUpdataData();
        params.delguids = _delguids;
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.bustype = _bustype;
        params.finintorgguid = _finintorgguid;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service, "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            _delguids = [];
            cmp.query();
        }
        return rs;
    }

    $(function () {
        commcmp.initDatatable();
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
            cmp.setTableColum();
        }
        cmp.query(true);
        _data_source = datasource(_datatype)
    })

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
        indexdata.status = 1;
        indexdata.obligate1 = "删除";
        if(_isGx){
            indexdata.is_remarked = "1";
            var _yesno = [{guid: "1", code: 1, name: "是"}, {guid: "2", code: 2, name: "否"}];
            var is_remarked_source = [];
            for (var i = 0; i < _yesno.length; i++) {
                var temparr = [];
                temparr.push(_yesno[i]["guid"]);
                temparr.push(_yesno[i]["code"]);
                temparr.push(_yesno[i]["name"]);
                is_remarked_source.push(temparr);
            }
            datatable.addMapperDatas("is_remarked", is_remarked_source);
        }
        Ext.lt.pmkpi.doMapper(_datatype, datatable.getCol("status"));
        datatable.getRecordSet().addData(indexdata,_sortid + datatable.getRecordset().toArray().length);
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
                if (data && data.length > 0) {
                    datatable.addMapperDatas("status", _data_source);
                    for (var i = 0; i < data.length; i++) {
                        var parent_sel_rows = datatable.getRecordset().query({guid: data[i].guid});
                        var parent_sel_obj = parent_sel_rows[0];
                        datastatus = parent_sel_obj.status;  //数据状态
                        if (parent_sel_obj.levelno == 3) {
                            if (parent_sel_obj.status == 1) {
                                _delguids.push(parent_sel_obj.guid);
                                datatable.removeData(parent_sel_obj);
                            } else if (_viewtype == "adjust") {
                                var _sortid = parent_sel_obj._sortid;
                                parent_sel_obj.status = 3;
                                parent_sel_obj.obligate1 = "撤销删除";
                                $.extend(parent_sel_obj, parent_sel_obj); //合并值集刷新
                                datatable.reflash(_sortid);
                            }
                        }
                    }
                }
            }
        })
    }


    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "obligate1") {
                col.style = " text-align:center;color:#468ac9;cursor:pointer;";
                col.onclick = function (td, el, l, c, d) {
                    var levelno = d.levelno;
                    if (levelno == "2") {
                        cmp.addrow( d.guid);
                    } else if (levelno == "3" && d.status != 3) {
                        cmp.del("", d.guid);
                    } else if (d.levelno == "3" && d.status == 3 && _viewtype == "adjust") {
                        Ext.lt.ui.confirm("确认要撤销删除选中指标？", {icon: "warn"}, function (ret) {
                            if (ret) {
                                var _sortid = d._sortid;
                                if (datastatus == "" || datastatus == null){
                                    d.status = "";
                                }else {
                                    d.status = "2";
                                }
                                d.obligate1 = "删除";
                                $.extend(d, d); //合并值集刷新
                                datatable.reflash(_sortid);
                            }
                        })
                    }
                };
            }
            if (col["colcode"] == "indexvalue") {
                upcols.push(col["colcode"]);
                col.fn = function (l, c, data, col) {
                    if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10" || _ismergeindex != "1") {
                        var indexvalue = !data.indexvalue ? "" : data.indexvalue;
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
                        var returnstr = !data.indexvalue ? computesignstr + unit : computesignstr + data.indexvalue + unit;
                        return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.status == "3") {
                        return false;
                    }
                    if (!d.indexvalue || d.indexvalue != '') {
                        if (!d.computesign || d.computesign == "") {
                            Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                            });
                            d.indexvalue = '';
                            return false;
                        }
                    }
                    if (d.computesign == "9") { //合肥添加定量其他
                        Ext.lt.pmkpi.doMapper(_kpivals, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else if(d.computesign == "10"){
                        Ext.lt.pmkpi.doMapper(_kpicalnotapply,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.indexvalue != undefined ? d.indexvalue : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                    }
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10') {
                        if (!d.indexvalue || !checkReferencepole(d.indexvalue)) {
                            d.indexvalue = '';
                            return false;
                        }
                    }
                    if (d.computesign == "9") {
                        d["kpivalsource"] = d["indexvalue"];
                    }
                    if (d.status != 1) {
                        d["status"] = 2;
                        datatable.addMapperDatas("status", _data_source);
                    }
                }
            }
            if (col["colcode"] == "computesign") {
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != "9" && d.computesign != "10") {
                        if (d.indexvalue && !checkReferencepole(d.indexvalue)) {
                            d.indexvalue = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "9") {
                        var istrue = false;
                        for (var i = 0; i < _kpivals.length; i++) {
                            if (d.indexvalue == _kpivals[i].guid) {
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexvalue = '';
                            d.meterunit = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "10") {
                        var istrue = false;
                        for (var i=0; i<_kpicalnotapply.length; i++) {
                            if (d.indexvalue == _kpicalnotapply[i].guid){
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexvalue = '';
                            d.meterunit = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "6") {
                        d.indexvalue = '';
                        d.meterunit = '';
                        return false;
                    } else if (!d.computesign || d.computesign == "") {
                        d.indexvalue = '';
                        d.meterunit = '';
                        return false;
                    }
                    if (d.status != 1) {
                        d["status"] = 2;
                        datatable.addMapperDatas("status", _data_source);
                    }
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
                            if (d.levelno != "3" || d.status == "3") {
                                return false;
                            }
                        }
                        cols[i].oneditend = function (table, el, l, c, d) {
                            if (d.status != 1) {
                                d["status"] = 2;
                                datatable.addMapperDatas("status", _data_source);
                            }
                        }
                    }
                }
            }
        }
    });

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
        var rowdata = paramobj.rowdata;
        if(rowdata.levelno != 3){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

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
                    return false;
                }
                // if(datas[i]['computesign'] == '9' && (!datas[i].value_remark || datas[i].value_remark == '')){
                //     Ext.lt.ui.alert("计算符号选择“定量（其他）”时，指标值说明必填！",{timeout:1},function(){});
                //     return;
                // }
            }
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].isvisiable == '1' && cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        return false;
                    }
                }
                if (cols[j].isvisiable == '1' && cols[j].colcode == 'value_change' && datas[i]["levelno"] == 3) {
                    if(datas[i]['value_change'] == '2' && (!datas[i].indexvalue || datas[i].indexvalue == '')){
                        Ext.lt.ui.alert("指标值变动情况选择“固定值”时，指标值必填！",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        return true;
    }

    return cmp;
}

function amtTotal(table) {
    if (table.getSumobj()) {
        var totalrow = table.getRecordset();
        var sumamt = 0.00;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for (var i = 0; i < len; i++) {
            if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3" && rowarr[i].status !="3") {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                sumamt += parseFloat(weight);
            } else if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
                sumamt += parseFloat(weight);
            } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
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

function datasource (datas){
    var data_source = [];
    for(var i=0; i<datas.length; i++){
        var temparr = [];
        temparr.push(datas[i]["guid"]);
        temparr.push(datas[i]["code"]);
        temparr.push(datas[i]["name"]);
        data_source.push(temparr);
    }
    return data_source;
}