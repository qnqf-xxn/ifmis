if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.deptfunc) {
    Ext.lt.pmkpi.deptfunc = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var totalgoals = []; //总体目标
var yeargoals = []; //年度目标
Ext.lt.pmkpi.dtperfadj = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var
        _viewtype = config.viewtype,
        _goaltype = '1', //部门绩效是总体还是年度，1总体，其他年度.
        _busguid = config.busguid,//审核定义guid，perf_t_busauditdefine表budguid
        _ismergeindex = config.ismergeindex,//指标值是否合并展示
        _signs = config.signs,//计算符号
        _datatype = config.datatype,//数据类型
        _proguid = config.proguid;//部门整体申报的guid
    var cmp = {};
    var _displaycols = [];
    var firstpage = true;
    serviceid = service;
    _mainguid = config.mainguid;
    _saveAgency = config.saveAgency,
        _scrWidth = document.body.clientWidth;
    _scrHeight = document.body.clientHeight;
    var isFirst = true;

    /**
     * 页面加载完成后立即执行
     */
    $(function () {
        common.initDatatable(maintable); //初始化加载主表
        common.initDatatable(); //初始化加载子表
        if (_viewtype == "query") {
            for (var i = 2; i < maintable.getCols().length; i++) {
                maintable.getCols()[i].edit = false;
            }
            for (var i = 2; i < datatable.getCols().length; i++) {
                datatable.getCols()[i].edit = false;
            }
            maintable.redraw();
            datatable.redraw();
            $("#add").hide();
            $("#del").hide();
        }
        Ext.lt.pmkpi.pageinit();
        $("#copybtn").hide();
        cmp.resiztable();
        cmp.mainquery(Ext.lt.pmkpi.goaltype, true);
        isFirst = false;
    })
    /**
     * 重新刷新表格.
     */
    cmp.resiztable = function () {
        var width = $("#maintable").width;
        maintable.resize(width - 20, _scrHeight * 0.4);
        datatable.resize(width - 20, _scrHeight);
    }
    /**
     * 页签点击操作.
     * @param obj
     */
    cmp.clickTabpage = function (obj) {
        if (!firstpage) {
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
            if (Ext.lt.pmkpi.goaltype == "1") {
                totalgoals = maintable.getRecordset().toArray();
            } else {
                yeargoals = maintable.getRecordset().toArray();
            }

            if (obj.code == "total") {
                $("#copybtn").hide();
            } else {
                $("#copybtn").show();
            }
        }
        if (obj.code == "total") {
            Ext.lt.pmkpi.goaltype = "1";
        } else {
            Ext.lt.pmkpi.goaltype = "0";
        }
        if (!isFirst) {
            cmp.mainquery(Ext.lt.pmkpi.goaltype);
        }
        cmp.setTableColum(obj.code);
    }

    /**
     * 初始化页面加载
     */
    Ext.lt.pmkpi.pageinit = function () {
        if (_viewtype != "query") {
            $('#maintable').append("<button title='删除指标' onclick=\"dtadjperf.del();\" type=\"button\" style=\"float:left;margin:1px 10px 0 15px;background-color:#3472ef;height: 30px;line-height: 30px;\" class=\"layui-btn btn-black\">删除指标</button>");
        }
    }
    /**
     * 根据页签动态配置表格的列.
     * @param type -- 哪个页签显示列 total--》总体 year--》 年度
     */
    cmp.setTableColum = function (type) {
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if ($.isEmptyObject(config["show"]) || config["show"] == type) {
                    col.display = true;
                } else {
                    _displaycols.push(col);
                    col.display = false; //display置为false，隐藏
                }
            }
            if (col["colcode"] == "snindexval" ||col["colcode"] == "qnindexval") {
                if (_viewtype == 'query') {//查看不可编辑
                    col.style = "background-color:#f2f2f2;";
                    col.edit = false;
                }
            }
        }
        //datatable.setCols(cols);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }
    /**
     * 主表的选中单选事件
     */
    Ext.lt.message.hook("fasp2datatable", "onRadioClick", function (d) {
        //处理子表数据保存到主表上
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = maintable.getRecordset().query({guid: goalguid});
            if (mainsel.length > 0) {
                mainsel[0]["#indexs"] = datas;
            }
        }
        cmp.query(d[4]);
    });

    /**
     * 主表查询.
     * goaltype -- 1 中长期， 0 年度
     */
    cmp.mainquery = function (goaltype, isquery) {
        if (firstpage) {
            var params = {};
            params.mainguid = _mainguid;
            params.agencyguid = _saveAgency;
            params.goaltype = _goaltype;
            params.proguid = _proguid;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(serviceid, "getMainDatas", params, function (rs) {
                totalgoals = rs.totalgoals;
                yeargoals = rs.yeargoals;
                //页面是查看状态时，操作列清空
                if (_viewtype == "query") {
                    for (let i = 0; i <totalgoals.length ; i++) {
                        totalgoals[i].obligate1 = "";
                    }
                    for (let i = 0; i <yeargoals.length ; i++) {
                        yeargoals[i].obligate1 = "";
                    }
                }
                if (goaltype == "0") {
                    maintable.setDatas(yeargoals);
                } else {
                    maintable.setDatas(totalgoals);
                }
                maintable.clearSelected();
                datatable.setDatas([]); //处理bug 81392
                Ext.lt.ui.loadingClose();
                if (isquery) {
                    setTimeout(function(){
                        parent._isQuery = true;
                    },500);
                }
            }, function () {
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert('目标查询失败！', function () {
                });
            });
        } else {
            if ("1" == goaltype) {
                maintable.setDatas(totalgoals);
            } else {
                maintable.setDatas(yeargoals);
            }
            maintable.clearSelected();
            datatable.setDatas([]);
        }
        firstpage = false;
    }
    /**
     * 子表查询
     * @param d -- 选中数据.
     */
    cmp.query = function (d) {
        var indexs = d["#indexs"];
        if (indexs.length > 0) {
            //页面是查看状态时，操作列清空
            if (_viewtype == "query") {
                for (let i = 0; i <indexs.length ; i++) {
                    indexs[i].obligate1 = "";
                }
            }
            datatable.setDatas(indexs);
        } else {
            var params = {};
            params.mainguid = d.mainguid;
            params.goalguid = d.guid;
            Ext.lt.RCP.call(serviceid, "getSubData", params, function (rs) {
                datatable.setDatas(rs.data);
            }, function () {
                Ext.lt.ui.alert('查询失败！', function () {
                });
            });
        }
    }
    /**
     * 主表的新增.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function (editdatatable) {
        var newguid = Ext.lt.RCP.asyncall(serviceid, "getCreateguid", null);
        var newdata = {};
        newdata.guid = newguid;
        newdata.mainguid = _mainguid;
        newdata.agencyguid = _saveAgency;
        newdata.rowtype = "add";
        newdata["#indexs"] = [];
        newdata["yearflag"] = Ext.lt.pmkpi.goaltype; //总体还是年度
        newdata.status = 3;
        newdata.obligate1 = "";
        var n = maintable.getRecordset().size(); //总数+1
        if (Ext.lt.pmkpi.goaltype == "1") {
            newdata["goalname"] = "长期目标" + (n + 1);
        } else {
            newdata["goalname"] = "年度目标" + (n + 1);
        }
        maintable.getRecordSet().addData(newdata, 999);
    });
    /**
     * 主表的删除.
     */
    Ext.lt.message.hook("delRow", "uidatatable", function (editdatatable) {
        var selDatas = maintable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的目标数据！', function () {
            });
            return;
        }
        var tmpstatus = selDatas[0]["status"];
        if (tmpstatus == "1") {
            Ext.lt.ui.alert('此数据已经删除，请选择其他状态数据！', function () {
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择目标数据？\n【目标删除会同步删除配套的绩效指标】', {icon: "warn"}, function (is) {
            if (is) {
                var goalguid = selDatas[0]["guid"];
                var goalname = "长期目标";
                if (Ext.lt.pmkpi.goaltype != "1") {
                    goalname = "年度目标";
                }
                if (tmpstatus == "2" || !tmpstatus || tmpstatus == "") { //修改删除
                    /*var main_row = maintable.getRecordset().query({guid: goalguid});
                    main_row[0].status = "1";
                    main_row[0].obligate1 = "撤销删除";*/
                    selDatas[0].status = "1";
                    selDatas[0].obligate1 = "撤销删除";
                    cmp.modDetail(goalguid,1);//处理子表.
                } else if (tmpstatus == "3") {
                    maintable.removeData(selDatas);
                    datatable.setDatas([]);
                }
                //处理各个目标的名称
                var arrs = maintable.getRecordset().toArray();
                for (var i = 0; i < arrs.length; i++) {
                    arrs[i]["goalname"] = goalname + (i + 1);
                }
                maintable.reflashdata();
            }
        })
    });
    /**
     * 删除/撤销删除主表，子表会随着级联.
     * @param goalguid --主键
     * @param flg -- 1 删除 2 还原
     */
    cmp.modDetail = function (goalguid, flg) {
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            for (var i = 0; i < datas.length; i++) {
                var sel_obj = datas[i];
                if (sel_obj["levelno"] == 3) {
                    if (1==flg){ //删除动作
                        if (sel_obj.status == 3) {
                            datatable.removeData(sel_obj);
                        } else {
                            datas[i].status = 1;
                            datas[i].obligate1 = "撤销删除";
                        }
                    }else{ //撤销删除动作
                        datas[i].status = "";
                        datas[i].obligate1 = "删除";
                        datas[i].adjustindexval = "";
                    }
                }
            }
            datatable.reflashdata();
        }
    }
    /**
     * 整体的保存方法.
     * @returns {*}
     */
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
        if (Ext.lt.pmkpi.goaltype == "1") {
            totalgoals = maintable.getRecordSet().toArray();
        } else {
            yeargoals = maintable.getRecordSet().toArray();
        }
        //3请求后端保存
        if (!cmp.nullcheck()) return false;
        if (!maintable.check()) return false;
        if (!cmp.checkAll()) return false;//先校验
        var params = {};
        params.totalgoals = totalgoals; //总体
        params.yeargoals = yeargoals;
        params.busguid = _busguid;
        params.saveAgency = _saveAgency;
        params.mainguid = _mainguid;
        params.proguid = _proguid; //申报阶段的来源
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid, "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            firstpage = true;
            cmp.mainquery(Ext.lt.pmkpi.goaltype);
        }
        return rs;
    }

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (_viewtype == 'query' && col["name"] != "check") {//查看不可编辑
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
            if (col["key"] == "/pmkpi/adjust/report/deptperfgoal") { //目标表
                if (col["colcode"] == "obligate1") {
                    col.style = " text-align:center;color:#468ac9;cursor:pointer;";
                    col.onclick = function (td, el, l, c, d) {
                        if (d.status == "1") {
                            //操作列值为空时，不走判断
                            if (!d.obligate1 == "" || !d.obligate1 == null) {
                                Ext.lt.ui.confirm("确认要撤销删除选目标？", {icon: "warn"}, function (ret) {
                                    if (ret) {
                                        var _sortid = d._sortid;
                                        d.status = "";
                                        d.obligate1 = "";
                                        d.adjustndgoal = "";
                                        $.extend(d, d); //合并值集刷新
                                        maintable.reflash(_sortid);
                                        //同时将明细表的删除列撤销删除
                                        cmp.modDetail(d.guid,"2");
                                    }
                                })
                            }
                        }
                    };
                }
                if (col["colcode"] == "adjustndgoal") { //调整后的目标
                    col.oneditstart = function (table, el, l, c, d) {
                        if (d.status && d.status != "2" && d.status != "") {
                            return false;
                        }
                        el.innerText = d.adjustndgoal != undefined ? d.adjustndgoal : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        if (d.status == "" || !d.status) {
                            d.status = 2;
                        }
                        if (d.status != 3 && d.status != 1 && !d["adjustndgoal"]) {
                            d.status = "";
                        }
                    }
                }
                if (col["colcode"] == "kpi_target") { //新增的绩效目标
                    col.oneditstart = function (table, el, l, c, d) {
                        if (d.status != "3") {
                            return false;
                        }
                        el.innerText = d.kpi_target != undefined ? d.kpi_target : '';
                        table.getCol(c).mapping = null;
                        table.nowtype = "input";
                        table.getCol(c).format = "";
                    }
                }
            } else if (col["key"] == "/pmkpi/adjust/report/deptperf") { //指标表
                if (col["colcode"] == "obligate1") {
                    col.style = " text-align:center;color:#468ac9;cursor:pointer;";
                    col.onclick = function (td, el, l, c, d) {
                        //操作列值为空时，不走判断
                        if (!d.obligate1 == "" || !d.obligate1 == null) {
                            var selDatas = maintable.getSelected();
                            if (selDatas.size() <= 0) {
                                Ext.lt.ui.alert('请选择要删除的目标数据！', function () {
                                });
                                return;
                            }
                            var tmpstatus = selDatas[0]["status"];
                            if (tmpstatus == "1") {
                                Ext.lt.ui.alert('绩效目标处于删除状态,不可编辑指标！', function () {
                                });
                                return;
                            }
                            var levelno = d.levelno;
                            if (levelno == "2") {
                                cmp.addbtnrow("", d.guid);
                            } else if (levelno == "3" && d.status != "1") {
                                cmp.del("", d.guid);
                            } else if (d.levelno == "3" && d.status == "1") {
                                Ext.lt.ui.confirm("确认要撤销删除选中指标？", {icon: "warn"}, function (ret) {
                                    if (ret) {
                                        var _sortid = d._sortid;
                                        d.status = "";
                                        d.obligate1 = "删除";
                                        d.adjustindexval = "";
                                        $.extend(d, d); //合并值集刷新
                                        datatable.reflash(_sortid);
                                    }
                                })
                            }
                        }
                    };
                }
            }
            if (col["colcode"] == "status") { //状态的翻译
                col.fn = function (l, c, data, col) {
                    var indexvalue = "";
                    if (data.status == "1") {
                        indexvalue = "删除";
                    } else if (data.status == "2") {
                        indexvalue = "修改";
                    } else if (data.status == "3") {
                        indexvalue = "新增";
                    }
                    return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
                }
            }
            if (col["colcode"] == "indexval") {
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
                    if (d.levelno != "3" || d.status != "3") {
                        return false;
                    }
                    el.innerText = d.indexval != undefined ? d.indexval : '';
                    table.getCol(c).mapping = null;
                    table.nowtype = "input";
                    table.getCol(c).format = "";
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
                            Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                            });
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
                col.fn = function (l, c, data, col) {
                    if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10" || _ismergeindex != "1") {
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
                    if (d.levelno != "3" || (d.status && (d.status == "1" || d.status == "3"))) {
                        return false;
                    }
                    el.innerText = d.adjustindexval != undefined ? d.adjustindexval : '';
                    table.getCol(c).mapping = null;
                    table.nowtype = "input";
                    table.getCol(c).format = "";
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
                    if (d.status == "" || !d.status) {
                        d.status = 2;
                    }
                    if (d.status != 3 && d.status != 1 && !d["adjustindexval"]) {
                        d.status = "";
                    }
                }
            }
            //一二级指标不可修改
            if (col["colcode"] == "name" || col["colcode"] == "explain" || col["colcode"] == "computesign"
                || col["colcode"] == "meterunit" || col["colcode"] == "weight" || col["colcode"] == "islinked"
                || col["colcode"] == "rule" || col["colcode"] == "kpi_remark" || col["colcode"] == "kpi_content" || col["colcode"] == "kpi_evalstd") {
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.status != "3") {
                        return false;
                    }
                }
            }
            if (col["colcode"] == "computesign") {
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6' && d.computesign != "9" && d.computesign != "10") {
                        if (!checkReferencepole(d.indexval)) {
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
                            return false;
                        }
                    }
                }
            }
        }
    });


    /**
     * 子表新增
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
        var url = '/pmkpi/deptperformance/report/editindex.page';
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.findex = data[0].findex;
        params.sindex = data[0].sindex;
        params.upguid = data[0].guid;
        params.type = "add";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth - 200, _scrHeight - 100, "新增指标");
    }
    /**
     * 行级新增操作
     */
    cmp.addbtnrow = function (obj, selguid) {
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
        var newdata = {};
        var uuid = getCreateguid(serviceid);
        var indexcols = datatable.getCols();
        for (var i = 0, len = indexcols.length; i < len; i++) {
            var col = indexcols[i];
            var colcode = col.colcode;
            newdata[colcode] = "";
        }
        newdata.guid = uuid;
        newdata.levelno = 3;
        newdata.isleaf = 1;
        newdata.superid = data[0].guid;
        newdata.sindex = data[0].guid;
        newdata.findex = data[0].superid;
        newdata.is_deleted = "2";
        newdata.goalguid = data[0].goalguid;
        newdata.rowtype = "add";
        newdata.status = 3;
        newdata.obligate1 = "删除";
        newdata.weight = 0;
        datatable.getRecordSet().addData(newdata, 999);
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
        var url = "/pmkpi/deptperformance/report/editindex.page";
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.findex = data[0].findex;
        params.sindex = data[0].sindex;
        params.modguid = data[0].guid;
        params.type = "mod";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth - 200, _scrHeight - 100, "修改指标");
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
            //判断处理已经删除的指标，不能再次删除了
            var flag = true;
            var tempstatus = "";
            for (var i = 0; i < data.length; i++) {
                tempstatus = data[i]["status"]; //数据状态.
                if (tempstatus && tempstatus == "1"){
                    flag = false;
                }
            }
            if (!flag){
                Ext.lt.ui.alert("要删除指标中存在已经删除的指标，请重新选择！", function () {
                });
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid: selguid});
        }
        Ext.lt.ui.confirm("确认要删除选中指标？", {icon: "warn"}, function (ret) {
            if (ret) {
                if (data && data.length > 0) { // #delindex
                    for (var i = 0; i < data.length; i++) {
                        var parent_sel_rows = datatable.getRecordset().query({guid: data[i].guid});
                        var parent_sel_obj = parent_sel_rows[0];
                        if (parent_sel_obj["levelno"] == 3) {
                            if (parent_sel_obj.status == 3) {
                                datatable.removeData(parent_sel_obj);
                            } else {
                                var _sortid = parent_sel_obj._sortid;
                                parent_sel_obj.status = 1;
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
    /**
     * 复制总体绩效到年度
     */
    cmp.copy = function () {
        Ext.lt.ui.confirm("是否复制总体到年度绩效？", {icon: "warn"}, function (ret) {
            if (ret) {
                Ext.lt.ui.loadingShow();
                //1 先保存现在的数据。
                var datas = datatable.getRecordSet().toArray();
                if (datas != null && datas.length > 0) {
                    var goalguid = datas[0].goalguid;
                    var mainsel = maintable.getRecordset().query({guid: goalguid});
                    if (mainsel.length > 0) {
                        mainsel[0]["#indexs"] = datas;
                    }
                }
                //2将主表保存到全局变量上
                if (Ext.lt.pmkpi.goaltype == "1") {
                    totalgoals = maintable.getRecordset().toArray();
                } else {
                    yeargoals = maintable.getRecordset().toArray();
                }
                if (totalgoals.length > 0) {
                    var len = yeargoals.length;
                    var tempgoals = Ext.lt.cloneobj(totalgoals);
                    var tempindexs = [];
                    for (var i = 0; i < tempgoals.length; i++) {
                        tempgoals[i]["guid"] = getCreateguid(serviceid);
                        tempgoals[i]["yearflag"] = "0";
                        tempgoals[i]["ordernum"] = (i + 9 + len);
                        tempgoals[i].rowtype = "add";
                        tempgoals[i]["_locationposition"] = null;
                        delete tempgoals[i]["_locationposition"]
                        tempgoals[i]["_sortid"] = null;
                        delete tempgoals[i]["_sortid"]
                        tempgoals[i]["goalname"] = "年度目标" + (len + i + 1);
                        tempindexs = tempgoals[i]["#indexs"];
                        var uuid = "";
                        for (var j = 0; j < tempindexs.length; j++) {
                            uuid = createUUID().replace(/-/g, '');
                            tempindexs[j]["yearflag"] = "0";
                            if (tempindexs[j]["levelno"] == 3) { //只有三级的给新增标识
                                tempindexs[j]["rowtype"] = "add";
                                tempindexs[j]["guid"] = uuid;
                                tempindexs[j]["goalguid"] = tempgoals[i]["guid"];
                            }
                        }
                        yeargoals.push(tempgoals[i]);
                    }
                    //重新刷新主表
                    cmp.mainquery(Ext.lt.pmkpi.goaltype);
                }
                Ext.lt.ui.loadingClose();
            }
        });
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
     * * 查看评审意见
     * */
    cmp.reviewinfo = function () {
        var params = {};
        var url = '/pmkpi/review/report/proindex.page';
        params.saveAgency = _saveAgency; //项目单位
        params.viewtype = "query";
        params.bustype = "dept";
        params.proguid = _mainguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight, "评审意见");
    }
    /**
     * 整体的校验.
     */
    cmp.nullcheck = function () {
        if (totalgoals.length == 0 && yeargoals.length > 0) {
            Ext.lt.ui.alert("请录入中长期目标不可为空！", function () {
            });
            return false;
        }
        if (totalgoals.length > 0 && yeargoals.length == 0) {
            Ext.lt.ui.alert("请录入年度目标不可为空！", function () {
            });
            return false;
        }
        return true;
    }
    /**
     * 最終保存时候表格填报数据的校验方法.
     * @returns {boolean}
     */
    cmp.checkAll = function () {
        for (var k = 0, lenk = totalgoals.length; k < lenk; k++) {
            var datas = totalgoals[k]["#indexs"];
            var cols = datatable.getCols();
            for (var i = 0, leni = datas.length; i < leni; i++) {
                for (var j = 0, lenj = cols.length; j < lenj; j++) {
                    if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                        var value = datas[i][cols[j].colcode];
                        if (value == null || value == "" || ("" + value).trim().length == 0) {
                            alert("[中长期目标]第" + (k + 1) + "行的绩效指标第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。");
                            return false;
                        }
                    }
                }
                //处理计算符号为定性，单位不填情况
                if (datas[i]["computesign"] != "6" && (datas[i]["meterunit"] == "" || datas[i]["meterunit"] == null || datas[i]["meterunit"] == undefined) && datas[i]["levelno"] == 3) {
                    alert("[中长期目标]第" + (k + 1) + "行的绩效指标第" + (datas[i]["_sortid"] + 1) + "行的单位必须有值。");
                    return false;
                }
            }
        }
        for (var k = 0, lenk = yeargoals.length; k < lenk; k++) {
            var datas = yeargoals[k]["#indexs"];
            var cols = datatable.getCols();
            for (var i = 0, leni = datas.length; i < leni; i++) {
                for (var j = 0, lenj = cols.length; j < lenj; j++) {
                    if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                        var value = datas[i][cols[j].colcode];
                        if (value == null || value == "" || ("" + value).trim().length == 0) {
                            alert("[年度目标]第" + (k + 1) + "行的绩效指标第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。");
                            return false;
                        }
                    }
                }
                //处理计算符号为定性，单位不填情况
                if (datas[i]["computesign"] != "6" && (datas[i]["meterunit"] == "" || datas[i]["meterunit"] == null || datas[i]["meterunit"] == undefined) && datas[i]["levelno"] == 3) {
                    alert("[年度目标]第" + (k + 1) + "行的绩效指标第" + (datas[i]["_sortid"] + 1) + "行的单位必须有值。");
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * 导入指标
     * @param obj
     */
    cmp.import = function (obj) {
        // 暂时写死导入模板的code
        var importcode = "pmkpi_huibei_deptimport";
        var vchtypeid = "E1DC02DD1B903FD7E0533315A8C0A1E1";
        var tokenid = Ext.lt.getparam("tokenid");
        //获取选中的目标数据
        var goaldatas = maintable.getSelected();
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.vchtypeid = vchtypeid;
        params.proguid = _mainguid;
        params.pagetype = "add";
        //选中目标后才能导入指标
        if (goaldatas.length > 0) {
            params.goalguid = goaldatas[0].guid; //目标guid
            window.importparam = params;
            Ext.lt.importdata.imports(tokenid, importcode, vchtypeid, Object.toJSON(params), function () {
                window.parent.Ext.lt.outfile.window.close()
                parent.Ext.lt.pmkpi.impsucess();
            });
        } else {
            Ext.lt.ui.alert("请选择目标进行指标导入！", function () {
            });
            return false;
        }
        goaldatas = "";
    }

    Ext.lt.pmkpi.impsucess = function () {
        Ext.lt.ui.alert("导入成功！", function () {
            var goaldatas = maintable.getSelected();
            Ext.lt.pmkpi.query(goaldatas[0]);
        });
    }

    Ext.lt.pmkpi.query = function (param) {
        var params = {};
        params.mainguid = param.mainguid;
        params.goalguid = param.guid;
        Ext.lt.RCP.call(serviceid, "getIndexData", params, function (rs) {
            datatable.setDatas(rs.data);
        }, function () {
            Ext.lt.ui.alert('查询失败！', function () {
            });
        });
    };

    return cmp;
}

function indexcheck(guid) {
    var url = "/pmkpi/deptperformance/report/indexcheck.page";
    var params = {};
    params.sindex = guid;
    params.saveAgency = _saveAgency;
    params.mainguid = _mainguid;
    url = Ext.lt.pmkpi.genPageUrl(url, params);
    Ext.lt.ui.openModalWindow(url, _scrWidth - 200, _scrHeight - 100, "选择指标");
}

function indexadd(sindex, findex) {
    var data = {};
    var newguid = Ext.lt.RCP.asyncall(serviceid, "getCreateguid", null);
    data.guid = newguid;
    data.rowtype = "add";
    data.mainguid = _mainguid;
    data.sindex = sindex;
    data.findex = findex;
    data.superid = sindex;
    data.levelno = 3;
    data.isleaf = 1;
    data._isleaf = 1;
    Ext.lt.pmkpi.isadd = true;
    datatable.getRecordSet().addData(data, 999);
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